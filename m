Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261744AbVEPXjo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261744AbVEPXjo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 19:39:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261312AbVEPXjn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 19:39:43 -0400
Received: from mail.dvmed.net ([216.237.124.58]:27806 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261964AbVEPXja (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 19:39:30 -0400
Message-ID: <42892F2B.8090908@pobox.com>
Date: Mon, 16 May 2005 19:39:23 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
CC: Netdev <netdev@oss.sgi.com>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [git patches] 2.6.x net driver fixes
Content-Type: multipart/mixed;
 boundary="------------050705020706030106060808"
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050705020706030106060808
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Here's a first experimental git push from me.  The git URL is
rsync://rsync.kernel.org/pub/scm/linux/kernel/git/jgarzik/netdev-2.6.git

but it should be noted that I would like you to pull the 'misc-fixes' 
branch.  I'm told that branches are supposed to live in .git/refs/heads, 
so there you will find netdev-2.6.git/refs/heads/misc-fixes.

Does that work?

Changelog and patch for review attached.

	Jeff, still afraid of trying a 'tough' merge



--------------050705020706030106060808
Content-Type: text/plain;
 name="changelog.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="changelog.txt"

commit c8920ba041c8934b29370f5d62ab9ea8f147966b
tree 6e0e12acd812f221906289348bc4e08cd1047df6
parent c4cc26d3310a6614a20e32276228a5d44159fc9b
author Daniel Andersen <daniel@linux-user.net> Fri, 06 May 2005 05:14:09 -0700
committer Jeff Garzik <jgarzik@pobox.com> Mon, 16 May 2005 08:04:29 -0400

[PATCH] wireless: 3CRWE154G72 Kconfig help fix

Version 2 of the 3com OfficeConnect 11g Cardbus Card aka 3CRWE154G72 is not
supported by the prism54 project.  To stop confusion, the kernel
documentation should state so as 3com made a good job hiding the version.

Signed-off-by: Andrew Morton <akpm@osdl.org>

diff -puN drivers/net/wireless/Kconfig~wireless-3crwe154g72-kconfig-help-fix drivers/net/wireless/Kconfig

--------------------------
commit c4cc26d3310a6614a20e32276228a5d44159fc9b
tree 35246410bf048fb6a0aa455b272f2a2933dbacad
parent 99718699f5746cc365f3a9ab4769568a1da97635
author Jiri Benc <jbenc@suse.cz> Wed, 27 Apr 2005 12:48:56 +0200
committer Jeff Garzik <jgarzik@pobox.com> Mon, 16 May 2005 07:18:48 -0400

[PATCH] Typo in tulip driver

This patch fixes a typo in tulip driver in 2.6.12-rc3.

--------------------------
commit 99718699f5746cc365f3a9ab4769568a1da97635
tree 6f8f9ad590b14514ad88c3478328795148c91e46
parent f7a3aae1723e7ffc9c4fcdb489365da7a3d81255
author Geoff Levand <geoffrey.levand@am.sony.com> Fri, 15 Apr 2005 01:20:32 -0700
committer Jeff Garzik <jgarzik@pobox.com> Mon, 16 May 2005 06:44:26 -0400

[PATCH] {PATCH] Fix IBM EMAC driver ioctl bug

Fix IBM EMAC driver ioctl bug.

I found IBM EMAC driver bug.
So mii-tool command print wrong status.

  # mii-tool
  eth0: 10 Mbit, half duplex, no link
  eth1: 10 Mbit, half duplex, no link

I can get correct status on fixed kernel.

  # mii-tool
  eth0: negotiated 100baseTx-FD, link okZZ
  eth1: negotiated 100baseTx-FD, link ok

Hiroaki Fuse

Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com> for CELF

--------------------------
commit f7a3aae1723e7ffc9c4fcdb489365da7a3d81255
tree 2c0a93d730060f63670d3e7f130ee12e26b3ed8f
parent 88d7bd8cb9eb8d64bf7997600b0d64f7834047c5
author Al Viro <viro@www.linux.org.uk> Sun, 03 Apr 2005 09:15:52 +0100
committer Jeff Garzik <jgarzik@pobox.com> Mon, 16 May 2005 06:22:32 -0400

[PATCH] drivers/net/wireless enabled by wrong option

	NET_WIRELESS is only a subset of the stuff in drivers/net/wireless;
NET_RADIO is what covers all of them.
Signed-off-by: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>

--------------------------

--------------050705020706030106060808
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

--- a/drivers/net/Makefile
+++ b/drivers/net/Makefile
@@ -187,7 +187,7 @@ obj-$(CONFIG_TR) += tokenring/
 obj-$(CONFIG_WAN) += wan/
 obj-$(CONFIG_ARCNET) += arcnet/
 obj-$(CONFIG_NET_PCMCIA) += pcmcia/
-obj-$(CONFIG_NET_WIRELESS) += wireless/
+obj-$(CONFIG_NET_RADIO) += wireless/
 obj-$(CONFIG_NET_TULIP) += tulip/
 obj-$(CONFIG_HAMRADIO) += hamradio/
 obj-$(CONFIG_IRDA) += irda/
--- a/drivers/net/ibm_emac/ibm_emac_core.c
+++ b/drivers/net/ibm_emac/ibm_emac_core.c
@@ -1595,7 +1595,7 @@ static struct ethtool_ops emac_ethtool_o
 static int emac_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
 {
 	struct ocp_enet_private *fep = dev->priv;
-	uint *data = (uint *) & rq->ifr_ifru;
+	uint16_t *data = (uint16_t *) & rq->ifr_ifru;
 
 	switch (cmd) {
 	case SIOCGMIIPHY:
--- a/drivers/net/tulip/tulip_core.c
+++ b/drivers/net/tulip/tulip_core.c
@@ -1104,7 +1104,7 @@ static void set_rx_mode(struct net_devic
 			if (entry != 0) {
 				/* Avoid a chip errata by prefixing a dummy entry. Don't do
 				   this on the ULI526X as it triggers a different problem */
-				if (!(tp->chip_id == ULI526X && (tp->revision = 0x40 || tp->revision == 0x50))) {
+				if (!(tp->chip_id == ULI526X && (tp->revision == 0x40 || tp->revision == 0x50))) {
 					tp->tx_buffers[entry].skb = NULL;
 					tp->tx_buffers[entry].mapping = 0;
 					tp->tx_ring[entry].length =
--- a/drivers/net/wireless/Kconfig
+++ b/drivers/net/wireless/Kconfig
@@ -323,7 +323,7 @@ config PRISM54
 	  For a complete list of supported cards visit <http://prism54.org>.
 	  Here is the latest confirmed list of supported cards:
 
-	  3com OfficeConnect 11g Cardbus Card aka 3CRWE154G72
+	  3com OfficeConnect 11g Cardbus Card aka 3CRWE154G72 (version 1)
 	  Allnet ALL0271 PCI Card
 	  Compex WL54G Cardbus Card
 	  Corega CG-WLCB54GT Cardbus Card

--------------050705020706030106060808--
