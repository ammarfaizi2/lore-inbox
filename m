Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263320AbVBCTf3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263320AbVBCTf3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 14:35:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263904AbVBCTd2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 14:33:28 -0500
Received: from alhya.freenux.org ([81.56.176.87]:6045 "EHLO moria.freenux.org")
	by vger.kernel.org with ESMTP id S263003AbVBCTU5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 14:20:57 -0500
Message-ID: <4202798B.7000802@kde.org>
Date: Thu, 03 Feb 2005 20:20:43 +0100
From: Mickael Marchand <marchand@kde.org>
User-Agent: Debian Thunderbird 1.0 (X11/20050119)
X-Accept-Language: en-us, en
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_moria-16265-1107458747-0001-2"
To: Gerd Knorr <kraxel@bytesex.org>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.11-rc3 - BT848 no signal
References: <Pine.LNX.4.58.0502021824310.2362@ppc970.osdl.org> <1107407987.2097.18.camel@lb.loomes.de> <87is5a0wxm.fsf@bytesex.org> <1107428571.2068.4.camel@lb.loomes.de> <20050203113022.GK10602@bytesex>
In-Reply-To: <20050203113022.GK10602@bytesex>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_moria-16265-1107458747-0001-2
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

I am having the same kind of troubles (can't tune and mt_set_frequency 
-121 errors) since 2.6.10 (it was working in 2.6.9) on amd64.
this patch did not help sadely.

log files attached if you have time to look at them :) (the non-working 
one being 2.6.11-rc3+your patch)

Cheers,
Mik

Gerd Knorr wrote:
>>>>mt2032_set_if_freq failed with -121
>>
>>OK here you go.
> 
> 
> Thanks, seems to be a initialization order bug which changes the default
> state of the tda9887 output ports.  The patch below should fix that.
> 
>   Gerd
> 
> diff -u linux-2.6.11/drivers/media/video/tda9887.c linux/drivers/media/video/tda9887.c
> --- linux-2.6.11/drivers/media/video/tda9887.c	2005-01-25 11:57:21.000000000 +0100
> +++ linux/drivers/media/video/tda9887.c	2005-02-03 12:26:16.246003021 +0100
> @@ -305,9 +305,9 @@
>  	printk("  B5   force mute audio: %s\n",
>  	       (buf[1] & 0x20) ? "yes" : "no");
>  	printk("  B6   output port 1   : %s\n",
> -	       (buf[1] & 0x40) ? "high" : "low");
> +	       (buf[1] & 0x40) ? "high (inactive)" : "low (active)");
>  	printk("  B7   output port 2   : %s\n",
> -	       (buf[1] & 0x80) ? "high" : "low");
> +	       (buf[1] & 0x80) ? "high (inactive)" : "low (active)");
>  
>  	printk(PREFIX "write: byte C 0x%02x\n",buf[2]);
>  	printk("  C0-4 top adjustment  : %s dB\n", adjust[buf[2] & 0x1f]);
> @@ -545,9 +545,9 @@
>  	int rc;
>  
>  	memset(buf,0,sizeof(buf));
> +	tda9887_set_tvnorm(t,buf);
>  	buf[1] |= cOutputPort1Inactive;
>  	buf[1] |= cOutputPort2Inactive;
> -	tda9887_set_tvnorm(t,buf);
>  	if (UNSET != t->pinnacle_id) {
>  		tda9887_set_pinnacle(t,buf);
>  	}
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


--=_moria-16265-1107458747-0001-2
Content-Type: text/plain; name=debug-nonworking; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="debug-nonworking"

mt2032 spurcheck triggered: 2
mt2032_set_if_freq failed with -121
mt2032_set_if_freq2 failed with -121
mt2032_set_if_freq failed with -121
mt2032_set_if_freq2 failed with -121
bttv0: unloading
bttv: driver version 0.9.15 loaded
bttv: using 8 buffers with 2080k (520 pages) each for capture
bttv: Bt8xx card found (0).
ACPI: PCI interrupt 0000:00:0c.0[A] -> GSI 17 (level, low) -> IRQ 185
bttv0: Bt878 (rev 17) at 0000:00:0c.0, irq: 185, latency: 64, mmio: 0xf4b00000
bttv0: detected: Pinnacle PCTV [card=39], PCI subsystem ID is 11bd:0012
bttv0: using: Pinnacle PCTV Studio/Rave [card=39,autodetected]
bttv0: gpio: en=00000000, out=00000000 in=00fff3ff [init]
tda9885/6/7: chip found @ 0x86
bttv0: i2c: checking for MSP34xx @ 0x80... not found
bttv0: pinnacle/mt: id=4 info="PAL+SECAM / mono" radio=no
bttv0: using tuner=33
tda9885/6/7: Oops: no tvnorm entry found
tda9885/6/7: writing: b=0xc0 c=0x10 e=0x00
tda9885/6/7: write: byte B 0xc0
  B0   video mode      : sound trap
  B1   auto mute fm    : no
  B2   carrier mode    : Intercarrier
  B3-4 tv sound/radio  : AM/TV
  B5   force mute audio: no
  B6   output port 1   : high (inactive)
  B7   output port 2   : high (inactive)
tda9885/6/7: write: byte C 0x10
  C0-4 top adjustment  : 0 dB
  C5-6 de-emphasis     : no
  C7   audio gain      : 0
tda9885/6/7: write: byte E 0x00
  E0-1 sound carrier   : 4.5 MHz
  E6   l pll ganting   : 13
  E2-4 video if        : 58.75 MHz
  E5   tuner gain      : normal
  E7   vif agc output  : pin3+pin22 port
--
bttv0: i2c: checking for MSP34xx @ 0x80... not found
bttv0: i2c: checking for TDA9875 @ 0xb0... not found
bttv0: i2c: checking for TDA7432 @ 0x8a... not found
bttv0: registered device video0
bttv0: registered device vbi0
bttv0: PLL: 28636363 => 35468950 . ok
tda9885/6/7: configure for: PAL-BG
tda9885/6/7: writing: b=0xd4 c=0x70 e=0x09
tda9885/6/7: write: byte B 0xd4
  B0   video mode      : sound trap
  B1   auto mute fm    : no
  B2   carrier mode    : QSS
  B3-4 tv sound/radio  : FM/TV
  B5   force mute audio: no
  B6   output port 1   : high (inactive)
  B7   output port 2   : high (inactive)
tda9885/6/7: write: byte C 0x70
  C0-4 top adjustment  : 0 dB
  C5-6 de-emphasis     : 50
  C7   audio gain      : 0
tda9885/6/7: write: byte E 0x09
  E0-1 sound carrier   : 5.5 MHz
  E6   l pll ganting   : 13
  E2-4 video if        : 38.9 MHz
  E5   tuner gain      : normal
  E7   vif agc output  : pin3+pin22 port
--
tda9885/6/7: configure for: PAL-BG
tda9885/6/7: writing: b=0xd4 c=0x70 e=0x09
tda9885/6/7: write: byte B 0xd4
  B0   video mode      : sound trap
  B1   auto mute fm    : no
  B2   carrier mode    : QSS
  B3-4 tv sound/radio  : FM/TV
  B5   force mute audio: no
  B6   output port 1   : high (inactive)
  B7   output port 2   : high (inactive)
tda9885/6/7: write: byte C 0x70
  C0-4 top adjustment  : 0 dB
  C5-6 de-emphasis     : 50
  C7   audio gain      : 0
tda9885/6/7: write: byte E 0x09
  E0-1 sound carrier   : 5.5 MHz
  E6   l pll ganting   : 13
  E2-4 video if        : 38.9 MHz
  E5   tuner gain      : normal
  E7   vif agc output  : pin3+pin22 port
--
tda9885/6/7: configure for: PAL-BG
tda9885/6/7: writing: b=0xd4 c=0x70 e=0x09
tda9885/6/7: write: byte B 0xd4
  B0   video mode      : sound trap
  B1   auto mute fm    : no
  B2   carrier mode    : QSS
  B3-4 tv sound/radio  : FM/TV
  B5   force mute audio: no
  B6   output port 1   : high (inactive)
  B7   output port 2   : high (inactive)
tda9885/6/7: write: byte C 0x70
  C0-4 top adjustment  : 0 dB
  C5-6 de-emphasis     : 50
  C7   audio gain      : 0
tda9885/6/7: write: byte E 0x09
  E0-1 sound carrier   : 5.5 MHz
  E6   l pll ganting   : 13
  E2-4 video if        : 38.9 MHz
  E5   tuner gain      : normal
  E7   vif agc output  : pin3+pin22 port
--
tda9885/6/7: configure for: SECAM-L
tda9885/6/7: writing: b=0x44 c=0x10 e=0x0b
tda9885/6/7: write: byte B 0x44
  B0   video mode      : sound trap
  B1   auto mute fm    : no
  B2   carrier mode    : QSS
  B3-4 tv sound/radio  : AM/TV
  B5   force mute audio: no
  B6   output port 1   : high (inactive)
  B7   output port 2   : low (active)
tda9885/6/7: write: byte C 0x10
  C0-4 top adjustment  : 0 dB
  C5-6 de-emphasis     : no
  C7   audio gain      : 0
tda9885/6/7: write: byte E 0x0b
  E0-1 sound carrier   : 6.5 MHz / AM
  E6   l pll ganting   : 13
  E2-4 video if        : 38.9 MHz
  E5   tuner gain      : normal
  E7   vif agc output  : pin3+pin22 port
--
tda9885/6/7: configure for: SECAM-L
tda9885/6/7: writing: b=0x44 c=0x10 e=0x0b
tda9885/6/7: write: byte B 0x44
  B0   video mode      : sound trap
  B1   auto mute fm    : no
  B2   carrier mode    : QSS
  B3-4 tv sound/radio  : AM/TV
  B5   force mute audio: no
  B6   output port 1   : high (inactive)
  B7   output port 2   : low (active)
tda9885/6/7: write: byte C 0x10
  C0-4 top adjustment  : 0 dB
  C5-6 de-emphasis     : no
  C7   audio gain      : 0
tda9885/6/7: write: byte E 0x0b
  E0-1 sound carrier   : 6.5 MHz / AM
  E6   l pll ganting   : 13
  E2-4 video if        : 38.9 MHz
  E5   tuner gain      : normal
  E7   vif agc output  : pin3+pin22 port
--
tda9885/6/7: configure for: SECAM-L
tda9885/6/7: writing: b=0x44 c=0x10 e=0x0b
tda9885/6/7: write: byte B 0x44
  B0   video mode      : sound trap
  B1   auto mute fm    : no
  B2   carrier mode    : QSS
  B3-4 tv sound/radio  : AM/TV
  B5   force mute audio: no
  B6   output port 1   : high (inactive)
  B7   output port 2   : low (active)
tda9885/6/7: write: byte C 0x10
  C0-4 top adjustment  : 0 dB
  C5-6 de-emphasis     : no
  C7   audio gain      : 0
tda9885/6/7: write: byte E 0x0b
  E0-1 sound carrier   : 6.5 MHz / AM
  E6   l pll ganting   : 13
  E2-4 video if        : 38.9 MHz
  E5   tuner gain      : normal
  E7   vif agc output  : pin3+pin22 port


--=_moria-16265-1107458747-0001-2
Content-Type: text/plain; name=debug-working; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="debug-working"

tuner: Ignoring new-style parameters in presence of obsolete ones
tda9887: Ignoring new-style parameters in presence of obsolete ones
bttv: driver version 0.9.15 loaded
bttv: using 8 buffers with 2080k (520 pages) each for capture
bttv: Bt8xx card found (0).
ACPI: PCI interrupt 0000:00:0c.0[A] -> GSI 17 (level, low) -> IRQ 185
bttv0: Bt878 (rev 17) at 0000:00:0c.0, irq: 185, latency: 64, mmio: 0xf4b00000
bttv0: detected: Pinnacle PCTV [card=39], PCI subsystem ID is 11bd:0012
bttv0: using: Pinnacle PCTV Studio/Rave [card=39,autodetected]
bttv0: gpio: en=00000000, out=00000000 in=00fff3ff [init]
tuner: chip found at addr 0xc0 i2c-bus bt878 #0 [sw]
tda9885/6/7: chip found @ 0x86
bttv0: i2c: checking for MSP34xx @ 0x80... not found
bttv0: pinnacle/mt: id=4 info="PAL+SECAM / mono" radio=no
bttv0: using tuner=33
tda9885/6/7: Oops: no tvnorm entry found
tda9885/6/7: writing: b=0xc0 c=0x10 e=0x00
tda9885/6/7: write: byte B 0xc0
  B0   video mode      : sound trap
  B1   auto mute fm    : no
  B2   carrier mode    : Intercarrier
  B3-4 tv sound/radio  : AM/TV
  B5   force mute audio: no
  B6   output port 1   : high
  B7   output port 2   : high
tda9885/6/7: write: byte C 0x10
  C0-4 top adjustment  : 0 dB
  C5-6 de-emphasis     : no
  C7   audio gain      : 0
tda9885/6/7: write: byte E 0x00
  E0-1 sound carrier   : 4.5 MHz
  E6   l pll ganting   : 13
  E2-4 video if        : 58.75 MHz
  E5   tuner gain      : normal
  E7   vif agc output  : pin3+pin22 port
--
tuner: type set to 33 (MT20xx universal) by bt878 #0 [sw]
tuner: MT2032 hexdump:
 24 27 ff 0f 1f f7 e4 8c  c3 4e ec d4 0a 32 28 22
  ff 4d 54 04 04
 tuner: microtune: companycode=4d54 part=04 rev=04
mt2032: xogc = 0x07
mt2032: xok = 0x00
mt2032: xogc = 0x06
mt2032: xogc = 0x06
mt2032: xok = 0x00
mt2032: xogc = 0x05
mt2032: xogc = 0x05
mt2032: xok = 0x00
mt2032: xogc = 0x04
mt2032: xogc = 0x04
mt2032: xok = 0x00
mt2032: xogc = 0x03
tuner: microtune MT2032 found, OK
bttv0: i2c: checking for MSP34xx @ 0x80... not found
bttv0: i2c: checking for TDA9875 @ 0xb0... not found
bttv0: i2c: checking for TDA7432 @ 0x8a... not found
bttv0: registered device video0
bttv0: registered device vbi0
bttv0: PLL: 28636363 => 35468950 . ok
--=_moria-16265-1107458747-0001-2--
