Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314225AbSD0OqG>; Sat, 27 Apr 2002 10:46:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314226AbSD0OqF>; Sat, 27 Apr 2002 10:46:05 -0400
Received: from gear.torque.net ([204.138.244.1]:56332 "EHLO gear.torque.net")
	by vger.kernel.org with ESMTP id <S314225AbSD0OqD>;
	Sat, 27 Apr 2002 10:46:03 -0400
Message-ID: <3CCAB8AB.6AB00A09@torque.net>
Date: Sat, 27 Apr 2002 10:41:47 -0400
From: Douglas Gilbert <dougg@torque.net>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.5.9-dj1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Michael Mertins <mime@gmx.li>, linux-kernel@vger.kernel.org
Subject: Re: ide-scsi-emulation bugreport 
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Mertins <mime@gmx.li> wrote:
> for a while burning runs fine but then always the following error occurs no
> matter what 2.4 kernel I use. So I am living with this error for quite a
> while already but since it is not getting better with each new kernel I install I
> feel urged to submit this.
<snip/>

Michael,
Below is my stock reply to that question, taken from my
sg FAQ [ http://www.torque.net/sg/faq.html ].

Hope this helps.

Doug Gilbert

vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv


In the linux 2.4 kernel series there has been an increase in problems when the ide-scsi
driver is used so that cdrecord can control ATAPI (IDE) cd writers. The problem may be
related to the aggressive manner in which the IDE subsystem attempts to optimize the speed
of transfers to devices it controls. Some people experiencing timeouts and machine lockups
have found that reducing the DMA setting via the hdparm command has fixed the problem. If
the cd writer is connected to /dev/hdd then users have reported success with these 2
commands:
    hdparm -d0 -c1 /dev/hdd
    hdparm -d 1 -X 34 /dev/hdd
The first one turns off DMA completely while the second one sets it "multiword DMA mode
2". Cd writers do not need the types of speeds that modern disks utilize. Even burning at
"x16" implies a sustained transfer rate of 16 times 150 KB/sec which is approximately 2.4
MB/sec, not really that fast. There has also been a report that moving a cd writer off a
high speed IDE controller (Promise) and back to the motherboard's lower speed IDE
controllers has fixed a random IDE bus reset problem. Another report suggests reducing (or
turning off) the DMA on the IDE hard disk can also stop lockups. Jörg Schilling states
that DMA should be used for burn speeds greater tha "x12". The lowest IDE DMA speed of 33
MB/sec should be sufficient for the foreseeable future.
