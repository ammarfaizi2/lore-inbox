Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135348AbRAVXDQ>; Mon, 22 Jan 2001 18:03:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135350AbRAVXDG>; Mon, 22 Jan 2001 18:03:06 -0500
Received: from ha1.rdc2.nsw.optushome.com.au ([203.164.2.50]:29419 "EHLO
	mss.rdc2.nsw.optushome.com.au") by vger.kernel.org with ESMTP
	id <S135348AbRAVXCw>; Mon, 22 Jan 2001 18:02:52 -0500
Message-ID: <3A6CB151.875467B2@optushome.com.au>
Date: Tue, 23 Jan 2001 09:16:49 +1100
From: Glenn McGrath <bug1@optushome.com.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Clausen <clausen@conectiva.com.br>
CC: linux-fsdevel@vger.kernel.org, bug-parted@gnu.org,
        linux-kernel@vger.kernel.org
Subject: Re: Partition IDs in the New World TM
In-Reply-To: <3A6C5D12.99704689@conectiva.com.br>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Clausen wrote:
> 
> Hi all,
> 
> We have roughly 10 different types of partition tables.  We hate
> them, but it looks like they won't be going away for a long time.
> 
> Partition IDs seem to create a lot of confusion.  For example,
> most people use 0x83 for both ext2 and reiserfs, on msdos
> partition tables.  People use "Apple_UNIX_SVR2" for ext2 on
> Mac, etc.
> 
> Linux doesn't really use partition IDs.  Well, not entirely
> true... it's used on Mac's as a heuristic, for finding swap
> devices, etc. - but I think this unnecessary.
> 
> LVM also uses it, but I also think it's unnecessary.
> 
> So, can anyone remember why we have partition IDs?  (as opposed
> to just probing for signatures on the fs)  If new partition table
> types come out (which is happening, believe it or not...), how
> should Linux/fdisk/parted handle IDs?  Should we have one Linux
> type, that we use for everything?  Should we have one type for each
> TYPE of data (file system, swap, logical volume physical device, etc.)?
> 
> Tchau,
> Andrew Clausen
> 

As far as i know partition ID's are only supposed to say what type of
filesystems is on a partition, which is a totally stupid and crappy idea
that makes no sense whatsoever (i feel strongly about this).

Linux filesystems have a filesystem type field in the filesystems
superblock, which is what mount -a tries to use to guess the filesystem,
the problem is that this flag isnt in the same place, so its not as
valuable as it should be.

Have a partition marker to indicate the filesystem is stupid because the
two are totally independent, of course i can format a filesystem of type
0x82 with whatever filesystem i want, and then there is also sorts of
confusion when the partition table says the wrong thing.

In an ideal world the filesystem superblock flag for any filesystem type
would be easy to get to, and then would also be a partition_table flag
magic bit that indicates the type of partition table (i.e. pc_bios,
solaris, bsd, atari/amiga, LVM) with the absence of the partition_type
flag you could assume it was a whole disk and check my reading the
superblock filesystem.

But of course you could never have an idealistic thing such as this
becuase different people would have to agree on one place for the flags.

Glenn
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
