Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751461AbVKYTbu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751461AbVKYTbu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Nov 2005 14:31:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751462AbVKYTbu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Nov 2005 14:31:50 -0500
Received: from smtp-105-friday.noc.nerim.net ([62.4.17.105]:29456 "EHLO
	mallaury.nerim.net") by vger.kernel.org with ESMTP id S1751461AbVKYTbt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Nov 2005 14:31:49 -0500
Date: Fri, 25 Nov 2005 20:33:00 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Vishal Linux <vishal.linux@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: How to get SDA/SCL bit position in the control word register of
 the video card?
Message-Id: <20051125203300.0899e9b7.khali@linux-fr.org>
In-Reply-To: <e3e24c6a0511240245i1d395ae6g4d768a75a602d6ce@mail.gmail.com>
References: <e3e24c6a0511240245i1d395ae6g4d768a75a602d6ce@mail.gmail.com>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vishal,

First of all, I would suggest that you post using your real name.
Pretending that you are Linux on your own will not make you popular.

> I am trying to communicate to the monitor eeprom to get the monitor
> capabilities and for that i need to have SDA/SCL bit positions in the
> control word register of the video card (to read and wrtie data using
> i2c protocol).
> 
> Different video card vendors have different offsets for the control
> word register and different bit positions for SDA/SCL.

True, this is actually totally hardware-dependant.

> I tried to use linux kernel API char* get_EDID_from_BIOS(void*) and
> then using kgdb to debug the kernel module (that i wrote) to get the
> same  but failed to find the way to get the above.

I couldn't find any function by that name in the Linux kernel source
tree. What are you talking about?

> I do have the offset of the control word register and Masking Value of
> Intel and Matrox card but i would like NOT to hardcode the masking
> value and the offset in my code. This will lead me to modify  my code
> for the different cards.
>
> Is there any way to get the control word register's address (and then
> SDA/SCL bit position) on the linux operating system. Is this
> information available to linux kernel ?

Support for different hardware belong to different drivers. If you are
trying to put support for many incompatible chips in a single driver,
you're doing something wrong.

Anyway, we already have DDC (I2C) support for almost all graphics
adapters in Linux. In most cases, the support is part of the
framebuffer driver (radeonfb, i2c-matroxfb, i810fb, savagefb,
nvidiafb.) We also have some legacy standalone drivers (i2c-810,
i2c-prosavage, i2c-savage4, i2c-voodoo3) which should be obsoleted over
time.

So, although you didn't clearly say what you really were trying to do,
it's almost certainly wrong. Don't go reinventing the wheel, use
existing drivers. Once you have loaded the proper driver for your
hardware, you can load the eeprom module to get access to the EDID
data. There is an helper script, named ddcmon [1], in the lm_sensors
package, which will decode the EDID data in a human-readable format.

You may also want to take a look at an older program called read-edid
[2], which does actually attempt to use the BIOS to retrieve the EDID,
with varying success, then decodes it in a form suitable for X
configuration files. This can be used in combination with another
script from the lm_sensors package, decode-edid.pl [3], to get the same
output from the i2c adapter and eeprom modules instead of BIOS.

[1] http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/prog/eeprom/ddcmon
[2] http://john.fremlin.de/programs/linux/read-edid/
[3] http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/prog/eeprom/decode-edid.pl

-- 
Jean Delvare
