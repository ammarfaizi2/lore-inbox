Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265615AbTL3IDm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 03:03:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265675AbTL3IDm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 03:03:42 -0500
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:49599 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP id S265615AbTL3IDl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 03:03:41 -0500
Date: Tue, 30 Dec 2003 00:03:36 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: linux-kernel@vger.kernel.org
Subject: [RFC][PATCH][2.4] Fix negative diskstats
Message-ID: <20031230080336.GP1882@matchmail.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I noticed that my diskstats were reporting negative numbers, and after a
hint from Andreas Dilger I found the problem.

The variables are unsigned int, but they're being reported as signed in proc.

--- drivers/block/genhd.c.orig	2003-12-29 18:35:35.000000000 -0800
+++ drivers/block/genhd.c	2003-12-29 18:40:11.000000000 -0800
@@ -201,7 +201,7 @@
 
 			disk_round_stats(hd);
 			seq_printf(s, "%4d  %4d %10d %s "
-				      "%d %d %d %d %d %d %d %d %d %d %d\n",
+				      "%u %u %u %u %u %u %u %u %u %u %u\n",
 				      gp->major, n, gp->sizes[n],
 				      disk_name(gp, n, buf),
 				      hd->rd_ios, hd->rd_merges,
