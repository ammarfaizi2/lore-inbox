Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311477AbSCNCQb>; Wed, 13 Mar 2002 21:16:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311479AbSCNCQV>; Wed, 13 Mar 2002 21:16:21 -0500
Received: from adsl-196-233.cybernet.ch ([212.90.196.233]:24565 "HELO
	mailphish.drugphish.ch") by vger.kernel.org with SMTP
	id <S311477AbSCNCQM>; Wed, 13 Mar 2002 21:16:12 -0500
Message-ID: <3C9007F5.1000003@drugphish.ch>
Date: Thu, 14 Mar 2002 03:16:21 +0100
From: Roberto Nibali <ratz@drugphish.ch>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020306
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Question about the ide related ioctl's BLK* in 2.5.7-pre1 kernel
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

What for are BLKRAGET, BLKFRAGET and BLKSECTGET still needed? I mean 
readahead doesn't seem to be exported anymore (at least through those 
interfaces). hdparm v4.6 does of course not like this (But this is a 
user space problem). Following output describes what I mean:

laphish:/usr/src/linux-2.5.7-pre1-orig # egrep -r 
"BLKRAGET|BLKFRAGET|BLKSECTGET" .
./arch/sparc64/kernel/ioctl32.c:HANDLE_IOCTL(BLKSECTGET, w_long)
./arch/mips64/kernel/ioctl32.c: 
IOCTL32_HANDLER(BLKSECTGET, w_long),
./arch/ppc64/kernel/ioctl32.c:HANDLE_IOCTL(BLKRAGET, w_long),
./arch/ppc64/kernel/ioctl32.c:HANDLE_IOCTL(BLKFRAGET, w_long),
./arch/ppc64/kernel/ioctl32.c:HANDLE_IOCTL(BLKSECTGET, w_long),
./arch/x86_64/ia32/ia32_ioctl.c:HANDLE_IOCTL(BLKSECTGET, w_long)
./drivers/acorn/block/mfmhd.c: 
case BLKSECTGET:
./drivers/block/blkpg.c: 
	case BLKSECTGET:
./drivers/md/lvm.c: *    09/02/1999 - changed BLKRASET and BLKRAGET in 
lvm_chr_ioctl() to
./include/linux/fs.h:#define BLKRAGET   _IO(0x12,99)	/* get current read ahead setting */
./include/linux/fs.h:#define BLKFRAGET  _IO(0x12,101)/* get filesystem 
(mm/filemap.c) read-ahead */
./include/linux/fs.h:#define BLKSECTGET _IO(0x12,103)/* get max sectors 
per request (ll_rw_blk.c) */
laphish:/usr/src/linux-2.5.7-pre1-orig #

At least BLKRAGET and BLKFRAGET don't seem to be used anymore.

Regards,
Roberto Nibali, ratz

