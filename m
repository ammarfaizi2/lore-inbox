Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264290AbTLQKyr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 05:54:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264292AbTLQKyr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 05:54:47 -0500
Received: from mail.fh-wedel.de ([213.39.232.194]:5864 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S264290AbTLQKyp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 05:54:45 -0500
Date: Wed, 17 Dec 2003 11:53:45 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Mike Fedyk <mfedyk@matchmail.com>, Helge Hafting <helgehaf@aitel.hist.no>,
       jw schultz <jw@pegasys.ws>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: raid0 slower than devices it is assembled of?
Message-ID: <20031217105345.GB30576@wohnheim.fh-wedel.de>
References: <200312151434.54886.adasi@kernel.pl> <20031216040156.GJ12726@pegasys.ws> <3FDF1C03.2020509@aitel.hist.no> <Pine.LNX.4.58.0312160825570.1599@home.osdl.org> <20031216205853.GC1402@matchmail.com> <Pine.LNX.4.58.0312161304390.1599@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.58.0312161304390.1599@home.osdl.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 December 2003 13:11:25 -0800, Linus Torvalds wrote:
> On Tue, 16 Dec 2003, Mike Fedyk wrote:
> >
> > Larger stripes may help in general, but I'd suggest that for raid5 (ie, not
> > raid0), the stripe size should not be enlarged as much.  On many
> > filesystems, a bitmap change, or inode table update shouldn't require
> > reading a large stripe from several drives to complete the pairity
> > calculations.
> 
> Oh, absolutely. I only made the argument as it works for RAID0, ie just
> striping.  There the only downside of a large stripe is the potential for
> a lack of parallelism, but as mentioned, I don't think that downside much
> exists with modern disks - the platter density and throughput (once you've
> seeked to the right place) are so high that there is no point to try to
> parallelise it at the data transfer point.
> 
> The thing you should try to do in parallel is the seeking, not the media
> throughput. And then small stripes hurt you, because they will end up
> seeking in sync.
> 
> For RAID5, you have different issues since the error correction makes
> updates be read-modify-write. At that point there are latency reasons to
> make the blocking be small.

Maybe I don't get it, but shouldn't large stripes help RAID5 as well?
For any write, you do the rmw stuff, so you have two seeks on two
drives, one of which is the parity one.  For RAID0, the same access
would result in one seek on one drive, but no fundamental difference.

With more than three drives, you should be able to parallelize the
seeks on RAID5 as well, shouldn't you?  So the same reasoning wrt long
stripes should apply, unless I'm stupid again.

Jörn

-- 
The competent programmer is fully aware of the strictly limited size of
his own skull; therefore he approaches the programming task in full
humility, and among other things he avoids clever tricks like the plague. 
-- Edsger W. Dijkstra
