Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261330AbTAXRIj>; Fri, 24 Jan 2003 12:08:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261295AbTAXRIj>; Fri, 24 Jan 2003 12:08:39 -0500
Received: from yuzuki.cinet.co.jp ([61.197.228.219]:36481 "EHLO
	yuzuki.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S267672AbTAXRI1>; Fri, 24 Jan 2003 12:08:27 -0500
Message-ID: <3E31752A.92C47F90@cinet.co.jp>
Date: Sat, 25 Jan 2003 02:17:30 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
X-Mailer: Mozilla 4.8C-ja  [ja/Vine] (X11; U; Linux 2.5.59-pc98smp i686)
X-Accept-Language: ja
MIME-Version: 1.0
To: Hiroshi Miura <miura@da-cha.org>
CC: vojtech@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.5.59] support japanese JP106 keyboard on new console.
References: <20030124031453.0A29F11775F@triton2>
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a question.

Hiroshi Miura wrote:
> 
> Hi,
> 
> After re-writting a console layer, a japanese keyboard is not supported (or degraded).
> This patch fixs it.
> 
> A USB keyboard driver may have same problem, but I don't have one.
> 
> --- linux-2.5.59/drivers/input/keyboard/atkbd.c 2002-12-03 07:59:41.000000000 +0900
> +++ edited/linux-2.5.59/drivers/input/keyboard/atkbd.c  2003-01-24 09:13:11.000000000 +0900
> @@ -309,6 +309,12 @@
>         if (atkbd_command(atkbd, &atkbd->oldset, ATKBD_CMD_GSCANSET))
>                 atkbd->oldset = 2;
> 
> +       if (atkbd->id == 0xab02) {
> +               printk("atkbd: jp109(106) keyboard found\n");
> +               param[0] = atkbd_set;
> +               atkbd_command(atkbd, param, ATKBD_CMD_SSCANSET);
> +               return 5;
> +       }
>  /*
>   * For known special keyboards we can go ahead and set the correct set.
>   * We check for NCD PS/2 Sun, NorthGate OmniKey 101 and
> @@ -531,6 +537,12 @@
>         else
>                 memcpy(atkbd->keycode, atkbd_set2_keycode, sizeof(atkbd->keycode));
> 
> +       if (atkbd->set == 5) {
> +               atkbd->keycode[0x13] = 0x70;  /* Hiragana/Katakana */
I'm interesting in the reason to use keycode 0x70 for 'Hiragana/Katakana' key.
Please clarify.

Regard,
Osamu Tomita
