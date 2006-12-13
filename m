Return-Path: <linux-kernel-owner+w=401wt.eu-S1751193AbWLMVrR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751193AbWLMVrR (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 16:47:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751202AbWLMVrR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 16:47:17 -0500
Received: from eazy.amigager.de ([213.239.192.238]:33085 "EHLO
	eazy.amigager.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751193AbWLMVrQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 16:47:16 -0500
X-Greylist: delayed 1456 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Dec 2006 16:47:16 EST
Date: Wed, 13 Dec 2006 22:22:59 +0100
From: Tino Keitel <tino.keitel@tikei.de>
To: linux-kernel@vger.kernel.org
Subject: How to interpret PM_TRACE output
Message-ID: <20061213212258.GA9879@dose.home.local>
Mail-Followup-To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

I tried PM_TRACE to find the driver that breaks resume from suspend.
I got working resume until I switched to the sk98lin driver
(because sky2 doesn't support wake on LAN). That's why I was quite sure that
sk98lin is the culprit, but I tried PM_TRACE anymay.

Here is the PM_TRACE output in dmesg:

  Magic number: 0:150:255
  hash matches drivers/base/power/resume.c:28
  hash matches device 0000:00:1d.3

$ lspci | grep 1d.3
00:1d.3 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #4

/proc/interrupts:

 17:      52387          0   IO-APIC-level  uhci_hcd:usb5, eth0, i915@pci:0000:00:02.0
 20:    1223105    1222776   IO-APIC-level  ehci_hcd:usb1, uhci_hcd:usb2

Since UHCI #4 (usb5, as ehci is usb1) and eth0 (sk98lin) use the same
interrupt, is it right to assume that the sk98lin driver does bad
interrupt handling and therefore breaks the usb5 device on resume?

Regards,
Tino
