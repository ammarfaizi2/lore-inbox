Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261964AbUKJQCl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261964AbUKJQCl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 11:02:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261961AbUKJQCl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 11:02:41 -0500
Received: from sd291.sivit.org ([194.146.225.122]:64211 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S261917AbUKJQBB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 11:01:01 -0500
Date: Wed, 10 Nov 2004 17:00:58 +0100
From: Stelian Pop <stelian@popies.net>
To: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Dominik Brodowski <linux@dominikbrodowski.de>,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH] drivers/net/pcmcia: use module_param() instead of MODULE_PARM()
Message-ID: <20041110160058.GB8542@sd291.sivit.org>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	Jeff Garzik <jgarzik@pobox.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Dominik Brodowski <linux@dominikbrodowski.de>,
	Andrew Morton <akpm@osdl.org>
References: <20041104112736.GT3472@crusoe.alcove-fr> <418AE490.1010304@pobox.com> <20041110155903.GA8542@sd291.sivit.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041110155903.GA8542@sd291.sivit.org>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

===================================================================

ChangeSet@1.2090, 2004-11-10 16:43:13+01:00, stelian@popies.net
  drivers/net/pcmcia: use module_param() instead of MODULE_PARM()
  
  Signed-off-by: Stelian Pop <stelian@popies.net>

===================================================================

 3c574_cs.c    |   21 +++++++++++++--------
 3c589_cs.c    |   18 ++++++++++--------
 axnet_cs.c    |   11 ++++++-----
 com20020_cs.c |   34 +++++++++++++++++-----------------
 fmvj18x_cs.c  |   15 ++++++++-------
 ibmtr_cs.c    |   23 ++++++++++++-----------
 nmclan_cs.c   |   14 ++++++++------
 pcnet_cs.c    |   46 +++++++++++++++++++++++++++++++++-------------
 smc91c92_cs.c |   18 ++++++++++--------
 xirc2ps_cs.c  |   25 +++++++++++++++++--------
 10 files changed, 134 insertions(+), 91 deletions(-)

===================================================================

diff -Nru a/drivers/net/pcmcia/3c574_cs.c b/drivers/net/pcmcia/3c574_cs.c
--- a/drivers/net/pcmcia/3c574_cs.c	2004-11-10 16:56:46 +01:00
+++ b/drivers/net/pcmcia/3c574_cs.c	2004-11-10 16:56:46 +01:00
@@ -107,24 +107,29 @@
 MODULE_DESCRIPTION("3Com 3c574 series PCMCIA ethernet driver");
 MODULE_LICENSE("GPL");
 
-#define INT_MODULE_PARM(n, v) static int n = v; MODULE_PARM(n, "i")
+/* Bit map of interrupts to choose from */
+static int irq_mask = 0xdeb8;
+module_param(irq_mask, int, 0444);
 
-/* Now-standard PC card module parameters. */
-INT_MODULE_PARM(irq_mask, 0xdeb8);
 static int irq_list[4] = { -1 };
-MODULE_PARM(irq_list, "1-4i");
+module_param_array(irq_list, int, NULL, 0444);
 
 /* Maximum events (Rx packets, etc.) to handle at each interrupt. */
-INT_MODULE_PARM(max_interrupt_work, 32);
+static int max_interrupt_work = 32;
+module_param(max_interrupt_work, int, 0444);
 
 /* Force full duplex modes? */
-INT_MODULE_PARM(full_duplex, 0);
+static int full_duplex; /* = 0 */
+module_param(full_duplex, int, 0444);
 
 /* Autodetect link polarity reversal? */
-INT_MODULE_PARM(auto_polarity, 1);
+static int auto_polarity = 1;
+module_param(auto_polarity, int, 0444);
 
+/* Now-standard PC card module parameters. */
 #ifdef PCMCIA_DEBUG
-INT_MODULE_PARM(pc_debug, PCMCIA_DEBUG);
+static int pc_debug = PCMCIA_DEBUG;
+module_param(pc_debug, int, 0644);
 #define DEBUG(n, args...) if (pc_debug>(n)) printk(KERN_DEBUG args)
 static char *version =
 "3c574_cs.c 1.65ac1 2003/04/07 Donald Becker/David Hinds, becker@scyld.com.\n";
diff -Nru a/drivers/net/pcmcia/3c589_cs.c b/drivers/net/pcmcia/3c589_cs.c
--- a/drivers/net/pcmcia/3c589_cs.c	2004-11-10 16:56:46 +01:00
+++ b/drivers/net/pcmcia/3c589_cs.c	2004-11-10 16:56:46 +01:00
@@ -126,18 +126,20 @@
 MODULE_DESCRIPTION("3Com 3c589 series PCMCIA ethernet driver");
 MODULE_LICENSE("GPL");
 
-#define INT_MODULE_PARM(n, v) static int n = v; MODULE_PARM(n, "i")
-
-/* Special hook for setting if_port when module is loaded */
-INT_MODULE_PARM(if_port, 0);
-
 /* Bit map of interrupts to choose from */
-INT_MODULE_PARM(irq_mask, 0xdeb8);
+static int irq_mask = 0xdeb8;
+module_param(irq_mask, int, 0444);
+
 static int irq_list[4] = { -1 };
-MODULE_PARM(irq_list, "1-4i");
+module_param_array(irq_list, int, NULL, 0444);
+
+/* Maximum events (Rx packets, etc.) to handle at each interrupt. */
+static int if_port; /* = 0 */
+module_param(if_port, int, 0444);
 
 #ifdef PCMCIA_DEBUG
-INT_MODULE_PARM(pc_debug, PCMCIA_DEBUG);
+static int pc_debug = PCMCIA_DEBUG;
+module_param(pc_debug, int, 0644);
 #define DEBUG(n, args...) if (pc_debug>(n)) printk(KERN_DEBUG args)
 static char *version =
 DRV_NAME ".c " DRV_VERSION " 2001/10/13 00:08:50 (David Hinds)";
diff -Nru a/drivers/net/pcmcia/axnet_cs.c b/drivers/net/pcmcia/axnet_cs.c
--- a/drivers/net/pcmcia/axnet_cs.c	2004-11-10 16:56:46 +01:00
+++ b/drivers/net/pcmcia/axnet_cs.c	2004-11-10 16:56:46 +01:00
@@ -73,15 +73,16 @@
 MODULE_DESCRIPTION("Asix AX88190 PCMCIA ethernet driver");
 MODULE_LICENSE("GPL");
 
-#define INT_MODULE_PARM(n, v) static int n = v; MODULE_PARM(n, "i")
-
 /* Bit map of interrupts to choose from */
-INT_MODULE_PARM(irq_mask,	0xdeb8);
+static int irq_mask = 0xdeb8;
+module_param(irq_mask, int, 0444);
+
 static int irq_list[4] = { -1 };
-MODULE_PARM(irq_list, "1-4i");
+module_param_array(irq_list, int, NULL, 0444);
 
 #ifdef PCMCIA_DEBUG
-INT_MODULE_PARM(pc_debug, PCMCIA_DEBUG);
+static int pc_debug = PCMCIA_DEBUG;
+module_param(pc_debug, int, 0644);
 #define DEBUG(n, args...) if (pc_debug>(n)) printk(KERN_DEBUG args)
 static char *version =
 "axnet_cs.c 1.28 2002/06/29 06:27:37 (David Hinds)";
diff -Nru a/drivers/net/pcmcia/com20020_cs.c b/drivers/net/pcmcia/com20020_cs.c
--- a/drivers/net/pcmcia/com20020_cs.c	2004-11-10 16:56:46 +01:00
+++ b/drivers/net/pcmcia/com20020_cs.c	2004-11-10 16:56:46 +01:00
@@ -57,7 +57,7 @@
 #ifdef PCMCIA_DEBUG
 
 static int pc_debug = PCMCIA_DEBUG;
-MODULE_PARM(pc_debug, "i");
+module_param(pc_debug, int, 0644);
 #define DEBUG(n, args...) if (pc_debug>(n)) printk(KERN_DEBUG args)
 
 static void regdump(struct net_device *dev)
@@ -101,26 +101,26 @@
 
 /*====================================================================*/
 
-/* Parameters that can be set with 'insmod' */
-
-static int node;
-static int timeout = 3;
-static int backplane;
-static int clockp;
-static int clockm;
-
-MODULE_PARM(node, "i");
-MODULE_PARM(timeout, "i");
-MODULE_PARM(backplane, "i");
-MODULE_PARM(clockp, "i");
-MODULE_PARM(clockm, "i");
 
 /* Bit map of interrupts to choose from */
-static u_int irq_mask = 0xdeb8;
+static int irq_mask = 0xdeb8;
+module_param(irq_mask, int, 0444);
+
 static int irq_list[4] = { -1 };
+module_param_array(irq_list, int, NULL, 0444);
+
+/* Parameters that can be set with 'insmod' */
+static int node; /* = 0 */
+module_param(node, int, 0444);
+static int timeout = 3;
+module_param(timeout, int, 0444);
+static int backplane; /* = 0 */
+module_param(backplane, int, 0444);
+static int clockp; /* = 0 */
+module_param(clockp, int, 0444);
+static int clockm; /* = 0 */
+module_param(clockm, int, 0444);
 
-MODULE_PARM(irq_mask, "i");
-MODULE_PARM(irq_list, "1-4i");
 MODULE_LICENSE("GPL");
 
 /*====================================================================*/
diff -Nru a/drivers/net/pcmcia/fmvj18x_cs.c b/drivers/net/pcmcia/fmvj18x_cs.c
--- a/drivers/net/pcmcia/fmvj18x_cs.c	2004-11-10 16:56:46 +01:00
+++ b/drivers/net/pcmcia/fmvj18x_cs.c	2004-11-10 16:56:46 +01:00
@@ -67,20 +67,21 @@
 MODULE_DESCRIPTION("fmvj18x and compatible PCMCIA ethernet driver");
 MODULE_LICENSE("GPL");
 
-#define INT_MODULE_PARM(n, v) static int n = v; MODULE_PARM(n, "i")
-
 /* Bit map of interrupts to choose from */
-/* This means pick from 15, 14, 12, 11, 10, 9, 7, 5, 4, and 3 */
-INT_MODULE_PARM(irq_mask, 0xdeb8);
+static int irq_mask = 0xdeb8;
+module_param(irq_mask, int, 0444);
+
 static int irq_list[4] = { -1 };
-MODULE_PARM(irq_list, "1-4i");
+module_param_array(irq_list, int, NULL, 0444);
 
 /* SRAM configuration */
 /* 0:4KB*2 TX buffer   else:8KB*2 TX buffer */
-INT_MODULE_PARM(sram_config, 0);
+static int sram_config; /* = 0 */
+module_param(sram_config, int, 0444);
 
 #ifdef PCMCIA_DEBUG
-INT_MODULE_PARM(pc_debug, PCMCIA_DEBUG);
+static int pc_debug = PCMCIA_DEBUG;
+module_param(pc_debug, int, 0644);
 #define DEBUG(n, args...) if (pc_debug>(n)) printk(KERN_DEBUG args)
 static char *version = DRV_NAME ".c " DRV_VERSION " 2002/03/23";
 #else
diff -Nru a/drivers/net/pcmcia/ibmtr_cs.c b/drivers/net/pcmcia/ibmtr_cs.c
--- a/drivers/net/pcmcia/ibmtr_cs.c	2004-11-10 16:56:46 +01:00
+++ b/drivers/net/pcmcia/ibmtr_cs.c	2004-11-10 16:56:46 +01:00
@@ -72,7 +72,7 @@
 
 #ifdef PCMCIA_DEBUG
 static int pc_debug = PCMCIA_DEBUG;
-MODULE_PARM(pc_debug, "i");
+module_param(pc_debug, int, 0644);
 #define DEBUG(n, args...) if (pc_debug>(n)) printk(KERN_DEBUG args)
 static char *version =
 "ibmtr_cs.c 1.10   1996/01/06 05:19:00 (Steve Kipisz)\n"
@@ -87,27 +87,28 @@
 /* Parameters that can be set with 'insmod' */
 
 /* Bit map of interrupts to choose from */
-static u_int irq_mask = 0xdeb8;
+static int irq_mask = 0xdeb8;
+module_param(irq_mask, int, 0444);
+
 static int irq_list[4] = { -1 };
+module_param_array(irq_list, int, NULL, 0444);
 
 /* MMIO base address */
-static u_long mmiobase = 0xce000;
+static int mmiobase = 0xce000;
+module_param(mmiobase, int, 0444);
 
 /* SRAM base address */
-static u_long srambase = 0xd0000;
+static int srambase = 0xd0000;
+module_param(srambase, int, 0444);
 
 /* SRAM size 8,16,32,64 */
-static u_long sramsize = 64;
+static int sramsize = 64;
+module_param(sramsize, int, 0444);
 
 /* Ringspeed 4,16 */
 static int ringspeed = 16;
+module_param(ringspeed, int, 0444);
 
-MODULE_PARM(irq_mask, "i");
-MODULE_PARM(irq_list, "1-4i");
-MODULE_PARM(mmiobase, "i");
-MODULE_PARM(srambase, "i");
-MODULE_PARM(sramsize, "i");
-MODULE_PARM(ringspeed, "i");
 MODULE_LICENSE("GPL");
 
 /*====================================================================*/
diff -Nru a/drivers/net/pcmcia/nmclan_cs.c b/drivers/net/pcmcia/nmclan_cs.c
--- a/drivers/net/pcmcia/nmclan_cs.c	2004-11-10 16:56:46 +01:00
+++ b/drivers/net/pcmcia/nmclan_cs.c	2004-11-10 16:56:46 +01:00
@@ -405,18 +405,20 @@
 MODULE_DESCRIPTION("New Media PCMCIA ethernet driver");
 MODULE_LICENSE("GPL");
 
-#define INT_MODULE_PARM(n, v) static int n = v; MODULE_PARM(n, "i")
+/* Bit map of interrupts to choose from */
+static int irq_mask = 0xdeb8;
+module_param(irq_mask, int, 0444);
 
 static int irq_list[4] = { -1 };
-MODULE_PARM(irq_list, "1-4i");
+module_param_array(irq_list, int, NULL, 0444);
 
 /* 0=auto, 1=10baseT, 2 = 10base2, default=auto */
-INT_MODULE_PARM(if_port, 0);
-/* Bit map of interrupts to choose from */
-INT_MODULE_PARM(irq_mask, 0xdeb8);
+static int if_port; /* = 0 */
+module_param(if_port, int, 0444);
 
 #ifdef PCMCIA_DEBUG
-INT_MODULE_PARM(pc_debug, PCMCIA_DEBUG);
+static int pc_debug = PCMCIA_DEBUG;
+module_param(pc_debug, int, 0644);
 #define DEBUG(n, args...) if (pc_debug>(n)) printk(KERN_DEBUG args)
 #else
 #define DEBUG(n, args...)
diff -Nru a/drivers/net/pcmcia/pcnet_cs.c b/drivers/net/pcmcia/pcnet_cs.c
--- a/drivers/net/pcmcia/pcnet_cs.c	2004-11-10 16:56:46 +01:00
+++ b/drivers/net/pcmcia/pcnet_cs.c	2004-11-10 16:56:46 +01:00
@@ -71,7 +71,7 @@
 
 #ifdef PCMCIA_DEBUG
 static int pc_debug = PCMCIA_DEBUG;
-MODULE_PARM(pc_debug, "i");
+module_param(pc_debug, int, 0644);
 #define DEBUG(n, args...) if (pc_debug>(n)) printk(KERN_DEBUG args)
 static char *version =
 "pcnet_cs.c 1.153 2003/11/09 18:53:09 (David Hinds)";
@@ -87,24 +87,44 @@
 MODULE_DESCRIPTION("NE2000 compatible PCMCIA ethernet driver");
 MODULE_LICENSE("GPL");
 
-#define INT_MODULE_PARM(n, v) static int n = v; MODULE_PARM(n, "i")
-
 /* Bit map of interrupts to choose from */
-INT_MODULE_PARM(irq_mask,	0xdeb8);
+static int irq_mask = 0xdeb8;
+module_param(irq_mask, int, 0444);
+
 static int irq_list[4] = { -1 };
-MODULE_PARM(irq_list, "1-4i");
+module_param_array(irq_list, int, NULL, 0444);
 
-INT_MODULE_PARM(if_port,	1);	/* Transceiver type */
-INT_MODULE_PARM(use_big_buf,	1);	/* use 64K packet buffer? */
-INT_MODULE_PARM(mem_speed,	0);	/* shared mem speed, in ns */
-INT_MODULE_PARM(delay_output,	0);	/* pause after xmit? */
-INT_MODULE_PARM(delay_time,	4);	/* in usec */
-INT_MODULE_PARM(use_shmem,	-1);	/* use shared memory? */
-INT_MODULE_PARM(full_duplex,	0);	/* full duplex? */
+/* Transceiver type */
+static int if_port = 1;
+module_param(if_port, int, 0444);
+
+/* use 64K packet buffer? */
+static int use_big_buf = 1;
+module_param(use_big_buf, int, 0444);
+
+/* shared mem speed, in ns */
+static int mem_speed; /* = 0 */
+module_param(mem_speed, int, 0444);
+
+/* pause after xmit? */
+static int delay_output; /* = 0 */
+module_param(delay_output, int, 0444);
+
+/* in usec */
+static int delay_time = 4;
+module_param(delay_time, int, 0444);
+
+/* use shared memory? */
+static int use_shmem = -1;
+module_param(use_shmem, int, 0444);
+
+/* full duplex ? */
+static int full_duplex; /* = 0 */
+module_param(full_duplex, int, 0444);
 
 /* Ugh!  Let the user hardwire the hardware address for queer cards */
 static int hw_addr[6] = { 0, /* ... */ };
-MODULE_PARM(hw_addr, "6i");
+module_param_array(hw_addr, int, NULL, 0444);
 
 /*====================================================================*/
 
diff -Nru a/drivers/net/pcmcia/smc91c92_cs.c b/drivers/net/pcmcia/smc91c92_cs.c
--- a/drivers/net/pcmcia/smc91c92_cs.c	2004-11-10 16:56:46 +01:00
+++ b/drivers/net/pcmcia/smc91c92_cs.c	2004-11-10 16:56:46 +01:00
@@ -66,7 +66,12 @@
 MODULE_DESCRIPTION("SMC 91c92 series PCMCIA ethernet driver");
 MODULE_LICENSE("GPL");
 
-#define INT_MODULE_PARM(n, v) static int n = v; MODULE_PARM(n, "i")
+/* Bit map of interrupts to choose from */
+static int irq_mask = 0xdeb8;
+module_param(irq_mask, int, 0444);
+
+static int irq_list[4] = { -1 };
+module_param_array(irq_list, int, NULL, 0444);
 
 /*
   Transceiver/media type.
@@ -74,15 +79,12 @@
    1 = 10baseT (and autoselect if #define AUTOSELECT),
    2 = AUI/10base2,
 */
-INT_MODULE_PARM(if_port, 0);
-
-/* Bit map of interrupts to choose from. */
-INT_MODULE_PARM(irq_mask, 0xdeb8);
-static int irq_list[4] = { -1 };
-MODULE_PARM(irq_list, "1-4i");
+static int if_port; /* = 0 */
+module_param(if_port, int, 0444);
 
 #ifdef PCMCIA_DEBUG
-INT_MODULE_PARM(pc_debug, PCMCIA_DEBUG);
+static int pc_debug = PCMCIA_DEBUG;
+module_param(pc_debug, int, 0644);
 static const char *version =
 "smc91c92_cs.c 0.09 1996/8/4 Donald Becker, becker@scyld.com.\n";
 #define DEBUG(n, args...) if (pc_debug>(n)) printk(KERN_DEBUG args)
diff -Nru a/drivers/net/pcmcia/xirc2ps_cs.c b/drivers/net/pcmcia/xirc2ps_cs.c
--- a/drivers/net/pcmcia/xirc2ps_cs.c	2004-11-10 16:56:46 +01:00
+++ b/drivers/net/pcmcia/xirc2ps_cs.c	2004-11-10 16:56:46 +01:00
@@ -220,7 +220,7 @@
  */
 #ifdef PCMCIA_DEBUG
 static int pc_debug = PCMCIA_DEBUG;
-MODULE_PARM(pc_debug, "i");
+module_param(pc_debug, int, 0644);
 #define DEBUG(n, args...) if (pc_debug>(n)) printk(KDBG_XIRC args)
 #else
 #define DEBUG(n, args...)
@@ -255,15 +255,24 @@
 MODULE_DESCRIPTION("Xircom PCMCIA ethernet driver");
 MODULE_LICENSE("Dual MPL/GPL");
 
-#define INT_MODULE_PARM(n, v) static int n = v; MODULE_PARM(n, "i")
+/* Bit map of interrupts to choose from */
+static int irq_mask = 0xdeb8;
+module_param(irq_mask, int, 0444);
 
 static int irq_list[4] = { -1 };
-MODULE_PARM(irq_list, "1-4i");
-INT_MODULE_PARM(irq_mask,	0xdeb8);
-INT_MODULE_PARM(if_port,	0);
-INT_MODULE_PARM(full_duplex,	0);
-INT_MODULE_PARM(do_sound, 	1);
-INT_MODULE_PARM(lockup_hack,	0);  /* anti lockup hack */
+module_param_array(irq_list, int, NULL, 0444);
+
+static int if_port; /* = 0 */
+module_param(if_port, int, 0444);
+
+static int full_duplex; /* = 0 */
+module_param(full_duplex, int, 0444);
+
+static int do_sound = 1;
+module_param(do_sound, int, 0444);
+
+static int lockup_hack; /* = 0 */
+module_param(lockup_hack, int, 0444);
 
 /*====================================================================*/
 
