Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756344AbWLCQZ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756344AbWLCQZ2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 11:25:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756360AbWLCQZ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 11:25:28 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:43932 "EHLO
	rubicon.netdirect.ca") by vger.kernel.org with ESMTP
	id S1756336AbWLCQZ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 11:25:27 -0500
X-Originating-Ip: 74.109.98.100
Date: Sun, 3 Dec 2006 11:21:51 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH] fs: Convert kmalloc()+memset() combo to kzalloc().
Message-ID: <Pine.LNX.4.64.0612031120110.4371@localhost.localdomain>
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


  Convert all obvious combinations of kmalloc()+memset() to single
kzalloc() in the fs/ directory.

Signed-off-by: Robert P. J. Day <rpjday@mindspring.com>

---

 binfmt_elf_fdpic.c |    3 +--
 seq_file.c         |    3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
index f86d5c9..789c1c6 100644
--- a/fs/binfmt_elf_fdpic.c
+++ b/fs/binfmt_elf_fdpic.c
@@ -709,12 +709,11 @@ #endif
 		return -ELIBBAD;

 	size = sizeof(*loadmap) + nloads * sizeof(*seg);
-	loadmap = kmalloc(size, GFP_KERNEL);
+	loadmap = kzalloc(size, GFP_KERNEL);
 	if (!loadmap)
 		return -ENOMEM;

 	params->loadmap = loadmap;
-	memset(loadmap, 0, size);

 	loadmap->version = ELF32_FDPIC_LOADMAP_VERSION;
 	loadmap->nsegs = nloads;
diff --git a/fs/seq_file.c b/fs/seq_file.c
index 555b9ac..f85feba 100644
--- a/fs/seq_file.c
+++ b/fs/seq_file.c
@@ -31,12 +31,11 @@ int seq_open(struct file *file, struct s
 	struct seq_file *p = file->private_data;

 	if (!p) {
-		p = kmalloc(sizeof(*p), GFP_KERNEL);
+		p = kzalloc(sizeof(*p), GFP_KERNEL);
 		if (!p)
 			return -ENOMEM;
 		file->private_data = p;
 	}
-	memset(p, 0, sizeof(*p));
 	mutex_init(&p->lock);
 	p->op = op;

