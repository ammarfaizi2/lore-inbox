Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268884AbUH3TxF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268884AbUH3TxF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 15:53:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268929AbUH3TxB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 15:53:01 -0400
Received: from av8-1-sn2.hy.skanova.net ([81.228.8.110]:6869 "EHLO
	av8-1-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S268884AbUH3Ts2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 15:48:28 -0400
Message-ID: <41338487.2050007@df.lth.se>
Date: Mon, 30 Aug 2004 21:48:23 +0200
From: Johan Billing <billing@df.lth.se>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040821
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: CD-ripping using ioctl() does not work when DMA is disabled (ide-cd)
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In kernel 2.6.8, my old TEAC CD-532E-A CD-ROM is blacklisted and DMA is 
automatically disabled. When I try to rip an audio CD using cdparanoia, 
all I get is a silent wav file full of zeroes. I know that there was 
some discussions about this on the list during the summer in conjunction 
with the "dropping to single frame DMA" issue, but I think I have some 
new information to add...

I investigated the cdparanoia source a bit and was able to pinpoint the 
problem a bit more. cdparanoia uses the ioctl() interface with 
CDROMREADAUDIO to read data from the CD and normally tries to read 6 or 
8 frames at a time. The problem is that only the first read frame 
contains valid data, the others are blank and only contain zeroes. If I 
disable error correction and only read one frame at a time ("cdparanoia 
-n1 -Z") it seems to work fine. If I defy the blacklist and turn DMA on 
using "hdparm -d1", cdparanoia can read multiple frames without any 
problems.

So in conclusion, this seems to be a problem that only occurs when 
reading multiple frames using ioctl() with DMA off. I hope that this 
will help find and fix the problem.

/Johan

