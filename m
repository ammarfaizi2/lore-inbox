Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261454AbTEAC1z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 22:27:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261722AbTEAC1z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 22:27:55 -0400
Received: from pop.gmx.net ([213.165.65.60]:54836 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261454AbTEAC1x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 22:27:53 -0400
Message-ID: <3EB0407E.6090603@gmx.net>
Date: Wed, 30 Apr 2003 23:30:38 +0200
From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021126
X-Accept-Language: de, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo@conectiva.com.br>
CC: Olaf Hering <olh@suse.de>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.21-rc1
References: <Pine.LNX.4.53L.0304211545580.12940@freak.distro.conectiva> <20030423224635.A25828@suse.de>
In-Reply-To: <20030423224635.A25828@suse.de>
X-Enigmail-Version: 0.71.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
X-Enigmail-Override-With: vi
X-Real-User-Agent: netcat
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Marcelo,

for your convenience I stripped the patch from the parts which should
not be applied, leaving only genuine bugfixes in the patch.

Olaf Hering wrote:
>  On Mon, Apr 21, Marcelo Tosatti wrote:
> 
>>Here goes the first candidate for 2.4.21.
>>
>>Please test it extensively.
> 
> 
> 2.4.20 needs these patches to compile with gcc3.3. It does still apply
> to 2.4.21-rc1.

The part mentioned below was removed.
> The extern inline -> static inline is only a workaround and must not go
> in, I hope a more recent gcc-3.3 has a fix for the inline bugs.


Please apply,
Carl-Daniel


Please review:

 drivers/net/irda/ma600.c        |    2 +-
 drivers/net/tokenring/olympic.c |    4 ++--
 drivers/sound/cs46xx.c          |    4 ++--
 net/decnet/dn_table.c           |    3 +--
 4 files changed, 6 insertions(+), 7 deletions(-)


diff -purNX /kernel_exclude.txt linux_ppc/drivers/net/irda/ma600.c linux_ppc/drivers/net/irda/ma600.c
--- linux_ppc/drivers/net/irda/ma600.c	2002-11-28 23:53:13.000000000 +0000
+++ linux_ppc/drivers/net/irda/ma600.c	2003-02-03 12:51:14.000000000 +0000
@@ -53,7 +53,7 @@
 	if(!(expr)) { \
 	        printk( "Assertion failed! %s,%s,%s,line=%d\n",\
         	#expr,__FILE__,__FUNCTION__,__LINE__); \
-	        ##func}
+	        func}
 #endif
 
 /* convert hex value to ascii hex */
diff -purNX /kernel_exclude.txt linux_ppc/drivers/net/tokenring/olympic.c linux_ppc/drivers/net/tokenring/olympic.c
--- linux_ppc/drivers/net/tokenring/olympic.c	2002-11-28 23:53:14.000000000 +0000
+++ linux_ppc/drivers/net/tokenring/olympic.c	2003-02-03 12:46:04.000000000 +0000
@@ -655,8 +655,8 @@ static int olympic_open(struct net_devic
 	printk(" stat_ring[7]: %p\n", &(olympic_priv->olympic_rx_status_ring[7])  );
 
 	printk("RXCDA: %x, rx_ring[0]: %p\n",readl(olympic_mmio+RXCDA),&olympic_priv->olympic_rx_ring[0]);
-	printk("Rx_ring_dma_addr = %08x, rx_status_dma_addr =
-%08x\n",olympic_priv->rx_ring_dma_addr,olympic_priv->rx_status_ring_dma_addr) ; 
+	printk("Rx_ring_dma_addr = %08x, rx_status_dma_addr ="
+"%08x\n",olympic_priv->rx_ring_dma_addr,olympic_priv->rx_status_ring_dma_addr) ; 
 #endif
 
 	writew((((readw(olympic_mmio+RXENQ)) & 0x8000) ^ 0x8000) | i,olympic_mmio+RXENQ);
diff -purNX /kernel_exclude.txt linux_ppc/drivers/sound/cs46xx.c linux_ppc/drivers/sound/cs46xx.c
--- linux_ppc/drivers/sound/cs46xx.c	2002-08-03 00:39:44.000000000 +0000
+++ linux_ppc/drivers/sound/cs46xx.c	2003-02-03 12:51:14.000000000 +0000
@@ -947,8 +947,8 @@ static void cs_play_setup(struct cs_stat
 
 struct InitStruct
 {
-    u32 long off;
-    u32 long val;
+    u32 off;
+    u32 val;
 } InitArray[] = { {0x00000040, 0x3fc0000f},
                   {0x0000004c, 0x04800000},
 
diff -purNX linux/kernel_exclude.txt linux_ppc.orig/net/decnet/dn_table.c linux_ppc/net/decnet/dn_table.c
--- linux_ppc.orig/net/decnet/dn_table.c	2001-12-21 17:42:05.000000000 +0000
+++ linux_ppc/net/decnet/dn_table.c	2003-02-06 08:24:01.000000000 +0000
@@ -836,8 +836,7 @@ struct dn_fib_table *dn_fib_get_table(in
                 return NULL;
 
         if (in_interrupt() && net_ratelimit()) {
-                printk(KERN_DEBUG "DECnet: BUG! Attempt to create routing table 
-from interrupt\n"); 
+                printk(KERN_DEBUG "DECnet: BUG! Attempt to create routing table from interrupt\n"); 
                 return NULL;
         }
         if ((t = kmalloc(sizeof(struct dn_fib_table), GFP_KERNEL)) == NULL)

