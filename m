Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265059AbTLKO2o (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 09:28:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265060AbTLKO2n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 09:28:43 -0500
Received: from out004pub.verizon.net ([206.46.170.142]:21940 "EHLO
	out004.verizon.net") by vger.kernel.org with ESMTP id S265059AbTLKO2k
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 09:28:40 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: None that appears to be detectable by casual observers
To: dan carpenter <error27@email.com>, linux-kernel@vger.kernel.org
Subject: Re: floppy.c problems?
Date: Thu, 11 Dec 2003 09:28:38 -0500
User-Agent: KMail/1.5.1
References: <200312101758.41498.gene.heskett@verizon.net> <200312102136.06817.error27@email.com>
In-Reply-To: <200312102136.06817.error27@email.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312110928.38162.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out004.verizon.net from [151.205.60.44] at Thu, 11 Dec 2003 08:28:39 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 11 December 2003 00:36, dan carpenter wrote:
>On Wednesday 10 December 2003 02:58 pm, Gene Heskett wrote:
>> I've added 4 more lines to the floppy definition array in
>> floppy.c, and increased the array count at the top to match, but I
>> don't seem to be able to get any output, its working as usual. 
>> Stuck in 512 bytes per sector modes, 9 to the track that is.
>
>Can you show us your code.
>
>regards,
>dan carpenter

sure, from the top of the array in floppy.c:
--------------
static struct floppy_struct floppy_type[36] = { /* it was [32] */
--------------
Then at the bottom, including 2 lines of the old code for reference:
--------------
        { 1600,10,2,80,0,0x25,0x02,0xDF,0x2E,"D800"  }, /* 30 800KB 3.5"    */
        { 3200,20,2,80,0,0x1C,0x00,0xCF,0x2C,"H1600" }, /* 31 1.6MB 3.5"    */
        {  720,18,1,35,0,0x2A,0x02,0xDF,0x00,"OS935s"}, /* 32 160k 5.25" ss os9 */
        {  720,18,1,40,0,0x2A,0x02,0xDF,0x00,"OS940s"}, /* 33 180k 5.25" ss os9 */
        {  720,18,2,40,0,0x2A,0x02,0xDF,0x00,"OS940d"}, /* 34 360k 5.25" dd os9 */
        {  720,18,2,80,0,0x2A,0x02,0xDF,0x00,"OS980d"}, /* 35 720k 5.25" hd os9 */
};
---------------

With those changes, and some additional defines in 
/usr/local/etc/mediaprm:
---------------
# TRS-80 Color Computer OS9 formats(to be confirmed)

"COCO360":
 DS DD sect=18 cyl=40 ssize=256 tpi=48

"COCO720":
 DS DD sect=18 cyl=80 ssize=256 tpi=96

# Now we know this one works!
"COCO3.5DD":
 DS DD sect=18 cyl=40 ssize=256 tpi=135

"COCO3.5HD":
 DS DD sect=18 cyl=80 ssize=256 tpi=135
---------------
And using "setfdprm /dev/fd0 coco3.5dd"
before each fdformat invocation,
I was finally able to make useable disks.  Note
that the COCO3.5HD is still on a "DD" diskette,
the coco's controllers cannot do 500 kilobaud
data rates.  So those last 2 should make 360k
and 720k disks.

But fdformat still lies like a fsking rug when
its formatting the disk, and outputs are odd
during the verify, skipping tracks, sometimes
several, at random.  Now if I could find the
srcs for fdformat, I'd make it tell the truth,
even if i have to give it a shot of pentathol.
 :-)  <--happy camper

-- 
Cheers, Gene
AMD K6-III@500mhz 320M
Athlon1600XP@1400mhz  512M
99.22% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.

