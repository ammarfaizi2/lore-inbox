Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964929AbVLUW5k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964929AbVLUW5k (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 17:57:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964922AbVLUW5j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 17:57:39 -0500
Received: from smtp-103-wednesday.nerim.net ([62.4.16.103]:56336 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S964929AbVLUW5j convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 17:57:39 -0500
Date: Thu, 22 Dec 2005 00:00:25 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Gene Heskett <gene.heskett@verizononline.net>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Sensors errors with 15-rc6, 15-rc5 was normal
Message-Id: <20051222000025.4ee54e84.khali@linux-fr.org>
In-Reply-To: <200512211725.39984.gene.heskett@verizon.net>
References: <200512201505.43199.gene.heskett@verizon.net>
	<200512211551.39092.gene.heskett@verizon.net>
	<20051221230725.4a4851fa.khali@linux-fr.org>
	<200512211725.39984.gene.heskett@verizon.net>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gene,

> > Please keep this conversation on the LKML, where it started.

How many times must I tell you?

> Next adapter: SMBus nForce2 adapter at 5100
> Do you want to scan it? (YES/no/selectively):
> Client found at address 0x08
> Client found at address 0x4e
> Probing for `National Semiconductor LM75'... Failed!
> Probing for `Dallas Semiconductor DS1621'... Failed!
> Probing for `Analog Devices ADM1021'... Failed!
> Probing for `Analog Devices ADM1021A/ADM1023'... Failed!
> Probing for `Maxim MAX1617'... Failed!
> Probing for `Maxim MAX1617A'... Failed!
> Probing for `TI THMC10'... Failed!
> Probing for `National Semiconductor LM84'... Failed!
> Probing for `Genesys Logic GL523SM'... Failed!
> Probing for `Onsemi MC1066'... Failed!
> Probing for `Maxim MAX1619'... Failed!
> Probing for `National Semiconductor LM82'... Failed!
> Probing for `National Semiconductor LM83'... Failed!
> Probing for `Maxim MAX6659'... Failed!
> Probing for `Maxim MAX6633/MAX6634/MAX6635'... Failed!

Hmm, that could be a secondary temperature sensor. Please find out
which i2c bus number is "SMBus nForce2 adapter at 5100" (using
"i2cdetect -l") then dump the chips contents ("i2cdump N 0x4e b" where
N is the i2c bus number).

Please check "lsmod" and confirm that you are using the w83627hf driver
and not the older w83781d driver.

> > 2* The output of "sensors" in 2.6.15-rc5.
> [root@coyote root]# sensors
> (...)
> w83627hf-isa-0290
> Adapter: ISA adapter
> VCore 1:   +1.66 V  (min =  +1.57 V, max =  +1.73 V)
> VCore 2:   +1.79 V  (min =  +1.57 V, max =  +1.73 V)       ALARM
> +3.3V:     +3.26 V  (min =  +3.14 V, max =  +3.47 V)
> +5V:       +4.87 V  (min =  +4.76 V, max =  +5.24 V)
> +12V:     +11.80 V  (min = +10.82 V, max = +13.19 V)
> -12V:     -12.28 V  (min = -13.18 V, max = -10.80 V)
> -5V:       -5.05 V  (min =  -5.25 V, max =  -4.75 V)
> V5SB:      +5.59 V  (min =  +4.76 V, max =  +5.24 V)       ALARM
> VBat:      +3.15 V  (min =  +2.40 V, max =  +3.60 V)
> fan1:     1757 RPM  (min =   -1 RPM, div = 16)              ALARM
> fan2:     2636 RPM  (min =  659 RPM, div = 16)
> fan3:        0 RPM  (min = 2636 RPM, div = 16)              ALARM
> temp1:       -48°C  (high =    +0°C, hyst =   +11°C)   sensor = 
> thermistor
> temp2:     +67.5°C  (high =  +120°C, hyst =  +115°C)   sensor = 
> thermistor
> temp3:    +127.5°C  (high =  +120°C, hyst =  +115°C)   sensor = 
> PII/Celeron diode   ALARM
> vid:      +1.650 V
> alarms:
> beep_enable:
>           Sound alarm enabled
> 
> > 3* The output of "sensors" in 2.6.15-rc6.
> (...)
> w83627hf-isa-0290
> Adapter: ISA adapter
> VCore 1:   +1.68 V  (min =  +1.57 V, max =  +1.73 V)
> VCore 2:   +1.79 V  (min =  +1.57 V, max =  +1.73 V)       ALARM
> +3.3V:     +3.30 V  (min =  +3.14 V, max =  +3.47 V)
> +5V:       +4.87 V  (min =  +4.76 V, max =  +5.24 V)
> +12V:     +11.86 V  (min = +10.82 V, max = +13.19 V)
> -12V:     -12.28 V  (min = -13.18 V, max = -10.80 V)
> -5V:       -5.00 V  (min =  -5.25 V, max =  -4.75 V)
> V5SB:      +5.62 V  (min =  +4.76 V, max =  +5.24 V)       ALARM
> VBat:      +3.14 V  (min =  +2.40 V, max =  +3.60 V)
> fan1:     1721 RPM  (min =   -1 RPM, div = 16)              ALARM
> fan2:     2636 RPM  (min =  659 RPM, div = 16)
> fan3:        0 RPM  (min = 2636 RPM, div = 16)              ALARM
> temp1:       -48°C  (high =    +0°C, hyst =   +11°C)   sensor = 
> thermistor
> temp2:     +63.0°C  (high =  +120°C, hyst =  +115°C)   sensor = 
> thermistor
> temp3:    +127.5°C  (high =  +120°C, hyst =  +115°C)   sensor = 
> PII/Celeron diode   ALARM
> vid:      +1.650 V
> alarms:
> beep_enable:
>           Sound alarm enabled
> 
> Humm, not a heck of a lot of diff to the sensors output. temp1 is shut 
> off in gkrellm anyway.  Is temp3 the cpu?  This is an Athon XP-2800 
> stepping 00 cpu.

Obvsiouly not, else your computer would be on fire. The CPU temp would
be temp2, although it's quite high especially for a thermistor-based
measurement (which is usually taken from the socket rather than the CPU
itself). And it matches what gkrellm tells you in -rc5 (65 degrees C is
149 degrees F).

temp1 and temp3 are either nor wired, or use a different sensor type
than the one currently setup. You may try changing the sensor type and
see if it brings interesting readings (like built-in CPU diode or
motherboard sensor).

And actually there is very little difference between both outputs -
I expected this as the driver did not change between -rc5 and -rc6.
So the problem seems to be that gkrellm fails to pick the proper
temperature input in -rc6. Why, I have no idea. But as long as
"sensors" work, the bug has to be in gkrellm rather than the kernel
driver.

See if you have anything under /proc/acpi/thermal_zone. Maybe gkrellm
picks the temperature from ACPI in -rc6 for whatever reason.

-- 
Jean Delvare
