Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261527AbSKZXFD>; Tue, 26 Nov 2002 18:05:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262266AbSKZXFD>; Tue, 26 Nov 2002 18:05:03 -0500
Received: from main.gmane.org ([80.91.224.249]:38882 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id <S261527AbSKZXFC>;
	Tue, 26 Nov 2002 18:05:02 -0500
To: linux-kernel@vger.kernel.org
X-Injected-Via-Gmane: http://gmane.org/
Path: not-for-mail
From: mst <gmane@misha.eml.cc>
Subject: lspci/pciutils  maintainer?
Date: Wed, 27 Nov 2002 00:58:37 +0200
Message-ID: <as0ud4$2he$1@main.gmane.org>
NNTP-Posting-Host: ras14-p49.hfa.netvision.net.il
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: main.gmane.org 1038351589 2606 62.0.112.49 (26 Nov 2002 22:59:49 GMT)
X-Complaints-To: usenet@main.gmane.org
NNTP-Posting-Date: Tue, 26 Nov 2002 22:59:49 +0000 (UTC)
User-Agent: Mozilla/5.0 (Windows; U; Win98; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en,pdf
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!
Does anyone know who maintains pciutils now?
I tried contacting Martin Mares <mj@suse.cz> but got no reply :(.

So I have no idea where to send it now.
Sorry if this is the wrong forum, pls mail me back off-list.

I have a trivial patch which intialises otherwise ununitialised
header type (It is later used to display capabilities and status for PCI-X
devices). As it is any PCIX devie is reported with non-bridge capabilities.



--- lspci.c Sat Mar 30 18:39:24 2002
+++ linux/lspci.c  Thu Oct 31 14:16:08 2002
@@ -108,7 +108,8 @@ scan_device(struct pci_dev *p)
    d->dev = p;
    if (!pci_read_block(p, 0, d->config, how_much))
      die("Unable to read %d bytes of configuration space.", how_much);
-  if (how_much < 128 && (d->config[PCI_HEADER_TYPE] & 0x7f) == 
PCI_HEADER_TYPE_CARDBUS)
+  p->hdrtype=d->config[PCI_HEADER_TYPE] & 0x7f;
+  if (how_much < 128 && p->hdrtype == PCI_HEADER_TYPE_CARDBUS)
      {
        /* For cardbus bridges, we need to fetch 64 bytes more to get the full 
standard header... */
        if (!pci_read_block(p, 64, d->config+64, 64))



