Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030246AbWBTOfA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030246AbWBTOfA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 09:35:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030250AbWBTOfA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 09:35:00 -0500
Received: from odin2.bull.net ([192.90.70.84]:7878 "EHLO odin2.bull.net")
	by vger.kernel.org with ESMTP id S1030246AbWBTOe7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 09:34:59 -0500
From: "Serge Noiraud" <serge.noiraud@bull.net>
To: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: RT and pci_lock while reading or writing pci bus configuration.
Date: Mon, 20 Feb 2006 15:42:19 +0100
User-Agent: KMail/1.7.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602201542.19857.Serge.Noiraud@bull.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I have one question :
In drivers/pci/access.c we have a global lock for pci configuration access.
In pci_bus_read_config_* or pci_bus_write_config_* functions, we acquire a lock.
When we call spin_lock_irqsave, we obtain the following message :
BUG: scheduling while atomic: IRQ 137/0x00000001/6431
caller is schedule+0x43/0x120
 [<c01050ec>] dump_stack+0x1c/0x20 (20)
 [<c03e7144>] __schedule+0xf44/0x1240 (236)
 [<c03e7483>] schedule+0x43/0x120 (12)
 [<c03e855b>] __down_mutex+0x2bb/0x5f0 (112)
 [<c03ea08c>] _spin_lock_irqsave+0x1c/0x40 (24)
 [<c023670d>] pci_bus_read_config_word+0x2d/0x70 (24)
 
Do I miss something or is it a BUG ?

-- 
Serge Noiraud
