Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751123AbWBHDNJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751123AbWBHDNJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 22:13:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751130AbWBHDNJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 22:13:09 -0500
Received: from tim.rpsys.net ([194.106.48.114]:45026 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S1751123AbWBHDNI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 22:13:08 -0500
Subject: Re: [PATCH 11/12] LED: Add IDE disk activity LED trigger
From: Richard Purdie <rpurdie@rpsys.net>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <58cb370e0602060853i469d3449j5d2673b407aec460@mail.gmail.com>
References: <1139154893.14624.15.camel@localhost.localdomain>
	 <58cb370e0602060853i469d3449j5d2673b407aec460@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 08 Feb 2006 03:12:58 +0000
Message-Id: <1139368379.6422.180.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-02-06 at 17:53 +0100, Bartlomiej Zolnierkiewicz wrote:
> > +{
> > +       led_trigger_event(ide_led_trigger, LED_OFF);
> 
> It should check for blk_fs_request().
> 
> ->end_request() can be used for other request types.
> 
> > +       ide_end_request(drive, uptodate, nr_sectors);
> > +}
> > +
> >
> >  static void __exit idedisk_exit (void)
> >  {
> > +       led_trigger_unregister_simple(ide_led_trigger);
> >         driver_unregister(&idedisk_driver.gen_driver);
> 
> Shouldn't ordering be reverse to this in idedisk_init()?
> First driver_unregister(), then led_trigger_unregister_simple()?

The other issues should have been addressed in -mm now, thanks. An event
call after unregistering a trigger will not trouble the led trigger code
as it was designed to withstand this. In -mm it now matches the order in
the init function but this is purely cosmetic.

Richard

