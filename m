Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267733AbTAIUP5>; Thu, 9 Jan 2003 15:15:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267738AbTAIUP5>; Thu, 9 Jan 2003 15:15:57 -0500
Received: from dhcp024-209-039-102.neo.rr.com ([24.209.39.102]:34951 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id <S267733AbTAIUPz>;
	Thu, 9 Jan 2003 15:15:55 -0500
Date: Thu, 9 Jan 2003 15:26:54 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: "Ruslan U. Zakirov" <cubic@wildrose.miee.ru>
Cc: greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: [2.5.54][PATCH] SB16 convertation to new PnP layer.
Message-ID: <20030109152654.GC17701@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	"Ruslan U. Zakirov" <cubic@wildrose.miee.ru>, greg@kroah.com,
	linux-kernel@vger.kernel.org
References: <Pine.BSF.4.05.10301081959130.88742-100000@wildrose.miee.ru> <20030108160939.GA17701@neo.rr.com> <59522031471.20030109183512@wr.miee.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59522031471.20030109183512@wr.miee.ru>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 09, 2003 at 06:35:12PM +0300, Ruslan U. Zakirov wrote:

> 1) As I've understood we need to free all reserved resources when
> remove function called, am I right?

Yes, all resources must be freed or the device will not work if it is
attached to the driver a second time.  This is becuase the driver will
think the device is busy when actually the resources were just never
freed from the previous session.  Also the resources must be freed to
safetly disable the device.


> 2) Who decide card is accessible at some time or not?

This is determined by both the pnp layer and the driver model.  Becuase a
card is a group of devices the individual devices must also not be matched
to more than one driver.  PnP Card Services have a few bugs in this area,
all of which have been resolved in the patch I released last week.  Greg,
could you please forward that to Linus.


> 3) And the last, where is the place of ISA not PnP cards in the device
> lists? As I think, they are fit with PnP bus, but their resources
> static(not configurable) or it's just lays under ALSA, apears in
> /proc/asound only and ALSA internals?

Currently the pnp layer does not support legacy non PnP devices.  I plan
to add support for them soon.  This support should achieve two objectives.
1.) Reserve resources used by the legacy devices
	a.) if the resources match an existing pnp devices, bind to that
	    device
	b.) if they conflict but do not match exactly return an error
	c.) otherwise reserve the resources and prevent pnp devices from
	    using them.
2.) Represent these legacy devices in sysfs.  Maybe the current legacy dir
    could be used or I may have to create "pnp_legacy".  Needs more research.

Regards,
Adam
