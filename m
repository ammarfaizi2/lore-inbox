Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267537AbUHWTxC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267537AbUHWTxC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 15:53:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266824AbUHWTvr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 15:51:47 -0400
Received: from mail.kroah.org ([69.55.234.183]:47299 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266830AbUHWSgT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 14:36:19 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI and I2C fixes for 2.6.8
User-Agent: Mutt/1.5.6i
In-Reply-To: <10932860812879@kroah.com>
Date: Mon, 23 Aug 2004 11:34:41 -0700
Message-Id: <10932860811751@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1790.2.3, 2004/08/02 15:33:31-07:00, domen@coderock.org

[PATCH] PCI: use list_for_each() i386/pci/pcbios.c

From: Domen Puncer <domen@coderock.org>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 arch/i386/pci/pcbios.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/arch/i386/pci/pcbios.c b/arch/i386/pci/pcbios.c
--- a/arch/i386/pci/pcbios.c	2004-08-23 11:08:39 -07:00
+++ b/arch/i386/pci/pcbios.c	2004-08-23 11:08:39 -07:00
@@ -365,7 +365,7 @@
 		idx = found = 0;
 		while (pci_bios_find_device(dev->vendor, dev->device, idx, &bus, &devfn) == PCIBIOS_SUCCESSFUL) {
 			idx++;
-			for (ln=pci_devices.next; ln != &pci_devices; ln=ln->next) {
+			list_for_each(ln, &pci_devices) {
 				d = pci_dev_g(ln);
 				if (d->bus->number == bus && d->devfn == devfn) {
 					list_del(&d->global_list);

