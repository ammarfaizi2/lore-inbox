Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131954AbRAASQL>; Mon, 1 Jan 2001 13:16:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132081AbRAASQB>; Mon, 1 Jan 2001 13:16:01 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:8036 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S131954AbRAASP4>; Mon, 1 Jan 2001 13:15:56 -0500
Date: Mon, 1 Jan 2001 18:37:29 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: nfs@lists.sourceforge.net, nfs-devel@linux.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: kNFSd maintenance in 2.2.19pre
Message-ID: <20010101183729.C13560@athlon.random>
In-Reply-To: <14913.22373.943123.320678@notabene.cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14913.22373.943123.320678@notabene.cse.unsw.edu.au>; from neilb@cse.unsw.edu.au on Thu, Dec 21, 2000 at 12:05:41PM +1100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 21, 2000 at 12:05:41PM +1100, Neil Brown wrote:
>  So, I have started putting some patches together and they can be
>  found at
>     http://www.cse.unsw.edu.au/~neilb/patches/knfsd-2.2/

I included the interesting ones in my tree.

Here two fixes against the vfs backport:

--- ./fs/nfsd/vfs.c.~1~	Fri Dec 29 18:02:01 2000
+++ ./fs/nfsd/vfs.c	Mon Jan  1 18:09:46 2001
@@ -1603,9 +1603,11 @@
 	eof = !cd.eob;
 
 	if (cd.offset) {
+#ifdef CONFIG_NFSD_V3
 		if (rqstp->rq_vers == 3)
 			(void)enc64(cd.offset, file.f_pos);
 		else
+#endif /* CONFIG_NFSD_V3 */
 			*cd.offset = htonl(file.f_pos);
 	}
 
@@ -1624,6 +1626,7 @@
 	return err;
 
 out_nfserr:
+	up(&inode->i_sem);
 	err = nfserrno(-err);
 	goto out_close;
 }

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
