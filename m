Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264022AbUE1VkP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264022AbUE1VkP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 17:40:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263979AbUE1VkL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 17:40:11 -0400
Received: from mail.kroah.org ([65.200.24.183]:39859 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264022AbUE1ViI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 17:38:08 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI fixes for 2.6.7-rc1
User-Agent: Mutt/1.5.6i
In-Reply-To: <1085780116326@kroah.com>
Date: Fri, 28 May 2004 14:35:16 -0700
Message-Id: <10857801163004@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1759, 2004/05/28 13:37:08-07:00, lcapitulino@prefeitura.sp.gov.br

[PATCH] PCI: fix pci/probe.c possible NULL pointer.

 In drivers/pci/probe.c::pci_scan_bridge() the call for pci_alloc_child_bus()
can return NULL, but it is not handled by the function (detected by
Coverity's checker).

 The patch bellow fix that returning `max' if we got the NULL, but
I do not know if it is right. I guess it is, because in that case
the function will act in the same way as with `pass != 0'.

Signed-off by: Luiz Capitulino <lcapitulino@prefeitura.sp.gov.br>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/pci/probe.c |    2 ++
 1 files changed, 2 insertions(+)


diff -Nru a/drivers/pci/probe.c b/drivers/pci/probe.c
--- a/drivers/pci/probe.c	Fri May 28 14:28:53 2004
+++ b/drivers/pci/probe.c	Fri May 28 14:28:53 2004
@@ -366,6 +366,8 @@
 			return max;
 		busnr = (buses >> 8) & 0xFF;
 		child = pci_alloc_child_bus(bus, dev, busnr);
+		if (!child)
+			return max;
 		child->primary = buses & 0xFF;
 		child->subordinate = (buses >> 16) & 0xFF;
 		child->bridge_ctl = bctl;

