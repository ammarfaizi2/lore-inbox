Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262557AbVESQNX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262557AbVESQNX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 12:13:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262559AbVESQNX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 12:13:23 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:20149 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262558AbVESQNL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 12:13:11 -0400
Subject: RE: Why yield in coredump_wait? [was: Re: Resent: BUG in RT 45-01
	whenRT program dumps core]
From: Lee Revell <rlrevell@joe-job.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: kus Kusche Klaus <kus@keba.com>, Linus Torvalds <torvalds@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
In-Reply-To: <1116513427.15866.52.camel@localhost.localdomain>
References: <AAD6DA242BC63C488511C611BD51F367323213@MAILIT.keba.co.at>
	 <1116513427.15866.52.camel@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 19 May 2005 12:13:10 -0400
Message-Id: <1116519190.21685.72.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-05-19 at 10:37 -0400, Steven Rostedt wrote:
> On Thu, 2005-05-19 at 16:23 +0200, kus Kusche Klaus wrote:
> > Does that mean that the core dump is written 
> > with the rt prio of the task which dumps?
> > 
> 
> Yes, since the process itself that crashed is what is writing the core.
> So if a RT process crashes, it writes the core as whatever it was.
> 
> > I'm not sure if this is a good idea: 
> > Dumping a big core might take *ages* (at least w.r.t. realtime),
> > especially because it usually goes to flash memory, a CF card,
> > or some other really slow device.
> > 
> 
> This is interesting, since if a RT task is dumping core, that usually
> means that it crashed, and therefore there's a bug in the system.  Also,
> unless the processes is writing to something that requires a busy wait
> (which the serial might do, and probably some flashes), this shouldn't
> effect the system.

Interesting indeed.  This could be caused by (possibly transient)
hardware failure as well as a bug.  How do mission critical hard RT
applications typically handle disasters like the RT process dumping
core?  Presumably you have a hardware or software watchdog, and drop
into some kind of safe mode.  It seems that you would need redundant
systems if you wanted to continue to handle the RT constraint while
recovering.

Lee

