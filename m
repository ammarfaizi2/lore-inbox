Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267625AbSKTFTV>; Wed, 20 Nov 2002 00:19:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267627AbSKTFTR>; Wed, 20 Nov 2002 00:19:17 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:2578 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S267625AbSKTFR5>;
	Wed, 20 Nov 2002 00:17:57 -0500
Date: Tue, 19 Nov 2002 21:18:20 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pcibios removal changes for 2.5.48
Message-ID: <20021120051820.GD21953@kroah.com>
References: <20021120051702.GB21953@kroah.com> <20021120051751.GC21953@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021120051751.GC21953@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.872.3.2, 2002/11/19 20:24:56-08:00, greg@kroah.com

PCMCIA: remove usage of pcibios_read_config_dword


diff -Nru a/drivers/pcmcia/cistpl.c b/drivers/pcmcia/cistpl.c
--- a/drivers/pcmcia/cistpl.c	Tue Nov 19 21:06:55 2002
+++ b/drivers/pcmcia/cistpl.c	Tue Nov 19 21:06:55 2002
@@ -430,7 +430,10 @@
 #ifdef CONFIG_CARDBUS
     if (s->state & SOCKET_CARDBUS) {
 	u_int ptr;
-	pcibios_read_config_dword(s->cap.cb_dev->subordinate->number, 0, 0x28, &ptr);
+	struct pci_dev *dev = pci_find_slot (s->cap.cb_dev->subordinate->number, 0);
+	if (!dev)
+	    return CS_BAD_HANDLE;
+	pci_read_config_dword(dev, 0x28, &ptr);
 	tuple->CISOffset = ptr & ~7;
 	SPACE(tuple->Flags) = (ptr & 7);
     } else
