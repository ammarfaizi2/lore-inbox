Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275301AbRJYP4U>; Thu, 25 Oct 2001 11:56:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275126AbRJYP4L>; Thu, 25 Oct 2001 11:56:11 -0400
Received: from newssvr17-ext.news.prodigy.com ([207.115.63.157]:13008 "EHLO
	newssvr17.news.prodigy.com") by vger.kernel.org with ESMTP
	id <S275301AbRJYPz5>; Thu, 25 Oct 2001 11:55:57 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
Newsgroups: linux.dev.kernel
Subject: Re: fdisk: "File size limit exceeded on fdisk" 2.4.10 to 2.4.13-pre6
In-Reply-To: <Pine.LNX.4.33.0110242100070.14064-100000@viper.haque.net>
Organization: TMR Associates, Schenectady NY
From: davidsen@tmr.com (bill davidsen)
X-Newsreader: trn 4.0-test75 (Feb 13, 2001)
Originator: davidsen@deathstar.prodigy.com (Bill Davidsen)
Message-ID: <LCWB7.5048$ag6.923038958@newssvr17.news.prodigy.com>
NNTP-Posting-Host: 192.168.192.240
X-Complaints-To: abuse@prodigy.net
X-Trace: newssvr17.news.prodigy.com 1004025387 000 192.168.192.240 (Thu, 25 Oct 2001 11:56:27 EDT)
NNTP-Posting-Date: Thu, 25 Oct 2001 11:56:27 EDT
Date: Thu, 25 Oct 2001 15:56:27 GMT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.33.0110242100070.14064-100000@viper.haque.net>,
Mohammad A. Haque <mhaque@haque.net> wrote:
| On Thu, 25 Oct 2001, Tim Tassonis wrote:
| 
| > I'm quite suprised, but this actually worked for me. Rebooted without
| > using hdparm, created the partintion (3GB) and everything seems ok. Looks
| > as if hdparm is doing something wrong here (v3.6).
| >
| 
| More than likely it's just triggering something that causes the problem.

I haven't seen any problem, either. Certainly not with fdisk, this is
what I see:
================================================================
bilbo:root> hdparm -V
hdparm v3.9

bilbo:root> df
Filesystem           1k-blocks      Used Available Use% Mounted on
/dev/hda3               995896    849248     95240  90% /
/dev/hda4              4597818   2727382   1639502  62% /extra
/extra/u_local          193687     74214    109473  40% /usr/local
/dev/hde1              4079656   3611952    262908  93% /extra2
bilbo:root> fdisk /dev/hde

The number of cylinders for this disk is set to 39770.
There is nothing wrong with that, but this is larger than 1024,
and could in certain setups cause problems with:
1) software that runs at boot time (e.g., old versions of LILO)
2) booting and partitioning software from other OSs
   (e.g., DOS FDISK, OS/2 FDISK)

Command (m for help): p

Disk /dev/hde: 16 heads, 63 sectors, 39770 cylinders
Units = cylinders of 1008 * 512 bytes

   Device Boot    Start       End    Blocks   Id  System
/dev/hde1             1      8127   4095976+  83  Linux native
/dev/hde2          8128     28445  10240272   83  Linux native

Command (m for help): q
================================================================

I certainly have used hdparm on that drive, my controller comes up in
ATA33 by default, and I run 
  # enable the ATA/66 hard drive(s)
  #   experiment with -u1 after backup
  hdparm -d1 -X66 /dev/hde
out of rc.local to get it going. BP6 m/b, dual Celeron500, 
  Linux bilbo 2.4.10-ac7-2 #5 SMP Sun Oct 7 08:03:37 EDT 2001 i686 unknown
from the uname. This is NOT a preempt kernel, the patch against this one
blew up on SMP, although it booted "nosmp" just fine. I have trying
again with 2.4.13-pre6 this weekend.

Don't know if this sheds light on the topic, I certainly do run fdisk on
"drives" my RAID controller creates which have 600GB or so broken into
little 100GB files.

-- 
bill davidsen <davidsen@tmr.com>
  His first management concern is not solving the problem, but covering
his ass. If he lived in the middle ages he'd wear his codpiece backward.
