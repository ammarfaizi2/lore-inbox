Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271854AbRHXOdz>; Fri, 24 Aug 2001 10:33:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271853AbRHXOdp>; Fri, 24 Aug 2001 10:33:45 -0400
Received: from [208.48.139.185] ([208.48.139.185]:51148 "HELO
	forty.greenhydrant.com") by vger.kernel.org with SMTP
	id <S271854AbRHXOd3>; Fri, 24 Aug 2001 10:33:29 -0400
Date: Fri, 24 Aug 2001 07:33:38 -0700
From: David Rees <dbr@greenhydrant.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 3ware RAID1 sequential read speed slower than write speed (2.4.8-ac10)
Message-ID: <20010824073338.A16254@greenhydrant.com>
Mail-Followup-To: David Rees <dbr@greenhydrant.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010824090655.29285.qmail@yusufg.portal2.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010824090655.29285.qmail@yusufg.portal2.com>; from yusufg@outblaze.com on Fri, Aug 24, 2001 at 09:06:55AM -0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 24, 2001 at 09:06:55AM -0000, Yusuf Goolamabbas wrote:
> P3-450 with 256MB RAM with a 3ware 6200 attached to 2 20GB Western
> Digitial 7200RPM Caviar Drive  WD200BB
> 
> Running bonnie++ <http://www.coker.com.au/bonnie++/> on both an ext3
> and ext2 partition, I get the following results
> 
> Version  1.01d      ------Sequential Output------ --Sequential Input- --Random-
>                     -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- --Seeks--
> Machine        Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP  /sec %CP
> ext3           512M  6020  98 41022  57  6673   8  4619  77 21834  14 237.1   2
> 
> 
> Version  1.01d      ------Sequential Output------ --Sequential Input- --Random-
>                     -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- --Seeks--
> Machine        Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP  /sec %CP
> ext2           512M  6385  99 39969  32  9371  10  5540  91 27864  14 320.7   2
> 
> 
> Whilst, I think the write performance is quite good. The read
> performance seems to be quite bad. I expected read performance to be
> better than write performance for RAID-1 configuration
> 
> Any ideas,patches to try ?

Yes, for a mirrored setup you would expect to see almost double the random
seeks and read rates equaling write rates.  I think the block size that
bonnie uses is small, so it doesn't give the RAID a chance to alternate
disks for block reads.

At least this is what seemed to happen when I was testing software RAID-1
using bonnie (not bonnie++).

What's the speed of one disk?  Can you try 2.4.8-ac9, -ac10 includes a 3ware
driver update.

I'll post some numbers from the software raid testing I was doing when I get
to work for comparison.  If anyone wants to send me a 3ware card (hint,
hint ;-), I'll gladly run some tests on that as well to compare.  Heck, I'll
even write a full review comparing 3ware to software raid!

-Dave
