Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268223AbUJVWB2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268223AbUJVWB2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 18:01:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268157AbUJVV6M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 17:58:12 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:17610 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S268113AbUJVVw6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 17:52:58 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: 2.6.9-mm1: NForce3 problem (IRQ sharing issue?)
Date: Fri, 22 Oct 2004 23:54:44 +0200
User-Agent: KMail/1.6.2
Cc: LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200410222354.44563.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a problem with 2.6.9-mm1 on an AMD64 NForce3-based box.  Namely, after 
some time in X, USB suddenly stops working and sound goes off simultaneously 
(it's quite annoying, as I use a USB mouse ;-)).  It is 100% reproducible and 
it may be related to the sharing of IRQ 5:

rafael@albercik:~> cat /proc/interrupts
           CPU0
  0:    3499292          XT-PIC  timer
  1:       7135          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  5:       6945          XT-PIC  NVidia nForce3, ohci_hcd
  8:          0          XT-PIC  rtc
  9:       1416          XT-PIC  acpi, yenta
 10:          2          XT-PIC  ehci_hcd
 11:      37266          XT-PIC  SysKonnect SK-98xx, yenta, ohci1394, ohci_hcd
 12:      13781          XT-PIC  i8042
 14:         16          XT-PIC  ide0
 15:      23601          XT-PIC  ide1
NMI:          0
LOC:    3498657
ERR:          1
MIS:          0

(NVidia nForce3 is a sound chip, snd_intel8x0).  After it happens I can't 
reboot the box cleanly (the ohci-hcd driver cannot be reloaded) and it does 
not leave any traces in the log.

Please let me know if you need any more information.

Greets,
RJW

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
