Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268917AbRHRW3n>; Sat, 18 Aug 2001 18:29:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268996AbRHRW3e>; Sat, 18 Aug 2001 18:29:34 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:13587 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S268917AbRHRW3V>; Sat, 18 Aug 2001 18:29:21 -0400
Message-ID: <3B7EEC4C.D0127AB4@zip.com.au>
Date: Sat, 18 Aug 2001 15:29:32 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Dewet Diener <linux-kernel@dewet.org>
CC: linux-kernel@vger.kernel.org,
        "ext3-users@redhat.com" <ext3-users@redhat.com>
Subject: Re: ext3 partition unmountable
In-Reply-To: <20010818030321.A11649@darkwing.flatlit.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dewet Diener wrote:
> 
> Hi all
> 
> After umounting a removable ext3 partition from my work PC, and
> trying to remount it at home, I've run into the following error
> trying to mount it as both ext2 and ext3:
> 
> EXT2-fs: ide1(22,65): couldn't mount because of unsupported optional features (10000).
> EXT3-fs: ide1(22,65): couldn't mount because of unsupported optional features (10000).
> 

Could you please run

	 od -A x -t x1 /dev/hdd1

and send the output?

For the superblock I get:

000400 c0 74 07 00 e2 e8 0e 00 d8 be 00 00 e1 8c 0e 00
000410 b5 74 07 00 00 00 00 00 02 00 00 00 02 00 00 00
000420 00 80 00 00 00 80 00 00 a0 3f 00 00 2f e9 7e 3b
000430 2f e9 7e 3b 01 00 16 00 53 ef 01 00 01 00 00 00
000440 1f e9 7e 3b 00 4e ed 00 00 00 00 00 01 00 00 00
000450 00 00 00 00 0b 00 00 00 80 00 00 00 04 00 00 00
000460 06 00 00 00 01 00 00 00 b9 d3 6c 59 2d cc 42 13
000470 91 84 d4 7b 60 d2 d9 50 00 00 00 00 00 00 00 00
000480 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

The incompat features are at superblock offset 0x60.
So here it's 0x00000006 - EXT3_FEATURE_INCOMPAT_FILETYPE
and EXT3_FEATURE_INCOMPAT_RECOVER.

Somehow you seem to have set bit 16, which isn't defined.  Not sure how
to fix this without simply running a binary editor against /dev/hdd1 and
clearing the byte at offset 0x462.

-
