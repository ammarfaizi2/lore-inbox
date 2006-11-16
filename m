Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162259AbWKPCsk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162259AbWKPCsk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 21:48:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162256AbWKPCsg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 21:48:36 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:22664 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1162254AbWKPCsW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 21:48:22 -0500
Message-Id: <20061116024930.261429000@sous-sol.org>
References: <20061116024332.124753000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Wed, 15 Nov 2006 18:44:02 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Steve French <sfrench@us.ibm.com>
Subject: [patch 30/30] CIFS: New POSIX locking code not setting rc properly to zero on successful
Content-Disposition: inline; filename=new-posix-locking-code-not-setting-rc-properly-to-zero-on-successful.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Steve French <sfrench@us.ibm.com>

unlock in case where server does not support POSIX locks and nobrl is
not specified.

Signed-off-by: Steve French <sfrench@us.ibm.com>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
 fs/cifs/file.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index e9c5ba9..ddb012a 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -752,6 +752,7 @@ int cifs_lock(struct file *file, int cmd
 			int stored_rc = 0;
 			struct cifsLockInfo *li, *tmp;
 
+			rc = 0;
 			down(&fid->lock_sem);
 			list_for_each_entry_safe(li, tmp, &fid->llist, llist) {
 				if (pfLock->fl_start <= li->offset &&
@@ -766,7 +767,7 @@ int cifs_lock(struct file *file, int cmd
 					kfree(li);
 				}
 			}
-		up(&fid->lock_sem);
+			up(&fid->lock_sem);
 		}
 	}
 

--
