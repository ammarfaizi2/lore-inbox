Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283418AbRK2WNJ>; Thu, 29 Nov 2001 17:13:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283421AbRK2WM6>; Thu, 29 Nov 2001 17:12:58 -0500
Received: from enterprise.bidmc.harvard.edu ([134.174.118.50]:35592 "EHLO
	enterprise.bidmc.harvard.edu") by vger.kernel.org with ESMTP
	id <S283418AbRK2WMu>; Thu, 29 Nov 2001 17:12:50 -0500
Message-Id: <200111292212.fATMCoo08605@enterprise.bidmc.harvard.edu>
Content-Type: text/plain; charset=US-ASCII
From: "Kristofer T. Karas" <ktk@enterprise.bidmc.harvard.edu>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.16: hda9: attempt to access beyond end of device
Date: Thu, 29 Nov 2001 17:12:47 -0500
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <20011129225814.A464@fmi.uni-passau.de>
In-Reply-To: <20011129225814.A464@fmi.uni-passau.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 29 November 2001 04:58 pm, M G Berberich wrote:
> Partition boundary problem in 2.4.16 ?!
> I just tried to make a mke2fs on my /dev/hda9 and mke2fs with kernel
> 2.4.16 and it failed with a partial write. /var/log/messages says:

I have a similar problem with /dev/sda9.  Booting 2.4.11...16 results in a 
partition not found error (as reported by fsck).  Going back to 2.4.10ac10, 
fdisk tells me that the partition ID for sda9 is 0x0000 which is corrupt, and 
will be fixed on a write.  I do the write, and sda9 is still invisible.  

Delete and recreate the partition with the exact same cylinder values, and 
the partition comes back, but is unmountable and un-fsck-able.

Examining raw hex data from other partitions, I find that the ext2 label 
string (as set with the -L flag to mke2fs) occurs at offset 02160 (octal) 
into the raw partition.  But on /dev/sda9, it is occurring at 01160 instead - 
off by one 512 byte sector.  Foo.  2.4.16 has not made my day.

Kris
