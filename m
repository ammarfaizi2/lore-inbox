Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751504AbWFJMQS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751504AbWFJMQS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 08:16:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751503AbWFJMQS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 08:16:18 -0400
Received: from thunk.org ([69.25.196.29]:24803 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1751493AbWFJMQR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 08:16:17 -0400
Date: Sat, 10 Jun 2006 08:15:36 -0400
From: Theodore Tso <tytso@mit.edu>
To: Jeff Garzik <jeff@garzik.org>
Cc: "Stephen C. Tweedie" <sct@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Matthew Frost <artusemrys@sbcglobal.net>,
       "ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Mingming Cao <cmm@us.ibm.com>,
       linux-fsdevel@vger.kernel.org, Alex Tomas <alex@clusterfs.com>
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
Message-ID: <20060610121536.GA7300@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Jeff Garzik <jeff@garzik.org>,
	"Stephen C. Tweedie" <sct@redhat.com>,
	Andrew Morton <akpm@osdl.org>,
	Matthew Frost <artusemrys@sbcglobal.net>,
	"ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>, Mingming Cao <cmm@us.ibm.com>,
	linux-fsdevel@vger.kernel.org, Alex Tomas <alex@clusterfs.com>
References: <1149890138.5776.114.camel@sisko.sctweedie.blueyonder.co.uk> <448A07EC.6000409@garzik.org> <20060610004727.GC7749@thunk.org> <448A1BBA.1030103@garzik.org> <20060610013048.GS5964@schatzie.adilger.int> <448A23B2.5080004@garzik.org> <20060610020306.GA449@thunk.org> <448A2A6F.8020301@garzik.org> <20060610025424.GA8536@thunk.org> <448A3863.3060906@garzik.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <448A3863.3060906@garzik.org>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 09, 2006 at 11:11:31PM -0400, Jeff Garzik wrote:
> It's an example of ext2 being bandaided to do something it was never 
> originally designed to do.  If online resizing had been planned from the 
> start, allocating new inode tables on the fly would be trivial, as it is 
> in JFS/NTFS/...

And once again this has *nothing* to do with inode allocation, or
dynamic allocation of inode tables.  Your "performance issue" has to
do with a difference in blocksizes.  If you ext2/3 to pass your silly
test, then upgrade to the latest e2fsprogs and install the following
/etc/mke2fs.conf:

[defaults]
	base_features = sparse_super,filetype,resize_inode,dir_index
	blocksize = 4096
	inode_ratio = 8192

[fs_types]
	small = {
		blocksize = 4096
		inode_ratio = 8192
	}
	floppy = {
		blocksize = 4096
		inode_ratio = 8192
	}

Happy now?

						- Ted
