Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965024AbWDMXKz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965024AbWDMXKz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 19:10:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965015AbWDMXKB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 19:10:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:51662 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S965012AbWDMXJ3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 19:09:29 -0400
Date: Thu, 13 Apr 2006 16:08:28 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org, torvalds@osdl.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, leonid.i.ananiev@intel.com,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 12/22] ext3: Fix missed mutex unlock
Message-ID: <20060413230828.GM5613@kroah.com>
References: <20060413230141.330705000@quad.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="ext3-fix-missed-mutex-unlock.patch"
In-Reply-To: <20060413230637.GA5613@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------

From: "Ananiev, Leonid I" <leonid.i.ananiev@intel.com>

Missed unlock_super()call is added in error condition code path.

Signed-off-by: Leonid Ananiev <leonid.i.ananiev@intel.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 fs/ext3/resize.c |    1 +
 1 file changed, 1 insertion(+)

--- linux-2.6.16.5.orig/fs/ext3/resize.c
+++ linux-2.6.16.5/fs/ext3/resize.c
@@ -974,6 +974,7 @@ int ext3_group_extend(struct super_block
 	if (o_blocks_count != le32_to_cpu(es->s_blocks_count)) {
 		ext3_warning(sb, __FUNCTION__,
 			     "multiple resizers run on filesystem!");
+		unlock_super(sb);
 		err = -EBUSY;
 		goto exit_put;
 	}

--
