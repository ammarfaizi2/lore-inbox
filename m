Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262730AbUHMLke@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262730AbUHMLke (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 07:40:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262927AbUHMLke
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 07:40:34 -0400
Received: from rg06.tte.ele.tue.nl ([131.155.194.16]:24846 "EHLO
	azrael.luon.net") by vger.kernel.org with ESMTP id S262730AbUHMLkb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 07:40:31 -0400
Date: Fri, 13 Aug 2004 13:43:21 +0200
From: Admar Schoonen <admar@luon.net>
To: linux-kernel@vger.kernel.org
Subject: 2.6.8-rc4 on sparc64 oopses at boot and no working XFree86
Message-ID: <20040813114320.GJ21828@azrael.luon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Linux azrael 2.6.5-cdt3x0 #1 Tue Apr 6 15:02:58 CEST 2004 i586 GNU/Linux
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I'm running 2.6.8-rc4 on a sun blade 100 (ultra sparc IIe) with 2 PGX64
(Ati mach64) framebuffers, running Debian unstable. When the kernel boots,
it looks like it produces an oops in the very beginning. This is not
visible on the console, but dmesg shows some traces:

  0053c3d0] class_device_add+0x50/0x140
   [0000000000514ce8] pci_scan_bus_parented+0xe8/0x180
   (...)
  bad: scheduling while atomic!
  Call Trace:
    [000000000045bc4c] call_usermodehelper+0xac/0xc0
    (...)
    (this goes on for over 200 lines and continues with:)
  PCI-IRQ: Routing bus[ 0] slot[ 8] map[0] to INO[23]
    (...)
  PCI-IRQ: Routing bus[ 1] slot[ 1] map[0] to INO[0a]
  PCI0(PBMA): Bus running at 33MHz
  isa0: [dma -> (floppy) (parallel)] [power] [serial] [serial]
  ebus0: [flashprom] [eeprom] [idprom]
  
This also happens with 2.6.8-rc1, but it doesn't with 2.6.7 and older.
On 2.6.6, it looks like this:

  NET: Registered protocol family 16
  PCI: Probing for controllers.
  PCI: Found SABRE, main regs at 000001fe00000000, wsync at 000001fe00001c20
  SABRE: Shared PCI config space at 000001fe01000000
  SABRE: DVMA at c0000000 [20000000]
  PCI-IRQ: Routing bus[ 0] slot[ 8] map[0] to INO[23]
    (...)
  PCI-IRQ: Routing bus[ 1] slot[ 1] map[0] to INO[0a]
  PCI0(PBMA): Bus running at 33MHz
  isa0: [dma -> (floppy) (parallel)] [power] [serial] [serial]
  ebus0: [flashprom] [eeprom] [idprom]
  
so perhaps something is changed in the pci / sabre code?

Furthermore, with 2.4.x, I could use both framebuffers on the console
and in X. With 2.6.x (x <= 7), I could only use the primary framebuffer;
secondary was always black on console and X. But with 2.6.8-rc1 and up,
I can use the secondary framebuffer (con2fbmap works), but X (configured
for only my primary framebuffer) gets a signal 11 before it can display
it's famouse black & white dots. X -configure also gets a signal 11.

I've put up my .config, dmesg log's and XFree86.0.log at
http://people.spacelabs.nl/~admar/2.6.8-rc4-sparc64/

Could anybody pleasse help me out with these problems?

Pleasse CC any replies to me, as I'm not subscribed to this list.

Regards

Admar Schoonen
