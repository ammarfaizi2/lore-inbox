Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030563AbVIOSLH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030563AbVIOSLH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 14:11:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030564AbVIOSLH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 14:11:07 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:56250 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030563AbVIOSLF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 14:11:05 -0400
Subject: Re: NTP leap second question
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       john stultz <johnstul@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>,
       yoshfuji@linux-ipv6.org, Roman Zippel <zippel@linux-m68k.org>,
       joe-lkml@rameria.de
In-Reply-To: <2088723E-06A0-40ED-A51D-19316AE57ECA@mac.com>
References: <43286E4B.1070809@mvista.com>
	 <43293591.19922.2890E4@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
	 <2088723E-06A0-40ED-A51D-19316AE57ECA@mac.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Date: Thu, 15 Sep 2005 19:35:50 +0100
Message-Id: <1126809350.3813.28.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2005-09-15 at 13:21 -0400, Kyle Moffett wrote:
> only ever be a half-second off).  If you're willing to make it a bit  
> slower and a bit more code, you could even make the slewing nonlinear  
> with a continuous derivative, so it's only in place for ~20 seconds,  

It all depends what time you are using and how you are using it. There
isn't one time system and assuming there is makes all the mess.

Your kernel time ticks along at a steady rate based on a fixed period
second where that period hopefully is a passable approximation of the
rate of progression of time measured by a big pile of cæsium atomic
clocks and defined in terms of atomic radiation.

UTC (civilian time) effectively follows rotations of the earth but using
fixed interval seconds. The rotation is a bit variable so 'leap seconds'
are inserted to keep the two within 1 second of one another.  A seperate
standard (UT1) computes a 'universal' measure of earth rotation as UT0
(true earth rotation) is dependant on where you are (because the poles
wobble). And you can measure time with seconds defined as a fraction of
an earth rotation (ie variable length seconds) which is what in reality
most people use and think.

In other words, you need to decide what you are measuring before you
decide how to measure it. If you wish to record the point at which an
event occurred in civilian time then UTC is correct. If you wish to
measure the duration elapsed between two points in time then TAI (or raw
time_t) is probably more useful.

If you are recording events to some legally defined standard you have to
go read what the government has inflicted on your radio station/telco
etc and follow that.

Glibc will do the conversion work for you providing your timezone
database is kept up to date.

Alan

