Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316355AbSFCNUI>; Mon, 3 Jun 2002 09:20:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316434AbSFCNUH>; Mon, 3 Jun 2002 09:20:07 -0400
Received: from [194.78.208.39] ([194.78.208.39]:38759 "EHLO mail.macqel.be")
	by vger.kernel.org with ESMTP id <S316355AbSFCNUF>;
	Mon, 3 Jun 2002 09:20:05 -0400
Message-Id: <200206031318.g53DIpS08552@mail.macqel.be>
Subject: PATCH: smbfs and >2Gb files
To: urban@teststation.com
Date: Mon, 3 Jun 2002 15:18:51 +0200 (CEST)
CC: linux-kernel@vger.kernel.org
From: "Philippe De Muyter" <phdm@macqel.be>
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

One of my workmates created a >2Gb file on a MS-Windows server. That works
perfectly.  He exported the partition and looked at it from another
MS-Windows machine, where he can see the right size.  But when we look
at the file from a linux machine, the reported size is plain wrong (it
is actually the real size on 32-bit, extended to 64 bit as a signed 32 bit
value, thus prefixed with 0xffffffff, and then printed as an unsigned 64 bit
value.).  Not only does `ls -l' not work, but other accesses to the file are
also impossible.

Here is a fix (tested on 2.2.16 and 2.4.18) :

--- include/linux/smb.hbk	Fri May 31 16:43:54 2002
+++ include/linux/smb.h	Fri May 31 17:55:49 2002
@@ -85,7 +85,7 @@
 	uid_t		f_uid;
 	gid_t		f_gid;
 	kdev_t		f_rdev;
-	off_t		f_size;
+	size_t		f_size;
 	time_t		f_atime;
 	time_t		f_mtime;
 	time_t		f_ctime;

Is it possible to incorporate that in the official linux kernel tree ?

Thanks in advance

Philippe De Muyter  phdm@macqel.be  Tel +32 27029044
Macq Electronique SA  rue de l'Aeronef 2  B-1140 Bruxelles  Fax +32 27029077
