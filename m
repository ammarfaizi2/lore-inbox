Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314012AbSDKHTV>; Thu, 11 Apr 2002 03:19:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314013AbSDKHTU>; Thu, 11 Apr 2002 03:19:20 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:60941 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S314012AbSDKHTT>;
	Thu, 11 Apr 2002 03:19:19 -0400
Message-ID: <3CB538FE.B97F200E@zip.com.au>
Date: Thu, 11 Apr 2002 00:19:26 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Duncan Sands <duncan.sands@math.u-psud.fr>
CC: linux-kernel@vger.kernel.org, Alexander Viro <viro@math.psu.edu>
Subject: Re: 2.5.8-pre3 & ext3: cannot chown
In-Reply-To: <E16vYXu-0000HV-00@baldrick>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Duncan Sands wrote:
> 
> The subject just about says it all.  After 12 hours
> of uptime running 2.5.8-pre3 on an ext3 partition,
> I noticed that changing the owner of a file had no
> effect.  Rebooting with 2.4.18, there was no problem
> in using chown.

How does this look?

--- linux-2.5.8-pre3/fs/open.c	Tue Apr  9 18:16:40 2002
+++ 25/fs/open.c	Thu Apr 11 00:15:09 2002
@@ -524,11 +524,11 @@ static int chown_common(struct dentry * 
 		goto out;
 	newattrs.ia_valid =  ATTR_CTIME;
 	if (user != (uid_t) -1) {
-		newattrs.ia_valid =  ATTR_UID;
+		newattrs.ia_valid |= ATTR_UID;
 		newattrs.ia_uid = user;
 	}
 	if (group != (gid_t) -1) {
-		newattrs.ia_valid =  ATTR_GID;
+		newattrs.ia_valid |= ATTR_GID;
 		newattrs.ia_gid = group;
 	}
 	if (!S_ISDIR(inode->i_mode))

-
