Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315883AbSE2X0W>; Wed, 29 May 2002 19:26:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315862AbSE2X0T>; Wed, 29 May 2002 19:26:19 -0400
Received: from h55p103-3.delphi.afb.lu.se ([130.235.187.176]:6615 "EHLO gin")
	by vger.kernel.org with ESMTP id <S315860AbSE2X0H>;
	Wed, 29 May 2002 19:26:07 -0400
Date: Thu, 30 May 2002 01:25:46 +0200
To: linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.com, jgarzik@mandrakesoft.com
Subject: [PATCH 2.5.19] fix compilation of drivers/net/tulip/de4x5.c
Message-ID: <20020529232546.GB24473@h55p111.delphi.afb.lu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: Anders Gustafsson <andersg@0x63.nu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I had to rename the struct bus_type in drivers/net/tulip/de4x5.c to
make it collide. as there is another struct bus_type defined in
include/linux/device.h. 

//anders/g


You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.596, 2002-05-30 01:00:35+02:00, andersg@heineken.0x63.nu
  Renames struct bus_type to struct de4x5_bus_type to avoid collision
  with the struct bus_type in device.h


 de4x5.c |   30 +++++++++++++++---------------
 1 files changed, 15 insertions(+), 15 deletions(-)


diff -Nru a/drivers/net/tulip/de4x5.c b/drivers/net/tulip/de4x5.c
--- a/drivers/net/tulip/de4x5.c	Thu May 30 01:15:54 2002
+++ b/drivers/net/tulip/de4x5.c	Thu May 30 01:15:55 2002
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

===================================================================


This BitKeeper patch contains the following changesets:
1596
## Wrapped with gzip_uu ##


begin 664 bkpatch4254
M'XL(`"MA]3P``]U676_3,!1]KG^%I4D(-II<?\5)4=%@13"!1%6TY\I-O"8T
M3:;$[0;DQ^-\L(^.TC#QA!/I./8]Q[[WGH<<X8M2%Z.!RB)=E$MTA#_DI1D-
M8IUD>J4S!VX\YF0;NS'+<[OAQOE:NUVXN])%IE-WL7(7:7X]I(Y`-G*J3!CC
MK8T8#8C#;E?,MRL]&LS>O;_X]&:&T'B,SV*5+?47;?!XC$Q>;%4:E:?*Q&F>
M.:906;G61CEAOJYN0RL*0.TCB&0@O(IXP&45DH@0Q8F.@'+?XZB[XNEN)KM"
M@@84F"=DQ:0D$DTP<43@8:`N")<!!C("&#%Q`M1.\#Y=?$+P$-!;_&_3.$,A
MGNE,K76)2U-L0H,7FW)>E]*>]&LITOQ&S.]OJ&V>1#C,TS0IDSRS*M>)L2V(
M]2.9)+/\;1)J)T8?,9-<,C2]:PT:_N5`"!2@UP<*$15)[1`WT\9MKN^$]TK"
M`4A%!)=0!9>^B$!2OA"<+T#M[<`#2;-)DZN'PG6GF9V0BH$/LC'@7LIA0SXY
M`?1UJ8KOR>IT;3,IU$J7^:5Y)/F;!!A("(3/O0JH$**Q*J&[3J7DL%,%'A+Q
M'WBUZ>-G/"RNF]=Z;[J_I4\P\L3W`DS0>0NE428)]^3Q`TT""75P"UUPDAE<
MC^G9^;Q,EIDRFT(_#V-5X..Z4B_WR!VG5R]>U9*LE62/)3N&BN9ED:^?_U&'
M6#O60AWN**ELKF]"?65L]0_H$.XU.BW6Y+WQ>(R?V6_+H@3\FM5A;Y8?M*P&
M^[(8T(;58D\6"P)1LSI\2K?0A`/GM4B'/8_FA#9'=]B71:%I1(>]O5`S.;3,
J!GN?YY&6U6!O5M!6I,6>/KO[APAC':[*S7KL^3R4H93H)V]6X2>Q"```
`
end
