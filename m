Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267043AbTB0Vd1>; Thu, 27 Feb 2003 16:33:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267048AbTB0VdQ>; Thu, 27 Feb 2003 16:33:16 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:43663 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S267043AbTB0Vcf>; Thu, 27 Feb 2003 16:32:35 -0500
Date: Thu, 27 Feb 2003 13:33:20 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Daniel Phillips <phillips@arcor.de>,
       Andreas Dilger <adilger@clusterfs.com>, bwindle-kbt@fint.org
cc: linux-kernel <linux-kernel@vger.kernel.org>,
       ext2-devel@lists.sourceforge.net, "Theodore Ts'o" <tytso@mit.edu>,
       chrisl@vmware.com
Subject: Re: [Bug 417] New: htree much slower than regular ext3
Message-ID: <184970000.1046381600@flay>
In-Reply-To: <20030227212403.D28DA3C7CB@mx01.nexgo.de>
References: <11490000.1046367063@[10.10.2.4]>
 <20030227200425.253F03FE26@mx01.nexgo.de>
 <20030227140019.G1373@schatzie.adilger.int>
 <20030227212403.D28DA3C7CB@mx01.nexgo.de>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > 11 ms sounds like two seeks for each returned dirent, which sounds
>> > like a bug.
>> 
>> I think you are pretty dead on there.  The difference is that with
>> unindexed entries, the directory entry and the inode are in the same
>> order, while with indexed directories they are essentially in random
>> order to each other.  That means that each directory lookup causes a
>> seek to get the directory inode data instead of doing allocation order
>> (which is sequential reads on disk).
>> 
>> In the past both would have been slow equally, but the orlov allocator in
>> 2.5 causes a number of directories to be created in the same group before
>> moving on to the next group, so you have nice batches of sequential
>> reads.
> 
> I think you're close to the truth there, but out-of-order inode table
> access  would only introduce one seek per inode table block, and the
> cache should  take care of the rest.  Martin's numbers suggest the cache
> isn't caching at  all.
> 
> Martin, does iostat show enormously more reads for the Htree case?

Wasn't me ... I just forward the bug data from bugzilla ;-)
Filer in this case was ... bwindle-kbt@fint.org
cc'ed.

M.

