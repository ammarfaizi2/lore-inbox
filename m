Return-Path: <linux-kernel-owner+w=401wt.eu-S1751580AbWLLUL0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751580AbWLLUL0 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 15:11:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932255AbWLLULZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 15:11:25 -0500
Received: from mx1.redhat.com ([66.187.233.31]:33830 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751548AbWLLULY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 15:11:24 -0500
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 2/2] WorkStruct: Use bitops-safe direct assignment
Date: Tue, 12 Dec 2006 20:11:17 +0000
To: torvalds@osdl.org, akpm@osdl.org, davem@davemloft.com, matthew@wil.cx
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
       dhowells@redhat.com
Message-Id: <20061212201117.29817.23933.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20061212201112.29817.22041.stgit@warthog.cambridge.redhat.com>
References: <20061212201112.29817.22041.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the direct assignment in set_wq_data() with a bitops-proofed wrapper
(assign_bits()).  This defends against the test_and_set_bit() used to mark a
work item active.

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 kernel/workqueue.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index db49886..f5e9540 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -97,7 +97,7 @@ static inline void set_wq_data(struct wo
 
 	new = (unsigned long) wq | (1UL << WORK_STRUCT_PENDING);
 	new |= work->management & WORK_STRUCT_FLAG_MASK;
-	work->management = new;
+	assign_bits(new, &work->management);
 }
 
 static inline void *get_wq_data(struct work_struct *work)
