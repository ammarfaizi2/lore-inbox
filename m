Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285014AbRLKMhS>; Tue, 11 Dec 2001 07:37:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285007AbRLKMhK>; Tue, 11 Dec 2001 07:37:10 -0500
Received: from ausmtp02.au.ibm.COM ([202.135.136.105]:6889 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP
	id <S285014AbRLKMgx>; Tue, 11 Dec 2001 07:36:53 -0500
Subject: PATCH for Max. symbolic links followed in do_follow_link() in fs/namei.c.
To: linux-kernel@vger.kernel.org
Cc: khoa@us.ibm.com, drfickle@us.ibm.com
X-Mailer: Lotus Notes Release 5.0.3 (Intl) 21 March 2000
Message-ID: <OF4DA872C6.DFC17C5B-ON65256B1F.004453D8@in.ibm.com>
From: "R Sreelatha" <rsreelat@in.ibm.com>
Date: Tue, 11 Dec 2001 18:05:02 +0530
X-MIMETrack: Serialize by Router on d23m0062/23/M/IBM(Release 5.0.8 |June 18, 2001) at
 11/12/2001 06:05:06 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

The comments for do_follow_link in fs/namei.c say the maximum number for
recursive symbolic links is 8, but somehow its been modified to 5.
This value used to be 8 before 2.4.12 version of the kernel.
A patch submitted for kernel 2.4.12 has changed the limit for
recursive symlinks (current->link_count) from 8 to 5( but the comment
has not changed).

Here is a patch to revert this number back to 8.
I have not subscribed to lkml.
So,please reply to me at "rsreelat@in.ibm.com".

thanks,
Sreelatha.

diff -u linux-2.4.16/fs/namei.c /home/sree/namei.c

--- linux-2.4.16/fs/namei.c   Tue Dec 11 16:06:18 2001
+++ /home/sree/namei.c   Tue Dec 11 17:37:52 2001
@@ -334,7 +334,7 @@
 static inline int do_follow_link(struct dentry *dentry, struct nameidata
*nd)
 {
     int err;
-    if (current->link_count >= 5)
+    if (current->link_count >= 8)
          goto loop;
     if (current->total_link_count >= 40)
          goto loop;


