Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754889AbWKQIMT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754889AbWKQIMT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 03:12:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754891AbWKQIMT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 03:12:19 -0500
Received: from s131.mittwaldmedien.de ([62.216.178.31]:58199 "EHLO
	s131.mittwaldmedien.de") by vger.kernel.org with ESMTP
	id S1754889AbWKQIMT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 03:12:19 -0500
From: Holger Schurig <hs4233@mail.mn-solutions.de>
To: Daniel Ritz <daniel.ritz-ml@swissonline.ch>
Subject: Re: [PATCH] usb: generic calibration support
Date: Fri, 17 Nov 2006 09:12:29 +0100
User-Agent: KMail/1.9.5
Cc: daniel.ritz@gmx.ch, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net,
       Dmitry Torokhov <dmitry.torokhov@gmail.com>
References: <200611161125.38901.hs4233@mail.mn-solutions.de> <200611170024.33248.daniel.ritz-ml@swissonline.ch>
In-Reply-To: <200611170024.33248.daniel.ritz-ml@swissonline.ch>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200611170912.29317.hs4233@mail.mn-solutions.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> sorry, but i have to give you a big NACK on that one:

Hehe, I actually anticipated this NACK :-)

> - no more modparam: it should be per-device sysfs attributes
>   (swap_xy is basically only for touchkitusb compatibility and 
>    shoud be converted to per-device sysfs attribute as well. i
>   just never got to do it)

That would be okay for me.

> - calibration can be handled in userspace just fine

Yes it can, and that is the most convinging argument against my 
patch.

However, user-space calibration often sucks. For example, in X11 
the calibration values are stored in /etc/X11/xorg.conf, so a 
calibration program has to parse & write that file. And I've 
seen binary-only-calibration programs from vendors 
use /etc/X11/XF86Config, which doesn't exist here. Anyway, once 
you've calibrated you have to restart X-Windows, so you need to 
terminate all running X applications just because of a silly 
re-calibration. Not nice.

A calibration at kernel level (may it be input level or driver 
level) doesn't have this problem. I can make the level 
persistent via udev, modules.conf or other means. Even when I 
have a frame-buffer based calibration utility, the calibration 
would be OK for X11 or GTK/DirectFB as well.

For me, this speaks against "Calibration is purely a user-space 
problem".

> - even for in-kernel it's in the wrong place. there are other
>   devices that report raw absolute data...so it would belong to
>   the input layer 

Suppose I have a graphics tabled and a touchscreen connected at 
the same time. Can I distinguish this easily at the input layer 
level?

I can very easily distinguish this at the device driver level. 
After all, the individual calibration parameters are a property 
of this individual device.
