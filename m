Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750788AbVKKOV6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750788AbVKKOV6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 09:21:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750789AbVKKOV6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 09:21:58 -0500
Received: from pat.uio.no ([129.240.130.16]:57051 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1750788AbVKKOV5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 09:21:57 -0500
Subject: Re: local denial-of-service with file leases
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Chris Wright <chrisw@osdl.org>
Cc: Avi Kivity <avi@argo.co.il>, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20051111084554.GZ7991@shell0.pdx.osdl.net>
References: <43737CBE.2030005@argo.co.il>
	 <20051111084554.GZ7991@shell0.pdx.osdl.net>
Content-Type: multipart/mixed; boundary="=-LF5bGnG2QEcFsdNbpzSJ"
Date: Fri, 11 Nov 2005 09:21:26 -0500
Message-Id: <1131718887.8805.33.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
X-UiO-Spam-info: not spam, SpamAssassin (score=-2.837, required 12,
	autolearn=disabled, AWL 1.98, FORGED_RCVD_HELO 0.05,
	RCVD_IN_SORBS_DUL 0.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-LF5bGnG2QEcFsdNbpzSJ
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, 2005-11-11 at 00:45 -0800, Chris Wright wrote:
> * Avi Kivity (avi@argo.co.il) wrote:
> > the following program will oom a the 2.6.14.1 kernel, running as an 
> > ordinary user:
> 
> I don't have a good mechanism for testing leases, but this should fix
> the leak.  Mind testing?
> 

Bruce has a simpler patch (see attachment). The call to fasync_helper()
in order to free active structures will have already been done in
locks_delete_lock(), so in principle, all we want to do is to skip the
fasync_helper() call in fcntl_setlease().

Cheers,
  Trond



--=-LF5bGnG2QEcFsdNbpzSJ
Content-Disposition: inline
Content-Description: Attached message - Re: [Fwd: local denial-of-service
	with file leases]
Content-Type: message/rfc822

Received: from exsvl01.hq.netapp.com ([10.56.8.45]) by
	magenta.hq.netapp.com with Microsoft SMTPSVC(6.0.3790.0); Thu, 10 Nov 2005
	16:08:03 -0800
Received: from svlexc02.hq.netapp.com ([10.57.157.136]) by
	exsvl01.hq.netapp.com with Microsoft SMTPSVC(6.0.3790.1830); Thu, 10 Nov
	2005 16:08:03 -0800
Received: from smtp2.corp.netapp.com ([10.57.159.114]) by
	svlexc02.hq.netapp.com with Microsoft SMTPSVC(5.0.2195.6713); Thu, 10 Nov
	2005 16:08:02 -0800
Received: from mx1.netapp.com (mx1.dmz.netapp.com [10.254.64.60]) by
	smtp2.corp.netapp.com (8.13.1/8.13.1/NTAP-1.6) with ESMTP id jAB07q1P002824
	for <Trond.Myklebust@netapp.com>; Thu, 10 Nov 2005 16:08:02 -0800 (PST)
Received: from mail.fieldses.org (HELO pickle.fieldses.org) ([66.93.2.214])
	by mx1.netapp.com with ESMTP; 10 Nov 2005 16:08:03 -0800
X-BrightmailFiltered: true
X-Brightmail-Tracker: AAAAAQAAA+k=
X-IronPort-AV: i="3.99,115,1131350400";  d="scan'208";
	a="266682983:sNHT15928324"
X-SBRS: 4.2
Received: from bfields by pickle.fieldses.org with local (Exim 4.54) id
	1EaMSW-00010t-UY; Thu, 10 Nov 2005 19:08:00 -0500
Date: Thu, 10 Nov 2005 19:08:00 -0500
To: Trond Myklebust <Trond.Myklebust@netapp.com>
Cc: "William A (Andy) Adamson" <andros@umich.edu>
Subject: Re: [Fwd: local denial-of-service with file leases]
Message-ID: <20051111000800.GE31168@fieldses.org>
References: <1131658095.8816.21.camel@lade.trondhjem.org>
	 <20051110225428.GC31168@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051110225428.GC31168@fieldses.org>
User-Agent: Mutt/1.5.11
From: "J. Bruce Fields" <bfields@fieldses.org>
Return-Path: bfields@fieldses.org
X-OriginalArrivalTime: 11 Nov 2005 00:08:02.0654 (UTC)
	FILETIME=[FB8727E0:01C5E653]
X-Evolution-Source: exchange://trond@magenta.hq.netapp.com/
Content-Transfer-Encoding: 7bit

On Thu, Nov 10, 2005 at 05:54:28PM -0500, bfields wrote:
> Sorry, that should ahve been an obvious thing to try after that last
> complaint.  OK, looking....

Yup:

http://linux.bkbits.net:8080/linux-2.6/diffs/fs/locks.c@1.70?nav=index.html|src/|src/fs|hist/fs/locks.c

(Isn't there someone with a complete kernel history in git and a gitweb
interface?  Sure would be convenient.)

This seems to fix it, but I want to investigate a little more tommorow.
--b.


---

 linux-2.6.14-bfields/fs/locks.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -puN fs/locks.c~locks-fix-fasync-leak fs/locks.c
--- linux-2.6.14/fs/locks.c~locks-fix-fasync-leak	2005-11-10 18:49:15.000000000 -0500
+++ linux-2.6.14-bfields/fs/locks.c	2005-11-10 18:50:12.000000000 -0500
@@ -1446,7 +1446,7 @@ int fcntl_setlease(unsigned int fd, stru
 	lock_kernel();
 
 	error = __setlease(filp, arg, &flp);
-	if (error)
+	if (error || arg == F_UNLCK)
 		goto out_unlock;
 
 	error = fasync_helper(fd, filp, 1, &flp->fl_fasync);
_

--=-LF5bGnG2QEcFsdNbpzSJ--

