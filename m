Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263769AbUIZUbs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263769AbUIZUbs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Sep 2004 16:31:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263770AbUIZUbs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Sep 2004 16:31:48 -0400
Received: from ozlabs.org ([203.10.76.45]:13519 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S263769AbUIZUbq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Sep 2004 16:31:46 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16727.9953.113125.387097@cargo.ozlabs.ibm.com>
Date: Mon, 27 Sep 2004 06:30:25 +1000
From: Paul Mackerras <paulus@samba.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Andrea Arcangeli <andrea@novell.com>, Rik van Riel <riel@redhat.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: ptep_establish/establish_pte needs set_pte_atomic and all
	set_pte must be written in asm
In-Reply-To: <1096160383.18233.67.camel@gaston>
References: <20040926002037.GP3309@dualathlon.random>
	<Pine.LNX.4.44.0409252030260.28582-100000@chimarrao.boston.redhat.com>
	<20040926004608.GS3309@dualathlon.random>
	<1096160383.18233.67.camel@gaston>
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt writes:

> On Sun, 2004-09-26 at 10:46, Andrea Arcangeli wrote:
> 
> > As far as the C language is concerned that *ptep = something can be
> > implemented with 8 writes of 1 byte each (or alternatively with an
> > assembler instruction that may make the written data visible not
> > atomically to other cpus, despite it was written with a single opcode,
> > similarly to what happens if you use incl without the lock prefix). I'm
> > not saying such instruction exists in ppc64, but the compiler is
> > definitely allowed to break the above. You can blame on the compiler to
> > be inefficient, but you can't blame on the compiler for the security
> > hazard it would generate. Only the kernel would be to blame if for
> > whatever reason a gcc version would be underoptimized.
> 
> BTW, for your reading pleasure :)
> 
> #define atomic_set(v,i)		(((v)->counter) = (i))

FWIW, we also rely on several other things that are not guaranteed by
the C standard, for instance that integer arithmetic is 2's
complement, that bytes are individually addressable, and that pointers
are represented by an address that is no bigger than a long.

Paul.

