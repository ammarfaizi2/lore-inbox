Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261191AbVHBFEb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261191AbVHBFEb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 01:04:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261365AbVHBFEb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 01:04:31 -0400
Received: from zproxy.gmail.com ([64.233.162.200]:3895 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261191AbVHBFEa convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 01:04:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NRbaRN7Hg/S7YrzjeLHDXPFYi/0U4MUWV/H/TdIAERibTv4bcpzTNSxa3ucZ6JT8zOlB9frT33XzXzpSEAw5QsQvLOPb8ZhOb/VNKQ7StUmB3/cileVuGwlVnFBOpq73/tr86pLee0MxJJRQ11T9eiBG3Xy3W+poSWys3KUKAuU=
Message-ID: <1c1c8636050801220442d8351c@mail.gmail.com>
Date: Tue, 2 Aug 2005 17:04:29 +1200
From: mdew <some.nzguy@gmail.com>
Reply-To: mdew <some.nzguy@gmail.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Fw: ati-remote strangeness from 2.6.12 onwards
Cc: linux-usb-devel@lists.sourceforge.net, Vojtech Pavlik <vojtech@suse.cz>,
       Dmitry Torokhov <dtor_core@ameritech.net>
In-Reply-To: <20050730173253.693484a2.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050730173253.693484a2.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I discovered a minor change in 2.6.10-mm1, changing this value back
corrects the "ok" button issue.


diff -urN linux/drivers/usb/input/ati_remote.c
linux-2.6.11/drivers/usb/input/ati_remote.c
--- linux/drivers/usb/input/ati_remote.c        2005-08-02
17:56:26.000000000 +1200
+++ linux-2.6.11/drivers/usb/input/ati_remote.c 2005-08-02
17:54:34.000000000 +1200
@@ -263,7 +263,7 @@
        {KIND_FILTERED, 0xe4, 0x1f, EV_KEY, KEY_RIGHT, 1},      /* right */
        {KIND_FILTERED, 0xe7, 0x22, EV_KEY, KEY_DOWN, 1},       /* down */
        {KIND_FILTERED, 0xdf, 0x1a, EV_KEY, KEY_UP, 1},         /* up */
-       {KIND_FILTERED, 0xe3, 0x1e, EV_KEY, KEY_ENTER, 1},      /* "OK" */
+       {KIND_FILTERED, 0xe3, 0x1e, EV_KEY, KEY_OK, 1},         /* "OK" */
        {KIND_FILTERED, 0xce, 0x09, EV_KEY, KEY_VOLUMEDOWN, 1}, /* VOL + */
        {KIND_FILTERED, 0xcd, 0x08, EV_KEY, KEY_VOLUMEUP, 1},   /* VOL - */
        {KIND_FILTERED, 0xcf, 0x0a, EV_KEY, KEY_MUTE, 1},       /* MUTE  */


On 7/31/05, Andrew Morton <akpm@osdl.org> wrote:
> 
> 
> Begin forwarded message:
> 
> Date: Sun, 31 Jul 2005 12:18:23 +1200
> From: mdew <some.nzguy@gmail.com>
> To: linux-kernel <linux-kernel@vger.kernel.org>
> Subject: ati-remote strangeness from 2.6.12 onwards
> 
> 
> using 2.6.11 everything works fine, Upgrading too 2.6.13-rc3 I noticed 2 errors,
> 
> (1) When setting the HZ rating too 250 or 100 will cause the driver to
> excessfully repeat keys/accelerate when pressing a button, making it
> unusable :(
> 
> (2) the "Ok" button no longer works in anything after and including
> 2.6.12-rc1 (I've tested upto 2.6.13-rc3), 2.6.11 works fine. xbindkeys
> doesnt register any "ok" key presses on 2.6.12-rc1 onwards.
> 
> 2.6.11 xbindkeys responses (nothing shows up in -rc1)
> 
> mediabawx2:~# xbindkeys -mk
> Press combination of keys or/and click under the window.
> You can use one of the two lines after "NoCommand"
> in $HOME/.xbindkeysrc to bind a key.
> 
> --- Press "q" to stop. ---
> "NoCommand"
> m:0x0 + c:36
> Return
> "NoCommand"
> m:0x0 + c:36
> Return
> 
> 
> Thanks :)
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
