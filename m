Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751200AbWCZPff@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751200AbWCZPff (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 10:35:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751300AbWCZPff
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 10:35:35 -0500
Received: from main.gmane.org ([80.91.229.2]:33419 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751200AbWCZPfe convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 10:35:34 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Kalin KOZHUHAROV <kalin@thinrope.net>
Subject: Re: Papouch USB thermometer support
Date: Mon, 27 Mar 2006 00:35:20 +0900
Message-ID: <e06cbp$dv0$1@sea.gmane.org>
References: <20060324194655.GY4124@vanheusden.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: s175249.ppp.asahi-net.or.jp
User-Agent: Mail/News 1.5 (X11/20060324)
In-Reply-To: <20060324194655.GY4124@vanheusden.com>
X-Enigmail-Version: 0.94.0.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Folkert van Heusden wrote:
> The following patch against 2.6.15 adds support for the www.Papouch.com
> USB thermometer by adding the appropriate vendor and product id.

OK, this should probably work, but adding a new device support might require
a bit more effort...

And since I started looking into the code, I think it may see some
cleanup, so I'll be submitting shortly a series of two patches, yours included
as a second one. I'll CC you and please add the correct Signed-off-by line if
you agree and repost.

The page for this device is here:
http://www.papouch.com/shop/scripts/_detail.asp?katcislo=0188

Specs (in Polish) here:
http://www.papouch.com/shop/scripts/pdf/tmu.pdf

> 
> 
Be careful with this line:
> Signed off: Folkert van Heusden <folkert@vanheusden.com

Should be:
Signed-off-by: Folkert van Heusden <folkert@vanheusden.com>

> diff -uNrbBd old/ftdi_sio.c new/ftdi_sio.c
> --- old/ftdi_sio.c      2006-03-24 20:36:19.000000000 +0100
> +++ new/ftdi_sio.c      2006-03-24 20:33:20.000000000 +0100
> @@ -307,6 +307,7 @@
> 
> 
>  static struct usb_device_id id_table_combined [] = {
> +       { USB_DEVICE(PAPOUCHE_VENDOR, PAPOUCHE_THEM_PROD) },

What about:
s/PAPOUCHE_VENDOR/PAPOUCHE_VID/g
s/PAPOUCHE_THEM_PROD/PAPOUCHE_TMU_PID/g

>         { USB_DEVICE(FTDI_VID, FTDI_IRTRANS_PID) },
>         { USB_DEVICE(FTDI_VID, FTDI_SIO_PID) },
>         { USB_DEVICE(FTDI_VID, FTDI_8U232AM_PID) },
> diff -uNrbBd old/ftdi_sio.h new/ftdi_sio.h
> --- old/ftdi_sio.h      2006-03-24 20:36:19.000000000 +0100
> +++ new/ftdi_sio.h      2006-03-24 20:37:35.000000000 +0100
> @@ -20,8 +20,13 @@
>   * Philipp Gühring - pg@futureware.at - added the Device ID of the USB relais
You are not using UTF-8 capable MUA or editor or both, so the umlaut is
broken here.

>   * from Rudolf Gugler
>   *
> + * Folkert van Heusden - folkert@vanheusden.com - added the device id of the
> + * temperature sensor from www.papouch.com

Credits are better with the PID/VID lines, not here. Just look at what
other (most) people have done.

add at least the name [TMU] here

>   */
> 
> +#define PAPOUCHE_VENDOR 0x5050
> +#define PAPOUCHE_THEM_PROD 0x0400

+#define PAPOUCHE_VID 0x5050
+#define PAPOUCHE_TMU_PID 0x0400

> +
>  #define FTDI_VID       0x0403  /* Vendor Id */
>  #define FTDI_SIO_PID   0x8372  /* Product Id SIO application of 8U100AX  */
>  #define FTDI_8U232AM_PID 0x6001 /* Similar device to SIO above */

IMHO, `diff -ruN` or `diff -pruN` should be better when posting patches :-)

Kalin.

-- 
|[ ~~~~~~~~~~~~~~~~~~~~~~ ]|
+-> http://ThinRope.net/ <-+
|[ ______________________ ]|


