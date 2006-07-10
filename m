Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161102AbWGJE3a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161102AbWGJE3a (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 00:29:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161335AbWGJE3a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 00:29:30 -0400
Received: from ns2.g-housing.de ([81.169.133.75]:58030 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S1161102AbWGJE3a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 00:29:30 -0400
Date: Mon, 10 Jul 2006 05:29:19 +0100 (BST)
From: Christian Kujau <evil@g-house.de>
X-X-Sender: evil@sheep.housecafe.de
To: linux-kernel@vger.kernel.org
cc: linux1394-devel@lists.sourceforge.net
Subject: ohci1394: aborting transmission
Message-ID: <Pine.LNX.4.64.0607100527200.10447@sheep.housecafe.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello lkml, hello linux1394-devel,

I've noticed a *very* long delay upon booting current -mm kernels. 
Here's a snippet from netconsole with 2.6.17-mm6:

------------snip--------------------
  [   50.651945] ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [APC1] -> GSI 16 (level, low) -> IRQ 16
  [   50.655774] NVRM: loading NVIDIA Linux x86_64 Kernel Module  1.0-7182  Wed Apr 19 13:55:00 PDT 2006
  [   50.763074] ACPI: PCI Interrupt 0000:00:06.0[A] -> Link [APCJ] -> GSI 23 (level, high) -> IRQ 23
  [   51.078391] intel8x0_measure_ac97_clock: measured 50730 usecs
  [   51.082255] intel8x0: clocking to 46828
  [   51.651890] ohci1394: fw-host0: AT dma reset ctx=0, aborting transmission
  [  229.450216] input: USB HIDBP Keyboard 046a:0001 as /class/input/input0
  [  229.458201] usbcore: registered new driver usbkbd
  [  229.462264] drivers/usb/input/usbkbd.c: :USB HID Boot Protocol keyboard driver
  [  229.473883] input: Logitech USB-PS/2 Optical Mouse as /class/input/input1
  [  229.479629] usbcore: registered new driver usbmouse
------------snap--------------------

So, we're waiting 3 minutes from 'ohci1394: aborting transmission' until 
'input: USB HIDBP' kicks in and boot continues as usual. Unfortunately 
I'm not sure since when this unusual delay is present as I don't
monitor the box' startups closely. With 2.6.18-rc1 it's:

------------snip------------
[   48.318107] intel8x0_measure_ac97_clock: measured 50655 usecs
[   48.322011] intel8x0: clocking to 46909
[   48.748826] ieee1394: Host added: ID:BUS[0-00:1023] GUID[0010dc00009b6e48]
[  226.073196] input: USB HIDBP Keyboard 046a:0001 as /class/input/input0
[  226.080945] usbcore: registered new driver usbkbd
[  226.084830] drivers/usb/input/usbkbd.c: :USB HID Boot Protocol keyboard driver
------------snip------------

Full logs/config/lspci here: http://nerdbynature.de/bits/2.6.17-mm6/

While I'm trying to find out the first kernelversion with these 
symptoms: any ideas on this one?

I can see the "[PATCH 2.6.17-rc5-mm2 00/18] ieee1394: misc updates" 
patchset, maybe I'll start with this one....

Thanks,
Christian.
-- 
BOFH excuse #54:

Evil dogs hypnotised the night shift
