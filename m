Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280357AbRK1TdJ>; Wed, 28 Nov 2001 14:33:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280257AbRK1Tcu>; Wed, 28 Nov 2001 14:32:50 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:56069 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S280357AbRK1Tcp>; Wed, 28 Nov 2001 14:32:45 -0500
Message-ID: <3C053BA7.874FCE12@zip.com.au>
Date: Wed, 28 Nov 2001 11:31:51 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.14-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Torrey Hoffman <torrey.hoffman@myrio.com>
CC: Dieter =?iso-8859-1?Q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Unresponiveness of 2.4.16
In-Reply-To: <D52B19A7284D32459CF20D579C4B0C0211CAE1@mail0.myrio.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Torrey Hoffman wrote:
> 
> Hmm. Speaking of dbench, I tried the combination of 2.4.16,
> your 2.4.16 low latency patch, and the IO scheduling patch
> on my dual PIII.
> 
> After starting it up I did a dbench 32 on a 180 GB reiserfs
> running on software RAID 5, just to see if it would
> fall over, and during the run I got the following error/
> warning message printed about 20 times on the console
> and in the kernel log:
> 
> vs-4150: reiserfs_new_blocknrs, block not free<4>
> 

uh-oh.  I probably broke reiserfs in the low-latency patch.

It's fairly harmless - we drop the big kernel lock, schedule
away.  Upon resumption, the block we had decided to allocate
has been allocated by someone else.  The filesystem emits a
warning and goes off to find a different block.

Will fix.

-
