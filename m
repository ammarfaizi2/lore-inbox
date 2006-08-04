Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161576AbWHDXYk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161576AbWHDXYk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 19:24:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161578AbWHDXYk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 19:24:40 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:32947 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1161576AbWHDXYj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 19:24:39 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=QjebquwwQmuLM2gFxs08uVI845QZ8RO3NwL7yXv7Lccs5bOtIx/sic4OOGroLlemAG0hGMxkHufOcAYhw/N8jwtBegtyH7dxXMVDj+UoKxIqqabg0pSdqRrbU2N86n0rwQo5lIdv9W3SxJzeuEbChjslSRUdBNG0EEI6vCtrZR8=
Message-ID: <44D3D747.9050605@gmail.com>
Date: Sat, 05 Aug 2006 01:24:32 +0159
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 2.0a1 (X11/20060724)
MIME-Version: 1.0
To: liyu <liyu@ccoss.com.cn>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: Microsoft Natural Ergonomic Keyboard 4000 Driver
 0.3.0
References: <200608031807374336989@ccoss.com.cn>
In-Reply-To: <200608031807374336989@ccoss.com.cn>
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

liyu wrote:
> This Patch require the "[PATCH] usb: The HID Simple Driver Interface 0.3.0".
> 
> Changelogs:
> 
> 	1. Rewrite under HID simple driver framework version 0.3.0, it is more smaller.
> 		
> Signed-off-by: Liyu <liyu@ccoss.com.cn>
> 
> diff -Naurp linux-2.6.17.7/drivers/usb/input.orig/usbnek4k.c linux-2.6.17.7/drivers/usb/input/usbnek4k.c
> --- linux-2.6.17.7/drivers/usb/input.orig/usbnek4k.c	1970-01-01 08:00:00.000000000 +0800
> +++ linux-2.6.17.7/drivers/usb/input/usbnek4k.c	2006-08-03 17:34:02.000000000 +0800
> @@ -0,0 +1,196 @@
> +/*
> + *  
> + *
> + *  Version:	0.3.0
> + *
> + *  Copyright (c) 2006 Liyu <liyu@ccoss.com.cn>
> + */
> +
> +/*
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License as published by the Free
> + * Software Foundation; either version 2 of the License, or (at your option)
> + * any later version.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/input.h>
> +#include "hid.h"
> +#include "hid-simple.h"
> +
> +#define USAGE_ZOOM_IN 0x22d
> +#define USAGE_ZOOM_OUT 0x22e
> +#define USAGE_HOME	0x223
> +#define USAGE_SEARCH	0x221
> +#define USAGE_EMAIL	0x18a
> +#define USAGE_FAVORITES	0x182
> +#define USAGE_MUTE	0xe2
> +#define USAGE_VOLUME_DOWN	0xea
> +#define USAGE_VOLUME_UP	0xe9
> +#define USAGE_PLAY_PAUSE	0xcd
> +#define USAGE_CALCULATOR	0x192
> +#define USAGE_BACK	0x224
> +#define USAGE_FORWARD	0x225
> +#define USAGE_CUSTOM	0xff05
> +
> +#define USAGE_CUSTOM_RELEASE	0x0
> +#define USAGE_CUSTOM_1	0x1
> +#define USAGE_CUSTOM_2	0x2
> +#define USAGE_CUSTOM_3	0x4
> +#define USAGE_CUSTOM_4	0x8
> +#define USAGE_CUSTOM_5	0x10
> +
> +#define USAGE_HELP	0x95
> +#define USAGE_UNDO	0x21a
> +#define USAGE_REDO	0x279
> +#define USAGE_NEW	0x201
> +#define USAGE_OPEN	0x202
> +#define USAGE_CLOSE	0x203
> +
> +#define USAGE_REPLY	0x289
> +#define USAGE_FWD	0x28b
> +#define USAGE_SEND	0x28c
> +#define USAGE_SPELL	0x1ab
> +#define USAGE_SAVE	0x207
> +#define USAGE_PRINT	0x208
> +
> +#define USAGE_KEYPAD_EQUAL 0x67
> +#define USAGE_KEYPAD_LEFT_PAREN 0xb6
> +#define USAGE_KEYPAD_RIGHT_PAREN 0xb7
> +
> +#define MSNEK4K_ID_VENDOR	0x045e
> +#define MSNEK4K_ID_PRODUCT	0x00db

pci_ids.h might be preffered place for IDS

> +
> +static struct usb_device_id nek4k_id_table[] = {
> +	{
> +		USB_DEVICE(MSNEK4K_ID_VENDOR, MSNEK4K_ID_PRODUCT)
> +	},
> +	{}
> +};
> +
> +
> +static struct usb_device_id __id[] = {
> +	{
> +		USB_DEVICE(MSNEK4K_ID_VENDOR, MSNEK4K_ID_PRODUCT)
> +	},
> +	{}
> +};
> +
> +MODULE_DEVICE_TABLE(usb, __id);

What's the purpose of double table?

> +
> +static char driver_name[] = "Microsoft Natural Ergonomic Keyboard 4000";
> +
> +struct usage_block consumer_usage_block[] = {
> +	USAGE_BLOCK(USAGE_ZOOM_IN, 0, EV_KEY, KEY_F13, 0),
> +	USAGE_BLOCK(USAGE_ZOOM_OUT, 0, EV_KEY, KEY_F14, 0),
> +	USAGE_BLOCK(USAGE_HOME, 0, EV_KEY, KEY_HOMEPAGE, 0),
> +	USAGE_BLOCK(USAGE_SEARCH, 0, EV_KEY, KEY_SEARCH, 0),
> +	USAGE_BLOCK(USAGE_EMAIL, 0, EV_KEY, KEY_EMAIL, 0),
> +	USAGE_BLOCK(USAGE_FAVORITES, 0, EV_KEY, KEY_FAVORITES, 0),
> +	USAGE_BLOCK(USAGE_MUTE, 0, EV_KEY, KEY_MUTE, 0),
> +	USAGE_BLOCK(USAGE_VOLUME_DOWN, 0, EV_KEY, KEY_VOLUMEDOWN, 0),
> +	USAGE_BLOCK(USAGE_VOLUME_UP, 0, EV_KEY, KEY_VOLUMEUP, 0),
> +	USAGE_BLOCK(USAGE_PLAY_PAUSE, 0, EV_KEY, KEY_PLAYPAUSE, 0),
> +	USAGE_BLOCK(USAGE_CALCULATOR, 0, EV_KEY, KEY_CALC, 0),
> +	USAGE_BLOCK(USAGE_BACK, 0, EV_KEY, KEY_BACK, 0),
> +	USAGE_BLOCK(USAGE_FORWARD, 0, EV_KEY, KEY_FORWARD, 0),
> +	USAGE_BLOCK(USAGE_HELP, 0, EV_KEY, KEY_HELP, 0),
> +	USAGE_BLOCK(USAGE_UNDO, 0, EV_KEY, KEY_UNDO, 0),
> +	USAGE_BLOCK(USAGE_REDO, 0, EV_KEY, KEY_REDO, 0),
> +	USAGE_BLOCK(USAGE_NEW, 0, EV_KEY, KEY_NEW, 0),
> +	USAGE_BLOCK(USAGE_OPEN, 0, EV_KEY, KEY_OPEN, 0),
> +	USAGE_BLOCK(USAGE_CLOSE, 0, EV_KEY, KEY_CLOSE, 0),
> +	USAGE_BLOCK(USAGE_REPLY, 0, EV_KEY, KEY_REPLY, 0),
> +	USAGE_BLOCK(USAGE_FWD, 0, EV_KEY, KEY_FORWARDMAIL, 0),
> +	USAGE_BLOCK(USAGE_SEND, 0, EV_KEY, KEY_SEND, 0),
> +	USAGE_BLOCK(USAGE_SPELL, 0, EV_KEY, KEY_F15, 0),
> +	USAGE_BLOCK(USAGE_SAVE, 0, EV_KEY, KEY_SAVE, 0),
> +	USAGE_BLOCK(USAGE_PRINT, 0, EV_KEY, KEY_PRINT, 0),
> +	USAGE_BLOCK_NULL
> +};
> +
> +struct usage_block msvendor_usage_block[] = {
> +	USAGE_BLOCK(USAGE_CUSTOM, USAGE_CUSTOM_1, EV_KEY, KEY_FN_F1, 0),
> +	USAGE_BLOCK(USAGE_CUSTOM, USAGE_CUSTOM_2, EV_KEY, KEY_FN_F2, 0),
> +	USAGE_BLOCK(USAGE_CUSTOM, USAGE_CUSTOM_3, EV_KEY, KEY_FN_F3, 0),
> +	USAGE_BLOCK(USAGE_CUSTOM, USAGE_CUSTOM_4, EV_KEY, KEY_FN_F4, 0),
> +	USAGE_BLOCK(USAGE_CUSTOM, USAGE_CUSTOM_5, EV_KEY, KEY_FN_F5, 0),
> +	USAGE_BLOCK_NULL
> +};
> +
> +struct usage_block keyboard_usage_block[] = {
> +	USAGE_BLOCK(USAGE_KEYPAD_EQUAL, 0, EV_KEY, KEY_KPEQUAL, 0),
> +	USAGE_BLOCK(USAGE_KEYPAD_LEFT_PAREN, 0, EV_KEY, KEY_KPLEFTPAREN, 0),
> +	USAGE_BLOCK(USAGE_KEYPAD_RIGHT_PAREN, 0, EV_KEY, KEY_KPRIGHTPAREN, 0),
> +	USAGE_BLOCK_NULL
> +};
> +
> +struct usage_page_block nek4k_usage_page_blockes[] = {
> +	USAGE_PAGE_BLOCK(HID_UP_CONSUMER, consumer_usage_block),
> +	USAGE_PAGE_BLOCK(HID_UP_MSVENDOR, msvendor_usage_block),
> +	USAGE_PAGE_BLOCK(HID_UP_KEYBOARD, keyboard_usage_block),
> +	USAGE_PAGE_BLOCK_NULL
> +};
> +
> +static int

we are not in bsd. put these on the line with the name of function.

> +nek4k_hid_event(const struct hid_device *hid, const struct hid_field *field,
> +			const struct hid_usage *usage, const __s32 value,
> +						const struct pt_regs *regs)

more coherent indent here, please

> +{
> +	struct hid_input *hidinput = field->hidinput;
> +	struct input_dev *input = hidinput->input;
> +	int code=0;

int code = 0; here

> +
> +	if ( (usage->hid&HID_USAGE_PAGE) != HID_UP_MSVENDOR ||
> +	     (usage->hid&HID_USAGE) != USAGE_CUSTOM ) {
> +		return (!0);

What the hell?

> +	}

superfluous { }

> +	
> +	switch (value) {
> +		case USAGE_CUSTOM_RELEASE:
> +			code = (int)hidinput->private;
> +			hidinput->private = NULL;
> +			input_event(input, EV_KEY, code, 0);
> +			input_sync(input);
> +			return 0;
> +		case USAGE_CUSTOM_1:
> +			code = KEY_FN_F1;	break;
> +		case USAGE_CUSTOM_2:
> +			code = KEY_FN_F2;	break;
> +		case USAGE_CUSTOM_3:
> +			code = KEY_FN_F3;	break;
> +		case USAGE_CUSTOM_4:
> +			code = KEY_FN_F4;	break;
> +		case USAGE_CUSTOM_5:
> +			code = KEY_FN_F5;	break;

just-one-expr on the line, please

> +	};

bad switch/case indent

> +	if (code) {
> +		hidinput->private = (void*)code;
> +		input_event(input, EV_KEY, code, 1);
> +		input_sync(input);
> +	}
> +	return 0; 
> +}
> +

regards,
-- 
<a href="http://www.fi.muni.cz/~xslaby/">Jiri Slaby</a>
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
