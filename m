Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751094AbWC3JoQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751094AbWC3JoQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 04:44:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751103AbWC3JoQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 04:44:16 -0500
Received: from smtp.osdl.org ([65.172.181.4]:39361 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751017AbWC3JoP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 04:44:15 -0500
Date: Thu, 30 Mar 2006 01:43:41 -0800
From: Andrew Morton <akpm@osdl.org>
To: Reuben Farrelly <reuben-lkml@reub.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-mm2
Message-Id: <20060330014341.18c53b0b.akpm@osdl.org>
In-Reply-To: <442BA46F.5040601@reub.net>
References: <20060328003508.2b79c050.akpm@osdl.org>
	<442BA46F.5040601@reub.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Reuben Farrelly <reuben-lkml@reub.net> wrote:
>
> 
> 
> On 28/03/2006 8:35 p.m., Andrew Morton wrote:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16/2.6.16-mm2/
> > 
> > 
> > - It seems to compile.
> 
> I've just upgraded from an i386 to an x86_64.  It was an.... ordeal, but the 
> kernel was the least of the worries.  Userland upgrades were a pain.
> 
> Using the same config as on i386 apart from the differences that a 'make 
> oldconfig' threw up on the new architecture, I am now seeing some problems with 
> the x86_64 that I was not seeing on i386 on this release.
> 
> Kernel messages like this when booting up:
> 
> time.c: Using 3.579545 MHz WALL PM GTOD PIT/TSC timer.
> time.c: Detected 3000.283 MHz processor.
> Console: colour VGA+ 80x25
> time.c: Lost 85 timer tick(s)! rip 10:start_kernel+0x14c/0x220
> last clier stext+0x7fdff0e8/0xe8 caller stext+0x7fdff0e8/0xe8
> time.c: Lost 5 timer tick(s)! rip 10:__do_softirq+0x5a/0xea
> last clier stext+0x7fdff0e8/0xe8 caller stext+0x7fdff0e8/0xe8
> Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
> time.c: Lost 2 timer tick(s)! rip 10:release_console_sem+0x1a5/0x228
> last clier _spin_lock_irqsave+0x16/0x26 caller release_console_sem+0x1a/0x228
> Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)

I don't know why the messages are mangled - it looks like there's some
problem with serial console (might be x86_64-specific).

But the messages you're seeing are due to some debug code, sorry - they
didn't happen on my test box.  You'll need to change report_lost_ticks
(arch/x86_64/kernel/time.c, line 66) to zero.

