Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264898AbTFLREy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 13:04:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264902AbTFLREy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 13:04:54 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:10507 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S264898AbTFLREx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 13:04:53 -0400
Date: Thu, 12 Jun 2003 18:18:37 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Kronos <kronos@kronoz.cjb.net>
Cc: linux-kernel@vger.kernel.org, lord@sgi.com
Subject: Re: [2.5.70][XFS] Sleeping function called from illegal context
Message-ID: <20030612181837.A8344@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Kronos <kronos@kronoz.cjb.net>, linux-kernel@vger.kernel.org,
	lord@sgi.com
References: <20030612170756.GA1357@dreamland.darkstar.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030612170756.GA1357@dreamland.darkstar.lan>; from kronos@kronoz.cjb.net on Thu, Jun 12, 2003 at 07:07:56PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- 1.53/fs/xfs/pagebuf/page_buf.c	Mon May 19 21:00:43 2003
+++ edited/fs/xfs/pagebuf/page_buf.c	Wed Jun 11 21:30:21 2003
@@ -1689,10 +1689,10 @@
 	int			pincount = 0;
 	int			flush_cnt = 0;
 
+	pagebuf_runall_queues(pagebuf_dataio_workqueue);
+
 	spin_lock(&pbd_delwrite_lock);
 	INIT_LIST_HEAD(&tmp);
-
-	pagebuf_runall_queues(pagebuf_dataio_workqueue);
 
 	list_for_each_safe(curr, next, &pbd_delwrite_queue) {
 		pb = list_entry(curr, page_buf_t, pb_list);
