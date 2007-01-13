Return-Path: <linux-kernel-owner+w=401wt.eu-S1030352AbXAMJ4g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030352AbXAMJ4g (ORCPT <rfc822;w@1wt.eu>);
	Sat, 13 Jan 2007 04:56:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030506AbXAMJ4f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Jan 2007 04:56:35 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:3217 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1030352AbXAMJ4f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Jan 2007 04:56:35 -0500
Date: Sat, 13 Jan 2007 10:56:29 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>,
       Anderson Briglia <anderson.briglia@indt.org.br>,
       Pierre Ossman <drzeus@drzeus.cx>
Cc: linux-kernel@vger.kernel.org
Subject: [-mm patch] make mmc_sysfs.c:mmc_key_type static
Message-ID: <20070113095628.GJ7469@stusta.de>
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
>  git-mmc.patch
>...
>  git trees
>...


This patch makes the needlessly global struct mmc_key_type static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/mmc/mmc.h       |    1 -
 drivers/mmc/mmc_sysfs.c |    4 +++-
 2 files changed, 3 insertions(+), 2 deletions(-)

--- linux-2.6.20-rc4-mm1/drivers/mmc/mmc.h.old	2007-01-13 08:28:31.000000000 +0100
+++ linux-2.6.20-rc4-mm1/drivers/mmc/mmc.h	2007-01-13 08:28:38.000000000 +0100
@@ -20,7 +20,6 @@
 void mmc_free_host_sysfs(struct mmc_host *host);
 
 /* core-internal data */
-extern struct key_type mmc_key_type;
 struct mmc_key_payload {
 	struct rcu_head	rcu;		/* RCU destructor */
 	unsigned short	datalen;	/* length of this data */
--- linux-2.6.20-rc4-mm1/drivers/mmc/mmc_sysfs.c.old	2007-01-13 08:28:44.000000000 +0100
+++ linux-2.6.20-rc4-mm1/drivers/mmc/mmc_sysfs.c	2007-01-13 08:29:21.000000000 +0100
@@ -66,6 +66,8 @@
 
 static struct device_attribute mmc_dev_attr_scr = MMC_ATTR_RO(scr);
 
+static struct key_type mmc_key_type;
+
 #ifdef	CONFIG_MMC_PASSWORDS
 
 static ssize_t
@@ -432,7 +434,7 @@
 	kfree(mpayload);
 }
 
-struct key_type mmc_key_type = {
+static struct key_type mmc_key_type = {
 	.name		= "mmc",
 	.def_datalen	= MMC_KEYLEN_MAXBYTES,
 	.instantiate	= mmc_key_instantiate,

