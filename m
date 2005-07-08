Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262852AbVGHUob@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262852AbVGHUob (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 16:44:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262876AbVGHUhf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 16:37:35 -0400
Received: from mta08-winn.ispmail.ntl.com ([81.103.221.48]:37109 "EHLO
	mta08-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S262873AbVGHUg5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 16:36:57 -0400
From: Neil Darlow <neil@darlow.co.uk>
To: vojtech@suze.cz
Subject: ns558 mis-detects gameport
Date: Fri, 8 Jul 2005 21:36:47 +0100
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org, linux-joystick@atrey.karlin.mff.cuni.cz
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507082136.47475.neil@darlow.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

I am passing on this information at the request of Daniel Drake (Gentoo kernel 
ebuild maintainer).

My hardware is an ASRock K7S41GX motherboard with Athlon XP2200+ CPU
running 2.6.12 on Gentoo GNU/Linux 2005.0. My gamepad is an Heroic HC 3100 
2-axis, 4-button digital model with Turbo features.

The CVS version string of ns558.c is:
$Id: ns558.c,v 1.43 2002/01/24 19:23:21 vojtech Exp $

My motherboard features a generic PC/ISA gameport at BIOS-selectable
addresses of 0x200 or 0x208. I have built my kernel (using Gentoo's genkernel) 
to include the Joystick Interface, Generic PC/ISA Gameport and Analog 
Joystick support as modules which are loaded at boot by coldplug/hotplug 
logic.

If I manually modprobe ns558 (which loads gameport), analog and joydev after 
boot my gameport is detected. If I let coldplug/hotplug load the modules at 
boot then ns558 fails to detect my gameport.

If I unload, and then reload, ns558 using coldplug/hotplug at boot then ns558 
detects my gameport correctly. My module loading setup and dmesg output for a 
ns558 insert-remove-insert cycle are as follows:

  options analog map=gamepad
  above analog joydev
  pre-install analog modprobe -r ns558; modprobe ns558

  gameport: NS558 ISA Gameport is isa0200/gameport0, io 0x201, speed 806kHz
  pnp: Device 00:0a disabled.
  ns558: probe of 00:0a failed with error -16
  gameport: kgameportd exiting
  pnp: Device 00:0a activated.
  gameport: NS558 PnP Gameport is pnp00:0a/gameport0, io 0x200, speed 806kHz
  input: Analog 2-axis 4-button gamepad at pnp00:0a/gameport0 [TSC timer, 1786
    MHz clock, 1299 ns res]

At https://www.redhat.com/archives/fedora-list/2005-January/msg04967.html the 
same problem is reported for 2.6.10 on Fedora.

Is a fix or workaround, other than what I'm doing already, available for this 
problem?

Regards,
Neil Darlow
-- 
Anti-virus scanned by ClamAV-0.86.1 - http://www.clamav.net
