Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270526AbTGNFyb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 01:54:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270527AbTGNFyb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 01:54:31 -0400
Received: from mail.kroah.org ([65.200.24.183]:55434 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270526AbTGNFy3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 01:54:29 -0400
Date: Sun, 13 Jul 2003 23:07:54 -0700
From: Greg KH <greg@kroah.com>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.75: parse error in pci.h if !CONFIG_PCI
Message-ID: <20030714060754.GA20416@kroah.com>
References: <20030713102740.GY12104@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030713102740.GY12104@fs.tum.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 13, 2003 at 12:27:41PM +0200, Adrian Bunk wrote:
> I got the following compile error when trying to compile 2.5.75 with 
> !CONFIG_PCI:
> 
> <--  snip  -->
> 
> ...
>   CC      drivers/message/fusion/mptscsih.o
> In file included from drivers/message/fusion/linux_compat.h:10,
>                  from drivers/message/fusion/mptbase.h:58,
>                  from drivers/message/fusion/mptscsih.c:82:
> include/linux/pci.h:718: error: syntax error before "int"
> drivers/message/fusion/mptscsih.c:6924: warning: `mptscsih_setup' 
> defined but not used
> make[3]: *** [drivers/message/fusion/mptscsih.o] Error 1
> 
> <--  snip  -->

Thanks, the patch below should fix this problem.  I'll send it on to
Linus in a bit.

greg k-h


# PCI: fix up error for when CONFIG_PCI=n and scsi.h is included.

diff -Nru a/include/linux/pci.h b/include/linux/pci.h
--- a/include/linux/pci.h	Sun Jul 13 23:07:44 2003
+++ b/include/linux/pci.h	Sun Jul 13 23:07:44 2003
@@ -715,7 +715,6 @@
 static inline int pci_assign_resource(struct pci_dev *dev, int i) { return -EBUSY;}
 static inline int pci_register_driver(struct pci_driver *drv) { return 0;}
 static inline void pci_unregister_driver(struct pci_driver *drv) { }
-static inline int scsi_to_pci_dma_dir(unsigned char scsi_dir) { return scsi_dir; }
 static inline int pci_find_capability (struct pci_dev *dev, int cap) {return 0; }
 static inline const struct pci_device_id *pci_match_device(const struct pci_device_id *ids, const struct pci_dev *dev) { return NULL; }
 
