Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750850AbWCYE3O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750850AbWCYE3O (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 23:29:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750822AbWCYE2r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 23:28:47 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:3005 "EHLO
	aria.kroah.org") by vger.kernel.org with ESMTP id S1750853AbWCYE2I
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 23:28:08 -0500
Date: Fri, 24 Mar 2006 20:27:47 -0800
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org, torvalds@osdl.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, nhorman@tuxdriver.com,
       Chris Wright <chrisw@sous-sol.org>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 16/20] proc: fix duplicate line in /proc/devices
Message-ID: <20060325042747.GQ21260@kroah.com>
References: <20060325041355.180237000@quad.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="proc-fix-duplicate-line-in-proc-devices.patch"
In-Reply-To: <20060325042556.GA21260@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Neil Horman <nhorman@tuxdriver.com>

Fix a duplicate block device line printed after the "Block device" header
in /proc/devices.

Signed-off-by: Neil Horman <nhorman@tuxdriver.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---

 fs/proc/proc_misc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.16.orig/fs/proc/proc_misc.c
+++ linux-2.6.16/fs/proc/proc_misc.c
@@ -312,7 +312,7 @@ static void *devinfo_next(struct seq_fil
 		case BLK_HDR:
 			info->state = BLK_LIST;
 			(*pos)++;
-			break;
+			/*fallthrough*/
 		case BLK_LIST:
 			if (get_blkdev_info(info->blkdev,&idummy,&ndummy)) {
 				/*

--
