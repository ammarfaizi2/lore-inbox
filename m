Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275661AbRIZWSj>; Wed, 26 Sep 2001 18:18:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275659AbRIZWS3>; Wed, 26 Sep 2001 18:18:29 -0400
Received: from macau.nmr.mgh.harvard.edu ([132.183.203.95]:45466 "EHLO
	macau.nmr.mgh.harvard.edu") by vger.kernel.org with ESMTP
	id <S275640AbRIZWSN>; Wed, 26 Sep 2001 18:18:13 -0400
Date: Wed, 26 Sep 2001 18:18:34 -0400 (EDT)
From: Paul Raines <raines@nmr.mgh.harvard.edu>
To: <linux-kernel@vger.kernel.org>
Subject: PROBLEM: bug in fs/nfsd/vfs.c
Message-ID: <Pine.LNX.4.33.0109261713590.15189-100000@macau.nmr.mgh.harvard.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tracked down a bug with NFS mishandling group permissions to
the following typo in linux/fs/nfsd/vfs.c where ctime was used
where atime was supposed to be used.  This is still present in
the 2.4.9 release.


*** linux/fs/nfsd/vfs.c.orig	Thu Aug 30 12:55:19 2001
--- linux/fs/nfsd/vfs.c	Thu Aug 30 12:55:27 2001
***************
*** 227,233 ****
  #define	MAX_TOUCH_TIME_ERROR (30*60)
  	if (err
  	    && (iap->ia_valid & BOTH_TIME_SET) == BOTH_TIME_SET
! 	    && iap->ia_mtime == iap->ia_ctime
  	    ) {
  	    /* looks good.  now just make sure time is in the right ballpark.
  	     * solaris, at least, doesn't seem to care what the time request is
--- 227,233 ----
  #define	MAX_TOUCH_TIME_ERROR (30*60)
  	if (err
  	    && (iap->ia_valid & BOTH_TIME_SET) == BOTH_TIME_SET
! 	    && iap->ia_mtime == iap->ia_atime
  	    ) {
  	    /* looks good.  now just make sure time is in the right ballpark.
  	     * solaris, at least, doesn't seem to care what the time request is


-- 
--------------------------------------------------------------
Paul Raines                  email: raines@nmr.mgh.harvard.edu
MGH-NMR Center.              tel:(617)-724-2369
149 (2301) 13th Street       fax:(617)-726-7422
Charlestown, MA 02129	USA


