Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272942AbTHEWRm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 18:17:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272950AbTHEWRm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 18:17:42 -0400
Received: from ns.tasking.nl ([195.193.207.2]:14092 "EHLO ns.tasking.nl")
	by vger.kernel.org with ESMTP id S272942AbTHEWRf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 18:17:35 -0400
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
X-Newsreader: knews 1.0b.1
Reply-To: dick.streefland@xs4all.nl (Dick Streefland)
Organization: none
X-Face: "`*@3nW;mP[=Z(!`?W;}cn~3M5O_/vMjX&Pe!o7y?xi@;wnA&Tvx&kjv'N\P&&5Xqf{2CaT 9HXfUFg}Y/TT^?G1j26Qr[TZY%v-1A<3?zpTYD5E759Q?lEoR*U1oj[.9\yg_o.~O.$wj:t(B+Q_?D XX57?U,#b,iM$[zX'I(!'VCQM)N)x~knSj>M*@l}y9(tK\rYwdv%~+&*jV"epphm>|q~?ys:g:K#R" 2PuAzy-N9cKM<Ml/%yPQxpq"Ttm{GzBn-*:;619QM2HLuRX4]~361+,[uFp6f"JF5R`y
From: spam@streefland.xs4all.nl (Dick Streefland)
Subject: [PATCH] autofs4 doesn't expire
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Host: 172.17.1.66
Message-ID: <4b0c.3f302ca5.93873@altium.nl>
Date: Tue, 05 Aug 2003 22:16:05 -0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In linux-2.6.0-test1, lookup_mnt() was changed to increment the ref
count of the returned vfsmount struct. This breaks expiration of
autofs4 mounts, because lookup_mnt() is called in check_vfsmnt()
without decrementing the ref count afterwards. The following patch
fixes this:

--- linux-2.6.0-test2/fs/autofs4/expire.c.orig	2003-07-14 05:36:30.000000000 +0200
+++ linux-2.6.0-test2/fs/autofs4/expire.c	2003-08-05 20:51:57.000000000 +0200
@@ -70,6 +70,7 @@
 	int ret = dentry->d_mounted;
 	struct vfsmount *vfs = lookup_mnt(mnt, dentry);
 
+	mntput(vfs);
 	if (vfs && is_vfsmnt_tree_busy(vfs))
 		ret--;
 	DPRINTK(("check_vfsmnt: ret=%d\n", ret));

-- 
Dick Streefland                    ////               De Bilt
dick.streefland@xs4all.nl         (@ @)       The Netherlands
------------------------------oOO--(_)--OOo------------------

