Return-Path: <linux-kernel-owner+w=401wt.eu-S932175AbXAVSRd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932175AbXAVSRd (ORCPT <rfc822;w@1wt.eu>);
	Mon, 22 Jan 2007 13:17:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932180AbXAVSRd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Jan 2007 13:17:33 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:3227 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932175AbXAVSRc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Jan 2007 13:17:32 -0500
Date: Mon, 22 Jan 2007 19:17:37 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Kristian Hoegsberg <krh@redhat.com>
Cc: linux-kernel@vger.kernel.org, Stefan Richter <stefanr@s5r6.in-berlin.de>,
       linux1394-devel@lists.sourceforge.net
Subject: [-mm patch] drivers/firewire/: cleanups
Message-ID: <20070122181736.GU9093@stusta.de>
References: <20070111222627.66bb75ab.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070111222627.66bb75ab.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 11, 2007 at 10:26:27PM -0800, Andrew Morton wrote:
>...
> Changes since 2.6.20-rc3-mm1:
>...
>  git-ieee1394.patch
>...
>  git trees
>...


This patch contains the following cleanups:
- "extern inline" -> "static inline"
- fw-topology.c: make struct fw_node_create static

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/firewire/fw-ohci.c        |    8 ++++----
 drivers/firewire/fw-topology.c    |    2 +-
 drivers/firewire/fw-topology.h    |    6 +++---
 drivers/firewire/fw-transaction.c |    2 +-
 drivers/firewire/fw-transaction.h |    2 +-
 5 files changed, 10 insertions(+), 10 deletions(-)

--- linux-2.6.20-rc4-mm1/drivers/firewire/fw-topology.c.old	2007-01-22 18:27:12.000000000 +0100
+++ linux-2.6.20-rc4-mm1/drivers/firewire/fw-topology.c	2007-01-22 18:27:21.000000000 +0100
@@ -92,7 +92,7 @@
 	return (sid[index] >> shift) & 0x03;
 }
 
-struct fw_node *fw_node_create(u32 sid, int port_count, int color)
+static struct fw_node *fw_node_create(u32 sid, int port_count, int color)
 {
 	struct fw_node *node;
 
--- linux-2.6.20-rc4-mm1/drivers/firewire/fw-transaction.c.old	2007-01-22 18:27:45.000000000 +0100
+++ linux-2.6.20-rc4-mm1/drivers/firewire/fw-transaction.c	2007-01-22 18:27:54.000000000 +0100
@@ -106,7 +106,7 @@
 	}
 }
 
-void
+static void
 fw_fill_packet(struct fw_packet *packet, int tcode, int tlabel,
 	       int node_id, int generation, int speed,
 	       unsigned long long offset, void *payload, size_t length)
--- linux-2.6.20-rc4-mm1/drivers/firewire/fw-transaction.h.old	2007-01-22 18:29:01.000000000 +0100
+++ linux-2.6.20-rc4-mm1/drivers/firewire/fw-transaction.h	2007-01-22 18:29:13.000000000 +0100
@@ -198,7 +198,7 @@
         void *callback_data;
 };
 
-extern inline struct fw_packet *
+static inline struct fw_packet *
 fw_packet(struct list_head *l)
 {
         return list_entry (l, struct fw_packet, link);
--- linux-2.6.20-rc4-mm1/drivers/firewire/fw-topology.h.old	2007-01-22 18:29:39.000000000 +0100
+++ linux-2.6.20-rc4-mm1/drivers/firewire/fw-topology.h	2007-01-22 18:29:43.000000000 +0100
@@ -57,13 +57,13 @@
         struct fw_port ports[0];
 };
 
-extern inline struct fw_node *
+static inline struct fw_node *
 fw_node(struct list_head *l)
 {
         return list_entry (l, struct fw_node, link);
 }
 
-extern inline struct fw_node *
+static inline struct fw_node *
 fw_node_get(struct fw_node *node)
 {
 	atomic_inc(&node->ref_count);
@@ -71,7 +71,7 @@
 	return node;
 }
 
-extern inline void
+static inline void
 fw_node_put(struct fw_node *node)
 {
 	if (atomic_dec_and_test(&node->ref_count))
--- linux-2.6.20-rc4-mm1/drivers/firewire/fw-ohci.c.old	2007-01-22 18:32:58.000000000 +0100
+++ linux-2.6.20-rc4-mm1/drivers/firewire/fw-ohci.c	2007-01-22 18:33:02.000000000 +0100
@@ -147,7 +147,7 @@
 	struct iso_context *ir_context_list;
 };
 
-extern inline struct fw_ohci *fw_ohci(struct fw_card *card)
+static inline struct fw_ohci *fw_ohci(struct fw_card *card)
 {
 	return container_of(card, struct fw_ohci, card);
 }
@@ -174,17 +174,17 @@
 
 static char ohci_driver_name[] = KBUILD_MODNAME;
 
-extern inline void reg_write(const struct fw_ohci *ohci, int offset, u32 data)
+static inline void reg_write(const struct fw_ohci *ohci, int offset, u32 data)
 {
 	writel(data, ohci->registers + offset);
 }
 
-extern inline u32 reg_read(const struct fw_ohci *ohci, int offset)
+static inline u32 reg_read(const struct fw_ohci *ohci, int offset)
 {
 	return readl(ohci->registers + offset);
 }
 
-extern inline void flush_writes(const struct fw_ohci *ohci)
+static inline void flush_writes(const struct fw_ohci *ohci)
 {
 	/* Do a dummy read to flush writes. */
 	reg_read(ohci, OHCI1394_Version);


