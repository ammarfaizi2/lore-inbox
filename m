Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263448AbUEGJ7i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263448AbUEGJ7i (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 05:59:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263460AbUEGJ7i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 05:59:38 -0400
Received: from palrel13.hp.com ([156.153.255.238]:61588 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S263448AbUEGJ7e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 05:59:34 -0400
From: "Naresh Kumar Inna" <knaresh@india.hp.com>
To: <linux-kernel@vger.kernel.org>
Subject: Question on __pci_bus_find_cap().
Date: Fri, 7 May 2004 15:29:04 +0530
Message-ID: <00fe01c43419$eeb4ce70$38624c0f@eb9856>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4939.300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The PCI spec 3.0 says that the Capabilities List is terminated with 00H
which indicates the last capability in the linked list. But in the code of
'__pci_bus_find_cap()', the while loop ( see below) terminates when the
value of the position is <  0x40 or a ttl value becomes zero. Shouldnt it
simply check for the value 0x0 and terminate? Please let me know if I am
missing something. Here is the diff:

--- pci.c.orig  2004-04-04 09:06:54.000000000 +0530
+++ pci.c.mod  2004-05-07 15:06:50.000000000 +0530
@@ -71,7 +71,6 @@
 {
        u16 status;
        u8 pos, id;
-       int ttl = 48;

        pci_bus_read_config_word(bus, devfn, PCI_STATUS, &status);
        if (!(status & PCI_STATUS_CAP_LIST))
@@ -88,7 +87,7 @@
        default:
                return 0;
        }
-       while (ttl-- && pos >= 0x40) {
+       while (pos != 0x0) {
                pos &= ~3;
                pci_bus_read_config_byte(bus, devfn, pos + PCI_CAP_LIST_ID,
&id);
                if (id == 0xff)

Regards,
Naresh Kumar,
HP-ISO,
Bangalore.



