Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317546AbSGZJMJ>; Fri, 26 Jul 2002 05:12:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317550AbSGZJMJ>; Fri, 26 Jul 2002 05:12:09 -0400
Received: from relay.muni.cz ([147.251.4.35]:18389 "EHLO anor.ics.muni.cz")
	by vger.kernel.org with ESMTP id <S317546AbSGZJMJ>;
	Fri, 26 Jul 2002 05:12:09 -0400
Date: Fri, 26 Jul 2002 11:15:20 +0200
From: Jan Kasprzak <kas@informatics.muni.cz>
To: alan@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: sard I/O accounting bug in -ac
Message-ID: <20020726111520.G23911@fi.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hello,

	There is a minor bug in the I/O accounting in 2.4.19-rc1-ac2 (and
probably later revisions as well - at least no fix to this is mentioned
in the changelog). The problem is that the "running" item in /proc/partitions
can get negative. Here is a part of my /proc/partitions:

# head /proc/partitions 
major minor  #blocks  name     rio rmerge rsect ruse wio wmerge wsect wuse running use aveq

  58     0  204210176 lvma 0 0 0 0 0 0 0 0 0 0 0
  34     0   75068280 hdg 12007096 98830582 885673212 17084202 317257 4005187 34592296 32986598 -1071 22122854 34831850
  34     1   74805696 hdg1 11988002 98662006 885199472 16164162 312861 3983758 34385688 32524318 4 17485050 5748597
  34     2     262552 hdg2 16396 4 131200 151010 4396 21429 206608 462280 0 484160 613290
  33     0   45034920 hde 10694513 98320446 660827602 40668484 175714 1606797 14276992 35243644 -1065 18924884 38273425
  33     1   44870616 hde1 10128022 63655922 590270586 37513084 171329 1585351 14070264 34922914 5 36875816 29493365
  33     2     164272 hde2 15831 0 126648 147970 4385 21446 206728 320730 0 249100 468700
  33    64   45034920 hdf 11314436 99923267 889901456 3322406 198326 2108746 18457720 28092418 -1068 20797814 37115864


	The negative values are only in entries for the whole disk, never for
its partition:

# grep -- - /proc/partitions
  34     0   75068280 hdg 12007082 98830340 885671132 17079932 317257 4005187 34592296 32986598 -1075 22116424 41738490
  33     0   45034920 hde 10694440 98319468 660819154 40653024 175714 1606797 14276992 35243644 -1070 18918454 2187572
  33    64   45034920 hdf 11314385 99922713 889896600 3308796 198326 2108746 18457720 28092418 -1070 20791384 1032102
  22     0   20005650 hdc 3903087 48375999 324447832 40241037 127195 1401386 12232848 26945838 -1070 26995574 36221312
   3     0    9770544 hda 33937639 61905727 191734832 39181743 9254145 28327116 75478202 2120759 -1065 17574604 29910514
   3    64   19938240 hdb 4225756 35931205 321255608 31092862 114779 1426224 12329296 37265634 -1063 22389064 20898945

	BTW, is there any documentation describing the meaning of the values
in /proc/partitions? What is the difference between rio/wio and rmerge/wmerge?
In what units is ruse/wuse measured? I thought it means milisecond of
read/write activity, but it grows far more by than 1000 per second for some
partitions.

	Thanks,

-Yenya

-- 
| Jan "Yenya" Kasprzak  <kas at {fi.muni.cz - work | yenya.net - private}> |
| GPG: ID 1024/D3498839      Fingerprint 0D99A7FB206605D7 8B35FCDE05B18A5E |
| http://www.fi.muni.cz/~kas/   Czech Linux Homepage: http://www.linux.cz/ |
|----------- If you want the holes in your knowledge showing up -----------|
|----------- try teaching someone.                  -- Alan Cox -----------|
