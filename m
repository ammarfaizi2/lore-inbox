Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262550AbTCIRYv>; Sun, 9 Mar 2003 12:24:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262551AbTCIRYv>; Sun, 9 Mar 2003 12:24:51 -0500
Received: from home.linuxhacker.ru ([194.67.236.68]:9111 "EHLO linuxhacker.ru")
	by vger.kernel.org with ESMTP id <S262550AbTCIRYu>;
	Sun, 9 Mar 2003 12:24:50 -0500
Date: Sun, 9 Mar 2003 20:34:33 +0300
From: Oleg Drokin <green@linuxhacker.ru>
To: alan@redhat.com, linux-kernel@vger.kernel.org
Cc: daniel.pirkl@email.cz
Subject: [2.4] ufs memleak
Message-ID: <20030309173433.GA27217@linuxhacker.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

   Seems there is ufs memleak in 2.4 code. See the patch attached.
   Found with help of smatch + enchanced unfree script.

Bye,
    Oleg
===== fs/ufs/util.c 1.5 vs edited =====
--- 1.5/fs/ufs/util.c	Tue Feb  5 17:10:25 2002
+++ edited/fs/ufs/util.c	Sun Mar  9 17:55:48 2003
@@ -47,6 +47,7 @@
 failed:
 	for (j = 0; j < i; j++)
 		brelse (ubh->bh[j]);
+	kfree(ubh);
 	return NULL;
 }
 
