Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261898AbUCLBzU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 20:55:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261899AbUCLBzU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 20:55:20 -0500
Received: from 167.100.172.209.cust.nextweb.net ([209.172.100.167]:17661 "EHLO
	STEPCHILD.logwinxp.resilience.com") by vger.kernel.org with ESMTP
	id S261898AbUCLByv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 20:54:51 -0500
Message-ID: <40511868.4060109@usa.net>
Date: Thu, 11 Mar 2004 17:54:48 -0800
From: Eric Brower <ebrower@usa.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] ethtool.h should use userspace-accessible types
Content-Type: multipart/mixed;
 boundary="------------010108000005040207010302"
X-OriginalArrivalTime: 12 Mar 2004 01:54:48.0673 (UTC) FILETIME=[003E5510:01C407D5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010108000005040207010302
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Attached is a patch to 2.4's ethtool.h to use appropriate, 
userspace-accessible data types (__u8 and friends, rather than u8 and 
friends).

I've also posted a patch against ethtool-1.8 to the sf.net gkernel site 
that cleans-up ethtool-copy.h and the rest in the same manner.

My motivation for the patch is to allow a userspace program to cleanly 
call ethtool ioctls without the typedef'ing used within the ethtool 
package.

Please cc me with responses, as I am not subscribed to lkml.

Thanks,
E

--------------010108000005040207010302
Content-Type: text/plain;
 name="2.4_ethtool_types.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.4_ethtool_types.patch"

===== include/linux/ethtool.h 1.18 vs edited =====
--- 1.18/include/linux/ethtool.h	Sun Oct 12 04:18:20 2003
+++ edited/include/linux/ethtool.h	Thu Mar 11 14:02:38 2004
@@ -15,24 +15,24 @@
 
 /* This should work for both 32 and 64 bit userland. */
 struct ethtool_cmd {
-	u32	cmd;
-	u32	supported;	/* Features this interface supports */
-	u32	advertising;	/* Features this interface advertises */
-	u16	speed;		/* The forced speed, 10Mb, 100Mb, gigabit */
-	u8	duplex;		/* Duplex, half or full */
-	u8	port;		/* Which connector port */
-	u8	phy_address;
-	u8	transceiver;	/* Which tranceiver to use */
-	u8	autoneg;	/* Enable or disable autonegotiation */
-	u32	maxtxpkt;	/* Tx pkts before generating tx int */
-	u32	maxrxpkt;	/* Rx pkts before generating rx int */
-	u32	reserved[4];
+	__u32	cmd;
+	__u32	supported;	/* Features this interface supports */
+	__u32	advertising;	/* Features this interface advertises */
+	__u16	speed;		/* The forced speed, 10Mb, 100Mb, gigabit */
+	__u8	duplex;		/* Duplex, half or full */
+	__u8	port;		/* Which connector port */
+	__u8	phy_address;
+	__u8	transceiver;	/* Which tranceiver to use */
+	__u8	autoneg;	/* Enable or disable autonegotiation */
+	__u32	maxtxpkt;	/* Tx pkts before generating tx int */
+	__u32	maxrxpkt;	/* Rx pkts before generating rx int */
+	__u32	reserved[4];
 };
 
 #define ETHTOOL_BUSINFO_LEN	32
 /* these strings are set to whatever the driver author decides... */
 struct ethtool_drvinfo {
-	u32	cmd;
+	__u32	cmd;
 	char	driver[32];	/* driver short name, "tulip", "eepro100" */
 	char	version[32];	/* driver version string */
 	char	fw_version[32];	/* firmware version string, if applicable */
@@ -40,53 +40,53 @@
 				/* For PCI devices, use pci_dev->slot_name. */
 	char	reserved1[32];
 	char	reserved2[16];
-	u32	n_stats;	/* number of u64's from ETHTOOL_GSTATS */
-	u32	testinfo_len;
-	u32	eedump_len;	/* Size of data from ETHTOOL_GEEPROM (bytes) */
-	u32	regdump_len;	/* Size of data from ETHTOOL_GREGS (bytes) */
+	__u32	n_stats;	/* number of __u64's from ETHTOOL_GSTATS */
+	__u32	testinfo_len;
+	__u32	eedump_len;	/* Size of data from ETHTOOL_GEEPROM (bytes) */
+	__u32	regdump_len;	/* Size of data from ETHTOOL_GREGS (bytes) */
 };
 
 #define SOPASS_MAX	6
 /* wake-on-lan settings */
 struct ethtool_wolinfo {
-	u32	cmd;
-	u32	supported;
-	u32	wolopts;
-	u8	sopass[SOPASS_MAX]; /* SecureOn(tm) password */
+	__u32	cmd;
+	__u32	supported;
+	__u32	wolopts;
+	__u8	sopass[SOPASS_MAX]; /* SecureOn(tm) password */
 };
 
 /* for passing single values */
 struct ethtool_value {
-	u32	cmd;
-	u32	data;
+	__u32	cmd;
+	__u32	data;
 };
 
 /* for passing big chunks of data */
 struct ethtool_regs {
-	u32	cmd;
-	u32	version; /* driver-specific, indicates different chips/revs */
-	u32	len; /* bytes */
-	u8	data[0];
+	__u32	cmd;
+	__u32	version; /* driver-specific, indicates different chips/revs */
+	__u32	len; /* bytes */
+	__u8	data[0];
 };
 
 /* for passing EEPROM chunks */
 struct ethtool_eeprom {
-	u32	cmd;
-	u32	magic;
-	u32	offset; /* in bytes */
-	u32	len; /* in bytes */
-	u8	data[0];
+	__u32	cmd;
+	__u32	magic;
+	__u32	offset; /* in bytes */
+	__u32	len; /* in bytes */
+	__u8	data[0];
 };
 
 /* for configuring coalescing parameters of chip */
 struct ethtool_coalesce {
-	u32	cmd;	/* ETHTOOL_{G,S}COALESCE */
+	__u32	cmd;	/* ETHTOOL_{G,S}COALESCE */
 
 	/* How many usecs to delay an RX interrupt after
 	 * a packet arrives.  If 0, only rx_max_coalesced_frames
 	 * is used.
 	 */
-	u32	rx_coalesce_usecs;
+	__u32	rx_coalesce_usecs;
 
 	/* How many packets to delay an RX interrupt after
 	 * a packet arrives.  If 0, only rx_coalesce_usecs is
@@ -94,21 +94,21 @@
 	 * to zero as this would cause RX interrupts to never be
 	 * generated.
 	 */
-	u32	rx_max_coalesced_frames;
+	__u32	rx_max_coalesced_frames;
 
 	/* Same as above two parameters, except that these values
 	 * apply while an IRQ is being serviced by the host.  Not
 	 * all cards support this feature and the values are ignored
 	 * in that case.
 	 */
-	u32	rx_coalesce_usecs_irq;
-	u32	rx_max_coalesced_frames_irq;
+	__u32	rx_coalesce_usecs_irq;
+	__u32	rx_max_coalesced_frames_irq;
 
 	/* How many usecs to delay a TX interrupt after
 	 * a packet is sent.  If 0, only tx_max_coalesced_frames
 	 * is used.
 	 */
-	u32	tx_coalesce_usecs;
+	__u32	tx_coalesce_usecs;
 
 	/* How many packets to delay a TX interrupt after
 	 * a packet is sent.  If 0, only tx_coalesce_usecs is
@@ -116,22 +116,22 @@
 	 * to zero as this would cause TX interrupts to never be
 	 * generated.
 	 */
-	u32	tx_max_coalesced_frames;
+	__u32	tx_max_coalesced_frames;
 
 	/* Same as above two parameters, except that these values
 	 * apply while an IRQ is being serviced by the host.  Not
 	 * all cards support this feature and the values are ignored
 	 * in that case.
 	 */
-	u32	tx_coalesce_usecs_irq;
-	u32	tx_max_coalesced_frames_irq;
+	__u32	tx_coalesce_usecs_irq;
+	__u32	tx_max_coalesced_frames_irq;
 
 	/* How many usecs to delay in-memory statistics
 	 * block updates.  Some drivers do not have an in-memory
 	 * statistic block, and in such cases this value is ignored.
 	 * This value must not be zero.
 	 */
-	u32	stats_block_coalesce_usecs;
+	__u32	stats_block_coalesce_usecs;
 
 	/* Adaptive RX/TX coalescing is an algorithm implemented by
 	 * some drivers to improve latency under low packet rates and
@@ -140,18 +140,18 @@
 	 * not implemented by the driver causes these values to be
 	 * silently ignored.
 	 */
-	u32	use_adaptive_rx_coalesce;
-	u32	use_adaptive_tx_coalesce;
+	__u32	use_adaptive_rx_coalesce;
+	__u32	use_adaptive_tx_coalesce;
 
 	/* When the packet rate (measured in packets per second)
 	 * is below pkt_rate_low, the {rx,tx}_*_low parameters are
 	 * used.
 	 */
-	u32	pkt_rate_low;
-	u32	rx_coalesce_usecs_low;
-	u32	rx_max_coalesced_frames_low;
-	u32	tx_coalesce_usecs_low;
-	u32	tx_max_coalesced_frames_low;
+	__u32	pkt_rate_low;
+	__u32	rx_coalesce_usecs_low;
+	__u32	rx_max_coalesced_frames_low;
+	__u32	tx_coalesce_usecs_low;
+	__u32	tx_max_coalesced_frames_low;
 
 	/* When the packet rate is below pkt_rate_high but above
 	 * pkt_rate_low (both measured in packets per second) the
@@ -162,43 +162,43 @@
 	 * is above pkt_rate_high, the {rx,tx}_*_high parameters are
 	 * used.
 	 */
-	u32	pkt_rate_high;
-	u32	rx_coalesce_usecs_high;
-	u32	rx_max_coalesced_frames_high;
-	u32	tx_coalesce_usecs_high;
-	u32	tx_max_coalesced_frames_high;
+	__u32	pkt_rate_high;
+	__u32	rx_coalesce_usecs_high;
+	__u32	rx_max_coalesced_frames_high;
+	__u32	tx_coalesce_usecs_high;
+	__u32	tx_max_coalesced_frames_high;
 
 	/* How often to do adaptive coalescing packet rate sampling,
 	 * measured in seconds.  Must not be zero.
 	 */
-	u32	rate_sample_interval;
+	__u32	rate_sample_interval;
 };
 
 /* for configuring RX/TX ring parameters */
 struct ethtool_ringparam {
-	u32	cmd;	/* ETHTOOL_{G,S}RINGPARAM */
+	__u32	cmd;	/* ETHTOOL_{G,S}RINGPARAM */
 
 	/* Read only attributes.  These indicate the maximum number
 	 * of pending RX/TX ring entries the driver will allow the
 	 * user to set.
 	 */
-	u32	rx_max_pending;
-	u32	rx_mini_max_pending;
-	u32	rx_jumbo_max_pending;
-	u32	tx_max_pending;
+	__u32	rx_max_pending;
+	__u32	rx_mini_max_pending;
+	__u32	rx_jumbo_max_pending;
+	__u32	tx_max_pending;
 
 	/* Values changeable by the user.  The valid values are
 	 * in the range 1 to the "*_max_pending" counterpart above.
 	 */
-	u32	rx_pending;
-	u32	rx_mini_pending;
-	u32	rx_jumbo_pending;
-	u32	tx_pending;
+	__u32	rx_pending;
+	__u32	rx_mini_pending;
+	__u32	rx_jumbo_pending;
+	__u32	tx_pending;
 };
 
 /* for configuring link flow control parameters */
 struct ethtool_pauseparam {
-	u32	cmd;	/* ETHTOOL_{G,S}PAUSEPARAM */
+	__u32	cmd;	/* ETHTOOL_{G,S}PAUSEPARAM */
 
 	/* If the link is being auto-negotiated (via ethtool_cmd.autoneg
 	 * being true) the user may set 'autonet' here non-zero to have the
@@ -210,9 +210,9 @@
 	 * then {rx,tx}_pause force the driver to use/not-use pause
 	 * flow control.
 	 */
-	u32	autoneg;
-	u32	rx_pause;
-	u32	tx_pause;
+	__u32	autoneg;
+	__u32	rx_pause;
+	__u32	tx_pause;
 };
 
 #define ETH_GSTRING_LEN		32
@@ -223,10 +223,10 @@
 
 /* for passing string sets for data tagging */
 struct ethtool_gstrings {
-	u32	cmd;		/* ETHTOOL_GSTRINGS */
-	u32	string_set;	/* string set id e.c. ETH_SS_TEST, etc*/
-	u32	len;		/* number of strings in the string set */
-	u8	data[0];
+	__u32	cmd;		/* ETHTOOL_GSTRINGS */
+	__u32	string_set;	/* string set id e.c. ETH_SS_TEST, etc*/
+	__u32	len;		/* number of strings in the string set */
+	__u8	data[0];
 };
 
 enum ethtool_test_flags {
@@ -236,28 +236,28 @@
 
 /* for requesting NIC test and getting results*/
 struct ethtool_test {
-	u32	cmd;		/* ETHTOOL_TEST */
-	u32	flags;		/* ETH_TEST_FL_xxx */
-	u32	reserved;
-	u32	len;		/* result length, in number of u64 elements */
-	u64	data[0];
+	__u32	cmd;		/* ETHTOOL_TEST */
+	__u32	flags;		/* ETH_TEST_FL_xxx */
+	__u32	reserved;
+	__u32	len;		/* result length, in number of __u64 elements */
+	__u64	data[0];
 };
 
 /* for dumping NIC-specific statistics */
 struct ethtool_stats {
-	u32	cmd;		/* ETHTOOL_GSTATS */
-	u32	n_stats;	/* number of u64's being returned */
-	u64	data[0];
+	__u32	cmd;		/* ETHTOOL_GSTATS */
+	__u32	n_stats;	/* number of __u64's being returned */
+	__u64	data[0];
 };
 
 struct net_device;
 
 /* Some generic methods drivers may use in their ethtool_ops */
-u32 ethtool_op_get_link(struct net_device *dev);
-u32 ethtool_op_get_tx_csum(struct net_device *dev);
-int ethtool_op_set_tx_csum(struct net_device *dev, u32 data);
-u32 ethtool_op_get_sg(struct net_device *dev);
-int ethtool_op_set_sg(struct net_device *dev, u32 data);
+__u32 ethtool_op_get_link(struct net_device *dev);
+__u32 ethtool_op_get_tx_csum(struct net_device *dev);
+int ethtool_op_set_tx_csum(struct net_device *dev, __u32 data);
+__u32 ethtool_op_get_sg(struct net_device *dev);
+int ethtool_op_set_sg(struct net_device *dev, __u32 data);
 
 /**
  * &ethtool_ops - Alter and report network device settings
@@ -320,31 +320,31 @@
 	void	(*get_regs)(struct net_device *, struct ethtool_regs *, void *);
 	void	(*get_wol)(struct net_device *, struct ethtool_wolinfo *);
 	int	(*set_wol)(struct net_device *, struct ethtool_wolinfo *);
-	u32	(*get_msglevel)(struct net_device *);
-	void	(*set_msglevel)(struct net_device *, u32);
+	__u32	(*get_msglevel)(struct net_device *);
+	void	(*set_msglevel)(struct net_device *, __u32);
 	int	(*nway_reset)(struct net_device *);
-	u32	(*get_link)(struct net_device *);
+	__u32	(*get_link)(struct net_device *);
 	int	(*get_eeprom_len)(struct net_device *);
-	int	(*get_eeprom)(struct net_device *, struct ethtool_eeprom *, u8 *);
-	int	(*set_eeprom)(struct net_device *, struct ethtool_eeprom *, u8 *);
+	int	(*get_eeprom)(struct net_device *, struct ethtool_eeprom *, __u8 *);
+	int	(*set_eeprom)(struct net_device *, struct ethtool_eeprom *, __u8 *);
 	int	(*get_coalesce)(struct net_device *, struct ethtool_coalesce *);
 	int	(*set_coalesce)(struct net_device *, struct ethtool_coalesce *);
 	void	(*get_ringparam)(struct net_device *, struct ethtool_ringparam *);
 	int	(*set_ringparam)(struct net_device *, struct ethtool_ringparam *);
 	void	(*get_pauseparam)(struct net_device *, struct ethtool_pauseparam*);
 	int	(*set_pauseparam)(struct net_device *, struct ethtool_pauseparam*);
-	u32	(*get_rx_csum)(struct net_device *);
-	int	(*set_rx_csum)(struct net_device *, u32);
-	u32	(*get_tx_csum)(struct net_device *);
-	int	(*set_tx_csum)(struct net_device *, u32);
-	u32	(*get_sg)(struct net_device *);
-	int	(*set_sg)(struct net_device *, u32);
+	__u32	(*get_rx_csum)(struct net_device *);
+	int	(*set_rx_csum)(struct net_device *, __u32);
+	__u32	(*get_tx_csum)(struct net_device *);
+	int	(*set_tx_csum)(struct net_device *, __u32);
+	__u32	(*get_sg)(struct net_device *);
+	int	(*set_sg)(struct net_device *, __u32);
 	int	(*self_test_count)(struct net_device *);
-	void	(*self_test)(struct net_device *, struct ethtool_test *, u64 *);
-	void	(*get_strings)(struct net_device *, u32 stringset, u8 *);
-	int	(*phys_id)(struct net_device *, u32);
+	void	(*self_test)(struct net_device *, struct ethtool_test *, __u64 *);
+	void	(*get_strings)(struct net_device *, __u32 stringset, __u8 *);
+	int	(*phys_id)(struct net_device *, __u32);
 	int	(*get_stats_count)(struct net_device *);
-	void	(*get_ethtool_stats)(struct net_device *, struct ethtool_stats *, u64 *);
+	void	(*get_ethtool_stats)(struct net_device *, struct ethtool_stats *, __u64 *);
 };
 
 /* CMDs currently supported */

--------------010108000005040207010302--

