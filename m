Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269326AbRIBVO5>; Sun, 2 Sep 2001 17:14:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269356AbRIBVOu>; Sun, 2 Sep 2001 17:14:50 -0400
Received: from f22.law3.hotmail.com ([209.185.241.22]:57098 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S269326AbRIBVOo>;
	Sun, 2 Sep 2001 17:14:44 -0400
X-Originating-IP: [65.25.189.2]
From: "John William" <jw2357@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: TMSCSIM module bug in 2.2.19?
Date: Sun, 02 Sep 2001 21:14:58 
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F22vtiy4jaxeQthTQ5n00005fc3@hotmail.com>
X-OriginalArrivalTime: 02 Sep 2001 21:14:58.0624 (UTC) FILETIME=[52246C00:01C133F4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While playing around with the tmscsim.o driver included with 2.2.19, I have 
the following problem.

One of my drives (Seagate Hawk) does not properly negotiate SYNC with the 
driver on boot up. After the machine is booted, I have to issue an INQUIRY 
command to the tmscsim driver to get it to recognize that the drive is SYNC 
capable.

Today, I noticed that every time I issue the INQUIRY command (with a 'echo 
"INQUIRY 0" > /proc/scsi/tmscsim/0") I get an error. Doing this on an 
otherwise quiet machine (no other processes acessing the disk) gives me the 
following:

Sep  2 16:13:54 cx kernel:  DC390: Issue INQUIRY command to Dev(Idx)
0 SCSI ID 0 LUN 0
Sep  2 16:13:54 cx kernel: DC390: Queue INQUIRY command to dev ID 00
LUN 00
Sep  2 16:13:54 cx kernel: SCSI disk error : host 0 channel 0 id 0 lu
n 0 return code = 8000000
Sep  2 16:13:54 cx kernel: [valid=0] Info fld=0x0, Current sd08:06: s
ense key Aborted Command
Sep  2 16:13:54 cx kernel: Additional sense indicates Overlapped comm
ands attempted
Sep  2 16:13:54 cx kernel: scsidisk I/O error: dev 08:06, sector 3714

The sector number is not the same every time, but appears to be some sort of 
remnant of the last disk access before the INQUIRY command was run. This is 
repeatable on my machine (and, I suspect, may be why the module doesn't 
properly negotiate SYNC on boot-up).

The interesting point is that even with this (apparent) failure, the driver 
correctly sets the SYNC attribute for the drive.

This is on a stock 2.2.19 machine, i386 SMP (dual Pentium).

Any ideas?

- John


_________________________________________________________________
Get your FREE download of MSN Explorer at http://explorer.msn.com/intl.asp

