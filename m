Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266903AbUIESts@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266903AbUIESts (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 14:49:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266905AbUIESts
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 14:49:48 -0400
Received: from imag.imag.fr ([129.88.30.1]:60567 "EHLO imag.imag.fr")
	by vger.kernel.org with ESMTP id S266903AbUIEStq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 14:49:46 -0400
Date: Sun, 5 Sep 2004 20:48:52 +0200
To: linux-kernel@vger.kernel.org
Subject: Re: Intel ICH - sound/pci/intel8x0.c
Message-ID: <20040905184852.GA25431@linux.ensimag.fr>
Reply-To: 1094385318.1099.23.camel@localhost.localdomain
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040523i
From: Matthieu Castet <mat@ensilinx1.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.4 (imag.imag.fr [129.88.30.1]); Sun, 05 Sep 2004 20:49:42 +0200 (CEST)
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-Information: Please contact the ISP for more information
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2004-09-05 at 03:43, Jon Smirl wrote:
> The joystick PCI ID table in intel8x0.c is not correct. Joysticks and
> MIDI ports are ISA devices and need be located by manual probing. This
> ID table needs to be removed. Joystick and MIDI ports do not have PCI
> IDs.

I agree, that was I explain in a previous post
(http://marc.theaimsgroup.com/?l=linux-kernel&m=109420281830288&w=2)
see the PS.


> It isn't that simple. The LPC bridge also contains the controls for
> the
> joystick ports. You also need them for hotplug handling of the bridge
> should someone stick one in a laptop docking station. The ID table
> also
> ensures the driver is loaded. It's probably true that it will need
> splitting up a bit if another driver also needs ownership of the LPC
> bridge but for now that hasn't happened.

Not for jostick and midi stuff you have to use pnp bus.
On my computer it works well :
I have removed the support of MIDI and GAMEPORT in alsa driver.
The gameport is handle with ns558
The midi device with a mpu401_pnp I post on the alsa mailling list
(http://sourceforge.net/mailarchive/forum.php?thread_id=5468125&forum_id=1751)
For that it work well you need a pnpbios patch
(http://marc.theaimsgroup.com/?l=linux-kernel&m=109411306024720&w=2) or
even try to use my pnpacpi patch
(http://marc.theaimsgroup.com/?l=linux-kernel&m=109430451522335&w=2)
And the isapnp hotplug script auto load the right module...

Regards,
Matthieu
