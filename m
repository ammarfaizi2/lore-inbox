Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750806AbVHHLdV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750806AbVHHLdV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 07:33:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750823AbVHHLdV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 07:33:21 -0400
Received: from wscnet.wsc.cz ([212.80.64.118]:22658 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S1750806AbVHHLdU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 07:33:20 -0400
Message-ID: <42F7426C.1020307@gmail.com>
Date: Mon, 08 Aug 2005 13:30:52 +0200
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: cs, en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Andrew Morton <akpm@osdl.org>, philb@gnu.org, tim@cyberelk.net,
       campbell@torque.net, andrea@suse.de
Subject: [PATCH -mm] parport_pc.c uses pci_find_device
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch changes pci_find_device to pci_get_device (encapsulated in 
for_each_pci_dev).

Generated in 2.6.13-rc5-mm1

Signed-off-by: Jiri Slaby <xslaby@fi.muni.cz>

diff --git a/drivers/parport/parport_pc.c b/drivers/parport/parport_pc.c
--- a/drivers/parport/parport_pc.c
+++ b/drivers/parport/parport_pc.c
@@ -3007,7 +3007,7 @@ static int __init parport_pc_init_superi
  	struct pci_dev *pdev = NULL;
  	int ret = 0;

-	while ((pdev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, pdev)) != NULL) {
+	for_each_pci_dev(pdev) {
  		id = pci_match_id(parport_pc_pci_tbl, pdev);
  		if (id == NULL || id->driver_data >= last_sio)
  			continue;
-- 
Jiri Slaby         www.fi.muni.cz/~xslaby
~\-/~      jirislaby@gmail.com      ~\-/~
241B347EC88228DE51EE A49C4A73A25004CB2A10
