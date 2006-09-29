Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750899AbWI3MBP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750899AbWI3MBP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 08:01:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750901AbWI3MBP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 08:01:15 -0400
Received: (root@vger.kernel.org) by vger.kernel.org id S1750894AbWI3MBO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 08:01:14 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:4944 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751176AbWI2Rf6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 13:35:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=l6CvXJAJ1ZVx54SD3Q8q4npNRKuvdVCoDp5ycO50HlB1+QcIEoq47j6LdO2Bjz+4gLd9wVh0VgIlepJLeWzt2HJOKeRRCLGChUFmscLUspP6I0Ka78P8hk46iY859tYGeLxUI2Q0Z4jX5YxbNqzXJMejR0KdQhOAunnM4q8ODNE=
Message-ID: <d120d5000609291035q7dad5f7fqcb38d4d8b3b211e5@mail.gmail.com>
Date: Fri, 29 Sep 2006 13:35:56 -0400
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
To: "Randy Dunlap" <rdunlap@xenotime.net>
Subject: Re: [PATCH] usb/hid: The HID Simple Driver Interface 0.3.2 (core)
Cc: "raise.sail" <raise.sail@gmail.com>, LKML <linux-kernel@vger.kernel.org>,
       linux-usb-devel <linux-usb-devel@lists.sourceforge.net>,
       greg <greg@kroah.com>
Illegal-Object: Syntax error in Cc: address found on vger.kernel.org:
	Cc:	raise.sail<raise.sail@gmail.com>
				  ^-missing end of address
Illegal-Object: Syntax error in Cc: address found on vger.kernel.org:
	Cc:	raise.sail<raise.sail@gmail.com>
				  ^-missing end of address
Illegal-Object: Syntax error in Cc: address found on vger.kernel.org:
	Cc:	raise.sail<raise.sail@gmail.com>
				  ^-missing end of address
Illegal-Object: Syntax error in Cc: address found on vger.kernel.org:
	Cc:	raise.sail<raise.sail@gmail.com>
				  ^-missing end of address
In-Reply-To: <20060929095913.f1b6f79d.rdunlap@xenotime.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200609291624123283320@gmail.com>
	 <20060929095913.f1b6f79d.rdunlap@xenotime.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/29/06, Randy Dunlap <rdunlap@xenotime.net> wrote:
> On Fri, 29 Sep 2006 16:24:15 +0800 raise.sail wrote:
>
> > Changelogs:
> >
> >       1. A bugfix for clear usage process.
> >
> > This driver requires:
> >       1.  [PATCH] usb: HID Simple Driver Interface 0.3.1 (Kconfig and Makefile), this patch can be used without any change.
> >
> > PS:   Who is the maintainer of the input subsystem today? Should I forward this mail to him/her?
>

I re-read these patches again and the main problem with the current
implementation is that it alters input devices's properties after
device has been registered and presented to userspace. That means that
hotplug users that presently can inspect device's capabilities and
decide if they are "interested" in device will not be able to do so
anymore. For example I think X event interface drivers examine input
devices and decide if it should be handled by as keyboard or pointing
device so it is possible for them to not notice that touchpad
capabilities were added to a keyboard later. For now the only thing
that is allowed to change after device has been registered is keymap.

Then there is issue with automatic loading of these sub-drivers. How
do they get loaded? Or we force everything to be built-in making HID
module very fat (like psmouse got pretty fat, but with HID prtential
for it to get very fat is much bigger).

The better way would be to split hid-input into a library module that
parses hid usages and reports and is shared between device-specific
modules that are "real" drivers (usb-drivers, not hid-sub-drivers).

-- 
Dmitry
