Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135716AbREBSbz>; Wed, 2 May 2001 14:31:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135725AbREBSbp>; Wed, 2 May 2001 14:31:45 -0400
Received: from echo.sound.net ([205.242.192.21]:7299 "HELO echo.sound.net")
	by vger.kernel.org with SMTP id <S135716AbREBSbb>;
	Wed, 2 May 2001 14:31:31 -0400
Date: Wed, 2 May 2001 13:30:31 -0500 (CDT)
From: Hal Duston <hald@sound.net>
To: twaugh@redhat.com
cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Parport_pc compile errors in 2.4.4
Message-ID: <Pine.GSO.4.10.10105021323230.22514-100000@sound.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,

I have encountered a compile error in 2.4.4.

The autoirq and autodma parameters that were added (in 2.4.3-ac2)
to parport_pc_init_superio are missing from the else 
side of the #ifdef CONFIG_PCI

I _think_ this patch should fix it.

==== PATCH against 2.4.4 ====
*** linux/drivers/parport/parport_pc.c.orig   Wed May  2 13:18:00 2001
--- linux/drivers/parport/parport_pc.c        Wed May  2 13:19:02 2001
***************
*** 2576,2582 ****
  }
  #else
  static struct pci_driver parport_pc_pci_driver;
! static int __init parport_pc_init_superio(void) {return 0;}
  #endif /* CONFIG_PCI */

  /* This is called by parport_pc_find_nonpci_ports (in asm/parport.h) */
--- 2576,2582 ----
  }
  #else
  static struct pci_driver parport_pc_pci_driver;
! static int __init parport_pc_init_superio (int autoirq, int autodma)
{return 0;}
  #endif /* CONFIG_PCI */

  /* This is called by parport_pc_find_nonpci_ports (in asm/parport.h) */
==== PATCH ENDS ====

Thanks,
Hal Duston
hald@sound.net

