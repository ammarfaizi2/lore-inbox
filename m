Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262587AbUCENAy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 08:00:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262588AbUCENAy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 08:00:54 -0500
Received: from butters.phys.uwm.edu ([129.89.57.31]:11710 "EHLO
	butters.phys.uwm.edu") by vger.kernel.org with ESMTP
	id S262587AbUCENAu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 08:00:50 -0500
Date: Fri, 5 Mar 2004 07:00:47 -0600 (CST)
From: Paul Armor <parmor@gravity.phys.uwm.edu>
X-X-Sender: parmor@butters.phys.uwm.edu
To: linux-kernel@vger.kernel.org
Subject: 2.4.24 AIC7xxx kernel messages
Message-ID: <Pine.LNX.4.44.0403050638300.14927-100000@butters.phys.uwm.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Please include me in responses, as I'm not currently subscribed.

Googling and searching various archives, I can't find more than passing 
references to my problem, so I'll ask here.  Has anyone else seen anything 
like this, or can anyone offer suggestions as to what may be wrong?  I've 
got an Adaptec 29160, off of which I've got 4 Promise UltraTrak SX8000's, 
across which I'm striping software RAID.  Sometimes, when under heavy 
load, the kernel will log lot's of messages, starting with:

Mar  5 03:47:15 storage2 kernel: scsi0:0:0:0: Attempting to queue an ABORT 
message
Mar  5 03:47:15 storage2 kernel: CDB: 0x28 0x0 0x27 0xaa 0xe5 0x57 0x0 0x0 
0x10 0x0
Mar  5 03:47:15 storage2 kernel: scsi0: At time of recovery, card was not 
paused
Mar  5 03:47:15 storage2 kernel: >>>>>>>>>>>>>>>>>> Dump Card State Begins 
<<<<<<<<<<<<<<<<<
Mar  5 03:47:15 storage2 kernel: scsi0: Dumping Card State in Data-in 
phase, at SEQADDR 0x54
Mar  5 03:47:15 storage2 kernel: Card was paused


...after which it will list SCB stats and info.
	This last occurance started after the machine had been copying 
data from one striped partition to another (it was ~250GB/1.1TB complete), 
and the log messages stopped ~11 minutes later; and the cp has continued.  
It seems as though the card/kernel/external arrays will work well together 
for many hours, get into this state for a few minutes, then work for many 
more hours, etc...  Any comments or suggestions would be GREATLY 
appreciated.

Here is the config:

> motherboard -                 Asus A7M266
>
> kernel -              linux-2.4.24
>
> controller -          Adaptec AIC7xxx driver version: 6.2.36
>                       Adaptec 29160 Ultra160 SCSI adapter
>                       aic7892: Ultra160 Wide Channel A, SCSI Id=7, 
32/253 SCBs
>
> ext. RAID arrays -    4 x Promise UltraTrak SX8000
>                       F/W version 1.1.0.30 (2/4/2003)
>
> Each box has three partitions
>
> We're running software raid 0 striping across the 4 boxes such that
>     md0=sd[abcd]1, md1=sd[abcd]2, md2=sd[abcd]3.

