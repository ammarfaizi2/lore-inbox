Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751235AbWDSUVI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751235AbWDSUVI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 16:21:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751236AbWDSUVI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 16:21:08 -0400
Received: from service.sh.cvut.cz ([147.32.127.214]:64933 "EHLO
	service.sh.cvut.cz") by vger.kernel.org with ESMTP id S1751235AbWDSUVH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 16:21:07 -0400
Message-ID: <44469BA3.2090309@sh.cvut.cz>
Date: Wed, 19 Apr 2006 22:20:51 +0200
From: Rudolf Marek <r.marek@sh.cvut.cz>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: lkml <linux-kernel@vger.kernel.org>, Andy Green <andy@warmcat.com>,
       lm-sensors@lm-sensors.org
Subject: Re: [lm-sensors] Black box flight recorder for Linux
References: <44379AB8.6050808@superbug.co.uk>	<m3psjqeeor.fsf@defiant.localdomain> <443A4927.5040801@warmcat.com>	<m3odz9kze6.fsf@defiant.localdomain> <m364l5dep9.fsf@defiant.localdomain>
In-Reply-To: <m364l5dep9.fsf@defiant.localdomain>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
> 
> Interesting: i2cdetect and friends can only find a custom Asus sensors
> chip on this bus (ASB100 chip at addresses 0x2D, 0x48 and 0x49) - and
> now my 24C64 at 0x57 (config address 7 = all ones). But the BIOS POST
> searches and finds more devices: there is something at 0x2F, 0x69, and
> there are (I think) DDR SDRAM EEPROMs and 0x51 and 0x52 (0x50 is an
> empty DIMM slot). Got this info with my "DIY" logic analyzer. I think
> the BIOS POST disconnects somehow the devices before loading the OS
> (in order to prevent data damage?).

Well Asus likes to play hide and seek...

> No wonder my first attempt with 24C16 which occupies all 0x50 - 0x57
> addresses had to fail.

Hm that should work, because Asus most likely multiplexes physical lines
instead of devices (using 74HC4052 IIRC)

> I think VGA monitors respond (at least?) at 0x50 address so
> a 16-bit-addressable EEPROM (at least not larger than 24C2048 which
> IMHO aren't yet available) with all-ones I^2C address selected
> should do as well if connected to VGA/DVI I^2C/ACCESS.bus.

What about to connect the device to parallel port, there are some adapter
schematics in kernel docs.

Simplest one needs just one 7405 two diodes and four resistors.

There is also a i2c-pport driver that may work without additional parts, just 3
pins of parport are used. Please note that you should set the parport to SPP
mode and not load any linux drivers. The driver is for 2.4. No 2.6 but I have
used it so you may find it on http://assembler.cz

Regards
Rudolf
