Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314083AbSF2Smb>; Sat, 29 Jun 2002 14:42:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314082AbSF2Sma>; Sat, 29 Jun 2002 14:42:30 -0400
Received: from sproxy.gmx.de ([213.165.64.20]:19332 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S314083AbSF2Sm3>;
	Sat, 29 Jun 2002 14:42:29 -0400
Message-ID: <3D1DF223.C56731EF@gmx.net>
Date: Sat, 29 Jun 2002 19:45:07 +0200
From: Gunther Mayer <gunther.mayer@gmx.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Nick Evgeniev <nick@octet.spb.ru>, linux-kernel@vger.kernel.org
Subject: Re: linux 2.4.19-rc1 i845e workaround udma fix
References: <E17O821-0007we-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

> Complain to your BIOS vendor
>
> A workaround for this BIOS flaw will be in the -ac tree in a week or so

Or try this patch today:

--- linux-2.4.19-rc1/arch/i386/kernel/pci-i386.c        Sat Jun 29 20:39:05
2002
+++ linux/arch/i386/kernel/pci-i386.c   Sat Jun 29 20:37:25 2002
@@ -314,8 +314,8 @@
        for(idx=0; idx<6; idx++) {
                r = &dev->resource[idx];
                if (!r->start && r->end) {
-                       printk(KERN_ERR "PCI: Device %s not available because
of resource collisions\n", dev->slot_name);
-                       return -EINVAL;
+                       printk(KERN_ERR "PCI: Device %s not available because
of resource collisions on idx=%d %x %x\n",
dev->slot_name,idx,r->start,r->end);
+                       printk("Temporary Workaround for 845E/845G:
ignoring.\n");
                }
                if (r->flags & IORESOURCE_IO)
                        cmd |= PCI_COMMAND_IO;

This increases hdparm -t from 3MB/sec to 41MB/sec.
-
Gunther

