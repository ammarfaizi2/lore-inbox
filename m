Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263397AbTDLV5U (for <rfc822;willy@w.ods.org>); Sat, 12 Apr 2003 17:57:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263398AbTDLV5U (for <rfc822;linux-kernel-outgoing>);
	Sat, 12 Apr 2003 17:57:20 -0400
Received: from mail.mplayerhq.hu ([192.190.173.45]:20373 "EHLO
	mail.mplayerhq.hu") by vger.kernel.org with ESMTP id S263397AbTDLV5T (for <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Apr 2003 17:57:19 -0400
Date: Sun, 13 Apr 2003 00:29:58 +0200 (CEST)
From: Szabolcs Berecz <szabi@mplayerhq.hu>
To: <alan@redhat.com>
cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.4.21-pre5-ac3: swapoff on a not attached swapfile
Message-ID: <Pine.LNX.4.33.0304130026520.11406-100000@mail.mplayerhq.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



When swapoff is called with a swapfile which is not attached, it calls
path_release with uninitialized struct nameidata.

Bye,
Szabi


--- linux-2.4.21-pre5-ac3/mm/swapfile.c.orig	Sat Apr 12 15:03:02 2003
+++ linux-2.4.21-pre5-ac3/mm/swapfile.c	Sat Apr 12 23:03:47 2003
@@ -742,7 +742,7 @@
 	err = -EINVAL;
 	if (type < 0) {
 		swap_list_unlock();
-		goto out_dput;
+		goto out_dput_no_nd;
 	}

 	if (prev < 0) {
@@ -798,8 +798,9 @@
 	err = 0;

 out_dput:
-	unlock_kernel();
 	path_release(&nd);
+out_dput_no_nd:
+	unlock_kernel();
 	filp_close(victim, NULL);
 out:
 	putname(tmp);

