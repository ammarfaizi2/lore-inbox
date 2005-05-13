Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262453AbVEMRcK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262453AbVEMRcK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 13:32:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262454AbVEMRaq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 13:30:46 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:47024 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S262453AbVEMR3v
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 13:29:51 -0400
Subject: Re: [PATCH] namespace.c: fix bind mount from foreign namespace
From: Ram <linuxram@us.ibm.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: viro@parcelfarce.linux.theplanet.co.uk, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <E1DWdn9-0004O2-00@dorka.pomaz.szeredi.hu>
References: <E1DWXeF-00017l-00@dorka.pomaz.szeredi.hu>
	 <20050513170602.GI1150@parcelfarce.linux.theplanet.co.uk>
	 <E1DWdn9-0004O2-00@dorka.pomaz.szeredi.hu>
Content-Type: multipart/mixed; boundary="=-n2Jpu51d1g8nE4H1MZTr"
Organization: IBM 
Message-Id: <1116005355.6248.372.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 13 May 2005 10:29:16 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-n2Jpu51d1g8nE4H1MZTr
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, 2005-05-13 at 10:17, Miklos Szeredi wrote:
> > > Bind mount from a foreign namespace results in
> > 
> > ... -EINVAL
> 
> Wrong answer.  Look again, you wrote the code, so you _should_ know ;)

I guess Al agrees that bind mount from foreign namespace must be
disallowed.

Which means what Jamie pointed to was right. Attached the patch which
fixes it.


> 
> Miklos
> -
> To unsubscribe from this list: send the line "unsubscribe linux-fsdevel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=-n2Jpu51d1g8nE4H1MZTr
Content-Disposition: attachment; filename=bind.patch
Content-Type: text/x-patch; name=bind.patch
Content-Transfer-Encoding: 7bit

--- /home/linux/views/linux-2.6.12-rc4/fs/namespace.c	2005-05-06 23:22:29.000000000 -0700
+++ 2.6.12-rc4/fs/namespace.c	2005-05-13 10:17:19.000000000 -0700
@@ -633,7 +633,7 @@ static int do_loopback(struct nameidata 
 
 	down_write(&current->namespace->sem);
 	err = -EINVAL;
-	if (check_mnt(nd->mnt) && (!recurse || check_mnt(old_nd.mnt))) {
+	if (check_mnt(nd->mnt) && check_mnt(old_nd.mnt)) {
 		err = -ENOMEM;
 		if (recurse)
 			mnt = copy_tree(old_nd.mnt, old_nd.dentry);

--=-n2Jpu51d1g8nE4H1MZTr--

