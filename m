Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278712AbRJ3XSo>; Tue, 30 Oct 2001 18:18:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278736AbRJ3XSe>; Tue, 30 Oct 2001 18:18:34 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:32080 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S278724AbRJ3XSQ>; Tue, 30 Oct 2001 18:18:16 -0500
Date: Wed, 31 Oct 2001 00:18:47 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: pre5 VM livelock
Message-ID: <20011031001847.F1340@athlon.random>
In-Reply-To: <3BDF1999.CAF5D101@mandrakesoft.com> <Pine.LNX.4.33.0110301436550.1188-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <Pine.LNX.4.33.0110301436550.1188-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Tue, Oct 30, 2001 at 02:49:27PM -0800
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2001 at 02:49:27PM -0800, Linus Torvalds wrote:
> 
> On Tue, 30 Oct 2001, Jeff Garzik wrote:
> >
> > Key symptoms:  Free swab 0Kb according to sysrq-m, and several processes
> > in run state according to sysrq-t.
> 
> What are the stack traces for the processes (ie "Ctrl-ScrollLock")
> 
> It actually _sounds_ like you're out-of-memory for real, you have no swap
> left, and you have only four pages in the swap cache which implies that
> the system has tried very very hard to get rid of the pages you _did_
> write to swap.
> 
> That, in turn, sounds like a memory leak. You've got 38578 pages on the

I agree it's oom, I think it's the infinite loop, it probably thinks
this memory is freeable but maybe it's all anonymous mlocked memory, or
maybe there's no swap at all that is equivalent for the vm.

I think it's not reproducible in -aa.

Andrea
