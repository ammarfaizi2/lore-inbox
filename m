Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424259AbWKJAIp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424259AbWKJAIp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 19:08:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424291AbWKJAIo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 19:08:44 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:42149 "EHLO
	out1.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S1424259AbWKJAIn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 19:08:43 -0500
X-Sasl-enc: lfSX4aQo80isWSg0nDYv3kizAFpEDj02s26QUW9d5ZuV 1163117322
Date: Thu, 9 Nov 2006 22:08:30 -0200
From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
To: Richard Purdie <rpurdie@rpsys.net>, benh@kernel.crashing.org,
       paulus@samba.org, Lennart Poettering <mzxreary@0pointer.de>,
       Andriy Skulysh <askulysh@image.kiev.ua>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
       Antonino Daplas <adaplas@pol.net>, Holger Macht <hmacht@suse.de>
Subject: Re: [PATCH] backlight: do not power off backlight when unregistering
Message-ID: <20061110000829.GA9021@khazad-dum.debian.net>
References: <20061105225429.GE14295@khazad-dum.debian.net> <1162773394.5473.18.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1162773394.5473.18.camel@localhost.localdomain>
X-GPG-Fingerprint: 1024D/1CDB0FE3 5422 5C61 F6B7 06FB 7E04  3738 EE25 DE3F 1CDB 0FE3
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 06 Nov 2006, Richard Purdie wrote:
> Those commits were designed to standardise several behaviours amongst
> several drivers and this specific case was added to the core rather than
> coding it in each of several drivers. We therefore really need to update
> those other drivers too (locomo at the very least).

The following in-tree drivers need changes:
drivers/video/backlight/locomolcd.c
drivers/video/backlight/hp680_bl.c
drivers/video/backlight/corgi_bl.c

I will repost the patch with locomolcd.c and hp680_bl.c included.

The following in-tree (latest linux-2.6 git tree) drivers are desktop/laptop
devices and likely do not want the "dim and power off backlight on
backlight_device_unregister" behavior:

drivers/video/aty/*
drivers/video/riva/fbdev.c
drivers/video/nvidia/nv_backlight.c
drivers/misc/msi-laptop.c

The ACPI drivers being converted to backlight sysfs are very unlikely to
want the "power off backlight on backlight_device_unregister" behavior, so I
have not hunted after backlight sysfs conversions in the linux-acpi-2.6 git
tree.  Still, linux-acpi is cc'ed.

I have CC'ed the relevant people (please forgive me any ommissions) for the
drivers listed above, so they can chime in if their driver should retain the
"dim and power off backlight on backlight_device_unregister" behaviour.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
