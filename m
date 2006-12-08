Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1947575AbWLIAHg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1947575AbWLIAHg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Dec 2006 19:07:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1947573AbWLIAH0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 19:07:26 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:37504 "EHLO
	sous-sol.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1947526AbWLHX72 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 18:59:28 -0500
Message-Id: <20061208235901.414289000@sous-sol.org>
References: <20061208235751.890503000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Fri, 08 Dec 2006 15:57:55 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, David Miller <davem@davemloft.net>,
       bunk@stusta.de, Al Viro <viro@zeniv.linux.org.uk>
Subject: [patch 04/32] EBTABLES: Verify that ebt_entries have zero ->distinguisher.
Content-Disposition: inline; filename=ebtables-verify-that-ebt_entries-have-zero-distinguisher.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Al Viro <viro@zeniv.linux.org.uk>

We need that for iterator to work; existing check had been too weak.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
 net/bridge/netfilter/ebtables.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- linux-2.6.19.orig/net/bridge/netfilter/ebtables.c
+++ linux-2.6.19/net/bridge/netfilter/ebtables.c
@@ -417,7 +417,7 @@ ebt_check_entry_size_and_hooks(struct eb
 	/* beginning of a new chain
 	   if i == NF_BR_NUMHOOKS it must be a user defined chain */
 	if (i != NF_BR_NUMHOOKS || !(e->bitmask & EBT_ENTRY_OR_ENTRIES)) {
-		if ((e->bitmask & EBT_ENTRY_OR_ENTRIES) != 0) {
+		if (e->bitmask != 0) {
 			/* we make userspace set this right,
 			   so there is no misunderstanding */
 			BUGPRINT("EBT_ENTRY_OR_ENTRIES shouldn't be set "
@@ -500,7 +500,7 @@ ebt_get_udc_positions(struct ebt_entry *
 	int i;
 
 	/* we're only interested in chain starts */
-	if (e->bitmask & EBT_ENTRY_OR_ENTRIES)
+	if (e->bitmask)
 		return 0;
 	for (i = 0; i < NF_BR_NUMHOOKS; i++) {
 		if ((valid_hooks & (1 << i)) == 0)
@@ -550,7 +550,7 @@ ebt_cleanup_entry(struct ebt_entry *e, u
 {
 	struct ebt_entry_target *t;
 
-	if ((e->bitmask & EBT_ENTRY_OR_ENTRIES) == 0)
+	if (e->bitmask == 0)
 		return 0;
 	/* we're done */
 	if (cnt && (*cnt)-- == 0)
@@ -576,7 +576,7 @@ ebt_check_entry(struct ebt_entry *e, str
 	int ret;
 
 	/* don't mess with the struct ebt_entries */
-	if ((e->bitmask & EBT_ENTRY_OR_ENTRIES) == 0)
+	if (e->bitmask == 0)
 		return 0;
 
 	if (e->bitmask & ~EBT_F_MASK) {
@@ -1309,7 +1309,7 @@ static inline int ebt_make_names(struct 
 	char *hlp;
 	struct ebt_entry_target *t;
 
-	if ((e->bitmask & EBT_ENTRY_OR_ENTRIES) == 0)
+	if (e->bitmask == 0)
 		return 0;
 
 	hlp = ubase - base + (char *)e + e->target_offset;

--
