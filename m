Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266620AbRGTG1R>; Fri, 20 Jul 2001 02:27:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266629AbRGTG1H>; Fri, 20 Jul 2001 02:27:07 -0400
Received: from pizda.ninka.net ([216.101.162.242]:30850 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S266620AbRGTG05>;
	Fri, 20 Jul 2001 02:26:57 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15191.53042.470246.343943@pizda.ninka.net>
Date: Thu, 19 Jul 2001 23:26:58 -0700 (PDT)
To: Niels Kristian Bech Jensen <nkbj@image.dk>
Cc: "Linux kernel developer's mailing list" 
	<linux-kernel@vger.kernel.org>
Subject: Re: Oops in 2.4.7-pre9.
In-Reply-To: <Pine.LNX.4.33.0107200815230.858-100000@hafnium.nkbj.dk>
In-Reply-To: <Pine.LNX.4.33.0107200815230.858-100000@hafnium.nkbj.dk>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


Niels Kristian Bech Jensen writes:
 > >>EIP; c01467e3 <proc_pid_make_inode+83/b0>   <=====

This should fix it:

--- fs/proc/base.c.~1~	Thu Jul 19 23:02:12 2001
+++ fs/proc/base.c	Thu Jul 19 23:25:28 2001
@@ -670,7 +670,8 @@
 	inode->u.proc_i.task = task;
 	inode->i_uid = 0;
 	inode->i_gid = 0;
-	if (ino == PROC_PID_INO || task->mm->dumpable) {
+	if (ino == PROC_PID_INO ||
+	    (task->mm && task->mm->dumpable)) {
 		inode->i_uid = task->euid;
 		inode->i_gid = task->egid;
 	}
