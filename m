Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933289AbWF0CHg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933289AbWF0CHg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 22:07:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933285AbWF0CHg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 22:07:36 -0400
Received: from 70-57-128-88.albq.qwest.net ([70.57.128.88]:6536 "EHLO
	moria.ionkov.net") by vger.kernel.org with ESMTP id S933289AbWF0CHf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 22:07:35 -0400
Date: Mon, 26 Jun 2006 22:18:56 -0600
From: Latchesar Ionkov <lucho@ionkov.net>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, v9fs-developer@lists.sourceforge.net
Subject: [PATCH] v9fs: return the correct error when interrupted by signal
Message-ID: <20060627041856.GA17321@ionkov.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If a signal interrupts the user process, v9fs sends a flush request to the
file server and waits for its response. It error code is incorrectly set to
the error code of the flush message instead of ERESTARTSYS. The patch sets
the error code to the correct value.

Signed-off-by: Latchesar Ionkov <lucho@ionkov.net>

---
commit c675b970b2befed791fa29f606852e205a009e62
tree 01b2f255baa2245d10e01756e981368a39401669
parent fcc18e83e1f6fd9fa6b333735bf0fcd530655511
author Latchesar Ionkov <lucho@ionkov.net> Mon, 26 Jun 2006 11:06:02 -0600
committer Latchesar Ionkov <lucho@ionkov.net> Mon, 26 Jun 2006 11:06:02 -0600

 fs/9p/mux.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/fs/9p/mux.c b/fs/9p/mux.c
index f4407eb..210d2c0 100644
--- a/fs/9p/mux.c
+++ b/fs/9p/mux.c
@@ -932,6 +932,8 @@ v9fs_mux_rpc(struct v9fs_mux_data *m, st
 					r.rcall || r.err);
 			} while (!r.rcall && !r.err && err==-ERESTARTSYS &&
 				m->trans->status==Connected && !m->err);
+
+			err = -ERESTARTSYS;
 		}
 		sigpending = 1;
 	}

