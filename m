Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263012AbUKTAPr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263012AbUKTAPr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 19:15:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261960AbUKTAM1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 19:12:27 -0500
Received: from lucidpixels.com ([66.45.37.187]:23177 "HELO lucidpixels.com")
	by vger.kernel.org with SMTP id S261712AbUKTAK7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 19:10:59 -0500
Date: Fri, 19 Nov 2004 19:10:51 -0500 (EST)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p500
To: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.6.10-rc2 panic(?) -> reboots with certain options
 enabled. (fwd)
In-Reply-To: <Pine.LNX.4.61.0411191856510.21635@p500>
Message-ID: <Pine.LNX.4.61.0411191910000.21635@p500>
References: <Pine.LNX.4.61.0411191856510.21635@p500>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Problem found!

It is PnP support, it causes the machine to reboot itself.

In 2.6.10-rc2-5, I turned off:

1) all usb
2) all parallel port support
3) all pnp support

(PROBLEM FIXED)

--------------------------------------------------
Now to pinpoint problem.
--------------------------------------------------

In build 2.6.10-rc2-6, I turned on:
1) usb support

(STILL NO PROBLEM)

--------------------------------------------------

In build 2.6.10-rc2-7, I turned on:
2) all parallel port support

(STILL NO PROBEM) (of course its the last option right..)

--------------------------------------------------

3) enabled the following pnp options 1 at a time:

In build 2.6.10-rc2-8, I turned on:
   x x          [*] Plug and Play support                                  x x

*** THIS IS THE CULPRIT

Kernel 2.6.10-rc2 build 8 w/ this option causes the machine to reboot
after it tries to load this kernel.



On Fri, 19 Nov 2004, Justin Piszcz wrote:

>
>
> ---------- Forwarded message ----------
> Date: Fri, 19 Nov 2004 18:52:18 -0500 (EST)
> From: Justin Piszcz <jpiszcz@lucidpixels.com>
> To: linux-kernel@vger.kernel.org
> Subject: Re: Kernel 2.6.10-rc2 panic(?) -> reboots with certain options 
> enabled.
>
> In 2.6.10-rc2-5, I turned off:
>
> 1) all usb
> 2) all parallel port support
> 3) all pnp support
>
> One of these is the culprit!
>
> (now boots OK)
>
> Now to find which is the problem.
>
> On Fri, 19 Nov 2004, Justin Piszcz wrote:
>
>> Build #2 - Regular kernel+built-set I always use, (boots fine).
>> Build #3 - Kernel panics(?) reboot takes place.
>> 
>> My guess is its the I2C stuff, I'll turn that off now and rebuild.
>> 
>> Configs for both kernels are attached and the diff is below:
>> 
>> 4c4
>> < # Fri Nov 19 18:44:23 2004
>> ---
>>> # Fri Nov 19 19:25:13 2004
>> 154c154
>> < CONFIG_ACPI_VIDEO=m
>> ---
>>> # CONFIG_ACPI_VIDEO is not set
>> 158c158
>> < CONFIG_ACPI_IBM=m
>> ---
>>> # CONFIG_ACPI_IBM is not set
>> 223c223,230
>> < # CONFIG_PARPORT is not set
>> ---
>>> CONFIG_PARPORT=y
>>> CONFIG_PARPORT_PC=y
>>> CONFIG_PARPORT_PC_CML1=y
>>> CONFIG_PARPORT_SERIAL=y
>>> CONFIG_PARPORT_PC_FIFO=y
>>> CONFIG_PARPORT_PC_SUPERIO=y
>>> # CONFIG_PARPORT_OTHER is not set
>>> CONFIG_PARPORT_1284=y
>> 228c235,241
>> < # CONFIG_PNP is not set
>> ---
>>> CONFIG_PNP=y
>>> # CONFIG_PNP_DEBUG is not set
>>> 
>>> #
>>> # Protocols
>>> #
>>> CONFIG_PNPACPI=y
>> 233a247
>>> # CONFIG_PARIDE is not set
>> 239c253
>> < # CONFIG_BLK_DEV_CRYPTOLOOP is not set
>> ---
>>> CONFIG_BLK_DEV_CRYPTOLOOP=y
>> 279a294
>>> # CONFIG_BLK_DEV_IDEPNP is not set
>> 304,307c319,320
>> < CONFIG_BLK_DEV_PDC202XX_OLD=y
>> < # CONFIG_PDC202XX_BURST is not set
>> < CONFIG_BLK_DEV_PDC202XX_NEW=y
>> < # CONFIG_PDC202XX_FORCE is not set
>> ---
>>> # CONFIG_BLK_DEV_PDC202XX_OLD is not set
>>> # CONFIG_BLK_DEV_PDC202XX_NEW is not set
>> 519a533
>>> # CONFIG_NET_SB1000 is not set
>> 579a594
>>> # CONFIG_PLIP is not set
>> 620a636
>>> # CONFIG_SERIO_PARKBD is not set
>> 655c671
>> < # CONFIG_SERIAL_8250_CONSOLE is not set
>> ---
>>> CONFIG_SERIAL_8250_CONSOLE=y
>> 663a680
>>> CONFIG_SERIAL_CORE_CONSOLE=y
>> 666a684,687
>>> CONFIG_PRINTER=y
>>> CONFIG_LP_CONSOLE=y
>>> # CONFIG_PPDEV is not set
>>> # CONFIG_TIPAR is not set
>> 707c728
>> < # CONFIG_HANGCHECK_TIMER is not set
>> ---
>>> CONFIG_HANGCHECK_TIMER=y
>> 712,713c733,734
>> < CONFIG_I2C=m
>> < CONFIG_I2C_CHARDEV=m
>> ---
>>> CONFIG_I2C=y
>>> CONFIG_I2C_CHARDEV=y
>> 718,719c739,740
>> < CONFIG_I2C_ALGOBIT=m
>> < CONFIG_I2C_ALGOPCF=m
>> ---
>>> CONFIG_I2C_ALGOBIT=y
>>> CONFIG_I2C_ALGOPCF=y
>> 733a755
>>> # CONFIG_I2C_PARPORT is not set
>> 735c757
>> < CONFIG_I2C_PIIX4=m
>> ---
>>> CONFIG_I2C_PIIX4=y
>> 751,752c773,774
>> < CONFIG_I2C_SENSOR=m
>> < CONFIG_SENSORS_ADM1021=m
>> ---
>>> CONFIG_I2C_SENSOR=y
>>> CONFIG_SENSORS_ADM1021=y
>> 780c802
>> < CONFIG_SENSORS_EEPROM=m
>> ---
>>> CONFIG_SENSORS_EEPROM=y
>> 811a834,836
>>> # CONFIG_VIDEO_BWQCAM is not set
>>> # CONFIG_VIDEO_CQCAM is not set
>>> # CONFIG_VIDEO_W9966 is not set
>> 959c984
>> < CONFIG_USB=m
>> ---
>>> CONFIG_USB=y
>> 978c1003
>> < CONFIG_USB_UHCI_HCD=m
>> ---
>>> CONFIG_USB_UHCI_HCD=y
>> 983c1008
>> < CONFIG_USB_AUDIO=m
>> ---
>>> CONFIG_USB_AUDIO=y
>> 1022c1047
>> < CONFIG_USB_OV511=m
>> ---
>>> CONFIG_USB_OV511=y
>> 1038a1064
>>> # CONFIG_USB_USS720 is not set
>> 1257,1259c1283,1285
>> < # CONFIG_CRYPTO_HMAC is not set
>> < # CONFIG_CRYPTO_NULL is not set
>> < # CONFIG_CRYPTO_MD4 is not set
>> ---
>>> CONFIG_CRYPTO_HMAC=y
>>> CONFIG_CRYPTO_NULL=y
>>> CONFIG_CRYPTO_MD4=y
>> 1261,1264c1287,1290
>> < # CONFIG_CRYPTO_SHA1 is not set
>> < # CONFIG_CRYPTO_SHA256 is not set
>> < # CONFIG_CRYPTO_SHA512 is not set
>> < # CONFIG_CRYPTO_WP512 is not set
>> ---
>>> CONFIG_CRYPTO_SHA1=y
>>> CONFIG_CRYPTO_SHA256=y
>>> CONFIG_CRYPTO_SHA512=y
>>> CONFIG_CRYPTO_WP512=y
>> 1266,1279c1292,1305
>> < # CONFIG_CRYPTO_BLOWFISH is not set
>> < # CONFIG_CRYPTO_TWOFISH is not set
>> < # CONFIG_CRYPTO_SERPENT is not set
>> < # CONFIG_CRYPTO_AES_586 is not set
>> < # CONFIG_CRYPTO_CAST5 is not set
>> < # CONFIG_CRYPTO_CAST6 is not set
>> < # CONFIG_CRYPTO_TEA is not set
>> < # CONFIG_CRYPTO_ARC4 is not set
>> < # CONFIG_CRYPTO_KHAZAD is not set
>> < # CONFIG_CRYPTO_ANUBIS is not set
>> < # CONFIG_CRYPTO_DEFLATE is not set
>> < # CONFIG_CRYPTO_MICHAEL_MIC is not set
>> < # CONFIG_CRYPTO_CRC32C is not set
>> < # CONFIG_CRYPTO_TEST is not set
>> ---
>>> CONFIG_CRYPTO_BLOWFISH=y
>>> CONFIG_CRYPTO_TWOFISH=y
>>> CONFIG_CRYPTO_SERPENT=y
>>> CONFIG_CRYPTO_AES_586=y
>>> CONFIG_CRYPTO_CAST5=y
>>> CONFIG_CRYPTO_CAST6=y
>>> CONFIG_CRYPTO_TEA=y
>>> CONFIG_CRYPTO_ARC4=y
>>> CONFIG_CRYPTO_KHAZAD=y
>>> CONFIG_CRYPTO_ANUBIS=y
>>> CONFIG_CRYPTO_DEFLATE=y
>>> CONFIG_CRYPTO_MICHAEL_MIC=y
>>> CONFIG_CRYPTO_CRC32C=y
>>> CONFIG_CRYPTO_TEST=y
>> 1284,1286c1310,1312
>> < # CONFIG_CRC_CCITT is not set
>> < # CONFIG_CRC32 is not set
>> < # CONFIG_LIBCRC32C is not set
>> ---
>>> CONFIG_CRC_CCITT=y
>>> CONFIG_CRC32=y
>>> CONFIG_LIBCRC32C=y
>> 1287a1314
>>> CONFIG_ZLIB_DEFLATE=y
>> 
>
