Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131089AbRCGRnR>; Wed, 7 Mar 2001 12:43:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131133AbRCGRnI>; Wed, 7 Mar 2001 12:43:08 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:12783 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S131089AbRCGRmx>; Wed, 7 Mar 2001 12:42:53 -0500
Date: Wed, 7 Mar 2001 14:41:17 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Linus Torvalds <torvalds@transmeta.com>
cc: <linux-kernel@vger.kernel.org>
Subject: 64-bit capable block device layer
Message-ID: <Pine.LNX.4.33.0103071432230.1409-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

how would you feel about having the block device layer 64-bit
capable, so Linux can have block devices of more than 2GB in
size ?

I know that 64-bit arithmetic is expensive on 32-bit platforms,
but I have the idea there is a way around that for people who
don't want 64-bit capable block devices.

1. use blkoff_t for all block number arithmetic

2. in some header file, have

#ifdef CONFIG_BLKDEV_64BIT
typedef long long blkoff_t
#else
typedef long blkoff_t
#endif

This way, people running smaller&slower machines can chose to
do the cheaper 32-bit arithmetic and only the people using huge
block devices will have to do the 64-bit arithmetic.

(yes, basically the same trick as we're using for PAE)

regards,

Rik
--
Linux MM bugzilla: http://linux-mm.org/bugzilla.shtml

Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

