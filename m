Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262424AbUDDOsm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Apr 2004 10:48:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262416AbUDDOsm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Apr 2004 10:48:42 -0400
Received: from smtp-100-sunday.nerim.net ([62.4.16.100]:26631 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S262427AbUDDOsf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Apr 2004 10:48:35 -0400
Date: Sun, 4 Apr 2004 16:48:45 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Michael Hunold <hunold@convergence.de>
Cc: sensors@Stimpy.netroedge.com, linux-kernel@vger.kernel.org, greg@kroah.com
Subject: Re: [RFC|PATCH][2.6] Additional i2c adapter flags for i2c client
 isolation
Message-Id: <20040404164845.4a4b7d8d.khali@linux-fr.org>
In-Reply-To: <40700823.7030802@convergence.de>
References: <40686476.7020603@convergence.de>
	<20040330213418.195dc972.khali@linux-fr.org>
	<406EBA38.1030203@gmx.de>
	<20040403163031.122b5df8.khali@linux-fr.org>
	<40700823.7030802@convergence.de>
Reply-To: sensors@stimpy.netroedge.com, linux-kernel@vger.kernel.org
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Here are some statistics:
> 
> Ok, adapters which specify I2C_ADAP_CLASS_TV_ANALOG
> ./drivers/media/video/saa7134/saa7134-i2c.c
> ./drivers/media/video/bttv-i2c.c
> 
> Ok, adapters which specify I2C_ADAP_CLASS_TV_ANALOG (these are my 
> drivers and I plan to patch them accordingly)
> ./drivers/media/video/hexium_orion.c
> ./drivers/media/video/mxb.c
> ./drivers/media/video/hexium_gemini.c
> ./drivers/media/video/dpc7146.c

I'm a bit confused, it's I2C_ADAP_CLASS_TV_ANALOG both times. What's the
difference, except that the second are yours?

> 
> Ok, adapters which specify I2C_ADAP_CLASS_CAM_DIGITAL,
> ./drivers/usb/media/w9968cf.c
> 
> Ok, adapters which specify I2C_ADAP_CLASS_SMBUS,
> ./drivers/i2c/busses/i2c-nforce2.c
> ./drivers/i2c/busses/i2c-sis630.c
> ./drivers/i2c/busses/i2c-piix4.c
> ./drivers/i2c/busses/i2c-sis96x.c
> ./drivers/i2c/busses/i2c-i801.c
> ./drivers/i2c/busses/i2c-ali15x3.c
> ./drivers/i2c/busses/i2c-isa.c
> ./drivers/i2c/busses/i2c-viapro.c
> ./drivers/i2c/busses/i2c-amd8111.c
> ./drivers/i2c/busses/i2c-amd756.c
> ./drivers/i2c/busses/i2c-parport-light.c
> ./drivers/i2c/busses/i2c-parport.c

You missed i2c-ali1535.c, i2c-sis5595.c and i2c-via.c. I think that you
used an old 2.6 trer for your statistics :(

> The following drivers implement adapters and don't have a type 
> specified. (6)
> 
> ./drivers/i2c/busses/i2c-ali1535.c
> ./drivers/i2c/busses/i2c-iop3xx.c
> ./drivers/i2c/busses/i2c-sis5595.c
> ./drivers/i2c/busses/scx200_acb.c
> ./drivers/i2c/busses/i2c-keywest.c
> ./drivers/i2c/busses/i2c-ibm_iic.c
> Are all of these I2C_ADAP_CLASS_SMBUS?

i2c-ali1535.c and i2c-sis5595.c are, and are already fixed. I can't tell
for the others.

> Ok, now come some special cases, where busses are registered through
> a helper function and don't have a type set. (my guesses are in
> paranthesis)
> 
> => i2c_bit_add_bus() users with no class entry (16)
> ./drivers/i2c/busses/i2c-frodo.c
> ./drivers/i2c/busses/i2c-philips-par.c
> ./drivers/i2c/busses/i2c-prosavage.c
> ./drivers/i2c/busses/scx200_i2c.c
> ./drivers/i2c/busses/i2c-savage4.c
> ./drivers/i2c/busses/i2c-via.c
> ./drivers/i2c/busses/i2c-elv.c
> ./drivers/i2c/busses/i2c-velleman.c
> ./drivers/i2c/busses/i2c-hydra.c
> ./drivers/video/aty/radeon_i2c.c
> ./drivers/ieee1394/pcilynx.c
> ./drivers/acorn/char/i2c.c
> ./drivers/i2c/busses/i2c-i810.c (I2C_CLASS_DDC|I2C_CLASS_TV_ANALOG?)
> ./drivers/i2c/busses/i2c-voodoo3.c (I2C_CLASS_DDC|I2C_CLASS_TV_ANALOG?)
> ./drivers/video/matrox/i2c-matroxfb.c (I2C_CLASS_DDC?)
> ./drivers/media/video/zoran_card.c (I2C_CLASS_TV_ANALOG?)

i2c-philips-par.c, i2c-elv.c and i2c-velleman.c are gone so you can
forget about them.

i2c-prosavage.c, i2c-savage4.c and radeon_i2c.c are video adapter
drivers, like i2c-i810.c, i2c-voodoo3.c and i2c-matroxfb.c. Most (if not
all) of them have several busses, typically one for DDC and one for
video chips, sometimes more. I don't expect us to have to OR classes in
most cases, just give the correct class to each bus. This is already
done for i2c-voodoo3.c, BTW.


> => i2c_pcf_add_bus() users with no class entry
> ./drivers/i2c/busses/i2c-elektor.c (I2C_CLASS_ALL?)
> 
> => i2c_iic_add_bus() users with no class entry
> ./drivers/i2c/busses/i2c-ite.c (I2C_CLASS_ALL?)
> 
> Now to the other side, the client drivers. As we have discussed, they 
> will all need to define a class type. My proposals are above each
> section:
> 
> I2C_CLASS_SMBUS
> ./drivers/i2c/chips/w83781d.c
> ./drivers/i2c/chips/lm75.c
> ./drivers/i2c/chips/adm1021.c
> ./drivers/i2c/chips/via686a.c
> ./drivers/i2c/chips/lm85.c
> ./drivers/i2c/chips/eeprom.c
> ./drivers/i2c/chips/it87.c
> ./drivers/i2c/chips/lm78.c
> ./drivers/i2c/chips/lm83.c
> ./drivers/i2c/chips/asb100.c
> ./drivers/i2c/chips/lm90.c
> ./drivers/i2c/chips/w83l785ts.c
> ./drivers/i2c/chips/fscher.c
> ./drivers/i2c/chips/gl518sm.c

They all do already, except lm85.c.

> I2C_CLASS_TV_ANALOG
> ./drivers/media/video/tea6420.c
> ./drivers/media/video/tea6415c.c
> ./drivers/media/video/tda9840.c
> ./drivers/media/video/tuner.c
> ./drivers/media/video/saa5249.c
> ./drivers/media/video/saa5246a.c
> ./drivers/media/video/saa7110.c
> ./drivers/media/video/tda9887.c
> ./drivers/media/video/saa7134/saa6752hs.c
> ./drivers/media/video/bt856.c
> ./drivers/media/video/saa7185.c
> ./drivers/media/video/bt819.c
> ./drivers/media/video/saa7111.c
> ./drivers/media/video/tuner-3036.c
> ./drivers/media/video/tda9875.c
> ./drivers/media/video/vpx3220.c
> ./drivers/media/video/msp3400.c
> ./drivers/media/video/tda7432.c
> ./drivers/media/video/bt832.c
> ./drivers/media/video/saa7114.c
> ./drivers/media/video/tvmixer.c
> ./drivers/media/video/adv7175.c
> ./drivers/media/video/adv7170.c
> ./drivers/media/video/tvaudio.c
> 
> I2C_CLASS_TV_DIGITAL
> ./drivers/media/dvb/bt8xx/dvb-bt8xx.c
> 
> I2C_CLASS_DDC
> ./drivers/video/matrox/matroxfb_maven.c

Hu, I think this one is a bus, not a chip.

BTW, there's only one chip driver that would have class I2C_CLASS_DDC,
this is ddcmon.c and it hasn't been ported to 2.6 yet.

> 
> No idea about these. Do we need some new classes for them?
> ./drivers/i2c/i2c-dev.c

This one is a generic driver that allows bus manipulation from
user-space. I2C_CLASS_ALL, definitely.

> ./drivers/macintosh/therm_adt7467.c
> ./drivers/macintosh/therm_pm72.c
> ./drivers/macintosh/therm_windtunnel.c
> ./drivers/acorn/char/pcf8583.c
> ./sound/oss/dmasound/dac3550a.c
> ./sound/oss/dmasound/tas_common.c
> ./sound/ppc/keywest.c
> ./drivers/media/video/ir-kbd-i2c.c

No idea either. All I can say is that some busses and chips concern
sound, so we will have to create a new class (I2C_CLASS_SOUND or
something similar).

> So, to get the whole stuff consistent through the kernel, 24 adapter 
> drivers and 49 client drivers need to be touched.

Sounds feasable. Now the question is: what will we do with busses and
chips we don't know? Two possibilities:

1* Don't set the class. This prevents the driver from being used, so we
can expect people to complain quite quickly, letting us fix the drivers
with the correct class.

2* Use I2C_CLASS_ALL. That way they keep working and people will not
complain. But most drivers will be too permissive, which is against the
plan.

Frankly I don't know.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
