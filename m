Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266473AbUF3Esk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266473AbUF3Esk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 00:48:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266469AbUF3Esj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 00:48:39 -0400
Received: from ozlabs.org ([203.10.76.45]:19158 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S266467AbUF3Er0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 00:47:26 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16610.17912.738648.646334@cargo.ozlabs.ibm.com>
Date: Wed, 30 Jun 2004 14:47:52 +1000
From: Paul Mackerras <paulus@samba.org>
To: Jamie Lokier <jamie@shareable.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linuxppc-dev@lists.linuxppc.org, Anton Blanchard <anton@au.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: A question about PROT_NONE on PPC and PPC64
In-Reply-To: <20040630031821.GB25149@mail.shareable.org>
References: <20040630031821.GB25149@mail.shareable.org>
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier writes:

> PPC32
> =====
> 
> In include/asm-ppc/pgtable.h, there's:
> 
> #define PAGE_NONE	__pgprot(_PAGE_BASE)
> #define PAGE_READONLY	__pgprot(_PAGE_BASE | _PAGE_USER)
> 
> It appears the only difference betwen PROT_READ and PROT_NONE is
> whether _PAGE_USER is set.
> 
> Thus PROT_NONE pages aren't readable from userspace, but it appears
> they _are_ readable from kernel space.  Is this correct?

No.  Kernel accesses to pages in the user portion of the address space
(0 .. TASK_SIZE-1) are done using the user permissions.  On classic
PPC this is implemented (in part) by setting Ks = Kp = 1 in the
segment descriptors for the user segments, which tells the hardware to
check the access as if it was a user access even in supervisor mode.

We do the same on ppc64 as well.

> So does this mean that PROT_NONE pages, although they aren't readable
> from userspace, are readable from kernel space?  I.e. that write()
> with a PROT_NONE region would succeed, instead of returning EFAULT as
> it should?

If you do find a ppc32 or ppc64 machine where the write succeeds
instead of returning EFAULT, let me know please.

Paul.
