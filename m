Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932498AbWEBHxE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932498AbWEBHxE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 03:53:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932496AbWEBHxD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 03:53:03 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:991 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932494AbWEBHxC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 03:53:02 -0400
Date: Tue, 2 May 2006 09:57:55 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [patch, 2.6.17-rc3-mm1] fix mm/migrate.c build bug
Message-ID: <20060502075755.GA15416@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=none autolearn=no SpamAssassin version=3.0.3
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

pte_unmap_unlock() takes the pte pointer as an argument.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

Index: linux/mm/migrate.c
===================================================================
--- linux.orig/mm/migrate.c
+++ linux/mm/migrate.c
@@ -177,7 +177,7 @@ static void remove_migration_pte(struct 
 		page_add_file_rmap(new);
 
 out:
-	pte_unmap_unlock(pte, ptl);
+	pte_unmap_unlock(ptep, ptl);
 }
 
 /*
