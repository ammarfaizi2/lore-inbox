Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261779AbTLBKLz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 05:11:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261776AbTLBKLz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 05:11:55 -0500
Received: from mtvcafw.SGI.COM ([192.48.171.6]:35780 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id S261774AbTLBKLw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 05:11:52 -0500
Date: Tue, 2 Dec 2003 21:10:02 +1100
From: Nathan Scott <nathans@sgi.com>
To: Jens Axboe <axboe@suse.de>
Cc: "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>,
       LKML <linux-kernel@vger.kernel.org>,
       Linux-raid maillist <linux-raid@vger.kernel.org>, linux-lvm@sistina.com
Subject: Re: Reproducable OOPS with MD RAID-5 on 2.6.0-test11
Message-ID: <20031202211002.C2009778@wobbly.melbourne.sgi.com>
References: <3FCB4AFB.3090700@backtobasicsmgmt.com> <20031201141144.GD12211@suse.de> <3FCB4CFA.4020302@backtobasicsmgmt.com> <20031201155143.GF12211@suse.de> <3FCC0EE0.9010207@backtobasicsmgmt.com> <20031202082713.GN12211@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20031202082713.GN12211@suse.de>; from axboe@suse.de on Tue, Dec 02, 2003 at 09:27:13AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 02, 2003 at 09:27:13AM +0100, Jens Axboe wrote:
> On Mon, Dec 01 2003, Kevin P. Fleming wrote:
> > 
> > without device-mapper in place, though, and I could not reproduce the 
> > problem! I copied > 500MB of stuff to the XFS filesystem created using 
> > the entire /dev/md/0 device without a single unusual message. I then 
> > unmounted the filesystem and used pvcreate/vgcreate/lvcreate to make a 
> > 3G volume on the array, made an XFS filesystem on it, mounted it, and 
> > tried copying data over. The oops message came back.
> 
> Smells like a bio stacking problem in raid/dm then. I'll take a quick
> look and see if anything obvious pops up, otherwise the maintainers of
> those areas should take a closer look.

One thing that might be of interest - XFS does tend to pass
variable size requests down to the block layer, and this has
tripped up md and other drivers in 2.4 in the distant past.

Log IO is typically 512 byte aligned (as opposed to block or
page size aligned), as are IOs into several of XFS' metadata
structures.

> > I'm copying this message to linux-lvm; the original oops message is 
> > repeated below for the benefit of those list readers. I've got one more 
> > round of testing to do (after the array resyncs itself), which is to try 
> > a filesystem other than XFS.
> 
> That might be a good idea, although it's not very likely to be an XFS
> problem as it happens further down the io stack. It should trigger just
> as happily on IDE or SCSI if that was the case.

I would tend to agree (but will happily fix things if proven
wrong ;) - I took a brief look through dm & md this afternoon
but nothing obvious jumped out at me.  I'm not particularly
familiar with that code though.

cheers.

-- 
Nathan
