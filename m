Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263831AbUDVHhW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263831AbUDVHhW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 03:37:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262579AbUDVHg6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 03:36:58 -0400
Received: from styx.suse.cz ([82.208.2.94]:3712 "EHLO shadow.ucw.cz")
	by vger.kernel.org with ESMTP id S263823AbUDVHad (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 03:30:33 -0400
Date: Thu, 22 Apr 2004 09:31:13 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/15] New set of input patches: atkbd - use bitfields
Message-ID: <20040422073113.GD340@ucw.cz>
References: <200404210049.17139.dtor_core@ameritech.net> <200404210057.52989.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200404210057.52989.dtor_core@ameritech.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2004 at 12:57:51AM -0500, Dmitry Torokhov wrote:
> 
> ===================================================================
> 
> 
> ChangeSet@1.1909, 2004-04-20 22:29:12-05:00, dtor_core@ameritech.net
>   Input: remove unneeded fields in atkbd structure, convert to bitfields

I think this is incorrect. We cannot set the bits in bitfields
atomically, which we need in some cases. We probably need to add
volatiles to some of them, too.


> diff -Nru a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
> --- a/drivers/input/keyboard/atkbd.c	Tue Apr 20 23:08:14 2004
> +++ b/drivers/input/keyboard/atkbd.c	Tue Apr 20 23:08:14 2004
> @@ -26,7 +26,6 @@
>  #include <linux/input.h>
>  #include <linux/serio.h>
>  #include <linux/workqueue.h>
> -#include <linux/timer.h>
>  
>  MODULE_AUTHOR("Vojtech Pavlik <vojtech@suse.cz>");
>  MODULE_DESCRIPTION("AT and PS/2 keyboard driver");
> @@ -173,22 +172,23 @@
>  	unsigned char keycode[512];
>  	struct input_dev dev;
>  	struct serio *serio;
> -	struct timer_list timer;
> +
>  	char name[64];
>  	char phys[32];
> +	unsigned short id;
> +	unsigned char set;
> +	unsigned int translated:1;
> +	unsigned int extra:1;
> +	unsigned int write:1;
> +
>  	unsigned char cmdbuf[4];
>  	unsigned char cmdcnt;
> -	unsigned char set;
> -	unsigned char extra;
> -	unsigned char release;
> -	int lastkey;
>  	volatile signed char ack;
>  	unsigned char emul;
> -	unsigned short id;
> -	unsigned char write;
> -	unsigned char translated;
> -	unsigned char resend;
> -	unsigned char bat_xl;
> +	unsigned int resend:1;
> +	unsigned int release:1;
> +	unsigned int bat_xl:1;
> +
>  	unsigned int last;
>  	unsigned long time;
>  };
> 

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
