Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932442AbWBXTic@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932442AbWBXTic (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 14:38:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932440AbWBXTic
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 14:38:32 -0500
Received: from palinux.external.hp.com ([192.25.206.14]:65471 "EHLO
	palinux.hppa") by vger.kernel.org with ESMTP id S932436AbWBXTib
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 14:38:31 -0500
Date: Fri, 24 Feb 2006 12:38:30 -0700
From: Matthew Wilcox <matthew@wil.cx>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: Christoph Hellwig <hch@infradead.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       erich <erich@areca.com.tw>, Arjan van de Ven <arjan@infradead.org>,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
       billion.wu@areca.com.tw, akpm@osdl.org, oliver@neukum.org
Subject: Re: Areca RAID driver remaining items?
Message-ID: <20060224193830.GR28587@parisc-linux.org>
References: <1140458552.3495.26.camel@mentorng.gurulabs.com> <20060220182045.GA1634@infradead.org> <001401c63779$12e49aa0$b100a8c0@erich2003> <20060222145733.GC16269@infradead.org> <00dc01c63842$381f9a30$b100a8c0@erich2003> <1140683157.2972.6.camel@laptopd505.fenrus.org> <001901c6385e$9aee7d40$b100a8c0@erich2003> <1140695990.19361.8.camel@localhost.localdomain> <20060224165647.GA4176@infradead.org> <Pine.LNX.4.58.0602240858180.7894@shark.he.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0602240858180.7894@shark.he.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 24, 2006 at 09:03:47AM -0800, Randy.Dunlap wrote:
> On Fri, 24 Feb 2006, Christoph Hellwig wrote:
> > Please avoid that unless really nessecary.  I doubt there's boards where
> > MSI would only be broken with the areca card but not with other MSI-capable
> > ones.  If a board or chipset is generally broken vs MSI it should be
> > added to the global MSI blacklist.  It's probably be nice to have a global
> > nomsi boot option instead of one in every driver aswell..
> 
> http://www.xenotime.net/linux/patches/pci_nomsi.patch adds a
> global boot option to disable MSI interrupt assignments.

I like it.  How about adding pci=nomsi instead of pci_nomsi?

--- drivers/pci/pci.c   4 Feb 2006 04:51:55 -0000       1.28
+++ drivers/pci/pci.c   24 Feb 2006 19:33:25 -0000
@@ -900,8 +900,12 @@ static int __devinit pci_setup(char *str
                if (k)
                        *k++ = 0;
                if (*str && (str = pcibios_setup(str)) && *str) {
-                       /* PCI layer options should be handled here */
-                       printk(KERN_ERR "PCI: Unknown option `%s'\n", str);
+                       if (!strcmp(str, "nomsi")) {
+                               pci_msi_enable = 0;
+                       } else {
+                               printk(KERN_ERR "PCI: Unknown option `%s'\n",
+                                               str);
+                       }
                }
                str = k;
        }

