Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751598AbWDYQdX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751598AbWDYQdX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 12:33:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751596AbWDYQdX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 12:33:23 -0400
Received: from smtp3.nextra.sk ([195.168.1.142]:51719 "EHLO mailhub3.nextra.sk")
	by vger.kernel.org with ESMTP id S1751594AbWDYQdW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 12:33:22 -0400
Message-ID: <444E4F4C.1030509@rainbow-software.org>
Date: Tue, 25 Apr 2006 18:33:16 +0200
From: Ondrej Zary <linux@rainbow-software.org>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Trying to get swsusp working on DTK FortisPro TOP-5A notebook
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
I'm trying to get swsusp working on my DTK FortisPro TOP-5A notebook. I 
compiled 2.6.16 kernel with drivers compiled in (ES1869 sound, TI 
CardBus, Xircom PCMCIA ethernet, Orinoco wifi and maybe something more). 
There is no ACPI as BIOS does not support it. The problem is that when I 
do "echo disk >/sys/power/state", it refuses to suspend:

Stopping tasks: =============================|
Shrinking memory... done (8698 pages freed)
pnp: Device 00:19 disabled.
pnp: Failed to disable device 00:16.
Could not suspend device 00:16: error -5
pnp: Device 00:19 activated.
PCI: Found IRQ 11 for device 0000:00:01.2
PCI: Found IRQ 9 for device 0000:00:0e.0
PCI: Found IRQ 11 for device 0000:00:0e.1
eth0: autonegotiation failed; using 10mbs
eth0: MII selected
eth0: media 10BaseT, silicon revision 4
Some devices failed to suspend
Restarting tasks... done


Device 00:19 is gameport of the sound card (it seems to suspend fine), 
however device 00:16 does not. It seems to be the synaptics touchpad:

$ cat /sys/bus/pnp/devices/00\:16/id
PNP0f13
$ cat /sys/bus/pnp/devices/00\:16/resources
state = active
irq 12

The psmouse driver is compiled in. Any ideas?

-- 
Ondrej Zary
