Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262777AbTJGUvp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 16:51:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262781AbTJGUvp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 16:51:45 -0400
Received: from fw.osdl.org ([65.172.181.6]:27056 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262777AbTJGUvn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 16:51:43 -0400
Date: Tue, 7 Oct 2003 13:43:05 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: lkml <linux-kernel@vger.kernel.org>, torvalds <torvalds@osdl.org>
Cc: urban@teststation.com
Subject: [PATCH] smbfs/ioctl: warning: unreachable code
Message-Id: <20031007134305.7633bca8.rddunlap@osdl.org>
In-Reply-To: <200310070636.h976agNd019288@cherrypit.pdx.osdl.net>
References: <200310070636.h976agNd019288@cherrypit.pdx.osdl.net>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Oct 2003 23:36:42 -0700 John Cherry <cherry@osdl.org> wrote:

| fs/smbfs/ioctl.c:34: warning: unreachable code at beginning of switch statement



patch_name:	smbfs_ioctl.patch
patch_version:	2003-10-07.13:50:29
author:		Randy.Dunlap <rddunlap@osdl.org>
description:	make statements reachable
product:	Linux
product_versions: 2.6.0-test6-2003.10.07
maintainer:	Urban Widmark (urban@teststation.com)
diffstat:	=
 fs/smbfs/ioctl.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)


diff -Naurp ./fs/smbfs/ioctl.c~smbioc ./fs/smbfs/ioctl.c
--- ./fs/smbfs/ioctl.c~smbioc	2003-10-07 13:12:16.000000000 -0700
+++ ./fs/smbfs/ioctl.c	2003-10-07 13:33:53.000000000 -0700
@@ -31,17 +31,20 @@ smb_ioctl(struct inode *inode, struct fi
 	int result = -EINVAL;
 
 	switch (cmd) {
-		uid16_t uid16 = 0;
-		uid_t uid32 = 0;
 	case SMB_IOC_GETMOUNTUID:
+	{
+		uid16_t uid16 = 0;
 		SET_UID(uid16, server->mnt->mounted_uid);
 		result = put_user(uid16, (uid16_t *) arg);
 		break;
+	}
 	case SMB_IOC_GETMOUNTUID32:
+	{
+		uid_t uid32 = 0;
 		SET_UID(uid32, server->mnt->mounted_uid);
 		result = put_user(uid32, (uid_t *) arg);
 		break;
-
+	}
 	case SMB_IOC_NEWCONN:
 		/* arg is smb_conn_opt, or NULL if no connection was made */
 		if (!arg) {


--
~Randy
