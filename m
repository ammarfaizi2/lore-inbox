Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283432AbRK2Xhu>; Thu, 29 Nov 2001 18:37:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283436AbRK2Xhk>; Thu, 29 Nov 2001 18:37:40 -0500
Received: from mail.myrio.com ([63.109.146.2]:15858 "HELO smtp1.myrio.com")
	by vger.kernel.org with SMTP id <S283432AbRK2Xh2> convert rfc822-to-8bit;
	Thu, 29 Nov 2001 18:37:28 -0500
Message-ID: <D52B19A7284D32459CF20D579C4B0C0211CAE8@mail0.myrio.com>
From: Torrey Hoffman <torrey.hoffman@myrio.com>
To: "'Rene Rebe'" <rene.rebe@gmx.net>
Cc: linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: RE: [reiserfs-list] ReiserFS on RAID5 Linux-2.4 - speed problem
Date: Thu, 29 Nov 2001 15:36:48 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

René Rebe wrote:
> Have you tryed:
> 
> echo 1023 > /proc/sys/vm/max-readahead
[...]

Well, I gave that a try.  

note:
/dev/md0 is a 180 GB reiserfs on software RAID 5.
/dev/hda9 is an 18 GB reiserfs on a normal partition.
System is a dual PIII-800 with 512 MB RAM.
Kernel is 2.4.16 + Andrew Morton's Low Latency and I/O 
scheduling patches.

before:
cat /proc/sys/vm/max-readahead:	31
dbench 32 on /dev/md0  :	8.11 MB/sec
dbench 32 on /dev/hda9 :	24.85 MB/sec

after:
echo 1023 > /proc/sys/vm/max-readahead
dbench 32 on /dev/md0  :	8.047 MB/sec
dbench 32 on /dev/hda9 :	24.65 MB/sec

So that change actually made things a little worse,
at least on this kernel.  :-(

Torrey
