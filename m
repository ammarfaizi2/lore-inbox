Return-Path: <linux-kernel-owner+w=401wt.eu-S1750729AbXAQAkO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750729AbXAQAkO (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 19:40:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751830AbXAQAkO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 19:40:14 -0500
Received: from rhlx01.hs-esslingen.de ([129.143.116.10]:51545 "EHLO
	rhlx01.hs-esslingen.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750729AbXAQAkN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 19:40:13 -0500
Date: Wed, 17 Jan 2007 01:40:12 +0100
From: Andreas Mohr <andim2@users.sourceforge.net>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>,
       Linux usb mailing list 
	<linux-usb-devel@lists.sourceforge.net>
Subject: Re: 2.6.20-rc5: usb mouse breaks suspend to ram
Message-ID: <20070117004012.GA11140@rhlx01.hs-esslingen.de>
Reply-To: andi@lisas.de
References: <20070116135727.GA2831@elf.ucw.cz> <d120d5000701160608t73db4405n5d157db43899776a@mail.gmail.com> <20070116142432.GA6171@elf.ucw.cz> <d120d5000701161325h112a9299w944763b7f1032a61@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d120d5000701161325h112a9299w944763b7f1032a61@mail.gmail.com>
User-Agent: Mutt/1.4.2.2i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jan 16, 2007 at 04:25:20PM -0500, Dmitry Torokhov wrote:
> No, HID is the preferred... I am not sure what is going on - on my box
> STR does not work at all thanks to nvidia chip turning the display on
> all the way as the very last step of suspend ;(

One or several of these options might help cure this:
- agp=off kernel command line (plus AGP driver option enabled in nvidia xorg.conf)
- suspend: cat /proc/bus/pci/AA/BB.C >/tmp/video_state    --> resume
- suspend: vbetool vbestate save    --> resume
- directly after resume: vbetool post
- playing with chvt to not stay in X vt upon suspend
- acpi_sleep=s3_bios or acpi_sleep=s3_mode

Especially the PCI video_state trick finally got me a working resume on
2.6.19-ck2 r128 Rage Mobility M4 AGP *WITH*(!) fully enabled and working
(and keeping working!) DRI (3D).
Or, to be precise, video_state was the ticket to keeping X.org alive
after resume instead of near-100% X lockup, which then allowed
vbestate post to successfully deal with the remaining pixel line distortion
in order to get a clear display again.
And some agp hacks might have played a role here, too, need to investigate
this again and submit something if this is the case.

In your case this sounds like the all-too-familiar mis-signalling of the
TFT display causing it to "melt" which ends up with an all-white screen,
so this should most likely be cured via vbetool post or so.

keywords: agpgart r128 suspend resume vbetool intel-agp dri

Andreas Mohr
