Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281199AbRLDRWG>; Tue, 4 Dec 2001 12:22:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282404AbRLDRUv>; Tue, 4 Dec 2001 12:20:51 -0500
Received: from mail203.mail.bellsouth.net ([205.152.58.143]:50080 "EHLO
	imf03bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S281645AbRLDRUQ>; Tue, 4 Dec 2001 12:20:16 -0500
Message-ID: <3C0D05C7.6C566FF2@mandrakesoft.com>
Date: Tue, 04 Dec 2001 12:20:07 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Phillips <phillips@bonn-fries.net>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: Linux/Pro  -- clusters
In-Reply-To: <Pine.LNX.4.10.10112032057070.978-100000@vaio.greennet> <E16BGhe-0000Pq-00@starship.berlin> <3C0CE97F.74AFFDBC@mandrakesoft.com> <E16BJBR-0000RM-00@starship.berlin>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:
> On December 4, 2001 04:19 pm, Jeff Garzik wrote:
> > ug.  what's wrong with a single additional alloc for generic_ip?  [if a
> > filesystem needs to do multiple allocs post-conversion, somebody's doing
> > something wrong]
> 
> Single additional alloc -> twice as many allocs, two slabs, more cachelines
> dirty.  This was hashed out on fsdevel, though apparently not to everyone's
> satisfaction.
> 
> > Using generic_ip in its current form has the advantage of being able to
> > create a nicely-aligned kmem cache for your private inode data.
> 
> I don't see why that's hard with the combined struct.

The advantage of having two structs means that both struct inode and the
private info can be aligned nicely.  Yes it potentially wastes a tiny
bit more memory, but I challenge you to find an architecture where doing
this isn't a win.  In a couple cases I looked at, additional slabs are
not even necessary, as kmalloc's standard ones do the job quite well. 
'cat /proc/slabinfo' for a list of the sizes.

Note this only applies to inodes.  There aren't enough superblocks in a
running system to worry about doing anything but simple kmalloc on the
superblock private info (before assigning to generic_sbp).

	Jeff


-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno

