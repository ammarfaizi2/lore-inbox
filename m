Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759672AbWLCNfV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759672AbWLCNfV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 08:35:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759671AbWLCNfV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 08:35:21 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:56545 "EHLO
	rubicon.netdirect.ca") by vger.kernel.org with ESMTP
	id S1758660AbWLCNfT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 08:35:19 -0500
X-Originating-Ip: 74.109.98.100
Date: Sun, 3 Dec 2006 08:31:50 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH] kernel: replace "kmalloc+memset" with kzalloc in kernel/
 dir
Message-ID: <Pine.LNX.4.64.0612030829400.3793@localhost.localdomain>
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


  Replace kmalloc()+memset() combination with kzalloc().

Signed-off-by: Robert P. J. Day <rpjday@mindspring.com>

---

 auditfilter.c |    3 +--
 futex.c       |    4 +---
 kexec.c       |    3 +--
 3 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
index 4f40d92..2e896f8 100644
--- a/kernel/auditfilter.c
+++ b/kernel/auditfilter.c
@@ -636,10 +636,9 @@ static struct audit_rule *audit_krule_to
 	struct audit_rule *rule;
 	int i;

-	rule = kmalloc(sizeof(*rule), GFP_KERNEL);
+	rule = kzalloc(sizeof(*rule), GFP_KERNEL);
 	if (unlikely(!rule))
 		return NULL;
-	memset(rule, 0, sizeof(*rule));

 	rule->flags = krule->flags | krule->listnr;
 	rule->action = krule->action;
diff --git a/kernel/futex.c b/kernel/futex.c
index 93ef30b..999bfaf 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -324,12 +324,10 @@ static int refill_pi_state_cache(void)
 	if (likely(current->pi_state_cache))
 		return 0;

-	pi_state = kmalloc(sizeof(*pi_state), GFP_KERNEL);
-
+	pi_state = kzalloc(sizeof(*pi_state), GFP_KERNEL);
 	if (!pi_state)
 		return -ENOMEM;

-	memset(pi_state, 0, sizeof(*pi_state));
 	INIT_LIST_HEAD(&pi_state->list);
 	/* pi_mutex gets initialized later */
 	pi_state->owner = NULL;
diff --git a/kernel/kexec.c b/kernel/kexec.c
index fcdd5d2..d43692c 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -108,11 +108,10 @@ static int do_kimage_alloc(struct kimage

 	/* Allocate a controlling structure */
 	result = -ENOMEM;
-	image = kmalloc(sizeof(*image), GFP_KERNEL);
+	image = kzalloc(sizeof(*image), GFP_KERNEL);
 	if (!image)
 		goto out;

-	memset(image, 0, sizeof(*image));
 	image->head = 0;
 	image->entry = &image->head;
 	image->last_entry = &image->head;
