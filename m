Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750762AbWHKICU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750762AbWHKICU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 04:02:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750763AbWHKICU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 04:02:20 -0400
Received: from tim.rpsys.net ([194.106.48.114]:30431 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S1750762AbWHKICT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 04:02:19 -0400
Subject: Re: [patch 6/6] Move per-device data out of backlight_properties
From: Richard Purdie <rpurdie@rpsys.net>
To: Dmitry Torokhov <dtor@insightbb.com>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20060811050611.655659401.dtor@insightbb.com>
References: <20060811050310.958962036.dtor@insightbb.com>
	 <20060811050611.655659401.dtor@insightbb.com>
Content-Type: text/plain
Date: Fri, 11 Aug 2006 09:02:07 +0100
Message-Id: <1155283327.6354.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-08-11 at 01:03 -0400, Dmitry Torokhov wrote:
> plain text document attachment (backlight-move-data.patch)
> Backlight: move per-device data out of backlight_properties
> 
> Data such as current brightness belongs to a device and should not
> be part of a structure shared between several devices.

I agree there's an issue to address here. Looking at this patch very
quickly, it breaks all the existing backlight drivers as they know about
the variables in struct backlight_properties and all their references
need to be updated e.g.: corgi_bl.c:

if (bd->props->power != FB_BLANK_UNBLANK)
intensity = 0;
if (bd->props->fb_blank != FB_BLANK_UNBLANK)
intensity = 0;

Thinking about this, ideally, struct backlight_properties would be left
containing the backlight properties in but become part of struct
backlight_device (and allocated with it). The drivers would provide a
new struct backlight_ops instead of the properties struct at present and
the function pointers would move to that structure.

Your other patches looked ok at a quick glance. I'll aim to test them
against the corgi driver over the weekend and I look at reworking this
one, unless you want beat me to it :)

Cheers,

Richard


