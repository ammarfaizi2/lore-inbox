Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750770AbVIFRIF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750770AbVIFRIF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 13:08:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750772AbVIFRIF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 13:08:05 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:32683 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750770AbVIFRIE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 13:08:04 -0400
Subject: Re: [WATCHDOG] v2.6.13 watchdog-patches
From: Josh Boyer <jdub@us.ibm.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Wim Van Sebroeck <wim@iguana.be>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org, Chuck Ebbert <76306.1226@compuserve.com>,
       "P @ Draig Brady" <P@draigBrady.com>, Ben Dooks <ben-linux@fluff.org>,
       Dimitry Andric <dimitry.andric@tomtom.com>, Olaf Hering <olh@suse.de>,
       Deepak Saxena <dsaxena@plexity.net>,
       Christer Weinigel <wingel@nano-system.com>
In-Reply-To: <1125778302.3223.29.camel@laptopd505.fenrus.org>
References: <20050903200443.GO19487@infomag.infomag.iguana.be>
	 <1125778302.3223.29.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Date: Tue, 06 Sep 2005 12:06:25 -0500
Message-Id: <1126026385.6930.3.camel@windu.rchland.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-09-03 at 22:11 +0200, Arjan van de Ven wrote:
> On Sat, 2005-09-03 at 22:04 +0200, Wim Van Sebroeck wrote:
> > Author: Chuck Ebbert <76306.1226@compuserve.com>
> > Date:   Fri Aug 19 14:14:07 2005 +0200
> > 
> >     [WATCHDOG] softdog-timer-running-oops.patch
> >     
> >     The softdog watchdog timer has a bug that can create an oops:
> >     
> >     1.  Load the module without the nowayout option.
> >     2.  Open the driver and close it without writing 'V' before close.
> >     3.  Unload the module.  The timer will continue to run...
> >     4.  Oops happens when timer fires.
> >     
> >     Reported Sun, 10 Oct 2004, by Michael Schierl <schierlm@gmx.de>
> >     
> >     Fix is easy: always take a reference on the module on open.
> >     Release it only when the device is closed and no timer is running.
> >     Tested on 2.6.13-rc6 using the soft_noboot option.  While the
> >     timer is running and the device is closed, the module use count
> >     stays at 1.  After the timer fires, it drops to 0.  Repeatedly
> >     opening and closing the driver caused no problems.  Please apply.
> 
> 
> this looks ENTIRELY like the wrong solution!
> Isn't it a LOT easier to just del_timer_sync() the timer from the module
> exit code? Mucking with module refcounts in a driver is almost always a
> sign of a bug or at least really bad design, and I think that is the
> case here.....
> 

But that defeats the purpose of the nowayout option doesn't it?

josh

