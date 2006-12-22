Return-Path: <linux-kernel-owner+w=401wt.eu-S1422988AbWLVNE1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422988AbWLVNE1 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 08:04:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754829AbWLVNE1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 08:04:27 -0500
Received: from mail.njl.fi ([193.184.55.66]:59419 "EHLO ns.njl.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754830AbWLVNE0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 08:04:26 -0500
X-Greylist: delayed 396 seconds by postgrey-1.27 at vger.kernel.org; Fri, 22 Dec 2006 08:04:25 EST
From: "binder" <enrico.binder@njl.ee>
To: linux-kernel@vger.kernel.org
Subject: bluetooth bug - mtu wrong
Date: Fri, 22 Dec 2006 14:57:42 +0200
Message-Id: <20061222125155.M20471@njl.ee>
X-Mailer: NJL 2.52 20060502
X-OriginatingIP: 213.35.238.251 (binder)
MIME-Version: 1.0
Content-Type: text/plain;
	charset=iso-8859-1
X-AntiVirus: scanned for viruses by NJL-FI
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi

my included lenevo r60e bluetooth adapter does not work with headsets
(bt-sco). only a small fix in linux soource helps !

Linux version 2.6.19eb2619_1 (root@picard) (gcc version 3.4.6) #2 SMP Mon Dec
4 22:04:52 EET 2006

i add to linux/driver/bluetooth/hci_usb.c at position after struct:

-----------------8<.............................
static struct usb_device_id blacklist_ids[] = {
...
{ USB_DEVICE(0x0a5c, 0x2110), .driver_info = HCI_RESET | HCI_WRONG_SCO_MTU },
...
}
.................>8-----------------------------

without it hciconfig shows wrong mtu value :
BD Address: 00:16:CE:E9:A4:2F ACL MTU: 1017:8 SCO MTU: 64:0

with the fix i get
BD Address: 00:16:CE:E9:A4:2F ACL MTU: 1017:8 SCO MTU: 64:8

after fix the headset works with receiving and sending voice !

ciao
--
With kind regards
Nordic Jetline
enrico binder

