Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965041AbVHJH5M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965041AbVHJH5M (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 03:57:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965043AbVHJH5M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 03:57:12 -0400
Received: from mail9.messagelabs.com ([194.205.110.133]:1208 "HELO
	mail9.messagelabs.com") by vger.kernel.org with SMTP
	id S965041AbVHJH5L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 03:57:11 -0400
X-VirusChecked: Checked
X-Env-Sender: icampbell@arcom.com
X-Msg-Ref: server-32.tower-9.messagelabs.com!1123660622!0!1
X-StarScan-Version: 5.4.15; banners=arcom.com,-,-
X-Originating-IP: [194.200.159.164]
Subject: Re: deactivating PXA255 watchdog
From: Ian Campbell <icampbell@arcom.com>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: Russell King <linux@arm.linux.org.uk>, Nicolas Pitre <nico@cam.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050809192437.GJ499@infomag.infomag.iguana.be>
References: <1117700284.3063.51.camel@icampbell-debian>
	 <20050809192437.GJ499@infomag.infomag.iguana.be>
Content-Type: text/plain
Organization: Arcom Control Systems
Date: Wed, 10 Aug 2005 08:57:00 +0100
Message-Id: <1123660620.13258.32.camel@icampbell-debian>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
X-IMAIL-SPAM-VALHELO: (23265432)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-08-09 at 21:24 +0200, Wim Van Sebroeck wrote:
> Hi Ian,
> 
> > I think you are the current "watchdog guy", although watchdog doesn't
> > have a MAINTAINERS entry so I'm looking at bk/lkml history etc and might
> > be mistaken...
> 
> Sorry for the late response. I indeed try to maintain the watchdog drivers
> and get a uniform API for all the watchdog drivers.
> 
> > I wrote to the the linux-arm-kernel mailing list recently with a query
> > because the sa1100_wdt code supports the writing 'V' to deactivate the
> > watchdog thing, but unfortunately once armed the hardware cannot be
> > deactivated. 
> > 
> > I was going to produce a patch to remove the 'V' support and it was
> > suggested by Russell that I should ask for your opinion. Do you have a
> > preference with regards to offering a warning or error etc if a 'V' is
> > written?
> > 
> > My original message is below. I have had confirmation that the SA1100
> > has the same behaviour as PXA2xx from Nico.
> 
> the actual problem you have is not the magic char 'V' that needs to be
> written to safely stop the watchdog. The problem is that your watchdog
> can not be stopped once started.
> What we should do (in my opinion) is to add a timer like done in
> mixcomwd.c. What this timer does is ping/tickle the watchdog internally
> when the watchdog is supposed to be not active. (So it starts pinging
> the watchdog after userspace stopped/released /dev/watchdog and it stops
> again when the userspace opens /dev/atchdog again).
> The writing of the magic char V is a failsafe mechanism for if the 
> watchdog daemon would crash and close /dev/watchdog when it is supposed
> to keep working...

A patch to simply pull out the 'V' failsafe handling was already merged
into the kernel.

I can try and find time to look at adding a timer etc but it might be
some time so if you feel like doing it please feel free.

Ian.
-- 
Ian Campbell, Senior Design Engineer
                                        Web: http://www.arcom.com
Arcom, Clifton Road,                    Direct: +44 (0)1223 403 465
Cambridge CB1 7EA, United Kingdom       Phone:  +44 (0)1223 411 200


_____________________________________________________________________
The message in this transmission is sent in confidence for the attention of the addressee only and should not be disclosed to any other party. Unauthorised recipients are requested to preserve this confidentiality. Please advise the sender if the addressee is not resident at the receiving end.  Email to and from Arcom is automatically monitored for operational and lawful business reasons.

This message has been virus scanned by MessageLabs.
