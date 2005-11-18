Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750735AbVKROtf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750735AbVKROtf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 09:49:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750742AbVKROtf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 09:49:35 -0500
Received: from mx1.redhat.com ([66.187.233.31]:62866 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750735AbVKROtf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 09:49:35 -0500
Date: Fri, 18 Nov 2005 14:49:25 +0000
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Kiyoshi Ueda <k-ueda@ct.jp.nec.com>
Subject: [PATCH] device-mapper dm-ioctl: missing put in table load error case
Message-ID: <20051118144925.GG11878@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	Kiyoshi Ueda <k-ueda@ct.jp.nec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

An error path in table_load() forgets to release a table that won't 
now be referenced.

From: Kiyoshi Ueda <k-ueda@ct.jp.nec.com>
Signed-Off-By: Alasdair G Kergon <agk@redhat.com>

Index: linux-2.6.14/drivers/md/dm-ioctl.c
===================================================================
--- linux-2.6.14.orig/drivers/md/dm-ioctl.c	2005-11-14 16:50:11.000000000 +0000
+++ linux-2.6.14/drivers/md/dm-ioctl.c	2005-11-14 16:50:39.000000000 +0000
@@ -974,6 +974,7 @@ static int table_load(struct dm_ioctl *p
 	if (!hc) {
 		DMWARN("device doesn't appear to be in the dev hash table.");
 		up_write(&_hash_lock);
+		dm_table_put(t);
 		return -ENXIO;
 	}
 
