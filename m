Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750968AbWCYEaH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750968AbWCYEaH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 23:30:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750895AbWCYE2k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 23:28:40 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:7869 "EHLO
	aria.kroah.org") by vger.kernel.org with ESMTP id S1750856AbWCYE2Q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 23:28:16 -0500
Date: Fri, 24 Mar 2006 20:27:56 -0800
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org, torvalds@osdl.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, neilb@suse.de,
       Chris Wright <chrisw@sous-sol.org>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 18/20] DM: Fix bug: BIO_RW_BARRIER requests to md/raid1 hang.
Message-ID: <20060325042756.GS21260@kroah.com>
References: <20060325041355.180237000@quad.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="dm-fix-bug-bio_rw_barrier-requests-to-md-raid1-hang.patch"
In-Reply-To: <20060325042556.GA21260@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Neil Brown <neilb@suse.de>

Both R1BIO_Barrier and R1BIO_Returned are 4 !!!!

This means that barrier requests don't get returned (i.e.  b_endio called)
because it looks like they already have been.

Signed-off-by: Neil Brown <neilb@suse.de>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---

 include/linux/raid/raid1.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.16.orig/include/linux/raid/raid1.h
+++ linux-2.6.16/include/linux/raid/raid1.h
@@ -130,6 +130,6 @@ struct r1bio_s {
  * with failure when last write completes (and all failed).
  * Record that bi_end_io was called with this flag...
  */
-#define	R1BIO_Returned 4
+#define	R1BIO_Returned 6
 
 #endif

--
