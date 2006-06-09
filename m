Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964904AbWFIKHr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964904AbWFIKHr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 06:07:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964986AbWFIKHr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 06:07:47 -0400
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:30861 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S964904AbWFIKHq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 06:07:46 -0400
Subject: Re: 2.6.17-rc6-rt1
From: =?ISO-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
To: Mike Galbraith <efault@gmx.de>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>, John Stultz <johnstul@us.ibm.com>,
       Deepak Saxena <dsaxena@plexity.net>
In-Reply-To: <1149842550.7585.27.camel@Homer.TheSimpsons.net>
References: <20060607211455.GA6132@elte.hu>
	 <1149842550.7585.27.camel@Homer.TheSimpsons.net>
Date: Fri, 09 Jun 2006 12:12:30 +0200
Message-Id: <1149847951.3829.26.camel@frecb000686>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 09/06/2006 12:11:21,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 09/06/2006 12:11:22,
	Serialize complete at 09/06/2006 12:11:22
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-06-09 at 10:42 +0200, Mike Galbraith wrote:
> On Wed, 2006-06-07 at 23:14 +0200, Ingo Molnar wrote:
> > i have released the 2.6.17-rc6-rt1 tree, which can be downloaded from 
> > the usual place:
> > 
> >    http://redhat.com/~mingo/realtime-preempt/
> > 
> > the biggest change was the port to 2.6.17-rc6, and the moving to John's 
> > latest and greatest GTOD queue. Most of the porting was done by Thomas 
> > Gleixner (thanks Thomas!). We also picked up the freshest genirq queue 
> > from -mm and the freshest PI-futex patchset. There are also lots of ARM 
> > fixups and enhancements from Deepak Saxena and Daniel Walker.
> 
> I have some fairly strange things going on with this kernel.
> 
> First of all, during boot, I end up with these two entries.
> BUG: wq(events) setscheduler() returned: -22.
> BUG: wq(events) setscheduler() returned: -22.
> 
> After boot, it takes a very long time for KDE to finish loading... more
> than five minutes for the desktop background to finally appear.  Tasks
> which are doing nothing but a ~50ms gettimeofday() select() idle loop
> show up in top as using 1 to 3 percent cpu, though strace of these looks
> fine.  Starting any threaded app takes ages, whereas plain-jane things
> like gcc work fine.  For example, if I fire up xmms, the gui comes up
> quickly, but it takes over three minutes from the time I poke play until
> the first sound is emitted.  Starting evolution takes even longer.
> 
> Hoping that something might show up while running glibc-2.4 make check
> to save me from wading through huge truckloads of strace, I tried it.
> It repeatedly goes boom.  RT29 goes boom the same way, but doesn't
> exhibit the slow threaded app symptom.  Drat.
> 

  Yep noticed that here too. As you pointed out it seems to be related
to threaded apps. ls, vi, ... work fine whereas xemacs or others are
real slow, portmapper fails to respond, ...

  I've got no indication in the logs that something went wrong, nor
do I see any kernel BUG or WARNING.

  My box is a dual 2.8GHz HT xeon w/ 2GB mem.

  rt29 was fine as is 2.6.17-rc6.

  I feel a bit perplexed here.


  Sébastien.

  

