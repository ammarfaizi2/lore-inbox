Return-Path: <linux-kernel-owner+w=401wt.eu-S1947467AbWLHXo5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1947467AbWLHXo5 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 18:44:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761289AbWLHXo4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 18:44:56 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:36127 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761287AbWLHXo4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 18:44:56 -0500
X-Originating-Ip: 74.102.209.62
Date: Fri, 8 Dec 2006 18:41:15 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH] kcalloc: Re-order the first two out-of-order args to kcalloc().
Message-ID: <Pine.LNX.4.64.0612081837020.6610@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-16.723, required 5, autolearn=not spam, ALL_TRUSTED -1.80,
	BAYES_00 -15.00, TW_DB 0.08)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  Some calls to kcalloc() appear to have the first two args in the
wrong order.

Signed-off-by: Robert P. J. Day <rpjday@mindspring.com>

---

 drivers/macintosh/smu.c             |    2 +-
 drivers/net/skge.c                  |    2 +-
 drivers/scsi/sym53c8xx_2/sym_hipd.c |    2 +-
 drivers/usb/misc/uss720.c           |    2 +-
 net/sunrpc/svc.c                    |    2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)


diff --git a/drivers/macintosh/smu.c b/drivers/macintosh/smu.c
index 6dde27a..8c36894 100644
--- a/drivers/macintosh/smu.c
+++ b/drivers/macintosh/smu.c
@@ -945,7 +945,7 @@ static struct smu_sdbp_header *smu_creat
 	 */
 	tlen = sizeof(struct property) + len + 18;

-	prop = kcalloc(tlen, 1, GFP_KERNEL);
+	prop = kcalloc(1, tlen, GFP_KERNEL);
 	if (prop == NULL)
 		return NULL;
 	hdr = (struct smu_sdbp_header *)(prop + 1);
diff --git a/drivers/net/skge.c b/drivers/net/skge.c
index b60f045..8a39376 100644
--- a/drivers/net/skge.c
+++ b/drivers/net/skge.c
@@ -749,7 +749,7 @@ static int skge_ring_alloc(struct skge_r
 	struct skge_element *e;
 	int i;

-	ring->start = kcalloc(sizeof(*e), ring->count, GFP_KERNEL);
+	ring->start = kcalloc(ring->count, sizeof(*e), GFP_KERNEL);
 	if (!ring->start)
 		return -ENOMEM;

diff --git a/drivers/scsi/sym53c8xx_2/sym_hipd.c b/drivers/scsi/sym53c8xx_2/sym_hipd.c
index 940fa1e..21cd4c7 100644
--- a/drivers/scsi/sym53c8xx_2/sym_hipd.c
+++ b/drivers/scsi/sym53c8xx_2/sym_hipd.c
@@ -5545,7 +5545,7 @@ int sym_hcb_attach(struct Scsi_Host *sho
 	/*
 	 *  Allocate the array of lists of CCBs hashed by DSA.
 	 */
-	np->ccbh = kcalloc(sizeof(struct sym_ccb **), CCB_HASH_SIZE, GFP_KERNEL);
+	np->ccbh = kcalloc(CCB_HASH_SIZE, sizeof(struct sym_ccb **), GFP_KERNEL);
 	if (!np->ccbh)
 		goto attach_failed;

diff --git a/drivers/usb/misc/uss720.c b/drivers/usb/misc/uss720.c
index 7e8a0ac..0df16f9 100644
--- a/drivers/usb/misc/uss720.c
+++ b/drivers/usb/misc/uss720.c
@@ -705,7 +705,7 @@ static int uss720_probe(struct usb_inter
 	/*
 	 * Allocate parport interface
 	 */
-	if (!(priv = kcalloc(sizeof(struct parport_uss720_private), 1, GFP_KERNEL))) {
+	if (!(priv = kcalloc(1, sizeof(struct parport_uss720_private), GFP_KERNEL))) {
 		usb_put_dev(usbdev);
 		return -ENOMEM;
 	}
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index eb44ec9..1ae79a8 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -308,7 +308,7 @@ __svc_create(struct svc_program *prog, u

 	serv->sv_nrpools = npools;
 	serv->sv_pools =
-		kcalloc(sizeof(struct svc_pool), serv->sv_nrpools,
+		kcalloc(serv->sv_nrpools, sizeof(struct svc_pool),
 			GFP_KERNEL);
 	if (!serv->sv_pools) {
 		kfree(serv);
