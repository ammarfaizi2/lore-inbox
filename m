Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262212AbVBBEAb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262212AbVBBEAb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 23:00:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262214AbVBBEAN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 23:00:13 -0500
Received: from rproxy.gmail.com ([64.233.170.200]:14110 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262212AbVBBD5v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 22:57:51 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=JhHm7pNoXTye/ol1nhBjvOuaISQi0yv4MUbqI7oVRGa2Vf28RR6FtUmaOtE5mo9PtC2skTziOLHadctfwc1kat5Qo2Et7E91wpFOeAG3a1Ly8gfH3ctdeXJHwYvThak5esqKIFe2ir5y8h/g42ldktClA+u1Hba+ZBDl3YY7Ecc=
Message-ID: <9e4733910502011957145191f5@mail.gmail.com>
Date: Tue, 1 Feb 2005 22:57:51 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Tejun Heo <tj@home-tj.org>, lkml <linux-kernel@vger.kernel.org>
Subject: ide and ROMs
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since it looks like ide is being worked on, can you convert ide to use
the PCI ROM access calls in drivers/pci/rom.c instead of directly
manipulating PCI config space? The new ROM calls work on all
architectures.

These are the places that need to be fix:
[jonsmirl@jonsmirl ide]$ grep -r PCI_ROM_ADDRESS_ENABLE *
pci/aec62xx.c:          pci_write_config_dword(dev, PCI_ROM_ADDRESS,
dev->resource[PCI_ROM_RESOURCE].start | PCI_ROM_ADDRESS_ENABLE);
pci/cmd64x.c:           pci_write_config_byte(dev, PCI_ROM_ADDRESS,
dev->resource[PCI_ROM_RESOURCE].start | PCI_ROM_ADDRESS_ENABLE);
pci/hpt34x.c:                          
dev->resource[PCI_ROM_RESOURCE].start | PCI_ROM_ADDRESS_ENABLE);
pci/hpt366.c:                   dev->resource[PCI_ROM_RESOURCE].start
| PCI_ROM_ADDRESS_ENABLE);
pci/pdc202xx_new.c:                    
dev->resource[PCI_ROM_RESOURCE].start | PCI_ROM_ADDRESS_ENABLE);
pci/pdc202xx_old.c:                    
dev->resource[PCI_ROM_RESOURCE].start | PCI_ROM_ADDRESS_ENABLE);
[jonsmirl@jonsmirl ide]$

-- 
Jon Smirl
jonsmirl@gmail.com
