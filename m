Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313070AbSEEP1m>; Sun, 5 May 2002 11:27:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313084AbSEEP1l>; Sun, 5 May 2002 11:27:41 -0400
Received: from fungus.teststation.com ([212.32.186.211]:49929 "EHLO
	fungus.teststation.com") by vger.kernel.org with ESMTP
	id <S313070AbSEEP1l>; Sun, 5 May 2002 11:27:41 -0400
Date: Sun, 5 May 2002 17:27:24 +0200 (CEST)
From: Urban Widmark <urban@teststation.com>
X-X-Sender: <puw@cola.enlightnet.local>
To: "Peter J. Milanese" <peterm@milanese.cc>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: SMBfs / Unicode problem perhaps?
In-Reply-To: <1020611972.3cd54d84bf75d@www.milanese.cc>
Message-ID: <Pine.LNX.4.33.0205051720470.4444-100000@cola.enlightnet.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 5 May 2002, Peter J. Milanese wrote:

> :\ - I am running 2.2.3a... I'll look at those messages and see if there is a
> corelation. Thanks for the tip-

Are you sure your smbmount is 2.2.3a and that you don't have a mix of an
old 2.2.1a install? smbmount from 2.2.3a should not negotiate unicode
unless you told it to ...

You could also try the untested patch below that only enables it if you
also specify "codepage=unicode" as a mount option.

/Urban


diff -urN -X exclude linux-2.5.13-kbuild-orig/fs/smbfs/proc.c linux-2.5.13-kbuild-smbfs/fs/smbfs/proc.c
--- linux-2.5.13-kbuild-orig/fs/smbfs/proc.c	Fri May  3 02:22:42 2002
+++ linux-2.5.13-kbuild-smbfs/fs/smbfs/proc.c	Sun May  5 14:53:08 2002
@@ -979,7 +979,9 @@
 		SB_of(server)->s_maxbytes = ~0ULL >> 1;
 		VERBOSE("LFS enabled\n");
 	}
-	if (server->opt.capabilities & SMB_CAP_UNICODE) {
+	if (server->opt.capabilities & SMB_CAP_UNICODE &&
+	    server->remote_nls == &unicode_table) {
+		/* Only enable unicode if the remote nls is also unicode */
 		server->mnt->flags |= SMB_MOUNT_UNICODE;
 		VERBOSE("Unicode enabled\n");
 	} else {

