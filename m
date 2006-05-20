Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932380AbWETVmy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932380AbWETVmy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 May 2006 17:42:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932390AbWETVmy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 May 2006 17:42:54 -0400
Received: from [198.99.130.12] ([198.99.130.12]:54657 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S932380AbWETVmy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 May 2006 17:42:54 -0400
Date: Sat, 20 May 2006 17:39:59 -0400
From: Jeff Dike <jdike@addtoit.com>
To: Renzo Davoli <renzo@cs.unibo.it>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andi Kleen <ak@suse.de>,
       Daniel Jacobowitz <dan@debian.org>, Ulrich Drepper <drepper@gmail.com>,
       osd@cs.unibo.it, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2-ptrace_multi
Message-ID: <20060520213959.GA4229@ccure.user-mode-linux.org>
References: <20060518155337.GA17498@cs.unibo.it> <20060519174534.GA22346@cs.unibo.it> <20060519201509.GA13477@nevyn.them.org> <200605192217.30518.ak@suse.de> <1148135825.2085.33.camel@localhost.localdomain> <20060520183020.GC11648@cs.unibo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060520183020.GC11648@cs.unibo.it>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 20, 2006 at 08:30:20PM +0200, Renzo Davoli wrote:
> Let me point out that PTRACE_MULTI is not only related to memory access.
> We are using PTRACE_MULTI also to store the registers and restart the
> execution of the ptraced process with a single syscall.
> This is very effective when umview runs on a ppc32 architecture. In
> fact, PPC_PTRACE_{G,S}ETREGS do not exist for that architecture
> (IMHO there is no evident reason for that). Without PTRACE_MULTI each register
> must be read/written individually by a PTRACE_{PEEK,POKE}USER(*)

Wouldn't the obvious fix be to implement [GS]ETREGS for arches that don't
have them?

> PTRACE_MULTI can be also used to optimize many other virtualized calls,
> e.g. to read/write all the buffers for a readv/writev/recvmsg/sendmsg
> call at once.

Here, I bet the data copying cost dominates the system call, and the
syscall overhead is minimal.

				Jeff
