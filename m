Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293628AbSCKGob>; Mon, 11 Mar 2002 01:44:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293631AbSCKGoW>; Mon, 11 Mar 2002 01:44:22 -0500
Received: from angband.namesys.com ([212.16.7.85]:63630 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S293628AbSCKGoH>; Mon, 11 Mar 2002 01:44:07 -0500
Date: Mon, 11 Mar 2002 09:44:01 +0300
From: Oleg Drokin <green@namesys.com>
To: rwhron@earthlink.net
Cc: linux-kernel@vger.kernel.org, sebastian.droege@gmx.de
Subject: Re: Opss! on 2.5.6 with ReiserFS
Message-ID: <20020311094401.B24600@namesys.com>
In-Reply-To: <20020310142609.A22174@rushmore>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="EeQfGwPcQSOJBaQU"
Content-Disposition: inline
In-Reply-To: <20020310142609.A22174@rushmore>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello!

On Sun, Mar 10, 2002 at 02:26:09PM -0500, rwhron@earthlink.net wrote:
> I have got oops at boot time from 2.5.6-pre3 and 2.5.6 on 
> system with reiserfs root filesystem on ide.  Oops occurs
> during attempt to mount /.   No modules in kernel.  
> 2.5.6-pre2 was okay.

This is a known merge problem, attached patch will cure it.

Bye,
    Oleg

--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="00-jdev_bd_merging_fix.diff"

--- linux-2.5.6-pre3/fs/reiserfs/journal.c.orig	Thu Mar  7 12:44:43 2002
+++ linux-2.5.6-pre3/fs/reiserfs/journal.c	Thu Mar  7 13:53:36 2002
@@ -1960,8 +1960,7 @@
       		SB_ONDISK_JOURNAL_DEVICE( super ) ?
 		to_kdev_t(SB_ONDISK_JOURNAL_DEVICE( super )) : super -> s_dev;	
 	/* there is no "jdev" option and journal is on separate device */
-	if( ( !jdev_name || !jdev_name[ 0 ] ) && 
-	    SB_ONDISK_JOURNAL_DEVICE( super ) ) {
+	if( ( !jdev_name || !jdev_name[ 0 ] ) ) {
 		journal -> j_dev_bd = bdget( kdev_t_to_nr( jdev ) );
 		if( journal -> j_dev_bd )
 			result = blkdev_get( journal -> j_dev_bd, 
@@ -1976,9 +1975,6 @@
 		return result;
 	}
 
-	/* no "jdev" option and journal is on the host device */
-	if( !jdev_name || !jdev_name[ 0 ] )
-		return 0;
 	journal -> j_dev_file = filp_open( jdev_name, 0, 0 );
 	if( !IS_ERR( journal -> j_dev_file ) ) {
 		struct inode *jdev_inode;

--EeQfGwPcQSOJBaQU--
