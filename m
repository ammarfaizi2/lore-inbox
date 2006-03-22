Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751229AbWCVN0M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751229AbWCVN0M (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 08:26:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751232AbWCVN0L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 08:26:11 -0500
Received: from ra.tuxdriver.com ([24.172.12.4]:16651 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S1751229AbWCVN0K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 08:26:10 -0500
Date: Wed, 22 Mar 2006 08:25:58 -0500
From: Neil Horman <nhorman@tuxdriver.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, joe.korty@ccur.com
Subject: [PATCH] proc: fix duplicate line in /proc/devices
Message-ID: <20060322132558.GB29565@hmsreliant.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch to fix a potential duplicate block device line printed after the "Block
device" header in /proc/devices.  Tested and confirmed working by the reporter.

Regards
Neil

Signed-off-by: Neil Horman <nhorman@tuxdriver.com>


 proc_misc.c |    1 -
 1 files changed, 1 deletion(-)


diff --git a/fs/proc/proc_misc.c b/fs/proc/proc_misc.c
index 1d24fea..b097958 100644
--- a/fs/proc/proc_misc.c
+++ b/fs/proc/proc_misc.c
@@ -312,7 +312,6 @@ static void *devinfo_next(struct seq_fil
 		case BLK_HDR:
 			info->state = BLK_LIST;
 			(*pos)++;
-			break;
 		case BLK_LIST:
 			if (get_blkdev_info(info->blkdev,&idummy,&ndummy)) {
 				/*
-- 
/***************************************************
 *Neil Horman
 *Software Engineer
 *gpg keyid: 1024D / 0x92A74FA1 - http://pgp.mit.edu
 ***************************************************/
