Return-Path: <linux-kernel-owner+w=401wt.eu-S1161078AbXAELxo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161078AbXAELxo (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 06:53:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161079AbXAELxn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 06:53:43 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:41644 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161076AbXAELxm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 06:53:42 -0500
X-Originating-Ip: 74.109.98.100
Date: Fri, 5 Jan 2007 06:48:33 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
cc: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] Remove unnecessary memset(0) calls after kzalloc() calls.
Message-ID: <Pine.LNX.4.64.0701050640540.24278@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-16.541, required 5, autolearn=not spam, ALL_TRUSTED -1.80,
	BAYES_00 -15.00, SARE_SUB_OBFU_Z 0.26)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  Delete the few remaining unnecessary calls to memset(0) after a call
to kzalloc().

Signed-off-by: Robert P. J. Day <rpjday@mindspring.com>

---

  AFAICT, these are the few remaining instances of this.  if you're
aware of any others, let me know and i can resubmit a revised patch.

 arch/x86_64/kernel/mce_amd.c   |    2 --
 drivers/input/gameport/ns558.c |    1 -
 drivers/pnp/pnpbios/rsparser.c |    1 -
 3 files changed, 4 deletions(-)

diff --git a/arch/x86_64/kernel/mce_amd.c b/arch/x86_64/kernel/mce_amd.c
index fa09deb..93c7072 100644
--- a/arch/x86_64/kernel/mce_amd.c
+++ b/arch/x86_64/kernel/mce_amd.c
@@ -401,7 +401,6 @@ static __cpuinit int allocate_threshold_blocks(unsigned int cpu,
 	b = kzalloc(sizeof(struct threshold_block), GFP_KERNEL);
 	if (!b)
 		return -ENOMEM;
-	memset(b, 0, sizeof(struct threshold_block));

 	b->block = block;
 	b->bank = bank;
@@ -490,7 +489,6 @@ static __cpuinit int threshold_create_bank(unsigned int cpu, unsigned int bank)
 		err = -ENOMEM;
 		goto out;
 	}
-	memset(b, 0, sizeof(struct threshold_bank));

 	kobject_set_name(&b->kobj, "threshold_bank%i", bank);
 	b->kobj.parent = &per_cpu(device_mce, cpu).kobj;
diff --git a/drivers/input/gameport/ns558.c b/drivers/input/gameport/ns558.c
index f68dbe6..7b7a546 100644
--- a/drivers/input/gameport/ns558.c
+++ b/drivers/input/gameport/ns558.c
@@ -151,7 +151,6 @@ static int ns558_isa_probe(int io)
 		return -ENOMEM;
 	}

-	memset(ns558, 0, sizeof(struct ns558));
 	ns558->io = io;
 	ns558->size = 1 << i;
 	ns558->gameport = port;
diff --git a/drivers/pnp/pnpbios/rsparser.c b/drivers/pnp/pnpbios/rsparser.c
index 95b7968..3c2ab83 100644
--- a/drivers/pnp/pnpbios/rsparser.c
+++ b/drivers/pnp/pnpbios/rsparser.c
@@ -530,7 +530,6 @@ pnpbios_parse_compatible_ids(unsigned char *p, unsigned char *end, struct pnp_de
 			dev_id =  kzalloc(sizeof (struct pnp_id), GFP_KERNEL);
 			if (!dev_id)
 				return NULL;
-			memset(dev_id, 0, sizeof(struct pnp_id));
 			pnpid32_to_pnpid(p[1] | p[2] << 8 | p[3] << 16 | p[4] << 24,id);
 			memcpy(&dev_id->id, id, 7);
 			pnp_add_id(dev_id, dev);



