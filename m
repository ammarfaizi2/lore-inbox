Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135396AbRDRV53>; Wed, 18 Apr 2001 17:57:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135395AbRDRV5W>; Wed, 18 Apr 2001 17:57:22 -0400
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:42510 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id <S135394AbRDRV5K>; Wed, 18 Apr 2001 17:57:10 -0400
Date: Wed, 18 Apr 2001 23:56:56 +0200
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: Alexander Viro <viro@math.psu.edu>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] proc_mknod() should check the mode parameter
Message-ID: <20010418235656.Q6985@arthur.ubicom.tudelft.nl>
In-Reply-To: <20010418222826.N6985@arthur.ubicom.tudelft.nl> <Pine.GSO.4.21.0104181749060.15153-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.21.0104181749060.15153-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Wed, Apr 18, 2001 at 05:51:08PM -0400
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 18, 2001 at 05:51:08PM -0400, Alexander Viro wrote:
> On Wed, 18 Apr 2001, Erik Mouw wrote:
> > While documenting the procfs interface (more of that later), I came
> > across proc_mknod() which is supposed to be used to create devices in
> > the procfs. IMHO it should therefore check if the mode parameter
> > contains S_IFBLK or S_IFCHR.
> 
> Why? All callers of proc_mknod() are in the kernel and they should
> know better. I could understand
> 	if (....)
> 		BUG();
> but silently doing nothing is really odd.

OK, what about this one:

Index: fs/proc/generic.c
===================================================================
RCS file: /home/erik/cvsroot/elinux/fs/proc/generic.c,v
retrieving revision 1.1.1.16
diff -u -r1.1.1.16 generic.c
--- fs/proc/generic.c	2001/04/08 23:34:42	1.1.1.16
+++ fs/proc/generic.c	2001/04/18 21:55:14
@@ -445,6 +445,9 @@
 	const char *fn = name;
 	int len;
 
+	if (! (S_ISCHR(mode) || S_ISBLK(mode)))
+		BUG();
+
 	if (!parent && xlate_proc_name(name, &parent, &fn) != 0)
 		goto out;
 	len = strlen(fn);


Erik

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
of Electrical Engineering, Faculty of Information Technology and Systems,
Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
