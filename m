Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267455AbTBNUyA>; Fri, 14 Feb 2003 15:54:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267458AbTBNUwd>; Fri, 14 Feb 2003 15:52:33 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:6803 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S267456AbTBNUwZ>; Fri, 14 Feb 2003 15:52:25 -0500
Date: Fri, 14 Feb 2003 16:02:16 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200302142102.h1EL2GE28325@devserv.devel.redhat.com>
To: James Bourne <jbourne@mtroyal.ab.ca>
cc: zaitcev@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: lockups with 2.4.20 (tg3? net/core/dev.c|deliver_to_old_ones)
In-Reply-To: <mailman.1045255801.17177.linux-kernel2news@redhat.com>
References: <mailman.1045255801.17177.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Since sometime in December two systems we have on site using P4 HT (one
> Dell 2650 and one Dell 4600, both dual CPU, both ht/mce capable) have been
> locking up without any kernel output and without sysrq keys working (the
> keyboard is locked solid).
>[...]
> Using nmi_watchdog I've managed to get a stack track and ran ksymoops over
> it (attached).

Good report. To tell the truth, I know that this lockup exists,
there's an RH issue-tracker item against me on this.
It is different from the old "porkchop" lockup, which DaveM and
Jeff Garzik fixed.

The stumbling block is that NMI oopser catches a thread which
gets stuck because of the lock, but this does not explain
how the lock was taken.

I think the best resolution would be an instrumentation patch
which records lock takers, and prints them when the thing is
forcefuly oopsed. I should come with it eventually, if someone
does not beat me to it (I wish they did, actually :-)

-- Pete
