Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262545AbVDGSyV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262545AbVDGSyV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 14:54:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262553AbVDGSyV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 14:54:21 -0400
Received: from host-83-146-9-72.bulldogdsl.com ([83.146.9.72]:62737 "EHLO
	host-83-146-9-72.bulldogdsl.com") by vger.kernel.org with ESMTP
	id S262545AbVDGSyK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 14:54:10 -0400
Message-ID: <425581D0.5010409@unsolicited.net>
Date: Thu, 07 Apr 2005 19:54:08 +0100
From: David Ranson <spam.david.trap@unsolicited.net>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Serial MRi MRI-PCIDS1 dual port serial card
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This trivial patch against 2.6.11.6 adds support for the MRi PCIDS1 dual
port serial card. This card is a little controversial since it is the
subject of a PCI vendor/device ID clash. (See
http://www.ussg.iu.edu/hypermail/linux/kernel/0303.1/0516.html). I have
for now just used the hex ID 0x950a. The divisor was part calculated
part iterated, so may not be exactly correct (but works for me at all
settings between 300 - 115300 bps).

Cheers
David

diff -ur old/linux-2.6.11/drivers/serial/8250_pci.c
new/linux-2.6.11/drivers/serial/8250_pci.c
--- old/linux-2.6.11/drivers/serial/8250_pci.c  2005-03-02
07:38:17.000000000 +0000
+++ new/linux-2.6.11/drivers/serial/8250_pci.c  2005-04-01
16:56:31.000000000 +0100
@@ -999,6 +999,7 @@

        pbn_b0_1_921600,
        pbn_b0_2_921600,
+        pbn_b0_2_1130000,
        pbn_b0_4_921600,

        pbn_b0_bt_1_115200,
@@ -1127,6 +1128,12 @@
                .base_baud      = 921600,
                .uart_offset    = 8,
        },
+        [pbn_b0_2_1130000] = {
+               .flags          = FL_BASE0,
+               .num_ports      = 2,
+               .base_baud      = 1130000,
+               .uart_offset    = 8,
+       },
        [pbn_b0_4_921600] = {
                .flags          = FL_BASE0,
                .num_ports      = 4,
@@ -1945,6 +1952,9 @@
        {       PCI_VENDOR_ID_OXSEMI, PCI_DEVICE_ID_OXSEMI_16PCI952,
                PCI_ANY_ID, PCI_ANY_ID, 0, 0,
                pbn_b0_bt_2_921600 },
+       {       PCI_VENDOR_ID_OXSEMI, 0x950a,
+               PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+               pbn_b0_2_1130000 },

        /*
         * SBS Technologies, Inc. P-Octal and PMC-OCTPRO cards,

