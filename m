Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135612AbREIG0u>; Wed, 9 May 2001 02:26:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135867AbREIG0l>; Wed, 9 May 2001 02:26:41 -0400
Received: from waulogy.Stanford.EDU ([128.12.53.47]:30731 "EHLO
	waulogy.stanford.edu") by vger.kernel.org with ESMTP
	id <S135612AbREIG01>; Wed, 9 May 2001 02:26:27 -0400
Date: Tue, 8 May 2001 23:24:50 -0700 (PDT)
From: david chan <cat@waulogy.stanford.edu>
To: Linus Torvalds <torvalds@transmeta.com>,
        <emu10k1-devel@opensource.creative.com>,
        Ed Okerson <eokerson@quicknet.net>
cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH] Fixes for Incorrect kmalloc() Sizes
Message-ID: <Pine.LNX.4.30.0105082303170.23207-100000@waulogy.stanford.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

These two patches fix silly kmalloc errors that allocate too little space.


Thank you,
David Chan


---snip---
--- drivers/sound/emu10k1/midi.c.orig	Fri Feb  9 11:30:23 2001
+++ drivers/sound/emu10k1/midi.c	Tue May  8 19:43:43 2001
@@ -56,7 +56,7 @@
 {
 	struct midi_hdr *midihdr;

-	if ((midihdr = (struct midi_hdr *) kmalloc(sizeof(struct midi_hdr
*), GFP_KERNEL)) == NULL) {
+	if ((midihdr = (struct midi_hdr *) kmalloc(sizeof(struct
midi_hdr), GFP_KERNEL)) == NULL) {
 		ERROR();
 		return -EINVAL;
 	}
@@ -328,7 +328,7 @@
 	if (!access_ok(VERIFY_READ, buffer, count))
 		return -EFAULT;

-	if ((midihdr = (struct midi_hdr *) kmalloc(sizeof(struct midi_hdr
*), GFP_KERNEL)) == NULL)
+	if ((midihdr = (struct midi_hdr *) kmalloc(sizeof(struct
midi_hdr), GFP_KERNEL)) == NULL)
 		return -EINVAL;

 	midihdr->bufferlength = count;
---snip---

---snip---
--- drivers/telephony/ixj.c.orig	Tue May  8 20:00:07 2001
+++ drivers/telephony/ixj.c	Tue May  8 20:00:25 2001
@@ -4475,7 +4475,7 @@
 {
 	IXJ_FILTER_CADENCE *lcp;

-	lcp = kmalloc(sizeof(IXJ_CADENCE), GFP_KERNEL);
+	lcp = kmalloc(sizeof(IXJ_FILTER_CADENCE), GFP_KERNEL);
 	if (lcp == NULL)
 		return -ENOMEM;
 	if (copy_from_user(lcp, (char *) cp, sizeof(IXJ_FILTER_CADENCE)))
---snip---




