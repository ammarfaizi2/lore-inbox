Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262968AbTCKQIb>; Tue, 11 Mar 2003 11:08:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262969AbTCKQIa>; Tue, 11 Mar 2003 11:08:30 -0500
Received: from angband.namesys.com ([212.16.7.85]:58256 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S262968AbTCKQI3>; Tue, 11 Mar 2003 11:08:29 -0500
Date: Tue, 11 Mar 2003 19:19:08 +0300
From: Oleg Drokin <green@namesys.com>
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [2.5] Memleak in fs/ufs/util.c
Message-ID: <20030311191908.A4381@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

    There is trivial memleak on error exit path in
    fs/ufs/util.c::_ubh_bread_()
    See the patch attached.

Bye,
    Oleg

===== fs/ufs/util.c 1.9 vs edited =====
--- 1.9/fs/ufs/util.c	Thu May 23 17:19:01 2002
+++ edited/fs/ufs/util.c	Tue Mar 11 19:17:01 2003
@@ -48,6 +48,7 @@
 failed:
 	for (j = 0; j < i; j++)
 		brelse (ubh->bh[j]);
+	kfree(ubh);
 	return NULL;
 }
 
