Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265773AbSKOFFX>; Fri, 15 Nov 2002 00:05:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265777AbSKOFFW>; Fri, 15 Nov 2002 00:05:22 -0500
Received: from probity.mcc.ac.uk ([130.88.200.94]:29965 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S265773AbSKOFFW>; Fri, 15 Nov 2002 00:05:22 -0500
Date: Fri, 15 Nov 2002 05:12:07 +0000
From: John Levon <levon@movementarian.org>
To: Corey Minyard <cminyard@mvista.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       "Heater, Daniel (IndSys, GEFanuc, VMIC)" <Daniel.Heater@gefanuc.com>,
       "'Zwane Mwaikambo'" <zwane@holomorphy.com>,
       Dipankar Sarma <dipankar@gamebox.net>, linux-kernel@vger.kernel.org
Subject: Re: NMI handling rework for x86
Message-ID: <20021115051207.GA29779@compsoc.man.ac.uk>
References: <3DD47858.3060404@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DD47858.3060404@mvista.com>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
X-Scanner: exiscan *18CYm1-00023b-00*18UF2C89MUk* (Manchester Computing, University of Manchester)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 14, 2002 at 10:30:16PM -0600, Corey Minyard wrote:

> Since a lot of things are hacking into this code (lkcd, kdb, oprofile, 
> nmi watchdog, and now my IPMI watchdog pretimeout), it would be very 
> nice to get their junk out of this code and allow them to bind in 
> nicely, and allow binding from modules.

I've just noticed you haven't fixed the watchdog vs. oprofile case.  You
pass in the handled flag to the NMI watchdog handler, but you ignore the
value and always do the perfctr reset. You /must/ only do the reset if
handled == false, or you'll screw up oprofile when it's running.

also, the diff would be much easier to read as a separate "mv nmi.c
nmi_watchdog.c" then diff against that

regards
john
