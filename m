Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266147AbUHEVxv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266147AbUHEVxv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 17:53:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267897AbUHEVwQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 17:52:16 -0400
Received: from mms3.broadcom.com ([63.70.210.38]:38154 "EHLO mms3.broadcom.com")
	by vger.kernel.org with ESMTP id S267911AbUHEVu0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 17:50:26 -0400
X-Server-Uuid: 8D569F9F-42CF-4602-970D-AACC4BD5D310
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: MMCONFIG violates pci power mgmt spec
Date: Thu, 5 Aug 2004 14:50:10 -0700
Message-ID: <B1508D50A0692F42B217C22C02D84972020F3BB9@NT-IRVA-0741.brcm.ad.broadcom.com>
Thread-Topic: MMCONFIG violates pci power mgmt spec
thread-index: AcR7Ni5NwTK0MzHhTs2RoSQfk9AD5w==
From: "Michael Chan" <mchan@broadcom.com>
To: linux-kernel@vger.kernel.org
cc: "Steve Lindsay" <slindsay@broadcom.com>,
       "Marcus Calescibetta" <marcusc@broadcom.com>
X-WSS-ID: 6D0C74192K04193301-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We are encountering a problem with the MMCONFIG code with respect to
power management. Specifically, when pci_mmcfg_write is used to program
a PCI Express device's PMCSR to a different power state, the dummy read
at the end of that routine violates the transition delay specified in
the PCI power management spec.

For example, if the device is transitioning into or out of D3hot, the
spec requires a delay of 10 msec before any accesses can be made to the
device. The dummy read in pci_mmcfg_write violates the delay
requirements even though pci_set_power_state has all the necessary
delays.

I have contacted "Durairaj, Sundarapandian
<sundarapandian.durairaj@intel.com>" but did not get a response, and so
I'm posting to this list. One question I wanted to ask him was whether
the dummy read was necessary. If the Intel chipset treats the mmconfig
write as a non-posted write, the dummy read becomes unnecessary and
removing it will solve the problem. If it is treated as a posted write,
I wonder if there is another way to flush it other than reading from the
target device.

Thanks,
Michael

