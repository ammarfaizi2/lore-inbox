Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262285AbVBEVeM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262285AbVBEVeM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 16:34:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262272AbVBEVeM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 16:34:12 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:12305 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S272843AbVBEVdl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 16:33:41 -0500
To: Marco Rogantini <marco.rogantini@supsi.ch>
Cc: linux-kernel@vger.kernel.org
Subject: Re: rtl8139 (8139too) net problem in linux 2.6.10
References: <Pine.LNX.4.62.0502051818370.4821@rost.dti.supsi.ch>
	<87wttmg77p.fsf@devron.myhome.or.jp>
	<Pine.LNX.4.62.0502052052560.6832@rost.dti.supsi.ch>
	<87y8e266pu.fsf@devron.myhome.or.jp>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sun, 06 Feb 2005 06:33:32 +0900
In-Reply-To: <87y8e266pu.fsf@devron.myhome.or.jp> (OGAWA Hirofumi's message
 of "Sun, 06 Feb 2005 06:24:13 +0900")
Message-ID: <87u0oq66ab.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OGAWA Hirofumi <hirofumi@mail.parknet.co.jp> writes:

> Umm... Bit strange...
>
> I couldn't find the PCI4510 in yenta_table. Did you add the PCI4510 to
> yenta_table? Could you send "lspci -n" (what vendor-id and device-id)?

Grr... Ok, probably that was processed as default bridge.

Could you please try the following patch for debug?

Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 drivers/pcmcia/yenta_socket.c |    2 ++
 1 files changed, 2 insertions(+)

diff -puN drivers/pcmcia/yenta_socket.c~yenta-pci4510-debug drivers/pcmcia/yenta_socket.c
--- linux-2.6.11-rc3/drivers/pcmcia/yenta_socket.c~yenta-pci4510-debug	2005-02-06 06:30:41.000000000 +0900
+++ linux-2.6.11-rc3-hirofumi/drivers/pcmcia/yenta_socket.c	2005-02-06 06:32:13.000000000 +0900
@@ -1105,6 +1105,8 @@ static struct pci_device_id yenta_table 
 	CB_ID(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_4410, TI12XX),
 	CB_ID(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_4450, TI12XX),
 	CB_ID(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_4451, TI12XX),
+#define PCI_DEVICE_ID_TI_4510		0xac44
+	CB_ID(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_4510, TI12XX),
 	CB_ID(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_4520, TI12XX),
 
 	CB_ID(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_1250, TI1250),
_

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
