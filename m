Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315803AbSEJE32>; Fri, 10 May 2002 00:29:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315802AbSEJE31>; Fri, 10 May 2002 00:29:27 -0400
Received: from c16410.randw1.nsw.optusnet.com.au ([210.49.25.29]:4591 "EHLO
	mail.chubb.wattle.id.au") by vger.kernel.org with ESMTP
	id <S315801AbSEJE31>; Fri, 10 May 2002 00:29:27 -0400
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15579.19620.51568.59112@wombat.chubb.wattle.id.au>
Date: Fri, 10 May 2002 14:29:24 +1000
To: Andrew Morton <akpm@zip.com.au>
CC: linux-kernel@vger.kernel.org, martin@dalecki.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: Re: [PATCH] remove 2TB block device limit
In-Reply-To: <3CDB4711.1A4FFDAC@zip.com.au>
In-Reply-To: <15579.16423.930012.986750@wombat.chubb.wattle.id.au>
	<3CDB4711.1A4FFDAC@zip.com.au>
X-Mailer: VM 7.03 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
--text follows this line--
>>>>> "Andrew" == Andrew Morton <akpm@zip.com.au> writes:

Andrew> Peter Chubb wrote:
>> Hi, At present, linux is limited to 2TB filesystems even on 64-bit
>> systems, because there are various places where the block offset on
>> disc are assigned to unsigned or int 32-bit variables.
>> 
>> There's a type, sector_t, that's meant to hold offsets in sectors
>> and blocks.  It's not used consistently (yet).
>> 
>> The patch at
>> http://www.gelato.unsw.edu.au/patches/2.5.14-largefile-patch
>> 
>> ...
>> 
>> As this touches lots of places -- the generic block layer (Andrew?)
>> the IDE code (Martin?) and RAID (Neil?) and minor changes to the
>> scsi I've CCd a few people directly.

Andrew> That would be more Jens and aviro than I.

OK, I'll forward it to them... (And I've added them to the CC list here)

Andrew> My vote would be: just merge the sucker while it still
Andrew> (almost) applies. 2TB is a showstopper for some people in 2.4
Andrew> today.  Obviously 2.6 will need 64-bit block numbers.

Yes.  But not always, I think --- the overhead on low-end boxes I
think may be prohibitive.  It should be a configuration option.

Andrew> The next obstacle will be page cache indices into the blockdev
Andrew> mapping.  That's either an 8TB or 16TB limit, depending on
Andrew> signedness correctness.

It's OK at 16TB now.  That was the point of the bmap() change.
And if you go to larger pages, or a larger index in the page cache,
you can get even bigger (but I don't think it's necessary just now).


Andrew> One minor point - it is currently not possible to print
Andrew> sector_t's.  This code:

Andrew> 	printk("%lu%s", some_sector, some_string);
Andrew> will work fine with 32-bit sector_t.  But with 64-bit sector_t

Currently, sector_t is cast to u64 everywhere it's printed out, and
the format %llu used.  I looked at the possibility of usng a PRIsector
macro a la inttypes.h but thought the result incredibly ugly.  Mind
you, casts aren't particularly clean

Peter C
