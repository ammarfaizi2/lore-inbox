Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268922AbRG0SKu>; Fri, 27 Jul 2001 14:10:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268925AbRG0SKk>; Fri, 27 Jul 2001 14:10:40 -0400
Received: from zipmail.com ([207.88.19.245]:61080 "EHLO zipmail.com")
	by vger.kernel.org with ESMTP id <S268922AbRG0SKZ>;
	Fri, 27 Jul 2001 14:10:25 -0400
Message-ID: <3B61AE96.5030909@firein.net>
Date: Fri, 27 Jul 2001 14:10:30 -0400
From: Dustin Byford <dustin@firein.net>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.7 i686; en-US; rv:0.9.1) Gecko/20010608
X-Accept-Language: en-us
MIME-Version: 1.0
To: Hans Reiser <reiser@namesys.com>
CC: Joshua Schmidlkofer <menion@srci.iwpsd.org>, linux-kernel@vger.kernel.org
Subject: Re: ReiserFS / 2.4.6 / Data Corruption
In-Reply-To: <E15Q9Bw-0005q5-00@the-village.bc.nu> <0107270926070B.06707@widmers.oce.srci.oce.int> <3B618CF2.5C105903@namesys.com>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hans Reiser wrote:

> Maybe somebody else who is using both ReiserFS and RedHat's boot scripts can comment on whether
> things are slow for them and if so, where they get slow.


For what it's worth I just configured a RedHat 7.1 box with reiserfs on 
all partitions except /boot using this update disk 
ftp://139.82.28.40/pub/update-rh71reiser-v1.img from 
http://cambuca.ldhs.cetuc.puc-rio.br/.

Upgraded all of redhat's packages, note there is a SysVinit update and a 
gcc update.

Compiled a 2.4.7-pre kernel and the latest reiserfsprogs.

Mounted /boot read only to eliminate the chance of an fsck required on 
that partition.

I have been running reiserfs on a mail server with about 60k accounts 
(30k really active) for about 6 months. I haven't experienced any 
problems with the filesystems. The one I just configured is its intended 
replacment. After a few days of testing with bonnie, some perl scripts I 
wrote, and a few pullings of the power cord I think it's almost ready 
for production. An upgrade to 2.4.7 and some more testing will tell.

If you pull the plug on this machine it takes around 40 seconds to get 
back to the login prompt, (p3-600 60G ide drive). Including the act of 
pulling the power cord, bios delays, lilo delays, and the rest of the 
redhat boot sequence.

So, in my experience I've had very few problems with reiserfs and 
redhat. That said, the slightest hint of data corruption under normal 
(continuous power, no failing hardware) operation and I'll probably be 
evaluating other filesystems. There are sometimes as many as 500,000 
files on this filesystem, reiserfs seems to do a good job under my 
conditions.

				--Dustin

Also, one purely cosmetic patch to rc.sysinit if you want:
--- rc.sysinit.orig Fri Jul 27 13:06:58 2001
+++ rc.sysinit Fri Jul 27 13:38:25 2001
@@ -211,7 +211,8 @@

_RUN_QUOTACHECK=0
ROOTFSTYPE=`grep " / " /proc/mounts | awk '{ print $3 }'`
-if [ -z "$fastboot" -a "$ROOTFSTYPE" != "nfs" ]; then
+if [ -z "$fastboot" -a "$ROOTFSTYPE" != "nfs" \
+ -a "$ROOTFSTYPE" != "reiserfs" ]; then

STRING=$"Checking root filesystem"
echo $STRING

