Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760681AbWLFPAE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760681AbWLFPAE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 10:00:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760682AbWLFPAE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 10:00:04 -0500
Received: from styx.suse.cz ([82.119.242.94]:54342 "EHLO mail.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1760681AbWLFPAB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 10:00:01 -0500
Date: Wed, 6 Dec 2006 16:00:12 +0100 (CET)
From: Jiri Kosina <jkosina@suse.cz>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Li Yu <raise.sail@gmail.com>,
       Greg Kroah Hartman <greg@kroah.com>,
       linux-usb-devel <linux-usb-devel@lists.sourceforge.net>,
       LKML <linux-kernel@vger.kernel.org>,
       Vincent Legoll <vincentlegoll@gmail.com>,
       "Zephaniah E. Hull" <warp@aehallh.com>, liyu <liyu@ccoss.com.cn>
Subject: Re: [PATCH] usb/hid: The HID Simple Driver Interface 0.4.1 (core)
In-Reply-To: <1165415924.2756.63.camel@localhost>
Message-ID: <Pine.LNX.4.64.0612061549040.29624@jikos.suse.cz>
References: <200612061803324532133@gmail.com>  <Pine.LNX.4.64.0612061114560.28502@twin.jikos.cz>
  <d120d5000612060624o15f608dk83f35a228b9a6d18@mail.gmail.com>
 <1165415924.2756.63.camel@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Dec 2006, Marcel Holtmann wrote:

> > I still have the same objection - the "simple'" code will have to be
> > compiled into the driver instead of being a separate module and
> > eventyally will lead to a monster-size HID module. We have this issue
> > with psmouse to a degree but with HID the growth potential is much
> > bigger IMO.

I guess that this paragraph wasn't for me, but rather for the author of 
the HID Simple Driver proposal, am I right?

> > Jiri, I have not looked at your patches yet (I need to do that) but

Please do, when you will have time. Any comments are very welcome, before 
I start actually heading for the merge.

> The transport actually doesn't care on how you interpret or tweak the
> events. This is not its job. It is a simple plain stupid transport.
> Every additional driver that you put on top of the HID parser will look
> at the VID/PID and then decide which input event to send or what to do.
> So from my understanding the generic one should work just fine, but in
> case we need some special handling you can load an extra driver to
> handle this. And this could be done as HID driver. One driver could be
> the new hidraw driver to allow raw access to the HID reports.

Yes, the hidraw driver is one of the things that I am planning to develop 
on top of the generic HID layer, after the HID split gets merged. 

The current patches mainly take the contents of drivers/usb/input, and 
separate the code to transport-specific and the rest, which is then put 
into drivers/hid (of course some code changes are needed) and USB-specific 
HID code is then hooked into this new HID layer. 
I have tried to verify that hooking bluetooth, in the state in which it 
currently is (plus the patches which are not in mainline, also because of 
non-existence of common HID code), would stay relatively easy task, 
hopefully.

This split is quite painful, as there are many things happening in USB all 
the time, so the best way seem to be just to perform big split (with 
needed changes) at once, and then develop other things on top of it (like 
hidraw).

-- 
Jiri Kosina
SUSE Labs
