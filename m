Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318772AbSH1KpB>; Wed, 28 Aug 2002 06:45:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318779AbSH1KpB>; Wed, 28 Aug 2002 06:45:01 -0400
Received: from uni-sb.de ([134.96.252.33]:40925 "EHLO uni-sb.de")
	by vger.kernel.org with ESMTP id <S318772AbSH1Ko7>;
	Wed, 28 Aug 2002 06:44:59 -0400
Date: Wed, 28 Aug 2002 12:49:15 +0200
Message-Id: <200208281049.g7SAnFX7004638@pixel.cs.uni-sb.de>
From: Georg Demme <gdemme@graphics.cs.uni-sb.de>
To: linux-kernel@vger.kernel.org
Subject: Server Hangups
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

this may not be an kernel issue, but the kernel-mailing-list is
something like my last resort in solving our problem.


SYMPTOMS:
While accessing file/dirs users experience hangups of under one second
up to several seconds.

At this point you may think: "Why is this a kernel issue?". Well,
maybe it is, maybe not. But I am running out of alternatives to
check (see section TESTS) and people to ask. After 2 MONTHS of tests,
I am still unable to pin down the problem. So here comes the whole story.
I hope to reach someone with more experience and am looking forward
for hints.


SYSTEM (current):
The following section describes the current hardware. See TESTS for
more.

Hardware:
- Dual PIII 1000, Abit VP6 Mainboard
- e1000 Pro Ethnernet
- 3Ware Escalade 7810 Raid with 4 disks (254GB total), ext3
- Adpatec 2940 w/ attached Overland 4810 Changer

Software (current):
- kernel 2.4.19
- Debian woody
- many services: nfs, imap, apache, mysql

Environment:
- 50 hosts in subnet
- 20 to 30 users average


TESTS:
Oberservations in conjunction with hangups
- whenever a hangup occurrs, the load on the server is more than 3
- when playing a video from (via nfs) or on the server there are
  hangups during playing (short under 1s)

The following tests were done an yield no result so far.
Hardware:
- exchanged raid disks with similar raid in a
  PIII 1133, Netgear GA630, Asus MB
- attached net to other swith over 100MBit

Software:
- kernel 2.4.9, 2.4.9-ac9-ext3, 2.4.16, 2.4.19
- ext3 -> ext2
- ext3 with data=ordered. data=writeback
- nfsd
  + rec-q to 256K per thread
  + changed number of nfsd's from 8 to 16 to 4
- network: no significant packet loss / collisions / failed
  reassemblies 
- firmware upgrade of the raid to 7.5

Reconstrution of the hangups:
In order to reconstruct the hangups, I did the following tests:
- Kernel compile from: 2,4,8 client hosts (-j 4/8)
- copy large files in parallel (well that created hangups, but I think
  due to too heavy disk io)
- network load with dd from several hosts

Monitoring:
- proc/stat (average of several days)
  + 125 interrupts/s
  + 173 page ins/s
  + 204 page out/s
  + 12 read operations/s on raid
  + 21 write operations/s on raid
- top (average of several days)
  + 1.5 load
  + 90% idle
- if you like more infos, simply ask. We are currently monitoring over
  30 statistical system values. Only the most important mentioned
  here.

Are there any recommended values to be monitored in case of hangs?


Since the hangups do not produce any log messages/errors, are there
any tools to monitor which proccesses hang? Something like a profiler?


Since the variety of things to check is so vast, I hope someone can
point me to a direction which may be worth going. Currently we are
three people just randomly switching off services or exchaning
hardware and then watching what happens. A very inefficient and
time-consuming (and at least frustrating) way of searching a
solution.

Since this is a very abstract problem and I have no glue if it is
really a kernel-problem, I would the thankful if you can give me some
more mailing lists where to post this message.
  
-- 
______________________________________________________________
sent by gdemme@cs.uni-sb.de                    - Georg Demme - 
http://graphics.cs.uni-sb.de/~gdemme/    Tel: +49 681/302-3834
Universität des Saarlandes       -      Gebäude 36.1, Raum E15
