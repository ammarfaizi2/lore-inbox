Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263903AbUAPF26 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 00:28:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265269AbUAPF26
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 00:28:58 -0500
Received: from web40707.mail.yahoo.com ([66.218.78.164]:58698 "HELO
	web40707.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263903AbUAPF2p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 00:28:45 -0500
Message-ID: <20040116052842.84253.qmail@web40707.mail.yahoo.com>
Date: Thu, 15 Jan 2004 23:28:42 -0600 (CST)
From: =?iso-8859-1?q?Kuroi?= <kuroi69@yahoo.com>
Subject: Trying to make a module
To: linux-kernel@vger.kernel.org
In-Reply-To: <20040116050613.GE1748@srv-lnx2600.matchmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everybody,

I am trying to make a driver for my WizardPen and I
found that a project existed for the kernel, I was
talking with the guy who wrote the mini faq and he
told me this:

The procedure to install the driver is the same as
described in the mini-howto, but after you have
patched your kernel, you just have to look hid-core.c
for :

> input->evbit[0] |= BIT(EV_MSC);
> input->mscbit[0] |= BIT(MSC_SERIAL);
> input_event(input, EV_MSC, MSC_SERIAL, 0);
> 
> And replace it by :
>
> struct hid_input* hidinput =
> list_entry(hid->inputs.next, struct
> hid_input,
> list);
> struct input_dev* input = &hidinput->input;
>
> input->evbit[0] |= BIT(EV_MSC);
> input->mscbit[0] |= BIT(MSC_SERIAL);
> input_event(input, EV_MSC, MSC_SERIAL, 0);

So I made it but, it fails givin me this output:

hid-core.c: In function `hid_input_report':
hid-core.c:945: error: structure has no member named
`input'
hid-core.c:946: error: structure has no member named
`input'
hid-core.c:947: error: structure has no member named
`input'
hid-core.c:943: warning: unused variable `input'
make[2]: *** [hid-core.o] Error 1
make[2]: Leaving directory
`/usr/src/linux-2.4.22-10mdk/drivers/usb'
make[1]: *** [_modsubdir_usb] Error 2
make[1]: Leaving directory
`/usr/src/linux-2.4.22-10mdk/drivers'
make: *** [_mod_drivers] Error 2

It appears that the USB API change, so someone could
help me telling me where I can find the new
specifications for the new API.

I am really new trying to change things in the kernel
but I want to learn.



_________________________________________________________
Do You Yahoo!?
Información de Estados Unidos y América Latina, en Yahoo! Noticias.
Visítanos en http://noticias.espanol.yahoo.com
