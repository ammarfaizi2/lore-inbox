Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932343AbWFIJNa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932343AbWFIJNa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 05:13:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932336AbWFIJNa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 05:13:30 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:39576 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932295AbWFIJN3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 05:13:29 -0400
Date: Fri, 9 Jun 2006 10:13:27 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Mingming Cao <cmm@us.ibm.com>
Cc: linux-kernel@vger.kernel.org,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-fsdevel@vger.kernel.org
Subject: Re: [RFC 0/13] extents and 48bit ext3
Message-ID: <20060609091327.GA3679@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Mingming Cao <cmm@us.ibm.com>, linux-kernel@vger.kernel.org,
	ext2-devel <ext2-devel@lists.sourceforge.net>,
	linux-fsdevel@vger.kernel.org
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 08, 2006 at 06:20:54PM -0700, Mingming Cao wrote:
> Current ext3 filesystem is limited to 8TB(4k block size), this is
> practically not enough for the increasing need of bigger storage as
> disks in a few years (or even now).
> 
> To address this need, there are co-effort from RedHat, ClusterFS, IBM
> and BULL to move ext3 from 32 bit filesystem to 48 bit filesystem,
> expanding ext3 filesystem limit from 8TB today to 1024 PB. The 48 bit
> ext3 is build on top of extent map changes for ext3, originally from
> Alex Tomas. In short, the new ext3 on-disk extents format is:

What a horrible idea!  The nice things about ext3 are:

 - the rather simple and thus reliable implementation
 - the lack of incompatible ondisk changes

and the block numbers are't the big problem concerning scalability, there's
a lot more to it, like btree(-like) structures in the allocator, parallel
alloocator algorithms and a better allocation group concept.

If you guys want big storage on linux please help improving the filesystems
design for that, e.g. jfs or xfs instead of showhorning it onto ext3 thus
both making ext3 less reliable for us desktop/small server users and not get
the full thing for the big storage people either.

