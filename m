Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262838AbUA3LBw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 06:01:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262901AbUA3LBw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 06:01:52 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:35201 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S262838AbUA3LBt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 06:01:49 -0500
Date: Fri, 30 Jan 2004 12:02:05 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.2-rc2-mm1
Message-ID: <20040130110205.GA1583@ucw.cz>
References: <20040127233402.6f5d3497.akpm@osdl.org> <20040130104829.GA2505@babylon.d2dc.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040130104829.GA2505@babylon.d2dc.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 30, 2004 at 05:48:29AM -0500, Zephaniah E. Hull wrote:
> On Tue, Jan 27, 2004 at 11:34:02PM -0800, Andrew Morton wrote:
> > 
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.2-rc2/2.6.2-rc2-mm1/
> > 
> > - From now on, -mm kernels will contain the latest contents of:
> > 
> > 	Vojtech's tree:		input.patch
> 
> This one seems to have a rather problematic patch, which I can't find
> any explanation for.

There is another revision of the same mouse from A4Tech (owned by
Jaroslav Kysela), that reports itself as Cypress and has the buttons a
bit differently.

If it indeed collides with your mouse, then we need somehow to specify
which button carries the wheel information in the quirk list.

> 
> Specificly:
> <snip>
> diff -Nru a/drivers/usb/input/hid-input.c b/drivers/usb/input/hid-input.c
> --- a/drivers/usb/input/hid-input.c	Thu Jan 29 22:57:25 2004
> +++ b/drivers/usb/input/hid-input.c	Thu Jan 29 22:57:25 2004
> @@ -432,20 +432,21 @@
>  	input_regs(input, regs);
>  
>  	if ((hid->quirks & HID_QUIRK_2WHEEL_MOUSE_HACK)
> -			&& (usage->code == BTN_BACK)) {
> +			&& (usage->code == BTN_BACK || usage->code == BTN_EXTRA)) {
>  		if (value)
>  			hid->quirks |= HID_QUIRK_2WHEEL_MOUSE_HACK_ON;
>  		else
>  			hid->quirks &= ~HID_QUIRK_2WHEEL_MOUSE_HACK_ON;
>  		return;
>  	}
> <snip>
> 
> This seems to be due to trying to use the same flag for
> USB_DEVICE_ID_CYPRESS_MOUSE as well, however this is very wrong.
> 
> The original user of HID_QUIRK_2WHEEL_MOUSE_HACK,
> USB_DEVICE_ID_A4TECH_WCP32PU, actually /HAS/ a button labeled BTN_EXTRA,
> which after this patch can no longer even be used.
> 
> The only proper approach is to rename HID_QUIRK_2WHEEL_MOUSE_HACK and
> add a new one for the Cypress mouse as well.
> 
> If need be I can generate such a patch, however I will need to know what
> to generate it against.
> 
> Zephaniah E. Hull.
> (Original author of the HID_QUIRK_2WHEEL_MOUSE_HACK patch.)
> 
> -- 
> 	1024D/E65A7801 Zephaniah E. Hull <warp@babylon.d2dc.net>
> 	   92ED 94E4 B1E6 3624 226D  5727 4453 008B E65A 7801
> 	    CCs of replies from mailing lists are requested.
> 
> If I have trouble installing Linux, something is wrong. Very wrong.
>   -- Linus Torvalds on l-k.



-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
