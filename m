Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030302AbWFIQ4k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030302AbWFIQ4k (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 12:56:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030304AbWFIQ4j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 12:56:39 -0400
Received: from mail.clusterfs.com ([206.168.112.78]:19076 "EHLO
	mail.clusterfs.com") by vger.kernel.org with ESMTP id S1030302AbWFIQ4i
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 12:56:38 -0400
Date: Fri, 9 Jun 2006 10:56:43 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Jeff Garzik <jeff@garzik.org>
Cc: Alex Tomas <alex@clusterfs.com>, Christoph Hellwig <hch@infradead.org>,
       linux-fsdevel@vger.kernel.org,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       Mingming Cao <cmm@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
Message-ID: <20060609165643.GA5964@schatzie.adilger.int>
Mail-Followup-To: Jeff Garzik <jeff@garzik.org>,
	Alex Tomas <alex@clusterfs.com>,
	Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org,
	ext2-devel <ext2-devel@lists.sourceforge.net>,
	Mingming Cao <cmm@us.ibm.com>, linux-kernel@vger.kernel.org
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com> <20060609091327.GA3679@infradead.org> <m364jafu3h.fsf@bzzz.home.net> <44898476.80401@garzik.org> <m33beee6tc.fsf@bzzz.home.net> <4489874C.1020108@garzik.org> <m3y7w6cr7d.fsf@bzzz.home.net> <44899113.3070509@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44899113.3070509@garzik.org>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 09, 2006  11:17 -0400, Jeff Garzik wrote:
> Not all users are big production houses that plan their filesystem 
> metadata migration months in advance!  I _guarantee_ some users will 
> boot into ext3-with-extents, use it for a while, and then try to 
> downgrade for whatever reason...  only to find they have been LOCKED 
> OUT.  That is a very real world situation, guys.

Except that the only way that they will get extents is if they read some
documentation that tells them to mount with "-o extents", which will also
say "this is incompatible with older kernels - only use it if you aren't
going to revert to older kernels".  If they try to mount such a filesystem
it will report "trying to mount filesystem with incompatible feature",
and "e2fsprogs" will report "incompatible feature extents - please upgrade
your e2fsprogs" (for versions newer than Nov 2004).


It's a lot better than e.g. the latest ubuntu which (apparently,
I read) can't mount a kernel older than 2.6.15 because of udev (or
sysfs?) changes.  It's better than e.g. reiserfs vs. reiser4 compatibility
(which doesn't exist).  2.4 kernels probably can't mount a new udev root
filesystem because none of the /dev files exist either.  2.4 kernels can't
mount a filesystem that is using device mapper ("LVM 2.0") instead of
"LVM 1.0".  All 2.2 kernel.org kernels couldn't use any system with RAID,
because any distro worth its salt had upgraded the RAID code to a working
(incompatible) version.

Nobody is forcing users to use extents.   Same with large inodes in ext3,
which give a 7x speedup in samba4 performance - did this cause you any
heartburn yet?   Large inodes + fast EAs are available for people who want
to use it for a couple of years already, will soon allow nanosecond times
and maybe one day in the distant future it will become the default but not
yet.  In a few years, the support for extents in ext3 will be pervasive
and most people won't care if they can boot to 2.4.10 or not, and if they
care about this they will also know enough not to enable extents.  The ext3
developers are a very cautious bunch, and don't force anything onto users.


Cheers, Andreas
--
Andreas Dilger
Principal Software Engineer
Cluster File Systems, Inc.

