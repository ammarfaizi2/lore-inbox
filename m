Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267039AbSLKOKu>; Wed, 11 Dec 2002 09:10:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267043AbSLKOKu>; Wed, 11 Dec 2002 09:10:50 -0500
Received: from cmailg3.svr.pol.co.uk ([195.92.195.173]:8466 "EHLO
	cmailg3.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S267039AbSLKOKs>; Wed, 11 Dec 2002 09:10:48 -0500
Date: Wed, 11 Dec 2002 14:18:20 +0000
To: Kevin Corry <corryk@us.ibm.com>
Cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Joe Thornber <joe@fib011235813.fsnet.co.uk>,
       Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lvm-devel@sistina.com
Subject: Re: [PATCH] dm.c - device-mapper I/O path fixes
Message-ID: <20021211141820.GA21461@reti>
References: <02121016034706.02220@boiler> <20021211121915.GB20782@reti> <200212111330.gBBDTTa06416@Port.imtp.ilyichevsk.odessa.ua> <02121107165303.29515@boiler>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02121107165303.29515@boiler>
User-Agent: Mutt/1.4i
From: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2002 at 07:16:53AM -0600, Kevin Corry wrote:
> However, it might be a good idea to consider how bio's keep track of errors. 
> When a bio is created, it is marked UPTODATE. Then, if any part of a bio 
> takes an error, the UPTODATE flag is turned off. When the whole bio 
> completes, if the UPTODATE flag is still on, there were no errors during the 
> i/o. Perhaps the "error" field in "struct dm_io" could be modified to use 
> this method of error tracking? Then we could change dec_pending() to be 
> something like:
> 
> if (error)
> 	clear_bit(DM_IO_UPTODATE, &io->error);
> 
> with a "set_bit(DM_IO_UPTODATE, &ci.io->error);" in __bio_split().

The problem with this is you don't keep track of the specific error to
later pass to bio_endio(io->bio...).  I guess it all comes down to
just how expensive that spin lock is; and since locking only occurs
when there's an error I'm happy with things as they are.

- Joe
