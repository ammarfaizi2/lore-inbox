Return-Path: <linux-kernel-owner+w=401wt.eu-S1425564AbWLHP3r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1425564AbWLHP3r (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 10:29:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1425563AbWLHP3r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 10:29:47 -0500
Received: from mx1.redhat.com ([66.187.233.31]:58561 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1425558AbWLHP3q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 10:29:46 -0500
From: David Howells <dhowells@redhat.com>
Subject: [PATCH] WorkStruct: Fix ieee80211-softmac compile problem
Date: Fri, 08 Dec 2006 15:29:36 +0000
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
       dhowells@redhat.com
Message-Id: <20061208152935.24254.46994.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix ieee80211-softmac compile problem where it's using schedule_work() on a
delayed_work struct.

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 net/ieee80211/softmac/ieee80211softmac_assoc.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/net/ieee80211/softmac/ieee80211softmac_assoc.c b/net/ieee80211/softmac/ieee80211softmac_assoc.c
index eec1a1d..e3f37fd 100644
--- a/net/ieee80211/softmac/ieee80211softmac_assoc.c
+++ b/net/ieee80211/softmac/ieee80211softmac_assoc.c
@@ -438,7 +438,7 @@ ieee80211softmac_try_reassoc(struct ieee
 
 	spin_lock_irqsave(&mac->lock, flags);
 	mac->associnfo.associating = 1;
-	schedule_work(&mac->associnfo.work);
+	schedule_delayed_work(&mac->associnfo.work, 0);
 	spin_unlock_irqrestore(&mac->lock, flags);
 }
 
