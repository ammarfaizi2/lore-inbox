Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312678AbSCVFv4>; Fri, 22 Mar 2002 00:51:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312679AbSCVFvq>; Fri, 22 Mar 2002 00:51:46 -0500
Received: from angband.namesys.com ([212.16.7.85]:37252 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S312678AbSCVFv3>; Fri, 22 Mar 2002 00:51:29 -0500
Date: Fri, 22 Mar 2002 08:51:28 +0300
From: Oleg Drokin <green@namesys.com>
To: Luigi Genoni <kernel@Expansa.sns.it>
Cc: linux-kernel@vger.kernel.org
Subject: Re: oops at boot with 2.5.7 and i810 (reiserFS related?)
Message-ID: <20020322085128.B6792@namesys.com>
In-Reply-To: <Pine.LNX.4.44.0203211841010.21275-100000@Expansa.sns.it>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="7AUc2qLy4jB3hD7Z"
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello!

On Thu, Mar 21, 2002 at 06:41:49PM +0100, Luigi Genoni wrote:

> It seems that a lot of users had oops mounting reiserFS with 2.5.6, but
> then a patch fixed that. Now I think this patch is in 2.5.7, (it should),
> but there are other changes i think to reiserFS code. So i have other
> oopses.

reiserfs in 2.5.6-pre3 to 2.5.7 have a bug that prevent it from mounting
usual filesystems (filesystems with relocated journals still works,
but I doubt much people use that).
 
> I think this could be a proof of a reiserFS bug.

Sure.

> If people at namesys need it (maybe they already know this, and have a
> patch to try), tomorrow i will post the oop mounting
> reiserFS.

No need for that. See attached patch that I am posting in response to
any such report (so just looking in archives first might help you faster).

Bye,
    Oleg

--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="00-jdev_bd_merging_fix.diff"

--- linux-2.5.6/fs/reiserfs/journal.c.orig	Tue Mar 12 15:25:27 2002
+++ linux-2.5.6/fs/reiserfs/journal.c	Tue Mar 12 15:26:47 2002
@@ -1958,8 +1958,7 @@
       		SB_ONDISK_JOURNAL_DEVICE( super ) ?
 		to_kdev_t(SB_ONDISK_JOURNAL_DEVICE( super )) : super -> s_dev;	
 	/* there is no "jdev" option and journal is on separate device */
-	if( ( !jdev_name || !jdev_name[ 0 ] ) && 
-	    SB_ONDISK_JOURNAL_DEVICE( super ) ) {
+	if( ( !jdev_name || !jdev_name[ 0 ] ) ) {
 		journal -> j_dev_bd = bdget( kdev_t_to_nr( jdev ) );
 		if( journal -> j_dev_bd )
 			result = blkdev_get( journal -> j_dev_bd, 
@@ -1974,9 +1973,6 @@
 		return result;
 	}
 
-	/* no "jdev" option and journal is on the host device */
-	if( !jdev_name || !jdev_name[ 0 ] )
-		return 0;
 	journal -> j_dev_file = filp_open( jdev_name, 0, 0 );
 	if( !IS_ERR( journal -> j_dev_file ) ) {
 		struct inode *jdev_inode;

--7AUc2qLy4jB3hD7Z--
