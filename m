Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267431AbSKQBx1>; Sat, 16 Nov 2002 20:53:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267433AbSKQBx1>; Sat, 16 Nov 2002 20:53:27 -0500
Received: from probity.mcc.ac.uk ([130.88.200.94]:15623 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S267431AbSKQBx0>; Sat, 16 Nov 2002 20:53:26 -0500
Date: Sun, 17 Nov 2002 02:00:17 +0000
From: John Levon <levon@movementarian.org>
To: Corey Minyard <cminyard@mvista.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       "'Zwane Mwaikambo'" <zwane@holomorphy.com>,
       linux-kernel@vger.kernel.org
Subject: Re: NMI handling rework for x86
Message-ID: <20021117020017.GA96715@compsoc.man.ac.uk>
References: <3DD47858.3060404@mvista.com> <20021115051207.GA29779@compsoc.man.ac.uk> <3DD5011F.9010409@mvista.com> <20021115174833.GB83229@compsoc.man.ac.uk> <3DD5444E.9070808@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DD5444E.9070808@mvista.com>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
X-Scanner: exiscan *18DEjR-0000sJ-00*IZVQeOUZLAY* (Manchester Computing, University of Manchester)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 15, 2002 at 01:00:30PM -0600, Corey Minyard wrote:

> I have attached another patch, this one fixes my stupid bug in 
> dummy_watchdog_reset and also adds code to the NMI watchdog to not 
> handle the NMI if it has already been handled.  Again, you must do a "cd 
> arch/i386/kernel; mv nmi.c nmi_watchdog.c" before applying this patch.

I have tested this patch running oprofile on a dual box at 150,000
ints/sec and more, with nmi_watchdog=0,1,2, and couldn't reproduce any
problems.

One thing: since we have the unnatural relationship between the watchdog
and oprofile, I would much prefer that be obvious in the priority. e.g
MAX_NMI_PRIORITY, which oprofile uses, then watchdog is MAX_NMI_PRIORITY
-1. Currently the gap between the two values you use indicates it's OK
to have another handler inbetween, which it definitely isn't.

regards
john
