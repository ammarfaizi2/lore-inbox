Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267029AbTCEC0g>; Tue, 4 Mar 2003 21:26:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267038AbTCEC0g>; Tue, 4 Mar 2003 21:26:36 -0500
Received: from bozo.vmware.com ([65.113.40.130]:57100 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id <S267029AbTCEC0d>; Tue, 4 Mar 2003 21:26:33 -0500
Message-ID: <3C77B405ABE6D611A93A00065B3FFBBA36A531@PA-EXCH2>
From: Christopher Li <chrisl@vmware.com>
To: "'Daniel Phillips'" <phillips@arcor.de>,
       "James H. Cloos Jr." <cloos@jhcloos.com>,
       ext2-devel@lists.sourceforge.net
Cc: ext3-users@redhat.com, linux-kernel@vger.kernel.org
Subject: RE: [Ext2-devel] Re: ext3 htree brelse problems look to be fixed!
Date: Tue, 4 Mar 2003 18:36:54 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2655.55)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I post a patch for comment on ext2-devel for the
NFS cookie bug.  Did not get any feedback yet.
As Ted suggested, it set the cookie to -1 on EOF,
even though it is not seek able to there.

I only test it with Stephen's "readdir.c".
Not have chance to run it on a NFS server yet.

Do you have more information about the cache trashing
bug?

Regards,
Chris


===== dir.c 1.5 vs edited =====
--- 1.5/fs/ext3/dir.c	Wed Oct  2 01:24:11 2002
+++ edited/dir.c	Sat Mar  1 23:45:04 2003
@@ -450,8 +450,10 @@
 						   &info->next_hash);
 			if (ret < 0)
 				return ret;
-			if (ret == 0)
+			if (ret == 0) {
+				filp->f_pos = -1;
 				break;
+			}
 			info->curr_node = rb_get_first(&info->root);
 		}
 

> -----Original Message-----
> From: Daniel Phillips [mailto:phillips@arcor.de]
> Sent: Wednesday, March 05, 2003 12:25 AM
> To: James H. Cloos Jr.; ext2-devel@lists.sourceforge.net
> Cc: ext3-users@redhat.com; linux-kernel@vger.kernel.org
> Subject: [Ext2-devel] Re: ext3 htree brelse problems look to be fixed!
> 
> 
> On Wed 05 Mar 03 00:57, James H. Cloos Jr. wrote:
> > I beleive (with this patch) htree is now ready for prime time.
> 
> Good that it's working for you, but it's not quite the last 
> issue.  There is 
> some apparent cache thrashing to track down, and I believe 
> there's still an 
> outstanding NFS issue.  It's getting there, though.
> 
> Regards,
> 
> Daniel
> 
> 
> -------------------------------------------------------
> This SF.net email is sponsored by: Etnus, makers of 
> TotalView, The debugger 
> for complex code. Debugging C/C++ programs can leave you 
> feeling lost and 
> disoriented. TotalView can help you find your way. Available 
> on major UNIX 
> and Linux platforms. Try it free. www.etnus.com
> _______________________________________________
> Ext2-devel mailing list
> Ext2-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ext2-devel
> 

