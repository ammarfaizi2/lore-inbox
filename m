Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261987AbUCDWUo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 17:20:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261984AbUCDWUo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 17:20:44 -0500
Received: from [193.108.190.253] ([193.108.190.253]:33459 "EHLO
	pluto.linuxkonsulent.dk") by vger.kernel.org with ESMTP
	id S261986AbUCDWUl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 17:20:41 -0500
Subject: smbfs patch
From: =?ISO-8859-1?Q?S=F8ren?= Hansen <sh@warma.dk>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Message-Id: <1078438839.10042.6.camel@luke>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 04 Mar 2004 23:20:39 +0100
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed that smbfs no longer respects the "uid" and "gid" mount
options passed to it by mount.(I think it stopped when the server was
upgraded to Samba 3.0. Not sure though, since my client was upgraded to
Linux 2.6.3 at around the same time). I've made this small patch that
fixes it (bear with me, this is my first patch to the kernel :-)  ):

======== Start patch ========
--- kernel-source-2.6.3.orig/fs/smbfs/proc.c    2004-02-19
08:55:44.000000000 +0 000
+++ kernel-source-2.6.3/fs/smbfs/proc.c         2004-03-04
13:56:04.000000000 +0 000
@@ -1834,7 +1834,13 @@
 static void
 smb_finish_dirent(struct smb_sb_info *server, struct smb_fattr *fattr)
 {
-       if (fattr->f_unix)
+
+       if (server->mnt->uid)
+               fattr->f_uid = server->mnt->uid;
+       if (server->mnt->gid)
+               fattr->f_gid = server->mnt->gid;
+
+       if (fattr->f_unix)
                return;
  
        fattr->f_mode = server->mnt->file_mode;
======= End patch ========


-- 
Søren Hansen

