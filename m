Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282860AbRLQUol>; Mon, 17 Dec 2001 15:44:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282866AbRLQUoc>; Mon, 17 Dec 2001 15:44:32 -0500
Received: from eventhorizon.antefacto.net ([193.120.245.3]:57493 "EHLO
	eventhorizon.antefacto.net") by vger.kernel.org with ESMTP
	id <S282862AbRLQUoX>; Mon, 17 Dec 2001 15:44:23 -0500
Message-ID: <3C1E587C.9060300@antefacto.com>
Date: Mon, 17 Dec 2001 20:41:32 +0000
From: Padraig Brady <padraig@antefacto.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: ramdisk size clarification
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It's not at all obvious to me what the {ramdisk,ramdisk_size,rd_size}
parameters for ramdisks do from reading ramdisk.txt (note rd_size
is used when using the ramdisk as a module).

I think they only set the size to be reported, for e.g. mke2fs does
the following to determine the size of a ramdisk:

open("/dev/ram0", O_RDONLY|O_LARGEFILE) = 3
ioctl(3, BLKGETSIZE, 0xbffff81c)        = 0
close(3)                                = 0

However there is no actual RAM allocated until it's required,
and also there is no upper limit on the amount of RAM used,
so the following will kill your system (well it did for me):
dd if=/dev/zero of=/dev/ram0

can this be clarified in the ramdisk.txt file please.

As a side note there is a lovely "trivial ramdisk" module
written by Andrw tridgell @:
http://cvs.sourceforge.net/cgi-bin/viewcvs.cgi/gkernel/ext3/tools/trd/
that does static allocation and (hence) doesn't grow beyond the
specified size.

thanks,
Padraig.

