Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263664AbUIFIl1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263664AbUIFIl1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 04:41:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263736AbUIFIl1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 04:41:27 -0400
Received: from imag.imag.fr ([129.88.30.1]:51652 "EHLO imag.imag.fr")
	by vger.kernel.org with ESMTP id S263664AbUIFIlY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 04:41:24 -0400
Date: Mon, 6 Sep 2004 10:40:29 +0200
To: linux-kernel@vger.kernel.org
Subject: Re: Intel ICH - sound/pci/intel8x0.c
Message-ID: <20040906084029.GA1316@linux.ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040523i
From: Matthieu Castet <mat@ensilinx1.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.4 (imag.imag.fr [129.88.30.1]); Mon, 06 Sep 2004 10:41:19 +0200 (CEST)
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-Information: Please contact the ISP for more information
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I just spent a while looking at the code. The joystick driver doesn't
> need to exist. Instead the snd_intel8x0_probe() routine could have a
> loop that does pci_get_subsys() over the ID's in
> snd_intel8x0_joystick_ids[]. When it finds one, use the config space
> to enable the joystick/midiports. You can locate the ports since
> pci_get_subsys() returns the pci_dev* for the bridge device.  Save the
> pci_dev* and set the ports back in snd_intel8x0_remove(). Don't forget
> to pci_put() the bridge device.
> 
yes, that is done in hw_random and 8xx_tco for a long time...

> This isn't a device driver for the bridge, we just want to locate it
> and flip some bits. Later on if a driver for the bridge get written it
> should support an API for setting these bits and the search loop can
> be removed.
> 
> All of these devices are listed as Intel LPC bridges:
> 2410, 2420, 2440, 244c, 2450, 2480, 2484, 24c0, 24cc, 24d0, 24dc,
> 25a1, 2640, 2641, 2642
> I have a 24D0 which isn't in the driver list, this is probably why
> MIDI doesn't work on my system.
Also check that you pass the righ io port to the modules (the irq won't
be use, it will use only polling mode )...

If you had enable pnpbios in your kernel, you could see your midi port
with :
for i in /sys/bus/pnp/devices/* ; do if [ "$(<$i/id)" = "PNP0b006" ];
then cat $i/resources;cat $i/options; fi ; done

Matthieu
