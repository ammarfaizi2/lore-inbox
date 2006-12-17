Return-Path: <linux-kernel-owner+w=401wt.eu-S1752552AbWLQMs5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752552AbWLQMs5 (ORCPT <rfc822;w@1wt.eu>);
	Sun, 17 Dec 2006 07:48:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752553AbWLQMs4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Dec 2006 07:48:56 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:52738 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752552AbWLQMsz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Dec 2006 07:48:55 -0500
X-Originating-Ip: 24.148.236.183
Date: Sun, 17 Dec 2006 07:43:39 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [RFC][PATCH] Rewrite unnecessary duplicated code to use FIELD_SIZEOF().
Message-ID: <Pine.LNX.4.64.0612170738410.24046@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-14.6, required 5, ALL_TRUSTED -1.80, BAYES_00 -15.00,
	RCVD_IN_SORBS_DUL 2.05, TW_TX 0.08, TW_XG 0.08)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  as with ARRAY_SIZE(), there are a number of places (mercifully, far
fewer) that recode what could be done with the FIELD_SIZEOF() macro in
kernel.h.

  i wrote a short script to handle that and this is the result (after
a minor amount of hand tweaking):

 arch/m68k/kernel/signal.c               |   30 +++++++++++-----------
 arch/um/drivers/net_kern.c              |    2 -
 drivers/block/viodasd.c                 |    2 -
 drivers/net/e1000/e1000_ethtool.c       |    2 -
 drivers/net/ixgb/ixgb_ethtool.c         |    2 -
 drivers/net/mv643xx_eth.c               |    2 -
 drivers/net/netxen/netxen_nic_ethtool.c |    2 -
 drivers/usb/atm/usbatm.c                |    2 -
 drivers/usb/net/cdc_ether.c             |    2 -
 drivers/usb/net/usbnet.c                |    2 -
 drivers/usb/serial/io_usbvend.h         |    8 ++---
 fs/ext2/xattr.c                         |    2 -
 fs/ext3/xattr.c                         |    2 -
 fs/ext4/xattr.c                         |    2 -
 fs/mbcache.c                            |    2 -
 include/acpi/actbl.h                    |    2 -
 include/asm-powerpc/fs_pd.h             |    2 -
 include/net/sctp/sctp.h                 |    2 -
 18 files changed, 35 insertions(+), 35 deletions(-)



diff --git a/arch/m68k/kernel/signal.c b/arch/m68k/kernel/signal.c
index f9af893..c99517e 100644
--- a/arch/m68k/kernel/signal.c
+++ b/arch/m68k/kernel/signal.c
@@ -54,21 +54,21 @@
 asmlinkage int do_signal(sigset_t *oldset, struct pt_regs *regs);

 const int frame_extra_sizes[16] = {
-  [1]	= -1, /* sizeof(((struct frame *)0)->un.fmt1), */
-  [2]	= sizeof(((struct frame *)0)->un.fmt2),
-  [3]	= sizeof(((struct frame *)0)->un.fmt3),
-  [4]	= sizeof(((struct frame *)0)->un.fmt4),
-  [5]	= -1, /* sizeof(((struct frame *)0)->un.fmt5), */
-  [6]	= -1, /* sizeof(((struct frame *)0)->un.fmt6), */
-  [7]	= sizeof(((struct frame *)0)->un.fmt7),
-  [8]	= -1, /* sizeof(((struct frame *)0)->un.fmt8), */
-  [9]	= sizeof(((struct frame *)0)->un.fmt9),
-  [10]	= sizeof(((struct frame *)0)->un.fmta),
-  [11]	= sizeof(((struct frame *)0)->un.fmtb),
-  [12]	= -1, /* sizeof(((struct frame *)0)->un.fmtc), */
-  [13]	= -1, /* sizeof(((struct frame *)0)->un.fmtd), */
-  [14]	= -1, /* sizeof(((struct frame *)0)->un.fmte), */
-  [15]	= -1, /* sizeof(((struct frame *)0)->un.fmtf), */
+  [1]	= -1, /* FIELD_SIZEOF(struct frame, un.fmt1), */
+  [2]	= FIELD_SIZEOF(struct frame, un.fmt2),
+  [3]	= FIELD_SIZEOF(struct frame, un.fmt3),
+  [4]	= FIELD_SIZEOF(struct frame, un.fmt4),
+  [5]	= -1, /* FIELD_SIZEOF(struct frame, un.fmt5), */
+  [6]	= -1, /* FIELD_SIZEOF(struct frame, un.fmt6), */
+  [7]	= FIELD_SIZEOF(struct frame, un.fmt7),
+  [8]	= -1, /* FIELD_SIZEOF(struct frame, un.fmt8), */
+  [9]	= FIELD_SIZEOF(struct frame, un.fmt9),
+  [10]	= FIELD_SIZEOF(struct frame, un.fmta),
+  [11]	= FIELD_SIZEOF(struct frame, un.fmtb),
+  [12]	= -1, /* FIELD_SIZEOF(struct frame, un.fmtc), */
+  [13]	= -1, /* FIELD_SIZEOF(struct frame, un.fmtd), */
+  [14]	= -1, /* FIELD_SIZEOF(struct frame, un.fmte), */
+  [15]	= -1, /* FIELD_SIZEOF(struct frame, un.fmtf), */
 };

 /*
diff --git a/arch/um/drivers/net_kern.c b/arch/um/drivers/net_kern.c
index afe3d42..07adda0 100644
--- a/arch/um/drivers/net_kern.c
+++ b/arch/um/drivers/net_kern.c
@@ -334,7 +334,7 @@ static int eth_configure(int n, void *init, char *mac,
 	int save, err, size;

 	size = transport->private_size + sizeof(struct uml_net_private) +
-		sizeof(((struct uml_net_private *) 0)->user);
+		FIELD_SIZEOF(struct uml_net_private, user);

 	device = kzalloc(sizeof(*device), GFP_KERNEL);
 	if (device == NULL) {
diff --git a/drivers/block/viodasd.c b/drivers/block/viodasd.c
index e19ba4e..a2825cf 100644
--- a/drivers/block/viodasd.c
+++ b/drivers/block/viodasd.c
@@ -68,7 +68,7 @@ MODULE_LICENSE("GPL");
 enum {
 	PARTITION_SHIFT = 3,
 	MAX_DISKNO = HVMAXARCHITECTEDVIRTUALDISKS,
-	MAX_DISK_NAME = sizeof(((struct gendisk *)0)->disk_name)
+	MAX_DISK_NAME = FIELD_SIZEOF(struct gendisk, disk_name)
 };

 static DEFINE_SPINLOCK(viodasd_spinlock);
diff --git a/drivers/net/e1000/e1000_ethtool.c b/drivers/net/e1000/e1000_ethtool.c
index da459f7..c00d358 100644
--- a/drivers/net/e1000/e1000_ethtool.c
+++ b/drivers/net/e1000/e1000_ethtool.c
@@ -53,7 +53,7 @@ struct e1000_stats {
 	int stat_offset;
 };

-#define E1000_STAT(m) sizeof(((struct e1000_adapter *)0)->m), \
+#define E1000_STAT(m) FIELD_SIZEOF(struct e1000_adapter, m), \
 		      offsetof(struct e1000_adapter, m)
 static const struct e1000_stats e1000_gstrings_stats[] = {
 	{ "rx_packets", E1000_STAT(stats.gprc) },
diff --git a/drivers/net/ixgb/ixgb_ethtool.c b/drivers/net/ixgb/ixgb_ethtool.c
index cd22523..4ee1b23 100644
--- a/drivers/net/ixgb/ixgb_ethtool.c
+++ b/drivers/net/ixgb/ixgb_ethtool.c
@@ -52,7 +52,7 @@ struct ixgb_stats {
 	int stat_offset;
 };

-#define IXGB_STAT(m) sizeof(((struct ixgb_adapter *)0)->m), \
+#define IXGB_STAT(m) FIELD_SIZEOF(struct ixgb_adapter, m), \
 		      offsetof(struct ixgb_adapter, m)
 static struct ixgb_stats ixgb_gstrings_stats[] = {
 	{"rx_packets", IXGB_STAT(net_stats.rx_packets)},
diff --git a/drivers/net/mv643xx_eth.c b/drivers/net/mv643xx_eth.c
index c41ae42..3872471 100644
--- a/drivers/net/mv643xx_eth.c
+++ b/drivers/net/mv643xx_eth.c
@@ -2652,7 +2652,7 @@ struct mv643xx_stats {
 	int stat_offset;
 };

-#define MV643XX_STAT(m) sizeof(((struct mv643xx_private *)0)->m), \
+#define MV643XX_STAT(m) FIELD_SIZEOF(struct mv643xx_private, m), \
 					offsetof(struct mv643xx_private, m)

 static const struct mv643xx_stats mv643xx_gstrings_stats[] = {
diff --git a/drivers/net/netxen/netxen_nic_ethtool.c b/drivers/net/netxen/netxen_nic_ethtool.c
index 2ab4885..938c6ea 100644
--- a/drivers/net/netxen/netxen_nic_ethtool.c
+++ b/drivers/net/netxen/netxen_nic_ethtool.c
@@ -50,7 +50,7 @@ struct netxen_nic_stats {
 	int stat_offset;
 };

-#define NETXEN_NIC_STAT(m) sizeof(((struct netxen_port *)0)->m), \
+#define NETXEN_NIC_STAT(m) FIELD_SIZEOF(struct netxen_port, m), \
 			offsetof(struct netxen_port, m)

 #define NETXEN_NIC_PORT_WINDOW 0x10000
diff --git a/drivers/usb/atm/usbatm.c b/drivers/usb/atm/usbatm.c
index ec63b0e..0be22a3 100644
--- a/drivers/usb/atm/usbatm.c
+++ b/drivers/usb/atm/usbatm.c
@@ -1332,7 +1332,7 @@ static int __init usbatm_usb_init(void)
 {
 	dbg("%s: driver version %s", __func__, DRIVER_VERSION);

-	if (sizeof(struct usbatm_control) > sizeof(((struct sk_buff *) 0)->cb)) {
+	if (sizeof(struct usbatm_control) > FIELD_SIZEOF(struct sk_buff, cb)) {
 		printk(KERN_ERR "%s unusable with this kernel!\n", usbatm_driver_name);
 		return -EIO;
 	}
diff --git a/drivers/usb/net/cdc_ether.c b/drivers/usb/net/cdc_ether.c
index 44a9154..dbc2ba3 100644
--- a/drivers/usb/net/cdc_ether.c
+++ b/drivers/usb/net/cdc_ether.c
@@ -497,7 +497,7 @@ static struct usb_driver cdc_driver = {

 static int __init cdc_init(void)
 {
-	BUILD_BUG_ON((sizeof(((struct usbnet *)0)->data)
+	BUILD_BUG_ON((FIELD_SIZEOF(struct usbnet, data)
 			< sizeof(struct cdc_state)));

  	return usb_register(&cdc_driver);
diff --git a/drivers/usb/net/usbnet.c b/drivers/usb/net/usbnet.c
index 6e39e99..03cef6c 100644
--- a/drivers/usb/net/usbnet.c
+++ b/drivers/usb/net/usbnet.c
@@ -1283,7 +1283,7 @@ EXPORT_SYMBOL_GPL(usbnet_resume);
 static int __init usbnet_init(void)
 {
 	/* compiler should optimize this out */
-	BUILD_BUG_ON (sizeof (((struct sk_buff *)0)->cb)
+	BUILD_BUG_ON (FIELD_SIZEOF(struct sk_buff, cb)
 			< sizeof (struct skb_data));

 	random_ether_addr(node_id);
diff --git a/drivers/usb/serial/io_usbvend.h b/drivers/usb/serial/io_usbvend.h
index f1804fd..b967389 100644
--- a/drivers/usb/serial/io_usbvend.h
+++ b/drivers/usb/serial/io_usbvend.h
@@ -507,10 +507,10 @@ struct edge_manuf_descriptor {

 #define MANUF_BOARD_REV_A		1	// First rev of 251+Netchip design

-#define	MANUF_SERNUM_LENGTH		sizeof(((struct edge_manuf_descriptor *)0)->SerialNumber)
-#define	MANUF_ASSYNUM_LENGTH		sizeof(((struct edge_manuf_descriptor *)0)->AssemblyNumber)
-#define	MANUF_OEMASSYNUM_LENGTH		sizeof(((struct edge_manuf_descriptor *)0)->OemAssyNumber)
-#define	MANUF_MANUFDATE_LENGTH		sizeof(((struct edge_manuf_descriptor *)0)->ManufDate)
+#define	MANUF_SERNUM_LENGTH		FIELD_SIZEOF(struct edge_manuf_descriptor, SerialNumber)
+#define	MANUF_ASSYNUM_LENGTH		FIELD_SIZEOF(struct edge_manuf_descriptor, AssemblyNumber)
+#define	MANUF_OEMASSYNUM_LENGTH		FIELD_SIZEOF(struct edge_manuf_descriptor, OemAssyNumber)
+#define	MANUF_MANUFDATE_LENGTH		FIELD_SIZEOF(struct edge_manuf_descriptor, ManufDate)

 #define	MANUF_ION_CONFIG_DIAG_NO_LOOP	0x20	// As below but no ext loopback test
 #define	MANUF_ION_CONFIG_DIAG		0x40	// 930 based device: 1=Run h/w diags, 0=norm
diff --git a/fs/ext2/xattr.c b/fs/ext2/xattr.c
index 247efd0..bd58220 100644
--- a/fs/ext2/xattr.c
+++ b/fs/ext2/xattr.c
@@ -1024,7 +1024,7 @@ init_ext2_xattr(void)
 {
 	ext2_xattr_cache = mb_cache_create("ext2_xattr", NULL,
 		sizeof(struct mb_cache_entry) +
-		sizeof(((struct mb_cache_entry *) 0)->e_indexes[0]), 1, 6);
+		FIELD_SIZEOF(struct mb_cache_entry, e_indexes[0]), 1, 6);
 	if (!ext2_xattr_cache)
 		return -ENOMEM;
 	return 0;
diff --git a/fs/ext3/xattr.c b/fs/ext3/xattr.c
index 99857a4..0c89380 100644
--- a/fs/ext3/xattr.c
+++ b/fs/ext3/xattr.c
@@ -1299,7 +1299,7 @@ init_ext3_xattr(void)
 {
 	ext3_xattr_cache = mb_cache_create("ext3_xattr", NULL,
 		sizeof(struct mb_cache_entry) +
-		sizeof(((struct mb_cache_entry *) 0)->e_indexes[0]), 1, 6);
+		FIELD_SIZEOF(struct mb_cache_entry, e_indexes[0]), 1, 6);
 	if (!ext3_xattr_cache)
 		return -ENOMEM;
 	return 0;
diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index dc969c3..e52d7f8 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -1299,7 +1299,7 @@ init_ext4_xattr(void)
 {
 	ext4_xattr_cache = mb_cache_create("ext4_xattr", NULL,
 		sizeof(struct mb_cache_entry) +
-		sizeof(((struct mb_cache_entry *) 0)->e_indexes[0]), 1, 6);
+		FIELD_SIZEOF(struct mb_cache_entry, e_indexes[0]), 1, 6);
 	if (!ext4_xattr_cache)
 		return -ENOMEM;
 	return 0;
diff --git a/fs/mbcache.c b/fs/mbcache.c
index deeb9dc..4b987c3 100644
--- a/fs/mbcache.c
+++ b/fs/mbcache.c
@@ -255,7 +255,7 @@ mb_cache_create(const char *name, struct mb_cache_op *cache_op,
 	struct mb_cache *cache = NULL;

 	if(entry_size < sizeof(struct mb_cache_entry) +
-	   indexes_count * sizeof(((struct mb_cache_entry *) 0)->e_indexes[0]))
+	   indexes_count * FIELD_SIZEOF(struct mb_cache_entry, e_indexes[0]))
 		return NULL;

 	cache = kmalloc(sizeof(struct mb_cache) +
diff --git a/include/acpi/actbl.h b/include/acpi/actbl.h
index b125cee..8b9dd97 100644
--- a/include/acpi/actbl.h
+++ b/include/acpi/actbl.h
@@ -317,7 +317,7 @@ struct fadt_descriptor_rev1 {
  * are removed and replaced by a Flags field.
  */
 #define ACPI_FLAG_OFFSET(d,f,o)         (u8) (ACPI_OFFSET (d,f) + \
-			  sizeof(((d *)0)->f) + o)
+			  FIELD_SIZEOF(d, f) + o)
 /*
  * Get the remaining ACPI tables
  */
diff --git a/include/asm-powerpc/fs_pd.h b/include/asm-powerpc/fs_pd.h
index 3d0e819..efb6d55 100644
--- a/include/asm-powerpc/fs_pd.h
+++ b/include/asm-powerpc/fs_pd.h
@@ -29,7 +29,7 @@ static inline int uart_clock(void)
 ({									\
 	u32 offset = offsetof(cpm2_map_t, member);			\
 	void *addr = ioremap (CPM_MAP_ADDR + offset,			\
-			      sizeof( ((cpm2_map_t*)0)->member));	\
+			      FIELD_SIZEOF(cpm2_map_t, member));	\
 	addr;								\
 })

diff --git a/include/net/sctp/sctp.h b/include/net/sctp/sctp.h
index c818f87..d929d18 100644
--- a/include/net/sctp/sctp.h
+++ b/include/net/sctp/sctp.h
@@ -601,7 +601,7 @@ static inline int param_type2af(__be16 type)
 static inline int sctp_sanity_check(void)
 {
 	SCTP_ASSERT(sizeof(struct sctp_ulpevent) <=
-		    sizeof(((struct sk_buff *)0)->cb),
+		    FIELD_SIZEOF(struct sk_buff, cb),
 		    "SCTP: ulpevent does not fit in skb!\n", return 0);

 	return 1;
