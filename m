Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132820AbRDITD2>; Mon, 9 Apr 2001 15:03:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132821AbRDITDS>; Mon, 9 Apr 2001 15:03:18 -0400
Received: from echo.sound.net ([205.242.192.21]:12769 "HELO echo.sound.net")
	by vger.kernel.org with SMTP id <S132820AbRDITDJ>;
	Mon, 9 Apr 2001 15:03:09 -0400
Date: Mon, 9 Apr 2001 14:02:40 -0500 (CDT)
From: Hal Duston <hald@sound.net>
To: Helge Deller <deller@gmx.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PS/2 ESDI
Message-ID: <Pine.GSO.4.10.10104091359540.14442-100000@sound.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,

OK, Helge is of course correct here.  I will get a new patch out tonight.

Basically, the ending = -1; needs to be preceded by an else.
(I think so anyway, as I don't have access to that machine right now.)

Hal Duston
hald@sound.net

On Mon, 9 Apr 2001, Helge Deller wrote:

> Hi Hal,
> 
> I don't have any ps2esdi devices, but while I was looking at your patch I 
> found:
> 
>  	case INT_CMD_COMPLETE:
> @@ -893,13 +879,9 @@
>  			printk("%s: timeout reading status word\n", DEVICE_NAME);
>  			outb((int_ret_code & 0xe0) | ATT_EOI, ESDI_ATTN);
>  			outb(CTRL_ENABLE_INTR, ESDI_CONTROL);
> -			if ((++CURRENT->errors) < MAX_RETRIES)
> -				do_ps2esdi_request(NULL);
> -			else {
> -				end_request(FAIL);
> -				if (!QUEUE_EMPTY)
> -					do_ps2esdi_request(NULL);
> -			}
> +			if ((++CURRENT->errors) >= MAX_RETRIES)
> +				ending = FAIL;
> +			ending = -1;
>  			break;
>  		}
> 
> Just a thought:
> in this if().. clause ending may get the FAIL value, but directly afterwards 
> it is set to -1 again....
> You have this two times in your patch.
> 
> Greetings,
> Helge.

