Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030368AbWFIXVE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030368AbWFIXVE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 19:21:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030376AbWFIXVE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 19:21:04 -0400
Received: from mail.clusterfs.com ([206.168.112.78]:22420 "EHLO
	mail.clusterfs.com") by vger.kernel.org with ESMTP id S1030301AbWFIXVC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 19:21:02 -0400
Date: Fri, 9 Jun 2006 17:21:08 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Valdis.Kletnieks@vt.edu
Cc: Alex Tomas <alex@clusterfs.com>, Jeff Garzik <jeff@garzik.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Mingming Cao <cmm@us.ibm.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
Message-ID: <20060609232108.GM5964@schatzie.adilger.int>
Mail-Followup-To: Valdis.Kletnieks@vt.edu,
	Alex Tomas <alex@clusterfs.com>, Jeff Garzik <jeff@garzik.org>,
	ext2-devel <ext2-devel@lists.sourceforge.net>,
	linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
	Mingming Cao <cmm@us.ibm.com>, linux-fsdevel@vger.kernel.org
References: <20060609091327.GA3679@infradead.org> <m364jafu3h.fsf@bzzz.home.net> <44898476.80401@garzik.org> <m33beee6tc.fsf@bzzz.home.net> <4489874C.1020108@garzik.org> <m3y7w6cr7d.fsf@bzzz.home.net> <44899113.3070509@garzik.org> <170fa0d20606090921x71719ad3m7f9387ba15413b8f@mail.gmail.com> <m3odx2b86p.fsf@bzzz.home.net> <200606092252.k59Mqc2Q018613@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200606092252.k59Mqc2Q018613@turing-police.cc.vt.edu>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 09, 2006  18:52 -0400, Valdis.Kletnieks@vt.edu wrote:
> On Fri, 09 Jun 2006 20:33:18 +0400, Alex Tomas said:
> > one who needs/wants to go back may get rid of extents by:
> > a) remounting w/o extents option
> > b) copying new-fashion-style files so that copies use blockmap
> > c) dropping extents feature in superblock
> 
> OK.. Obviously my brain is tiny and easily overfilled.

...

> Given that the whole alledged problem with extents is that they're not
> backward compatible, how do you read the files in (b) so that you can copy
> them, if the data is in the non-compatible extents that you can't read because
> you've disabled extents?

You mount with the new kernel without "-o extents", and find files with
extents "lsattr -R /mnt/tmp | awk '/----e / print { $2 }'", copy those
files, mv over old files, unmount.

A similar thing is necessary for ext3 filesystems before you can mount them
as ext2 - they can't be mounted as ext2 until the journal is recovered
(an unrecovered journal is an incompatible feature).

Cheers, Andreas
--
Andreas Dilger
Principal Software Engineer
Cluster File Systems, Inc.

