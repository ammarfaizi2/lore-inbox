Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281649AbRKPXfh>; Fri, 16 Nov 2001 18:35:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281646AbRKPXf2>; Fri, 16 Nov 2001 18:35:28 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:61427 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S281651AbRKPXfP>;
	Fri, 16 Nov 2001 18:35:15 -0500
Date: Fri, 16 Nov 2001 16:33:46 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Michael Peddemors <michael@wizard.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Current Max Swap size? Performance issues
Message-ID: <20011116163346.L1308@lynx.no>
Mail-Followup-To: Michael Peddemors <michael@wizard.ca>,
	linux-kernel@vger.kernel.org
In-Reply-To: <1005948151.10803.18.camel@mistress>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <1005948151.10803.18.camel@mistress>; from michael@wizard.ca on Fri, Nov 16, 2001 at 02:02:31PM -0800
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 16, 2001  14:02 -0800, Michael Peddemors wrote:
> With all of the latest VM, again the question is asked...  Best way to
> set up swap now..
> 
> For 2 GIG memory...
> Channel 0 is RAID 1 SCSI
> Channel 2 is RAID 1+0 SCSI
> Hardware Raid
> 
> Shoudl it be?
> 
> 2 GIG swap partition (Is this still the limit?)

Yes, still the limit.  It turns out that this is not an on-disk format
limit, but rather an in-memory structure limit, in case you cared.  For
non-x86 platforms, there is a different limit.

> Dual 2 GIG swaps on seperate channels?
> Dual 2 GIG swap files on same channel?
> (Assuming that the channel is different than the channel using the bulk
> of I/O)

Well, if you have the hardware for it, obviously separate channels will
be better, as long as you don't get a lot of I/O contention.  If you
put them on the same channel, but different disks, you still will get
some speedup if the swaps are equal priority.  If they are sharing the
same disk, make sure you have different priorities for the swaps, so
that one gets filled before the other, or you will get a LOT of seeking
going on.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

