Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261217AbTI3IXG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 04:23:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261231AbTI3IXG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 04:23:06 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:42117 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S261217AbTI3IXE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 04:23:04 -0400
Date: Tue, 30 Sep 2003 09:22:13 +0100
From: Jamie Lokier <jamie@shareable.org>
To: torvalds@osdl.org
Cc: akpm@zip.com.au, "Hu, Boris" <boris.hu@intel.com>,
       linux-kernel@vger.kernel.org, Hugh Dickins <hugh@veritas.com>,
       Ulrich Drepper <drepper@redhat.com>
Subject: [PATCH] Bumbling follow-on to previous "perfect" futex patch
Message-ID: <20030930082213.GC26649@mail.jlokier.co.uk>
References: <20030930074246.GB26649@mail.jlokier.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030930074246.GB26649@mail.jlokier.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch: futex_refs2-2.6.0-test6

Please apply this on top of the previous patch, titled "Futex waiters
take an mm or inode reference".

Thanks,
-- Jamie


--- dual-2.6.0-test6/kernel/futex.c.before	2003-09-30 06:43:17.000000000 +0100
+++ dual-2.6.0-test6/kernel/futex.c	2003-09-30 09:12:13.457796502 +0100
@@ -444,6 +444,8 @@
 	if (unlikely(list_empty(&q.list))) {
 		/* We were woken already. */
 		spin_unlock(&bh->lock);
+		/* Equivalent to calling unqueue_me() here, but faster. */
+		drop_key_refs(&q.key);
 		return 0;
 	}
 
