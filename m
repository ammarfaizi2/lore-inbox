Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965591AbWKDSuE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965591AbWKDSuE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Nov 2006 13:50:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965605AbWKDSuE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Nov 2006 13:50:04 -0500
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:53159 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S965591AbWKDSuC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Nov 2006 13:50:02 -0500
Date: Sat, 4 Nov 2006 19:50:01 +0100 (CET)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: New filesystem for Linux
In-Reply-To: <20061104104601.GA16991@wohnheim.fh-wedel.de>
Message-ID: <Pine.LNX.4.64.0611041946580.24713@artax.karlin.mff.cuni.cz>
References: <20061102235920.GA886@wohnheim.fh-wedel.de>
 <Pine.LNX.4.64.0611030217570.7781@artax.karlin.mff.cuni.cz>
 <20061103101901.GA11947@wohnheim.fh-wedel.de>
 <Pine.LNX.4.64.0611031252430.17174@artax.karlin.mff.cuni.cz>
 <20061103122126.GC11947@wohnheim.fh-wedel.de>
 <Pine.LNX.4.64.0611031428010.17427@artax.karlin.mff.cuni.cz>
 <20061103134802.GD11947@wohnheim.fh-wedel.de>
 <Pine.LNX.4.64.0611031509500.27698@artax.karlin.mff.cuni.cz>
 <20061103145329.GE11947@wohnheim.fh-wedel.de>
 <Pine.LNX.4.64.0611031953411.30722@artax.karlin.mff.cuni.cz>
 <20061104104601.GA16991@wohnheim.fh-wedel.de>
X-Personality-Disorder: Schizoid
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1908636959-1255821713-1162666201=:24713"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1908636959-1255821713-1162666201=:24713
Content-Type: TEXT/PLAIN; charset=iso-8859-2; format=flowed
Content-Transfer-Encoding: 8BIT

>>> So which, if I may ask, are the advantages of your design over sprite
>>> lfs?
>>
>> It is very different from LFS. LFS is log-filesystem, i.e. journal spans
>> the whole device. The problem with this design is that it's fast for write
>> (cool benchmark numbers) and slow in real-world workloads.
>>
>> LFS places files according to time they were created, not according to
>> their directory.
>>
>> If you have directory with some project where you have files that you
>> edited today, day ago, week ago, month ago etc., then any current
>> filesystem (even ext2) will try to place files near each other --- while
>> LFS will scatter the files over the whole partition according to time they
>> were written. --- I believe that this is the reason why log-structured
>> filesystems are not in wild use --- this is a case where optimizing for
>> benchmark kills real-world performance.
>
> Darn, I was asking the wrong question again.  Let me rephrase:
>
> So which, if I may ask, are the advantages of your crash
> count/transaction count design over the sprite lfs checkpoint design?
>
> Allocation strategy is an interesting topic as well.  Rosenblum and
> Ousterhout were wrong in their base assumption that read performance
> won't matter long-term, as caches are exponentially growing.  It
> turned out that storage size was growing just as fast and the ratio
> remained roughly the same.  But let us postpone that for a while.
>
> Jörn

LFS fragments data by design ... it can't write to already allocated 
space, so if you write to the middle of LFS directory, it will allocate 
new block, new indirect pointers to that directory, new block in inode 
table etc.

The same fragmentation with files (although with files it could be fixed 
by not relying on consistecny of their content).

Mikulas
--1908636959-1255821713-1162666201=:24713--
