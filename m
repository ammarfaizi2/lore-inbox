Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269943AbSISFLm>; Thu, 19 Sep 2002 01:11:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269945AbSISFLm>; Thu, 19 Sep 2002 01:11:42 -0400
Received: from h106-129-61.datawire.net ([207.61.129.106]:9884 "EHLO
	newmail.datawire.net") by vger.kernel.org with ESMTP
	id <S269943AbSISFLl> convert rfc822-to-8bit; Thu, 19 Sep 2002 01:11:41 -0400
From: Shawn Starr <spstarr@sh0n.net>
Organization: sh0n.net
To: sct@redhat.com, akpm@digeo.com
Subject: [BENCHMARK] EXT3 vs EXT2 results with rmap14a and testing with contest 0.34
Date: Thu, 19 Sep 2002 00:16:26 -0400
User-Agent: KMail/1.4.6
References: <200209182118.12701.spstarr@sh0n.net> <200209182140.30364.spstarr@sh0n.net> <1032403983.3d893c0f8986b@kolivas.net>
In-Reply-To: <1032403983.3d893c0f8986b@kolivas.net>
MIME-Version: 1.0
Content-Disposition: inline
Cc: Con Kolivas <conman@kolivas.net>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200209190016.26609.spstarr@sh0n.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry about the confusing email before. This should make more sense =)

These results compare EXT3 against EXT2 with rmap using the contest tool
you can get it at: http://contest.kolivas.net

These tests are from a Athlon MP 2000+ w/ 512MB RAM

noload:

Kernel									Time            	CPU
2.4.20-pre7-rmap14a-xfs-uml-shawn12d            	259.47		99%
2.4.20-pre7-rmap14a-xfs-uml-shawn12d            	267.66          	97%

process_load:

Kernel                  							Time            	CPU
2.4.20-pre7-rmap14a-xfs-uml-shawn12d            	318.91          	80%
2.4.20-pre7-rmap14a-xfs-uml-shawn12d            	324.44          	79%

io_halfmem:

Kernel                  							Time			CPU
2.4.20-pre7-rmap14a-xfs-uml-shawn12d            	306.82          	87%
2.4.20-pre7-rmap14a-xfs-uml-shawn12d            	461.74          	57%

io full mem:

Kernel									Time			CPU
2.4.20-pre7-rmap14a-xfs-uml-shawn12d            	325.39          	82%
2.4.20-pre7-rmap14a-xfs-uml-shawn12d            	411.47          	64%

full logs of the tests are:

WITH EXT2
------------
noload Time: 259.47  CPU: 99%  Major Faults: 770937  Minor Faults: 1173705
process_load Time: 318.91  CPU: 80%  Major Faults: 742261  Minor Faults: 
1169516
io_halfmem Time: 306.82  CPU: 87%  Major Faults: 742000  Minor Faults: 1169497
Was writing number 33 of a 257Mb sized io_load file after 307 seconds
io_fullmem Time: 325.39  CPU: 82%  Major Faults: 742000  Minor Faults: 1169494
Was writing number 16 of a 514Mb sized io_load file after 337 seconds
mem_load Time: 340.32  CPU: 79%  Major Faults: 743307  Minor Faults: 1170011


WITH EXT3
-----------

noload Time: 267.66  CPU: 97%  Major Faults: 771111  Minor Faults: 1173722
process_load Time: 324.44  CPU: 79%  Major Faults: 742261  Minor Faults: 
1169518
io_halfmem Time: 461.74  CPU: 57%  Major Faults: 742000  Minor Faults: 1169496
Was writing number 34 of a 257Mb sized io_load file after 465 seconds
io_fullmem Time: 411.47  CPU: 64%  Major Faults: 742000  Minor Faults: 1169494
Was writing number 15 of a 514Mb sized io_load file after 425 seconds
mem_load Time: 333.99  CPU: 81%  Major Faults: 743320  Minor Faults: 1170021

NOTES:
====

As you can see, there's something DEFINATELY wrong here.  EXT3 is much slower
then EXT2. I converted the EXT3 disk back to EXT2 to do the second test.

Also, I specified no mount options for EXT3 (which means it uses ordered 
mode). The journal was created with tune2fs -j /dev/hda#


>From #Kernelnewbies (snip)
==============
<ShawnCONSOLE> riel uses EXT3
<riel> my cpu is slower
<ShawnCONSOLE> but you have fast disks?
<riel> so it doesn't fall idle as quickly as yours, when waiting on the disk
<riel> not very fast ;)
<riel> old 8 GB IDE disk
<ShawnCONSOLE> so having a fast disk and a fast CPU causes the cpu to wait 
longer cause the disk finishes its tasks much faster then the cpu expects? 
<ShawnCONSOLE> mem load final test = 78%
<ShawnCONSOLE> so final numbers:
<ShawnCONSOLE> 99, 80%, 87%, 83%, 75%
<riel> yes, a very fast CPU falls idle more quickly
<riel> but it's very curious that ext3 is  that  much worse than ext2
<ShawnCONSOLE> thats much better.
<riel> definately worth pointing out to the ext3 maintainers.
