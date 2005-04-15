Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261986AbVDOWPV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261986AbVDOWPV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 18:15:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261988AbVDOWPV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 18:15:21 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:23283 "EHLO
	dhcp153.mvista.com") by vger.kernel.org with ESMTP id S261986AbVDOWPL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 18:15:11 -0400
Date: Fri, 15 Apr 2005 15:15:09 -0700 (PDT)
From: Daniel Walker <dwalker@mvista.com>
To: mingo@elte.hu
cc: linux-kernel@vger.kernel.org
Subject: Slab Corruption and RT
Message-ID: <Pine.LNX.4.44.0504151451030.30537-100000@dhcp153.mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



I get Slab corruption while repeatedly loading and unloading small (3k) 
executables that just loop calling gettimeofday().. The 
"last user" is alway __mmdrop() . This only happens under RT ..

I think this is related to a problem observed by Steven Rostedt . 

Another trigger is to run bonnie++ with 2timer_test (from high res 
timers/libposixtime) run repeatedly. In this case, you end up Slab 
corruption and with a corrupted timer list which leads to an OOPS.


Daniel



<3>Slab corruption: start=c1972424, len=940
Slab corruption: start=c1972424, len=940
<3>Redzone: 0x5a2cf071/0x5a2cf071.
Redzone: 0x5a2cf071/0x5a2cf071.
<3>Last user: [<c003dbb4>]Last user: 
[<c003dbb4>](__mmdrop+0xa0/0xe0)(__mmdrop+0xa0/0xe0)

<3>0c0:0c0: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6a 6a 6b 6b 6b 
6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b

<3>Prev obj: start=c197206c, len=940
Prev obj: start=c197206c, len=940
<3>Redzone: 0x170fc2a5/0x170fc2a5.
Redzone: 0x170fc2a5/0x170fc2a5.
<3>Last user: [<c003dabc>]Last user: 
[<c003dabc>](mm_alloc+0x1c/0x74)(mm_alloc+0x1c/0x74)

<3>000:000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00

<3>010:010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 40 40 00 00 00 00 af af c1 c1

<3>Next obj: start=c19727dc, len=940
Next obj: start=c19727dc, len=940
<3>Redzone: 0x170fc2a5/0x170fc2a5.
Redzone: 0x170fc2a5/0x170fc2a5.
<3>Last user: [<c003dabc>]Last user: 
[<c003dabc>](mm_alloc+0x1c/0x74)(mm_alloc+0x1c/0x74)

<3>000:000: 9c 9c 71 71 f9 f9 c1 c1 94 94 2d 2d c4 c4 c1 c1 1c 1c 7f 7f f9 
f9 c1 c1 68 68 dc dc 02 02 c0 c0

<3>010:010: 78 78 2c 2c 07 07 c0 c0 00 00 00 00 00 00 40 40 00 00 20 20 1a 
1a 40 40 00 00 00 00 a7 a7 c1 c1




