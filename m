Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267545AbTAXFsx>; Fri, 24 Jan 2003 00:48:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267546AbTAXFsx>; Fri, 24 Jan 2003 00:48:53 -0500
Received: from twilight.ucw.cz ([195.39.74.230]:2798 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S267545AbTAXFsw>;
	Fri, 24 Jan 2003 00:48:52 -0500
Date: Fri, 24 Jan 2003 06:57:41 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Hiroshi Miura <miura@da-cha.org>
Cc: vojtech@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.5.59] support japanese JP106 keyboard on new console.
Message-ID: <20030124065741.B19571@ucw.cz>
References: <20030124031453.0A29F11775F@triton2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030124031453.0A29F11775F@triton2>; from miura@da-cha.org on Fri, Jan 24, 2003 at 12:14:53PM +0900
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 24, 2003 at 12:14:53PM +0900, Hiroshi Miura wrote:

> After re-writting a console layer, a japanese keyboard is not supported (or degraded).
> This patch fixs it.

This patch doesn't work, all normal keyboards - not just japanese ones have id of 0xab02.

> A USB keyboard driver may have same problem, but I don't have one.
> 
> --- linux-2.5.59/drivers/input/keyboard/atkbd.c	2002-12-03 07:59:41.000000000 +0900
> +++ edited/linux-2.5.59/drivers/input/keyboard/atkbd.c	2003-01-24 09:13:11.000000000 +0900
> @@ -309,6 +309,12 @@
>  	if (atkbd_command(atkbd, &atkbd->oldset, ATKBD_CMD_GSCANSET))
>  		atkbd->oldset = 2;
>  
> +	if (atkbd->id == 0xab02) {
> +		printk("atkbd: jp109(106) keyboard found\n");
> +		param[0] = atkbd_set;
> +		atkbd_command(atkbd, param, ATKBD_CMD_SSCANSET);
> +		return 5;
> +	}
>  /*
>   * For known special keyboards we can go ahead and set the correct set.
>   * We check for NCD PS/2 Sun, NorthGate OmniKey 101 and
> @@ -531,6 +537,12 @@
>  	else
>  		memcpy(atkbd->keycode, atkbd_set2_keycode, sizeof(atkbd->keycode));
>  
> +	if (atkbd->set == 5) {
> +		atkbd->keycode[0x13] = 0x70;  /* Hiragana/Katakana */
> +		atkbd->keycode[0x6a] = 0x7c;  /* Yen, pipe 124*/
> +		atkbd->set = 2;
> +	}
> +
>  	atkbd->dev.name = atkbd->name;
>  	atkbd->dev.phys = atkbd->phys;
>  	atkbd->dev.id.bustype = BUS_I8042;
> @@ -544,7 +556,7 @@
>  
>  	input_register_device(&atkbd->dev);
>  
> -	printk(KERN_INFO "input: %s on %s\n", atkbd->name, serio->phys);
> +	printk(KERN_INFO "input: %s (0x%x) on %s\n", atkbd->name, atkbd->id, serio->phys);
>  }
>  
>  
> -- 
> Hiroshi Miura  --- http://www.da-cha.org/ 
> NTTDATA Corp. Marketing & Business Strategy Planning Dept. --- miurahr@nttdata.co.jp 
> Key fingerprint = 9117 9407 5684 FBF1 4063  15B4 401D D077 04AB 8617
> -- My hacking life is happy as the day is long

-- 
Vojtech Pavlik
SuSE Labs
