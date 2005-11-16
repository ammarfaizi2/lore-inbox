Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030245AbVKPI5Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030245AbVKPI5Y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 03:57:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030244AbVKPI5Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 03:57:24 -0500
Received: from rwcrmhc12.comcast.net ([204.127.198.43]:44475 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1030245AbVKPI5X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 03:57:23 -0500
Message-ID: <437AF46E.70400@namesys.com>
Date: Wed, 16 Nov 2005 00:57:18 -0800
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>, vs <vs@thebsh.namesys.com>,
       Andrew Morton <akpm@osdl.org>
Subject: [Fwd: [PATCH 5/8] reiser4-lock-ordering-fix.patch]
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------000301080302010103060709"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000301080302010103060709
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit



--------------000301080302010103060709
Content-Type: message/rfc822;
 name="[PATCH 5/8] reiser4-lock-ordering-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="[PATCH 5/8] reiser4-lock-ordering-fix.patch"

Return-Path: <vs@tribesman.namesys.com>
Delivered-To: reiser@namesys.com
Received: (qmail 24471 invoked from network); 15 Nov 2005 17:00:16 -0000
Received: from ppp83-237-207-83.pppoe.mtu-net.ru (HELO tribesman.namesys.com) (83.237.207.83)
  by thebsh.namesys.com with SMTP; 15 Nov 2005 17:00:16 -0000
Received: by tribesman.namesys.com (Postfix on SuSE Linux 8.0 (i386), from userid 512)
	id 1088E71D997; Tue, 15 Nov 2005 19:59:46 +0300 (MSK)
Date: Tue, 15 Nov 2005 19:59:46 +0300
To: reiser@namesys.com
Subject: [PATCH 5/8] reiser4-lock-ordering-fix.patch
Message-ID: <437A1402.mail7JM11VIDH@tribesman.namesys.com>
User-Agent: nail 10.5 4/27/03
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="1XOTR6C989-=-19LG31SB90-CUT-HERE-1HVBICAKBR-=-IFK233O2IO"
From: vs@tribesman.namesys.com (Vladimir Saveliev)

This is a multi-part message in MIME format.

--1XOTR6C989-=-19LG31SB90-CUT-HERE-1HVBICAKBR-=-IFK233O2IO
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

.

--1XOTR6C989-=-19LG31SB90-CUT-HERE-1HVBICAKBR-=-IFK233O2IO
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="reiser4-lock-ordering-fix.patch"


From: Alex Zarochentsev <zam@namesys.com>

This patch fixes broken lock ordering.

Signed-off-by: Vladimir V. Saveliev <vs@namesys.com>


 fs/reiser4/txnmgr.c |    2 ++
 1 files changed, 2 insertions(+)

diff -puN fs/reiser4/txnmgr.c~reiser4-lock-ordering-fix fs/reiser4/txnmgr.c
--- linux-2.6.14-mm2/fs/reiser4/txnmgr.c~reiser4-lock-ordering-fix	2005-11-15 17:18:42.000000000 +0300
+++ linux-2.6.14-mm2-vs/fs/reiser4/txnmgr.c	2005-11-15 17:18:42.000000000 +0300
@@ -2256,7 +2256,9 @@ static void fuse_not_fused_lock_owners(t
 			spin_lock_atom(atomh);
 		}
 		if (atomh == atomf || !atom_isopen(atomh) || !atom_isopen(atomf)) {
+			spin_unlock_atom(atomf);
 			atom_dec_and_unlock(atomh);
+			spin_lock_atom(atomf);
 			atom_dec_and_unlock(atomf);
 			goto repeat;
 		}

_

--1XOTR6C989-=-19LG31SB90-CUT-HERE-1HVBICAKBR-=-IFK233O2IO--



--------------000301080302010103060709--
