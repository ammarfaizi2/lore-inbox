Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751756AbWJWHre@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751756AbWJWHre (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 03:47:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751773AbWJWHre
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 03:47:34 -0400
Received: from fmmailgate05.web.de ([217.72.192.243]:31674 "EHLO
	fmmailgate05.web.de") by vger.kernel.org with ESMTP
	id S1751756AbWJWHrd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 03:47:33 -0400
Reveived: from web.de 
	by fmmailgate05.web.de (Postfix) with SMTP id C385B2561E6
	for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2006 09:47:00 +0200 (CEST)
Date: Mon, 23 Oct 2006 09:47:00 +0200
Message-Id: <1381032543@web.de>
MIME-Version: 1.0
From: Christian stahl <stahl23@web.de>
To: linux-kernel@vger.kernel.org
Subject: 2.6.18.1 hangs after resuming from apm suspend
Organization: http://freemail.web.de/
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After upgrading from 2.6.16.20 to 2.6.18.1 my Siemens Scenic
Mobile 750AGP Notebook hangs after resuming from suspend.

However resuming from suspend works properly if:

- the prism 2.5 WLAN card is removed before suspending
- the prism 2.5 WLAN is removed after resuming


Here's the content of /proc/interrupts:

   0:     466068          XT-PIC  timer
  1:       2282          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  7:     780738          XT-PIC  yenta, pcmcia1.0
  9:          1          XT-PIC  yenta
 10:          0          XT-PIC  ES1938
 11:          1          XT-PIC  uhci_hcd:usb1
 12:      48503          XT-PIC  i8042
 14:       2935          XT-PIC  ide0
NMI:          0 
ERR:          0


This is what happens after initiating apm -s;

hostap_cs: CS_EVENT_PM_SUSPEND
wifi0: removed pending cmd_queue entry (type=0, cmd=0x0021, param0=0xfc28)
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
PM: Writing back config space on device 0000:00:00.0 at offset 1 (was a2100106, writing 22100106)
PM: Writing back config space on device 0000:00:01.0 at offset 7 (was 2a0e0e0, writing 22a0e0e0)
PCI: Enabling device 0000:00:07.2 (0000 -> 0001)
PCI: Found IRQ 11 for device 0000:00:07.2
usb usb1: root hub lost power or was reset
PM: Writing back config space on device 0000:00:08.0 at offset b (was 3e110a, writing 8898125d)
PCI: Enabling device 0000:00:08.0 (0000 -> 0001)
PCI: Found IRQ 10 for device 0000:00:08.0
PM: Writing back config space on device 0000:00:14.0 at offset 1 (was 2100000, writing 2100007)
PCI: Found IRQ 9 for device 0000:00:14.0
PCI: Sharing IRQ 9 with 0000:01:00.0
wifi0: hfa384x_cmd: command was not completed (res=0, entry=c5e384a0, type=0, cmd=0x0021, param0=0xfc28, EVSTAT=ffff INTEN=ffff)
wifi0: interrupt delivery does not seem to work
wifi0: hfa384x_get_rid: CMDCODE_ACCESS failed (res=-110, rid=fc28, len=2)
Could not read current WEP flags.
wifi0: encryption setup failed
Could not read current WEP flags.
wifi0: encryption setup failed
Could not read current WEP flags.
wifi0: encryption setup failed
Could not read current WEP flags.
wifi0: encryption setup failed
Could not read current WEP flags.
wifi0: encryption setup failed
PM: Writing back config space on device 0000:00:14.1 at offset 1 (was 82100000, writing 2100007)
PCI: Found IRQ 7 for device 0000:00:14.1
hostap_cs: CS_EVENT_PM_RESUME
wifi0: card already removed or not configured during shutdown
wifi0: Interrupt, but dev not OK
wifi0: Interrupt, but dev not OK
wifi0: Interrupt, but dev not OK
wifi0: Interrupt, but dev not OK
wifi0: Interrupt, but dev not OK
wifi0: Interrupt, but dev not OK
wifi0: Interrupt, but dev not OK
wifi0: Interrupt, but dev not OK
wifi0: Interrupt, but dev not OK
wifi0: Interrupt, but dev not OK
printk: 756711 messages suppressed.
wifi0: Interrupt, but dev not OK
pccard: card ejected from slot 1
wifi0: cnfAuthentication setting to 0x1 failed
Could not read current WEP flags.
wifi0: encryption setup failed
wlan0: JoinRequest 00:0f:66:d3:14:60 failed
prism2_hw_init: initialized in 5318 ms
wifi0: prism2_enable_aux_port - timeout - reg=0xffff
wifi0: prism2_enable_aux_port - timeout - reg=0xffff
wifi0: valid PDA not found
SWSUPPORT0 write/read failed: FFFF != 8A32
hostap_cs: Initialization failed
wifi0: card already removed or not configured during shutdown
hub 1-0:1.0: over-current change on port 1
wifi0: card already removed or not configured during shutdown
hub 1-0:1.0: over-current change on port 2

[stalls here until the card is being removed and hostap_cs gets
unloaded]
_______________________________________________________________________
Viren-Scan für Ihren PC! Jetzt für jeden. Sofort, online und kostenlos.
Gleich testen! http://www.pc-sicherheit.web.de/freescan/?mc=022222

