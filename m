Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261510AbUJXPEx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261510AbUJXPEx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 11:04:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261511AbUJXPEw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 11:04:52 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:9607 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261510AbUJXPEu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 11:04:50 -0400
Subject: Re: How is user space notified of CPU speed changes?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Robert Love <rml@novell.com>
In-Reply-To: <1098571334.29081.21.camel@krustophenia.net>
References: <1098399709.4131.23.camel@krustophenia.net>
	 <1098444170.19459.7.camel@localhost.localdomain>
	 <1098508238.13176.17.camel@krustophenia.net>
	 <1098566366.24804.8.camel@localhost.localdomain>
	 <1098571334.29081.21.camel@krustophenia.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1098626510.24073.9.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 24 Oct 2004 15:02:08 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2004-10-23 at 23:42, Lee Revell wrote:
> > - The kernel doesn't always know
> 
> OK, this one seems like the hard one.  Wouldn't this cause weird
> behavior though?  For example Linux only calculates the delay loop once,
> at boot time.  Does this render *delay() useless?

Such systems you do need to run with notsc - although 2.6 autodetects
this prints complaints and does the job itself.

> > - CPU speed is meaningless in hyper-threading since performance is not
> > x2 for two cores but instead varies
> 
> Doesn't matter.  As long as they are both the same speed, JACK's
> calculations will be correct.  We calculate the CPU speed at startup.
> Then we just read the TSC and do the math.

Are you trying to use tsc for delays or measure CPU speed. The original
question you asked was about CPU speed and the two are very different.

> > - It doesn't handle split CPU speed SMP - where CPU speeds vary
> 
> We don't have to support this.  If someone wants to do it they will have
> to bind jackd to one CPU or the other.

If you are trying to do tsc stuff remember tsc synchronization between
processors is not guaranteed and works on most boards today as a quirk
of design.

> Does anyone know how OSX/CoreAudio handles the situation?  Apparently
> realtime apps work flawlessly on speed scaling laptops under OSX.

Presumably they use the other timers that Apple designed into their
hardware as they control both ends. You've got a good 48Khz or so clock
in the audio device too so many games clock off the audio clock anyway.

