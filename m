Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262690AbTDNAHI (for <rfc822;willy@w.ods.org>); Sun, 13 Apr 2003 20:07:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262695AbTDNAHI (for <rfc822;linux-kernel-outgoing>);
	Sun, 13 Apr 2003 20:07:08 -0400
Received: from h68-147-110-38.cg.shawcable.net ([68.147.110.38]:46070 "EHLO
	schatzie.adilger.int") by vger.kernel.org with ESMTP
	id S262690AbTDNAHH (for <rfc822;linux-kernel@vger.kernel.org>); Sun, 13 Apr 2003 20:07:07 -0400
Date: Sun, 13 Apr 2003 18:17:10 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Dr. David Alan Gilbert" <gilbertd@treblig.org>,
       Chuck Ebbert <76306.1226@compuserve.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Benefits from computing physical IDE disk geometry?
Message-ID: <20030413181710.A26054@schatzie.adilger.int>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	"Dr. David Alan Gilbert" <gilbertd@treblig.org>,
	Chuck Ebbert <76306.1226@compuserve.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200304131407_MC3-1-3441-57C7@compuserve.com> <20030413182405.GG676@gallifrey> <1050272088.24564.2.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1050272088.24564.2.camel@dhcp22.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Sun, Apr 13, 2003 at 11:14:49PM +0100
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 13, 2003  23:14 +0100, Alan Cox wrote:
> On Sul, 2003-04-13 at 19:24, Dr. David Alan Gilbert wrote:
> > Now given these discs have processors on board isn't it about time
> > someone improved the disc interface standards to push some of the
> > intelligence drivewards?  I guess with enough intelligence the drive
> > could do free block allocation and could do things like copying blocks
> > around for you.
> 
> I wish it would. Most of the research and stuff so far has either put
> the file system into the disk firmware (upgrade hell). Having a disk
> which talked entirely about
> 
> 	read(handle,offset, length)
> 	write(handle, offset, length)
> 	alloc(handle, near_handle, length, otherhints...)
> 
> might well work out rather better.

This is essentially what the Lustre Object Storage Target (OST) protocol
looks like.  The client talks to the OST with "object IDs" and does simple
create/destroy/getattr/setattr operations on the objid.

The data I/O protocol (bulk read/write) can do scatter/gather vector I/O
on one or more objects at a time using objid/offset/range triplets, and
the internal data representation is totally opaque to the client (i.e. no
block numbers are passed around in the API).

One thing that is totally missing from the Linux client-side is the ability
to use a "copy" syscall to copy objects directly between OSTs instead of
having to go through the client.

> It also allows the disk to do fairly major relayout of data as it learns
> usage.

Yes, among other things.  We can do stacking of drivers (e.g. RAID, snapshot,
migration, read caching, etc) without having to change the protocol.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

