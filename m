Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265214AbUF2Dmq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265214AbUF2Dmq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 23:42:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265353AbUF2Dmq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 23:42:46 -0400
Received: from fw.osdl.org ([65.172.181.6]:25017 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265214AbUF2Dmp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 23:42:45 -0400
Date: Mon, 28 Jun 2004 20:42:35 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Roland McGrath <roland@redhat.com>
cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Andrew Cagney <cagney@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] x86 single-step (TF) vs system calls & traps
In-Reply-To: <200406290155.i5T1tKYY030209@magilla.sf.frob.com>
Message-ID: <Pine.LNX.4.58.0406282039200.28764@ppc970.osdl.org>
References: <200406290155.i5T1tKYY030209@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 28 Jun 2004, Roland McGrath wrote:
> 
> When you single-step into a trap instruction, you actually don't get a
> SIGTRAP until the instruction after the trap instruction has also executed.

Yes. This is documented Intel behaviour. It also guarantees that there is 
forward progress in some strange circumstances, if I remember correctly.

And I refuse to make the fast-path slower just because of this. Not only 
has Linux always worked like this, as far as I know all other x86 OS's 
also tend to just do the Intel behaviour thing.

		Linus
