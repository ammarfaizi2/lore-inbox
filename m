Return-Path: <linux-kernel-owner@vger.kernel.org>
thread-index: AcQVpBRZuhoHzFD3TZCw0GtgLr4g8w==
Envelope-to: paul@sumlocktest.fsnet.co.uk
Delivery-date: Sat, 03 Jan 2004 10:09:00 +0000
Message-ID: <00c701c415a4$145940f0$d100000a@sbs2003.local>
Content-Transfer-Encoding: 7bit
Date: Mon, 29 Mar 2004 16:39:53 +0100
X-Mailer: Microsoft CDO for Exchange 2000
From: "Vojtech Pavlik" <vojtech@suse.cz>
To: <Administrator@osdl.org>
Cc: "Vojtech Pavlik" <vojtech@suse.cz>, "Andrew Morton" <akpm@osdl.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/7] i8042 suspend
Content-Class: urn:content-classes:message
Importance: normal
Priority: normal
References: <200401030350.43437.dtor_core@ameritech.net> <200401030356.48071.dtor_core@ameritech.net>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.0
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <200401030356.48071.dtor_core@ameritech.net>
User-Agent: Mutt/1.4.1i
Sender: <linux-kernel-owner@vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
X-OriginalArrivalTime: 29 Mar 2004 15:39:53.0937 (UTC) FILETIME=[14B3E410:01C415A4]

On Sat, Jan 03, 2004 at 03:56:45AM -0500, Dmitry Torokhov wrote:
> diff -Nru a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
> --- a/drivers/input/serio/i8042.c	Sat Jan  3 03:07:29 2004
> +++ b/drivers/input/serio/i8042.c	Sat Jan  3 03:07:29 2004
> @@ -746,6 +746,29 @@
>  
>  
>  /*
> + * Reset the controller.
> + */
> +void i8042_controller_reset(void)
> +{
> +	if (i8042_reset) {
> +		unsigned char param;
> +
> +		if (i8042_command(&param, I8042_CMD_CTL_TEST))
> +			printk(KERN_ERR "i8042.c: i8042 controller reset timeout.\n");
> +	}

We should be checking the return value from the TEST command as well,
if we want to use this to initialize the controller on non-x86 platforms
(where i8042.reset is 0).

>  
> -/*
> - * Reset the controller.
> - */
> -
> -	if (i8042_reset) {
> -		unsigned char param;
> +	i8042_controller_reset();
> +}
>  
> -		if (i8042_command(&param, I8042_CMD_CTL_TEST))
> -			printk(KERN_ERR "i8042.c: i8042 controller reset timeout.\n");
> -	}


This actually introduces a bug, because we don't want to restore the CTR
setting before we save it, which the new code does.

> @@ -809,7 +826,7 @@
>  	if (i8042_mux_present)
>  		if (i8042_enable_mux_mode(&i8042_aux_values, NULL) ||
>  		    i8042_enable_mux_ports(&i8042_aux_values)) {
> -			printk(KERN_WARNING "i8042: failed to resume active multiplexor, mouse won't wotk.\n");
> +			printk(KERN_WARNING "i8042: failed to resume active multiplexor, mouse won't work.\n");

Ahh, a typo. :)

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
