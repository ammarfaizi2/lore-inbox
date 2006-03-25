Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751018AbWCYEcc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751018AbWCYEcc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 23:32:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750837AbWCYE15
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 23:27:57 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:48316
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1750844AbWCYE1a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 23:27:30 -0500
Date: Fri, 24 Mar 2006 20:27:09 -0800
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk, dgc@sgi.com,
       Nathan Scott <nathans@sgi.com>, Chris Wright <chrisw@sous-sol.org>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 10/20] XFS writeout fix
Message-ID: <20060325042709.GK21260@kroah.com>
References: <20060325041355.180237000@quad.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="xfs-writeout-fix.patch"
In-Reply-To: <20060325042556.GA21260@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
[XFS] Check that a page has dirty buffers before finding it acceptable for
rewrite clustering.  This prevents writing excessive amounts of clean data
when doing random rewrites of a cached file.

Signed-off-by: David Chinner <dgc@sgi.com>
Signed-off-by: Nathan Scott <nathans@sgi.com>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---

 fs/xfs/linux-2.6/xfs_aops.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.16.orig/fs/xfs/linux-2.6/xfs_aops.c
+++ linux-2.6.16/fs/xfs/linux-2.6/xfs_aops.c
@@ -616,7 +616,7 @@ xfs_is_delayed_page(
 				acceptable = (type == IOMAP_UNWRITTEN);
 			else if (buffer_delay(bh))
 				acceptable = (type == IOMAP_DELAY);
-			else if (buffer_mapped(bh))
+			else if (buffer_dirty(bh) && buffer_mapped(bh))
 				acceptable = (type == 0);
 			else
 				break;

--
