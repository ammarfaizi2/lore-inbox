Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750958AbVJ2Arl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750958AbVJ2Arl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 20:47:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750959AbVJ2Arl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 20:47:41 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:32943 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750956AbVJ2Ark
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 20:47:40 -0400
Subject: Re: kernel-2.6.14-rc5-rt7 - 604.62 BogoMIPS (2.6.14-rc5 - 6024.43
	BogoMIPS) problem with bogometer ?
From: john stultz <johnstul@us.ibm.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
       mingo@elte.hu
In-Reply-To: <1130546221.6169.67.camel@localhost.localdomain>
References: <200510281828.AA38666812@usfltd.com>
	 <1130542935.27168.431.camel@cog.beaverton.ibm.com>
	 <1130544632.6169.63.camel@localhost.localdomain>
	 <1130546221.6169.67.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 28 Oct 2005 17:47:37 -0700
Message-Id: <1130546858.27168.447.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-10-28 at 20:37 -0400, Steven Rostedt wrote:
> > > That should explain a differing lpj value, although 10x smaller is a
> > > little strange, so I'll dig into this on my system and see if I find
> > > anything.
> > > 
> > > Do let me know if you see any actual changes in behavior (drivers acting
> > > funny, etc).
> > 
> > John, 
> > 
> > Don't waste any time on this.  This was caused by a brain fart on
> > Thomas' part :-)  Some legacy code in ktimer_interrupt returned a enum
> > that was being used to update the ticks.  So before high-res was
> > activated, the jiffies would be incremented 7 times instead of just
> > once.  It's already been fixed. Just waiting for Ingo to release his new
> > patch.
> 
> Would you want to be CC'd on all ktimer related patches?  This way you
> wont think things like this was caused by your code.

I skim lkml so that's probably not necessary. This complaint just
grabbed my attention since I had made a related change in the area.

I did recall the jiffies issue once you mentioned it, but I'm not
keeping to close a watch as far as what versions of ktimers patches are
in what versions of the -rt tree (Ingo: is there a place where you have
the -rt tree broken out?)

Please do be sure to CC me if you run into any timekeeping related
problems, just so I'm sure not to miss them.

thanks!
-john

