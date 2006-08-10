Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750971AbWHJUwY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750971AbWHJUwY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 16:52:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750963AbWHJUwX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 16:52:23 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:36994 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1750971AbWHJUwW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 16:52:22 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@suse.cz>
Subject: Re: 2.6.18-rc4 (and earlier): CMOS clock corruption during suspend to disk on i386
Date: Thu, 10 Aug 2006 22:51:20 +0200
User-Agent: KMail/1.9.3
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Linux ACPI <linux-acpi@vger.kernel.org>
References: <200608091426.31762.rjw@sisk.pl> <20060810001232.GB4249@ucw.cz> <200608101415.21505.rjw@sisk.pl>
In-Reply-To: <200608101415.21505.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608102251.20707.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thursday 10 August 2006 14:15, Rafael J. Wysocki wrote:
> On Thursday 10 August 2006 02:12, Pavel Machek wrote:
> > > > > > > It looks like the CMOS clock gets corrupted during the suspend to disk
> > > > > > > on i386.  I've observed this on 2 different boxes.  Moreover, one of them is
> > > > > > > AMD64-based and the x86_64 kernel doesn't have this problem on it.
> > > > > > > 
> > > > > > > Also, I've done some tests that indicate the corruption doesn't occur before
> > > > > > > saving the suspend image.  It rather happens when the box is powered off
> > > > > > > or rebooted (tested both cases).
> > > > > > > 
> > > > > > > Unfortunately, I have no more time to debug it further right now.
> > > > > > 
> > > > > > Do you have Linus' "please corrupt my cmos for debuggin" hack enabled?
> > > > > 
> > > > > Well, I know nothing about that. ;-)
> > > > 
> > > > CONFIG_PM_TRACE=y will scrog your CMOS clock each time you suspend.
> > > 
> > > Oh dear.  Of course it's set in my .config.  Thanks a lot for this hint. :-)
> > > 
> > > BTW, it's a dangerous setting, because some drivers get mad if the time after
> > > the resume appears to be earlier than the time before the suspend.  Also the
> > > timer .suspend/.resume routines aren't prepared for that.
> > 
> > Its config option should just go away. People comfortable using *that*
> > should just edit some header file. Rafael, could you do patch doing
> > something like that?
> 
> Just remove the option from Kconfig or the whole setting?
> 
> Shouldn't we also change the timer .resume() routines to check if the time
> after the resume is later than (or at least the same as) the time before the
> suspend and set the "sleep length" to 0 if not?

Hm, I'm thinking it may actually be useful to have in Kconfig and if we change
the timer resume to detect the dangerous situation and prevent it from
happening, that should be sufficient.

Rafael
