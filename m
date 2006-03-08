Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751171AbWCHJsW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751171AbWCHJsW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 04:48:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932530AbWCHJsV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 04:48:21 -0500
Received: from mail.homelink.ru ([81.9.33.123]:45265 "EHLO eltel.net")
	by vger.kernel.org with ESMTP id S1751689AbWCHJsV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 04:48:21 -0500
Date: Wed, 8 Mar 2006 12:48:07 +0300
From: Andrew Zabolotny <zap@homelink.ru>
To: Richard Purdie <rpurdie@rpsys.net>
Cc: adaplas@gmail.com, linux-fbdev-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: RFC: Backlight Class sysfs attribute behaviour
Message-Id: <20060308124807.6b995cf4.zap@homelink.ru>
In-Reply-To: <1141686307.6524.98.camel@localhost.localdomain>
References: <1141571334.6521.38.camel@localhost.localdomain>
	<440B89AB.3020203@gmail.com>
	<1141634729.6524.14.camel@localhost.localdomain>
	<20060307000718.0e8b8be3.zap@homelink.ru>
	<1141686307.6524.98.camel@localhost.localdomain>
Organization: home
X-Mailer: Sylpheed version 2.0.0beta6 (GTK+ 2.6.7; i686-pc-linux-gnu)
X-Face: #%`a@cSvZ:n@M%n/to$C^!{JE%'%7_0xb("Hr%7Z0LDKO7?w=m~CU#d@-.2yO<l^giDz{>9
 epB|2@pe{%4[Q3pw""FeqiT6rOc>+8|ED/6=Eh/4l3Ru>qRC]ef%ojRz;GQb=uqI<yb'yaIIzq^NlL
 rf<gnIz)JE/7:KmSsR[wN`b\l8:z%^[gNq#d1\QSuya1(
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 06 Mar 2006 23:05:07 +0000
Richard Purdie <rpurdie@rpsys.net> wrote:

> My driver_brightness is really a more generic version of your
> "hw_power" which allows other factors to be taken into consideration
> as well. We may as well have the broader-range solution as it costs
> us nothing.
Ok, your solution seems fine to me. In fact, with the old backend we
don't have guarantees that current hardware state can be read in
general; it just happened to be true for used hardware.

I just would propose to change the prototype of

int (*set_status)(struct backlight_device *, int brightness, int power,
int fb_blank);

to 

int (*set_status)(struct backlight_device *, struct backlight_status *);

This will allow adding new factors without changing the prototype
(thus without breaking old drivers which will simply ignore new added
factors).

I'm also not sure what should return

int (*get_status)(struct backlight_device *);

the brightness or the power status? Maybe it should be:

int (*get_status)(struct backlight_device *, struct backlight_status *);

-- 
Greetings,
   Andrew
