Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263905AbRFMANh>; Tue, 12 Jun 2001 20:13:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263906AbRFMAN1>; Tue, 12 Jun 2001 20:13:27 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:15152 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S263905AbRFMANH>; Tue, 12 Jun 2001 20:13:07 -0400
Date: Wed, 13 Jun 2001 02:12:42 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Richard Henderson <rth@redhat.com>
Cc: torvalds@transmeta.com, alan@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: 2.4.5 gcc3 build patch
Message-ID: <20010613021242.E709@athlon.random>
In-Reply-To: <20010612162733.D26637@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010612162733.D26637@redhat.com>; from rth@redhat.com on Tue, Jun 12, 2001 at 04:27:33PM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2001 at 04:27:33PM -0700, Richard Henderson wrote:
> We fixed a bug in cv-qualification checking.
> 
> timer.c:35: conflicting types for `xtime'
> include/linux/sched.h:540: previous declaration of `xtime'
> 
> There's no need for the volatile qualification here.  One, being a
> struct it doesn't do any good, and two it's protected by xtime_lock.

wrong, the sec field of xtime is read all the time without any lock.
so xtime can change under you it has to be declared volatile or C
language will screwup. gcc 3.0 effectively spotted a bug in the kernel
that wasn't exporting xtime as volatile.

Right fix is this that I did just about 10 minutes ago after the 3.0
checkout ;)

	ftp://ftp.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.6pre2aa2/00_gcc-30-volatile-xtime-1

Andrea
