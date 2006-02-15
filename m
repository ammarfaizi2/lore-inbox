Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946008AbWBOQXW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946008AbWBOQXW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 11:23:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946009AbWBOQXW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 11:23:22 -0500
Received: from [213.91.10.50] ([213.91.10.50]:55510 "EHLO zone4.gcu-squad.org")
	by vger.kernel.org with ESMTP id S1946007AbWBOQXV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 11:23:21 -0500
Date: Wed, 15 Feb 2006 17:20:37 +0100 (CET)
To: linux-kernel@vger.kernel.org
Subject: Re: Random reboots
X-IlohaMail-Blah: khali@localhost
X-IlohaMail-Method: mail() [mem]
X-IlohaMail-Dummy: moo
X-Mailer: IlohaMail/0.8.14 (On: webmail.gcu.info)
Message-ID: <ARSSpsNs.1140020437.1823510.khali@localhost>
In-Reply-To: <20060215160036.GB17864@tau.solarneutrino.net>
From: "Jean Delvare" <khali@linux-fr.org>
Bounce-To: "Jean Delvare" <khali@linux-fr.org>
CC: "Ryan Richter" <ryan@tau.solarneutrino.net>,
       "Erik Mouw" <erik@harddisk-recovery.com>,
       "Nick Warne" <nick@linicks.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Greylist: Sender is SPF-compliant, not delayed by milter-greylist-2.1.2 (zone4.gcu-squad.org [127.0.0.1]); Wed, 15 Feb 2006 17:20:38 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ryan,

On 2006-02-15, Ryan Richter wrote:
> It's a Tyan S2880, and I'm using their sensors.conf:
>
> ftp://ftp.tyan.com/software/lms/lms_s2880.tgz
>
> Here's what sensors reports:
>
> w83627hf-isa-0290
> Adapter: ISA adapter
> VCore 1:   +1.54 V  (min =  +1.47 V, max =  +1.62 V)       ALARM
> VCore 2:   +1.54 V  (min =  +1.47 V, max =  +1.62 V)       ALARM
> +3.3V:     +3.33 V  (min =  +3.14 V, max =  +3.46 V)
> +5V:       +4.97 V  (min =  +4.73 V, max =  +5.24 V)
> +12V:      +4.56 V  (min = +10.82 V, max = +13.19 V)
> -12V:      -2.25 V  (min = -13.18 V, max = -10.88 V)
> -5V:       -3.94 V  (min =  -5.25 V, max =  -4.75 V)
> V5SB:      +5.51 V  (min =  +4.73 V, max =  +5.24 V)
> VBat:      +1.28 V  (min =  +2.40 V, max =  +3.60 V)
> fan1:     4354 RPM  (min =   -1 RPM, div = 2)
> fan2:     3479 RPM  (min = 5273 RPM, div = 2)
> fan3:        0 RPM  (min = 30681 RPM, div = 2)
> temp1:       +77°C  (high =  -128°C, hyst =  -128°C)  sensor = thermistor
> temp2:     +77.5°C  (high =   +80°C, hyst =   +75°C)  sensor = thermistor
> temp3:     +77.5°C  (high =   +80°C, hyst =   +75°C)  sensor = thermistor
> vid:      +1.550 V  (VRM Version 2.4)

There's one chip missing. If memory serves, this board has two hardware
monitoring chips: one Winbond Super-I/O and one LM85-compatible SMBus
chip. You are missing the i2c-amd756 driver in your kernel build
(CONFIG_I2C_AMD756) which prevents you from accessing that second chip.

Additionally, the Winbond Super-I/O chips are better supported by the
newer w83627hf driver than by the w83781d you are using.

So, you should change your kernel configuration to:

CONFIG_I2C_AMD756=y
#CONFIG_SENSORS_W83781D is not set
CONFIG_SENSORS_W83627HF=y

Then you'll probably have much better results - even if the
configuration file might need additional tweaking.

> Still, I don't see why the new kernel shouldn't be stable if 2.6.11.3
> was.

If not software regression, the aging of your hardware might have caused
it, as I mentioned earlier. But you are free to believe in the
hypothesis you prefer, given that we are not currently able to
demonstrate it anyway ;)

--
Jean Delvare
