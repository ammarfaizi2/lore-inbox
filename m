Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262753AbVAQJto@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262753AbVAQJto (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 04:49:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262752AbVAQJtc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 04:49:32 -0500
Received: from ppsw-2.csi.cam.ac.uk ([131.111.8.132]:26588 "EHLO
	ppsw-2.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S262750AbVAQJtX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 04:49:23 -0500
Subject: Re: [RFC] Ext3 nanosecond timestamps in big inodes
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Andreas Dilger <adilger@clusterfs.com>
Cc: Andreas Gruenbacher <agruen@suse.de>, linux-fsdevel@vger.kernel.org,
       lkml <linux-kernel@vger.kernel.org>, Alex Tomas <alex@clusterfs.com>,
       Andrew Tridgell <tridge@samba.org>
In-Reply-To: <20050116054604.GI22715@schnapps.adilger.int>
References: <200501142216.12726.agruen@suse.de>
	 <20050116054604.GI22715@schnapps.adilger.int>
Content-Type: text/plain
Organization: University of Cambridge Computing Service, UK
Date: Mon, 17 Jan 2005 09:49:12 +0000
Message-Id: <1105955352.22856.5.camel@imp.csi.cam.ac.uk>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-01-15 at 22:46 -0700, Andreas Dilger wrote:
> On Jan 14, 2005  22:16 +0100, Andreas Gruenbacher wrote:
> > +static inline struct timespec ext3_current_time(struct inode *inode)
> > +{
> > +	return (inode->i_sb->s_time_gran == 1) ?
> > +	       CURRENT_TIME : CURRENT_TIME_SEC;
> > +}
> 
> If "s_time_gran" (I haven't seen this before but it doesn't appear to
> be a part of your patch) had some useful meaning we could use it to e.g.
> shift the nsec part of the timestamps as Andy requested so as not to make
> the timestamps change too often.

sb->s_time_gran is the granularity used for the time in each fs in
nanoseconds.  So, for example in NTFS it is set to 100 as NTFS stores
time as 100ns intervals.  This means the kernel time can be rounded
appropriately when the fs inode times are being updated.  Without this
you can see inode time jumping backwards in time if the inode is thrown
out of memory and then read in again and in the process it had some of
the time bits truncated...

See the original post of the patch from Andi Kleen for details:

http://marc.theaimsgroup.com/?l=linux-kernel&m=110134111125012&w=2

Best regards,

        Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

