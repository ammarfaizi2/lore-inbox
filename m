Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932696AbWFUTjc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932696AbWFUTjc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 15:39:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932705AbWFUTgQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 15:36:16 -0400
Received: from mx1.redhat.com ([66.187.233.31]:31653 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932703AbWFUTgN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 15:36:13 -0400
Date: Wed, 21 Jun 2006 20:36:09 +0100
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, David Teigland <teigland@redhat.com>
Subject: [PATCH 10/15] dm table split_args: handle no input
Message-ID: <20060621193609.GY4521@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	David Teigland <teigland@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Teigland <teigland@redhat.com>

Return sense if dm_split_args is called with a NULL input parameter.

Signed-off-by: David Teigland <teigland@redhat.com>
Signed-off-by: Alasdair G Kergon <agk@redhat.com>

Index: linux-2.6.17/drivers/md/dm-table.c
===================================================================
--- linux-2.6.17.orig/drivers/md/dm-table.c	2006-06-21 16:19:33.000000000 +0100
+++ linux-2.6.17/drivers/md/dm-table.c	2006-06-21 17:17:58.000000000 +0100
@@ -590,6 +590,12 @@ int dm_split_args(int *argc, char ***arg
 	unsigned array_size = 0;
 
 	*argc = 0;
+
+	if (!input) {
+		*argvp = NULL;
+		return 0;
+	}
+
 	argv = realloc_argv(&array_size, argv);
 	if (!argv)
 		return -ENOMEM;
