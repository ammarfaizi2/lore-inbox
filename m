Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753137AbVHHAKj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753137AbVHHAKj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Aug 2005 20:10:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753138AbVHHAKj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Aug 2005 20:10:39 -0400
Received: from wscnet.wsc.cz ([212.80.64.118]:31366 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S1753137AbVHHAKj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Aug 2005 20:10:39 -0400
Message-ID: <42F6A2F3.5020906@gmail.com>
Date: Mon, 08 Aug 2005 02:10:27 +0200
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: cs, en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] pci_find_device and pci_find_slot mark as deprecated
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This marks these functions as deprecated not to use in latest drivers
(it doesn't use reference counts and the device returned by it can 
disappear in any time).

This patch was sent yet on:
28 Jul 2005 (without pci_find_slot removing and wrapping lines)

Signed-off-by: Jiri Slaby <xslaby@fi.muni.cz>

diff --git a/include/linux/pci.h b/include/linux/pci.h
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -328,9 +328,11 @@ void pci_setup_cardbus(struct pci_bus *b
 
 /* Generic PCI functions exported to card drivers */
 
-struct pci_dev *pci_find_device (unsigned int vendor, unsigned int device, const struct pci_dev *from);
+struct pci_dev *pci_find_device (unsigned int vendor, unsigned int device,
+	const struct pci_dev *from) __deprecated;
 struct pci_dev *pci_find_device_reverse (unsigned int vendor, unsigned int device, const struct pci_dev *from);
-struct pci_dev *pci_find_slot (unsigned int bus, unsigned int devfn);
+struct pci_dev *pci_find_slot (unsigned int bus, unsigned int devfn)
+	__deprecated;
 int pci_find_capability (struct pci_dev *dev, int cap);
 int pci_find_ext_capability (struct pci_dev *dev, int cap);
 struct pci_bus * pci_find_next_bus(const struct pci_bus *from);

-- 
Jiri Slaby         www.fi.muni.cz/~xslaby
~\-/~      jirislaby@gmail.com      ~\-/~
241B347EC88228DE51EE A49C4A73A25004CB2A10

