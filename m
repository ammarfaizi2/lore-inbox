Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312771AbSCVRxr>; Fri, 22 Mar 2002 12:53:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312772AbSCVRxi>; Fri, 22 Mar 2002 12:53:38 -0500
Received: from pc1-roms3-0-cust11.bri.cable.ntl.com ([213.105.74.11]:4868 "EHLO
	oakley.chf") by vger.kernel.org with ESMTP id <S312771AbSCVRx3>;
	Fri, 22 Mar 2002 12:53:29 -0500
Date: Fri, 22 Mar 2002 17:53:12 +0000 (GMT)
From: Mike Ricketts <mike@earth.li>
To: Luigi Genoni <kernel@Expansa.sns.it>
cc: linux-kernel@vger.kernel.org, green@namesys.com
Subject: Re: oops mounting reiserFS with 2.5.7
In-Reply-To: <Pine.LNX.4.44.0203220017200.2260-100000@Expansa.sns.it>
Message-ID: <Pine.LNX.4.10.10203221750500.1280-100000@oakley.chf>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Mar 2002, Luigi Genoni wrote:

> Unable to handle kernel NULL pointer dereference at virtual address
> 00000010
> c013415a
> *pde = 00000000
> Oops: 0000
> CPU:    0
> EIP:    0010:[<c013415a>]    Not tainted

I tihnk, although I might well be wrong:

--- linux-2.5.7/fs/reiserfs/journal.c.orig	Tue Mar 12 15:25:27 2002
+++ linux-2.5.7/fs/reiserfs/journal.c	Tue Mar 12 15:26:47 2002
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

-- 
Mike Ricketts <mike@earth.li>                      http://www.earth.li/~mike/

Do you have exactly what I want in a plaid poindexter bar bat??


