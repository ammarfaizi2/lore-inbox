Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932277AbWDYSW6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932277AbWDYSW6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 14:22:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932278AbWDYSW6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 14:22:58 -0400
Received: from nz-out-0102.google.com ([64.233.162.199]:55106 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932273AbWDYSW5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 14:22:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:to:cc:subject:message-id:mime-version:content-type:from;
        b=Zm5EUfpLAYae5Q5k8veyBDVkX2azPE+yqgfi2IlKjLwxtJ/kCsbsyPhAMsxAdhUwCMsRM3VlamwhTl2YHswh5guGlZNPr3mxoSzpbvmg5fNcINwnzduKlNers4fSvaJco+LagMo2CNiy3XP8NbyZw9X9b6IzwfDEVb93r+m/Kkc=
Date: Tue, 25 Apr 2006 11:21:37 -0700 (PDT)
To: linux-kernel@vger.kernel.org
cc: akpm@osdl.org
Subject: [PATCH] likely cleanup: remove unlikely for kfree(NULL)
Message-ID: <Pine.LNX.4.64.0604251120420.5810@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
From: Hua Zhong <hzhong@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On my system, it shows about 84K misses and 67K hits. So there are more kfree(NULL) than people realize.

I know some people won't like it, but I think it's not worth the confusion and maintenance burden, so I'm giving it a shot. :-)

Signed-off-by: Hua Zhong <hzhong@gmail.com>

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
diff --git a/mm/slab.c b/mm/slab.c
index e6ef9bd..0fbc854 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -3380,7 +3380,7 @@ void kfree(const void *objp)
  	struct kmem_cache *c;
  	unsigned long flags;

-	if (unlikely(!objp))
+	if (!objp)
  		return;
  	local_irq_save(flags);
  	kfree_debugcheck(objp);
