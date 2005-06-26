Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261632AbVFZXRx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261632AbVFZXRx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Jun 2005 19:17:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261639AbVFZXRx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Jun 2005 19:17:53 -0400
Received: from relay01.mail-hub.dodo.com.au ([203.220.32.149]:20690 "EHLO
	relay01.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S261632AbVFZXRl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Jun 2005 19:17:41 -0400
From: Grant Coady <grant_lkml@dodo.com.au>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-mm2
Date: Mon, 27 Jun 2005 09:17:34 +1000
Organization: <http://scatter.mine.nu/>
Message-ID: <didub15c1ucfs9t23opuvvm3a0rapikeoq@4ax.com>
References: <20050626040329.3849cf68.akpm@osdl.org> <20050626124219.G14862@flint.arm.linux.org.uk>
In-Reply-To: <20050626124219.G14862@flint.arm.linux.org.uk>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Jun 2005 12:42:19 +0100, Russell King <rmk+lkml@arm.linux.org.uk> wrote:

>On Sun, Jun 26, 2005 at 04:03:29AM -0700, Andrew Morton wrote:
>> - Lots of merges.  I'm holding off on the 80-odd pcmcia patches until we get
>>   the recent PCI breakage sorted out.
>
>I'm not sure what PCI breakage you're referring to, but a lot of the
>Cardbus-centric "breakage" isn't a regression - it's new machines
>with weird PCI BIOS setups being incompatible Linux's current PCI
>bus handing strategy.
>
>I've been trying to get this fixed for a considerable time, but linux-pci
>folk seem to be disinterested.
>
>The assumption that the PCI BIOS will sanely assign the PCI bus numbers
>and that Linux does not need to reassign them is looking increasingly
>incorrect - most of the Cardbus "why can't the system see my card"
>are resolved by passing "pci=assign-busses", which causes the PCI
>subsystem to renumber all PCI busses.

Not the case for where I'm having problems, Toshiba laptop, more 
info on http://scatter.mine.nu/test/linux-2.6/tosh/

--- ioports-2.6.12.1a   2005-06-27 09:00:21.000000000 +1000
+++ ioports-2.6.12-mm2a 2005-06-27 09:03:44.000000000 +1000
@@ -10,20 +10,13 @@
 00f0-00ff : fpu
 0170-0177 : ide1
 01f0-01f7 : ide0
-02f8-02ff : 0000:00:07.0
 0376-0376 : ide1
 0378-037a : parport0
 03c0-03df : vesafb
 03f6-03f6 : ide0
 03f8-03ff : serial
 0cf8-0cff : PCI conf1
-1c00-1cff : 0000:00:07.0
-4000-40ff : PCI CardBus #02
-  4000-407f : 0000:02:00.0
-    4000-407f : xircom_cb
-4400-44ff : PCI CardBus #02
-fc00-fcff : 0000:00:0c.0
-  fc00-fcff : ESS Maestro
+fc00-fcff : ESS Maestro
 fd00-fd3f : motherboard
 fe00-fe3f : 0000:00:05.3
   fe00-fe3f : motherboard
@@ -40,8 +33,6 @@
 fe90-fe97 : motherboard
 fe9e-fe9e : motherboard
 feac-feac : motherboard
-ff80-ff9f : 0000:00:05.2
-  ff80-ff9f : uhci_hcd
-fff0-ffff : 0000:00:05.1
-  fff0-fff7 : ide0
-  fff8-ffff : ide1
+ff80-ff9f : uhci_hcd
+fff0-fff7 : ide0
+fff8-ffff : ide1

lilo.conf:
image = /boot/bzImage-2.6.12-mm2a
  optional
  label = 2.6.12-mm2ap
  append="pci=assign-busses"

--- ioports-2.6.12.1a   2005-06-27 09:00:21.000000000 +1000
+++ ioports-2.6.12-mm2ap        2005-06-27 09:06:31.000000000 +1000
@@ -10,20 +10,13 @@
 00f0-00ff : fpu
 0170-0177 : ide1
 01f0-01f7 : ide0
-02f8-02ff : 0000:00:07.0
 0376-0376 : ide1
 0378-037a : parport0
 03c0-03df : vesafb
 03f6-03f6 : ide0
 03f8-03ff : serial
 0cf8-0cff : PCI conf1
-1c00-1cff : 0000:00:07.0
-4000-40ff : PCI CardBus #02
-  4000-407f : 0000:02:00.0
-    4000-407f : xircom_cb
-4400-44ff : PCI CardBus #02
-fc00-fcff : 0000:00:0c.0
-  fc00-fcff : ESS Maestro
+fc00-fcff : ESS Maestro
 fd00-fd3f : motherboard
 fe00-fe3f : 0000:00:05.3
   fe00-fe3f : motherboard
@@ -40,8 +33,6 @@
 fe90-fe97 : motherboard
 fe9e-fe9e : motherboard
 feac-feac : motherboard
-ff80-ff9f : 0000:00:05.2
-  ff80-ff9f : uhci_hcd
-fff0-ffff : 0000:00:05.1
-  fff0-fff7 : ide0
-  fff8-ffff : ide1
+ff80-ff9f : uhci_hcd
+fff0-fff7 : ide0
+fff8-ffff : ide1

--Grant.

