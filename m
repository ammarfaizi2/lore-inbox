Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262985AbTFAKlZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jun 2003 06:41:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263182AbTFAKlZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jun 2003 06:41:25 -0400
Received: from mout2.freenet.de ([194.97.50.155]:46814 "EHLO mout2.freenet.de")
	by vger.kernel.org with ESMTP id S262985AbTFAKlX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jun 2003 06:41:23 -0400
From: Andreas Hartmann <andihartmann@freenet.de>
X-Newsgroups: fa.linux.kernel
Subject: Re: [PATCH] rmap 15j for 2.4.21-rc6
Date: Sun, 01 Jun 2003 13:00:22 +0200
Organization: privat
Message-ID: <bbcmc6$74t$1@ID-44327.news.dfncis.de>
References: <fa.nvklblk.jl430u@ifi.uio.no> <fa.h329tc5.1djcrol@ifi.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Trace: susi.maya.org 1054465222 7325 192.168.1.3 (1 Jun 2003 11:00:22 GMT)
X-Complaints-To: abuse@fu-berlin.de
User-Agent: KNode/0.7.2
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org






Michael Frank wrote:

> On Saturday 31 May 2003 22:48, Rik van Riel wrote:
>>
>> Today I finally merged rmap15j forward to marcelo's latest
>> release.  The IO stall fixes should be especially interesting:
>>
> 
> Patched rc6 ex BK OK and compiled with gcc295-3 OK
> 
> On a P4/533-2.4Ghz/512MB with udma5 IDE ~50MB/s:
> 
> Shows severe interactivity problems and hangs
> 
> Scroll and mouse hangs and delayed response to keyboard
> greater 1s are easily observable.
> 

Well, I did the test with 2.4.21rc6 after patching your script (I got syntax
errors):

When I'm using the script as seen in the patch, I'm getting problems with df
(it's mostly very lazy, about 20s delay or more), the load is 4, doing an
ls on some other directories is extremly slow. Mouse and keyboard are
hanging some times.
The write speed shown in xosview was between 1 and 15MB/s. Often the HD LED
was on, but no data seemed to be put to the HD.


My system:
AMD Athlon(tm) XP 2000+
512 MB RAM
Chipsatz Apollo KT266/A/333
WDC WD205AA, udma4, 20,5 GB
             (multcount    = 16 (on),I/O support  =  1 (32-bit),
             unmaskirq    =  1 (on),using_dma    =  1 (on),
             readahead    =  8 (on)
             )
reiserfs


Regards,
Andreas Hartmann


--- /home/Andreas/tstinter      Sun Jun  1 11:03:10 2003
+++ tstinter    Sun Jun  1 11:27:18 2003
@@ -138,7 +138,7 @@
     sleep 1
    fi
  #invoke dd write loops
-   while (( i-- )); do
+   while (( i=`expr $i - 1` )); do
      $TSTINTER _xwrite "$2" $i
      sleep 1
    done
@@ -163,13 +163,13 @@
  #
  _read)
    if [ "$2" = "" ]; then
-     count=100K
+     count=100000
    else
      count=$2
    fi
-   dd if=/dev/zero of=$TEMPFILE$3 bs=4K count=$count
+   dd if=/dev/zero of=$TEMPFILE$3 bs=4096 count=$count
    while (( 1 )); do
-     time dd if=$TEMPFILE$3 of=/dev/null bs=4K count=$count &> /dev/null
+     time dd if=$TEMPFILE$3 of=/dev/null bs=4096 count=$count &> /dev/null
    done
    ;;
  #
@@ -181,12 +181,12 @@
  #
  _write)
    if [ "$2" = "" ]; then
-     count=100K
+     count=100000
    else
      count=$2
    fi
    while (( 1 )); do
-     time dd if=/dev/zero of=$TEMPFILE$3 bs=4K count=$count
+     time dd if=/dev/zero of=$TEMPFILE$3 bs=4096 count=$count
    done
    ;;
  #

