Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932464AbWFGXwt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932464AbWFGXwt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 19:52:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932467AbWFGXwt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 19:52:49 -0400
Received: from khc.piap.pl ([195.187.100.11]:20752 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S932464AbWFGXws (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 19:52:48 -0400
To: Andy Green <andy@warmcat.com>
Cc: Jean Delvare <khali@linux-fr.org>, linux-kernel@vger.kernel.org,
       lm-sensors@lm-sensors.org
Subject: Re: Black box flight recorder for Linux
References: <44379AB8.6050808@superbug.co.uk>
	<m3psjqeeor.fsf@defiant.localdomain> <443A4927.5040801@warmcat.com>
	<m3zmgqxjs8.fsf@defiant.localdomain>
	<20060607100349.a990e054.khali@linux-fr.org>
	<4486A7FC.2090904@warmcat.com>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Thu, 08 Jun 2006 01:52:42 +0200
In-Reply-To: <4486A7FC.2090904@warmcat.com> (Andy Green's message of "Wed, 07 Jun 2006 11:18:36 +0100")
Message-ID: <m3irncr0ad.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Andy Green <andy@warmcat.com> writes:

> A whole other way forward is to consider to replace the EEPROM from
> the original proposal (which does provide its own advantages such as
> simplicity, I accept) with something else that ends up on another
> PC. In this concept some logic presents a fake I2C peripheral to the
> DDC interface at an I2C address of our choosing.  This logic acts as a
> bidirectional "UART" type of thing, allowing transfer of data in both
> directions between the Linux box being debugged and another PC.

Right. I think one could use something like ATMEL 89F2051 (20-pin 8051
non-SMD clones with flash and hardware UART) or something similar.

Client I2C is difficult in Linux (using general purpose I/O port) but
with a dedicated CPU it's not a problem (not sure about 400 kHz access).

> http://warmcat.com/milksop/filtror.html

Well, that's a bit more complicated. I'm not going to try that on
an experimental PCB :-)

> However this would be much simpler, not even needing RAM.  It can hook
> to the second PC by the same I2C method, parallel printer port, RS232
> or USB depending on the level of complexity of the design.
>
> I guess the link will feel quite like a 9600 or 19200 baud serial port
> in terms of throughput.

Depends on I2C. With something like 400 kHz it should be faster,
probably like 115200.

> Maybe this effort is considered too esoteric, but it seems to me to be
> a reason to keep the DDC access drivers standalone, the
> hardware-specific framebuffer drivers can call through to them and we
> can use them in a clean way.  I realize this is a bit of a late
> objection and that there was not previously much point to keeping them
> as separate things in the world.

Actually we have:
- the Xserver "hardware access" issue
- DRI/DRM
- now the I2C bus driver
- frame buffer

To avoid conflicts we really need them managed by a single driver.
Probably the GGI (KGI?) should be revisited?

Long-term project, unfortunatelly, but I think we'll have to do that
eventually.

The I2C, graphics subsystem and DRI/DRM could be sub-modules, with
the master module only keeping track of hardware access, mode
settings etc.
-- 
Krzysztof Halasa
