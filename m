Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264386AbTLVK5g (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 05:57:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264389AbTLVK5g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 05:57:36 -0500
Received: from frankvm.xs4all.nl ([80.126.170.174]:14828 "EHLO
	iapetus.localdomain") by vger.kernel.org with ESMTP id S264386AbTLVK5a
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 05:57:30 -0500
Date: Mon, 22 Dec 2003 11:56:24 +0100
From: Frank van Maarseveen <frankvm@xs4all.nl>
To: linux-kernel@vger.kernel.org
Subject: 2.4.22/2.4.23 lockups
Message-ID: <20031222105624.GA19824@iapetus.localdomain>
Mail-Followup-To: Frank van Maarseveen <frankvm@xs4all.nl>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Subliminal-Message: Use Linux!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have two machines which experience lockups (no pinging, capslock and
scrollock LEDs blinking) when X is started or terminated. The workaround
seems to be to allocate a separate IRQ for the ICH 82801AA and VGA in the
BIOS instead of sharing with eth0 and usb (which just happens to be the
default BIOS configuration). The workaround makes some sense because the
login directory is on an NFS mount and the desktop includes some audio
related stuff. I don't know if the VGA IRQ has any meaning nowadays. The
resulting /proc/interrupts:

           CPU0       
  0: 2069643371          XT-PIC  timer
  1:    1141456          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  5:   52924396          XT-PIC  usb-uhci, eth0
  8:         27          XT-PIC  rtc
 10:       1155          XT-PIC  Intel ICH 82801AA
 12:     954568          XT-PIC  PS/2 Mouse
 14:    3182852          XT-PIC  ide0
 15:         12          XT-PIC  ide1
NMI:          0 
LOC: 2069672026 
ERR:          1
MIS:          0
$ lspci
00:00.0 Host bridge: Intel Corp. 82810E GMCH [Graphics Memory Controller Hub] (rev 03)
00:01.0 VGA compatible controller: Intel Corp. 82810E CGC [Chipset Graphics Controller] (rev 03)
00:1e.0 PCI bridge: Intel Corp. 82801AA PCI Bridge (rev 02)
00:1f.0 ISA bridge: Intel Corp. 82801AA ISA Bridge (LPC) (rev 02)
00:1f.1 IDE interface: Intel Corp. 82801AA IDE (rev 02)
00:1f.2 USB Controller: Intel Corp. 82801AA USB (rev 02)
00:1f.5 Multimedia audio controller: Intel Corp. 82801AA AC'97 Audio (rev 02)
01:0b.0 Ethernet controller: Intel Corp. 82557 [Ethernet Pro 100] (rev 05)


This problem may also be present in kernels before 2.4.22 but I have no
data on that. Is this a known issue or should I investigate it further?

-- 
Frank
