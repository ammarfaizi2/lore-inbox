Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932211AbWHKM10@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932211AbWHKM10 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 08:27:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932214AbWHKM10
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 08:27:26 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:21632 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932211AbWHKM1Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 08:27:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IhZPz1UvEXLfayyHWaLx3aoMmR007x1SB0xmz6A9/UZ6B7+5dAF1W+OI74QPefrJpBCAthsAPMrKwOrNP1rwaHBs9mvO+zoL22ALVF+CiDfJQZnOLSrsxsu+s2e1XzSolj3ZiPHWQQnviSZTjxfYs2Kzq8nWYiFI6r0YR8vWjDk=
Message-ID: <d120d5000608110527q142a727ex5c2223a9aed5aeaa@mail.gmail.com>
Date: Fri, 11 Aug 2006 08:27:19 -0400
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
To: "Richard Purdie" <rpurdie@rpsys.net>
Subject: Re: [patch 6/6] Move per-device data out of backlight_properties
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1155283327.6354.6.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060811050310.958962036.dtor@insightbb.com>
	 <20060811050611.655659401.dtor@insightbb.com>
	 <1155283327.6354.6.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/11/06, Richard Purdie <rpurdie@rpsys.net> wrote:
> On Fri, 2006-08-11 at 01:03 -0400, Dmitry Torokhov wrote:
> > plain text document attachment (backlight-move-data.patch)
> > Backlight: move per-device data out of backlight_properties
> >
> > Data such as current brightness belongs to a device and should not
> > be part of a structure shared between several devices.
>
> I agree there's an issue to address here. Looking at this patch very
> quickly, it breaks all the existing backlight drivers as they know about
> the variables in struct backlight_properties and all their references
> need to be updated e.g.: corgi_bl.c:
>
> if (bd->props->power != FB_BLANK_UNBLANK)
> intensity = 0;
> if (bd->props->fb_blank != FB_BLANK_UNBLANK)
> intensity = 0;
>

Oops, I had them all updated but apparently lost that change. I'll fix
it and resend.

> Thinking about this, ideally, struct backlight_properties would be left
> containing the backlight properties in but become part of struct
> backlight_device (and allocated with it).

Why would you want to separate properties into a structure? You don't
normally pass a set of properties around so I am not sure why would we
need this...

-- 
Dmitry
