Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751371AbWHIUw6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751371AbWHIUw6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 16:52:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751370AbWHIUw6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 16:52:58 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:28132 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751368AbWHIUw5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 16:52:57 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.18-rc4 (and earlier): CMOS clock corruption during suspend to disk on i386
Date: Wed, 9 Aug 2006 22:51:57 +0200
User-Agent: KMail/1.9.3
Cc: Pavel Machek <pavel@ucw.cz>, LKML <linux-kernel@vger.kernel.org>,
       Linux ACPI <linux-acpi@vger.kernel.org>
References: <200608091426.31762.rjw@sisk.pl> <200608092201.42885.rjw@sisk.pl> <20060809131232.75a260e1.akpm@osdl.org>
In-Reply-To: <20060809131232.75a260e1.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608092251.58062.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 09 August 2006 22:12, Andrew Morton wrote:
> On Wed, 9 Aug 2006 22:01:42 +0200
> "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> 
> > On Wednesday 09 August 2006 14:30, Pavel Machek wrote:
> > > Hi!
> > > > 
> > > > It looks like the CMOS clock gets corrupted during the suspend to disk
> > > > on i386.  I've observed this on 2 different boxes.  Moreover, one of them is
> > > > AMD64-based and the x86_64 kernel doesn't have this problem on it.
> > > > 
> > > > Also, I've done some tests that indicate the corruption doesn't occur before
> > > > saving the suspend image.  It rather happens when the box is powered off
> > > > or rebooted (tested both cases).
> > > > 
> > > > Unfortunately, I have no more time to debug it further right now.
> > > 
> > > Do you have Linus' "please corrupt my cmos for debuggin" hack enabled?
> > 
> > Well, I know nothing about that. ;-)
> > 
> 
> CONFIG_PM_TRACE=y will scrog your CMOS clock each time you suspend.

Oh dear.  Of course it's set in my .config.  Thanks a lot for this hint. :-)

BTW, it's a dangerous setting, because some drivers get mad if the time after
the resume appears to be earlier than the time before the suspend.  Also the
timer .suspend/.resume routines aren't prepared for that.

