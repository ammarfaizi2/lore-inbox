Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261324AbUJWWmU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261324AbUJWWmU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 18:42:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261325AbUJWWmU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 18:42:20 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:59272 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261324AbUJWWmQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 18:42:16 -0400
Subject: Re: How is user space notified of CPU speed changes?
From: Lee Revell <rlrevell@joe-job.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Robert Love <rml@novell.com>
In-Reply-To: <1098566366.24804.8.camel@localhost.localdomain>
References: <1098399709.4131.23.camel@krustophenia.net>
	 <1098444170.19459.7.camel@localhost.localdomain>
	 <1098508238.13176.17.camel@krustophenia.net>
	 <1098566366.24804.8.camel@localhost.localdomain>
Content-Type: text/plain
Date: Sat, 23 Oct 2004 18:42:13 -0400
Message-Id: <1098571334.29081.21.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-10-23 at 22:19 +0100, Alan Cox wrote:
> On Sad, 2004-10-23 at 06:10, Lee Revell wrote:
> > JACK makes extensive use of microsecond-level timers.  These must be
> > calibrated at startup, and recalibrated when the CPU speed changes.  How
> > does JACK register with the kernel to be notified when the CPU speed
> > changes?
> 
> It did
> 
> - The kernel doesn't always know

OK, this one seems like the hard one.  Wouldn't this cause weird
behavior though?  For example Linux only calculates the delay loop once,
at boot time.  Does this render *delay() useless?

> - CPU speed is meaningless in hyper-threading since performance is not
> x2 for two cores but instead varies

Doesn't matter.  As long as they are both the same speed, JACK's
calculations will be correct.  We calculate the CPU speed at startup.
Then we just read the TSC and do the math.

> - It doesn't handle split CPU speed SMP - where CPU speeds vary

We don't have to support this.  If someone wants to do it they will have
to bind jackd to one CPU or the other.

> - God help you if virtualised

We don't have to support this.

Does anyone know how OSX/CoreAudio handles the situation?  Apparently
realtime apps work flawlessly on speed scaling laptops under OSX.

Lee


