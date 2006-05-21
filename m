Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964886AbWEUP2M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964886AbWEUP2M (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 11:28:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964887AbWEUP2M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 11:28:12 -0400
Received: from lea.cs.unibo.it ([130.136.1.101]:15029 "EHLO lea.cs.unibo.it")
	by vger.kernel.org with ESMTP id S964886AbWEUP2M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 11:28:12 -0400
Date: Sun, 21 May 2006 17:28:10 +0200
To: Jeff Dike <jdike@addtoit.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andi Kleen <ak@suse.de>,
       Daniel Jacobowitz <dan@debian.org>, Ulrich Drepper <drepper@gmail.com>,
       osd@cs.unibo.it, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2-ptrace_multi
Message-ID: <20060521152810.GL15497@cs.unibo.it>
References: <20060518155337.GA17498@cs.unibo.it> <20060519174534.GA22346@cs.unibo.it> <20060519201509.GA13477@nevyn.them.org> <200605192217.30518.ak@suse.de> <1148135825.2085.33.camel@localhost.localdomain> <20060520183020.GC11648@cs.unibo.it> <20060520213959.GA4229@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060520213959.GA4229@ccure.user-mode-linux.org>
User-Agent: Mutt/1.5.6+20040907i
From: renzo@cs.unibo.it (Renzo Davoli)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 20, 2006 at 05:39:59PM -0400, Jeff Dike wrote:
> Wouldn't the obvious fix be to implement [GS]ETREGS for arches that don't
> have them?
It is not enough. I am fixing the [GS]ETREGS for ppc32 but it happens
that the error number is stored in the register PT_CCR (a.k.a. R38)
so I need an extra call to get that, then I need the program counter which is
in PT_NIP (R31). [GS]ETREGS for ppc load/store just the range R0-R31.
so I need 3 syscalls for each syscall issued by the ptraced process
instead of just one.
Each architecture has its own idiosyncrasies so when somebody is trying to 
write and efficient and *portable* support for virtual machines it happens
to have a piece of memory here, a register there etc that are needed
to support something.
I felt that giving a clear and effective way to do more ptrace requests
at once was the general solution.
Readv, writev were created to solve the performance problem to deal with calls
involving several buffers. All the programs based on readv/writev
can be implemented in a less efficient way through standard read/write.
This proposal had the same humble goal applied to ptrace instead of
read/write.

renzo
