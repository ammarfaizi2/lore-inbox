Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265201AbSLBXnA>; Mon, 2 Dec 2002 18:43:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265336AbSLBXnA>; Mon, 2 Dec 2002 18:43:00 -0500
Received: from imrelay-2.zambeel.com ([209.240.48.8]:44050 "EHLO
	imrelay-2.zambeel.com") by vger.kernel.org with ESMTP
	id <S265201AbSLBXm5>; Mon, 2 Dec 2002 18:42:57 -0500
Message-ID: <233C89823A37714D95B1A891DE3BCE5202AB1A69@xch-a.win.zambeel.com>
From: Manish Lachwani <manish@Zambeel.com>
To: "'Jeff Garzik'" <jgarzik@pobox.com>, hps@intermeta.de
Cc: linux-kernel@vger.kernel.org
Subject: RE: LM sensors into kernel?
Date: Mon, 2 Dec 2002 15:50:05 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sometime back, I had put the sensors support in the 2.4.17 SMP kernel. It
did not give me any problems and we have been using it successfully. The
following are some of the details:

Created a CONFIG_SENSORS entry and an entry for every sensor type

#
# Hardware sensors support
#
CONFIG_SENSORS=y
# CONFIG_SENSORS_ADM1021 is not set
# CONFIG_SENSORS_ADM1024 is not set
# CONFIG_SENSORS_ADM1025 is not set
# CONFIG_SENSORS_ADM9240 is not set
# CONFIG_SENSORS_DS1621 is not set
# CONFIG_SENSORS_FSCPOS is not set
# CONFIG_SENSORS_GL518SM is not set
# CONFIG_SENSORS_GL520SM is not set
# CONFIG_SENSORS_MAXILIFE is not set
# CONFIG_SENSORS_IT87 is not set
# CONFIG_SENSORS_MTP008 is not set
# CONFIG_SENSORS_LM75 is not set
# CONFIG_SENSORS_LM78 is not set
# CONFIG_SENSORS_LM80 is not set
# CONFIG_SENSORS_LM87 is not set
# CONFIG_SENSORS_SIS5595 is not set
# CONFIG_SENSORS_THMC50 is not set
# CONFIG_SENSORS_W83781D is not set
CONFIG_SENSORS_W83782D=y

And in the Makefile:

DRIVERS-$(CONFIG_SENSORS) += drivers/sensors/sensor.o

Put all the sensor related drivers in drivers/sensors  and created a
Makefile:

O_TARGET := sensor.o

export-objs     := sensors.o

obj-$(CONFIG_SENSORS)           += sensors.o
obj-$(CONFIG_SENSORS_ADM1021)   += adm1021.o
obj-$(CONFIG_SENSORS_ADM1024)   += adm1024.o
obj-$(CONFIG_SENSORS_ADM1025)   += adm1025.o
obj-$(CONFIG_SENSORS_ADM9240)   += adm9240.o
obj-$(CONFIG_SENSORS_BT869)     += bt869.o
obj-$(CONFIG_SENSORS_DDCMON)    += ddcmon.o
obj-$(CONFIG_SENSORS_DS1621)    += ds1621.o
obj-$(CONFIG_SENSORS_EEPROM)    += eeprom.o
obj-$(CONFIG_SENSORS_FSCPOS)    += fscpos.o
obj-$(CONFIG_SENSORS_GL518SM)   += gl518sm.o
obj-$(CONFIG_SENSORS_GL520SM)   += gl520sm.o
obj-$(CONFIG_SENSORS_IT87)      += it87.o
obj-$(CONFIG_SENSORS_LM75)      += lm75.o
obj-$(CONFIG_SENSORS_LM78)      += lm78.o
obj-$(CONFIG_SENSORS_LM80)      += lm80.o
obj-$(CONFIG_SENSORS_LM87)      += lm87.o
obj-$(CONFIG_SENSORS_MAXILIFE)  += maxilife.o
obj-$(CONFIG_SENSORS_MTP008)    += mtp008.o
obj-$(CONFIG_SENSORS_SIS5595)   += sis5595.o
obj-$(CONFIG_SENSORS_THMC50)    += thmc50.o
obj-$(CONFIG_SENSORS_VIA686A)   += via686a.o
obj-$(CONFIG_SENSORS_W83781D)   += w83781d.o
obj-$(CONFIG_SENSORS_W83782D)   += w83782d.o



-----Original Message-----
From: Jeff Garzik [mailto:jgarzik@pobox.com]
Sent: Monday, December 02, 2002 2:52 PM
To: hps@intermeta.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: LM sensors into kernel?


Henning P. Schmiedehausen wrote:
> Bill Davidsen <davidsen@tmr.com> writes:
> 
> 
>>Okay, thanks. I was hoping since lm_sensors were proposed before the
>>freeze, relatively stable, and highly useful that they might get in.
> 
> 
> As most of the I2C code is in, I would consider the lm_sensors mainly
> as "drivers" so they wouldn't be hit by the freeze. 


To tangent a bit, I was somewhat disappointed when the I2C kernel 
merging guy disappeared... :(

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
