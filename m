Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315746AbSE2Xsa>; Wed, 29 May 2002 19:48:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315748AbSE2Xs3>; Wed, 29 May 2002 19:48:29 -0400
Received: from p062.as-l031.contactel.cz ([212.65.234.254]:58496 "EHLO
	ppc.vc.cvut.cz") by vger.kernel.org with ESMTP id <S315746AbSE2Xs1>;
	Wed, 29 May 2002 19:48:27 -0400
Date: Thu, 30 May 2002 01:44:07 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: A Guy Called Tyketto <tyketto@wizard.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.19 - de4x5 errs on compile
Message-ID: <20020529234407.GD12672@ppc.vc.cvut.cz>
In-Reply-To: <20020529231453.GA31987@wizard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2002 at 04:14:53PM -0700, A Guy Called Tyketto wrote:
> make[2]: Leaving directory `/usr/src/linux-2.5.15/drivers/media'
> make[2]: Entering directory `/usr/src/linux-2.5.15/drivers/misc'
> make[2]: Nothing to be done for `modules'.
> make[2]: Leaving directory `/usr/src/linux-2.5.15/drivers/misc'
> make[2]: Entering directory `/usr/src/linux-2.5.15/drivers/net'
> make[3]: Entering directory `/usr/src/linux-2.5.15/drivers/net/tulip'
> gcc -D__KERNEL__ -I/usr/src/linux-2.5.15/include -Wall -Wstrict-prototypes 
> -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe 
> -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4  -DMODULE 
> -DMODVERSIONS -include /usr/src/linux-2.5.15/include/linux/modversions.h   
> -DKBUILD_BASENAME=de4x5  -c -o de4x5.o de4x5.c
> de4x5.c:869: redefinition of `struct bus_type'
> make[3]: *** [de4x5.o] Error 1
> make[3]: Leaving directory `/usr/src/linux-2.5.15/drivers/net/tulip'
> make[2]: *** [_modsubdir_tulip] Error 2
> make[2]: Leaving directory `/usr/src/linux-2.5.15/drivers/net'
> make[1]: *** [_modsubdir_net] Error 2
> make[1]: Leaving directory `/usr/src/linux-2.5.15/drivers'

I sent patch below to Linus a hour ago.
						Petr Vandrovec

diff -urN linux-2.5.19/drivers/net/tulip/de4x5.c linux-2.5.19/drivers/net/tulip/de4x5.c
--- linux-2.5.19/drivers/net/tulip/de4x5.c	Tue May 21 07:07:30 2002
+++ linux-2.5.19/drivers/net/tulip/de4x5.c	Thu May 30 00:21:52 2002
@@ -866,7 +866,7 @@
 ** offsets in the PCI and EISA boards. Also note that the ethernet address
 ** PROM is accessed differently.
 */
-static struct bus_type {
+static struct de4x5_bus_type {
     int bus;
     int bus_num;
     int device;
@@ -967,10 +967,10 @@
 static int     test_ans(struct net_device *dev, s32 irqs, s32 irq_mask, s32 msec);
 static int     test_tp(struct net_device *dev, s32 msec);
 static int     EISA_signature(char *name, s32 eisa_id);
-static int     PCI_signature(char *name, struct bus_type *lp);
+static int     PCI_signature(char *name, struct de4x5_bus_type *lp);
 static void    DevicePresent(u_long iobase);
 static void    enet_addr_rst(u_long aprom_addr);
-static int     de4x5_bad_srom(struct bus_type *lp);
+static int     de4x5_bad_srom(struct de4x5_bus_type *lp);
 static short   srom_rd(u_long address, u_char offset);
 static void    srom_latch(u_int command, u_long address);
 static void    srom_command(u_int command, u_long address);
@@ -998,7 +998,7 @@
 static int     get_hw_addr(struct net_device *dev);
 static void    srom_repair(struct net_device *dev, int card);
 static int     test_bad_enet(struct net_device *dev, int status);
-static int     an_exception(struct bus_type *lp);
+static int     an_exception(struct de4x5_bus_type *lp);
 #if !defined(__sparc_v9__) && !defined(__powerpc__) && !defined(__alpha__)
 static void    eisa_probe(struct net_device *dev, u_long iobase);
 #endif
@@ -1143,7 +1143,7 @@
 static int __init 
 de4x5_hw_init(struct net_device *dev, u_long iobase, struct pci_dev *pdev)
 {
-    struct bus_type *lp = &bus;
+    struct de4x5_bus_type *lp = &bus;
     int i, status=0;
     char *tmp;
     
@@ -2105,7 +2105,7 @@
     u_short vendor;
     u32 cfid;
     u_long iobase;
-    struct bus_type *lp = &bus;
+    struct de4x5_bus_type *lp = &bus;
     char name[DE4X5_STRLEN];
 
     if (lastEISA == MAX_EISA_SLOTS) return;/* No more EISA devices to search */
@@ -2186,7 +2186,7 @@
     u_short vendor, index, status;
     u_int irq = 0, device, class = DE4X5_CLASS_CODE;
     u_long iobase = 0;                     /* Clear upper 32 bits in Alphas */
-    struct bus_type *lp = &bus;
+    struct de4x5_bus_type *lp = &bus;
 
     if (lastPCI == NO_MORE_PCI) return;
 
@@ -2299,7 +2299,7 @@
     u_int irq = 0, device;
     u_long iobase = 0;                     /* Clear upper 32 bits in Alphas */
     int i, j;
-    struct bus_type *lp = &bus;
+    struct de4x5_bus_type *lp = &bus;
     struct list_head *walk = &dev->bus_list;
 
     for (walk = walk->next; walk != &dev->bus_list; walk = walk->next) {
@@ -3992,7 +3992,7 @@
 ** Look for a particular board name in the PCI configuration space
 */
 static int
-PCI_signature(char *name, struct bus_type *lp)
+PCI_signature(char *name, struct de4x5_bus_type *lp)
 {
     static c_char *de4x5_signatures[] = DE4X5_SIGNATURE;
     int i, status = 0, siglen = sizeof(de4x5_signatures)/sizeof(c_char *);
@@ -4041,7 +4041,7 @@
 DevicePresent(u_long aprom_addr)
 {
     int i, j=0;
-    struct bus_type *lp = &bus;
+    struct de4x5_bus_type *lp = &bus;
     
     if (lp->chipset == DC21040) {
 	if (lp->bus == EISA) {
@@ -4122,7 +4122,7 @@
     u_long iobase = dev->base_addr;
     int broken, i, k, tmp, status = 0;
     u_short j,chksum;
-    struct bus_type *lp = &bus;
+    struct de4x5_bus_type *lp = &bus;
 
     broken = de4x5_bad_srom(lp);
 
@@ -4203,7 +4203,7 @@
 ** didn't seem to work here...?
 */
 static int
-de4x5_bad_srom(struct bus_type *lp)
+de4x5_bad_srom(struct de4x5_bus_type *lp)
 {
     int i, status = 0;
 
@@ -4237,7 +4237,7 @@
 static void
 srom_repair(struct net_device *dev, int card)
 {
-    struct bus_type *lp = &bus;
+    struct de4x5_bus_type *lp = &bus;
 
     switch(card) {
       case SMC:
@@ -4258,7 +4258,7 @@
 static int
 test_bad_enet(struct net_device *dev, int status)
 {
-    struct bus_type *lp = &bus;
+    struct de4x5_bus_type *lp = &bus;
     int i, tmp;
 
     for (tmp=0,i=0; i<ETH_ALEN; i++) tmp += (u_char)dev->dev_addr[i];
@@ -4291,7 +4291,7 @@
 ** List of board exceptions with correctly wired IRQs
 */
 static int
-an_exception(struct bus_type *lp)
+an_exception(struct de4x5_bus_type *lp)
 {
     if ((*(u_short *)lp->srom.sub_vendor_id == 0x00c0) && 
 	(*(u_short *)lp->srom.sub_system_id == 0x95e0)) {
