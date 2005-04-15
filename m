Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261802AbVDOLHl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261802AbVDOLHl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 07:07:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261804AbVDOLHl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 07:07:41 -0400
Received: from smtp1.poczta.interia.pl ([217.74.65.44]:28194 "EHLO
	smtp.poczta.interia.pl") by vger.kernel.org with ESMTP
	id S261802AbVDOLHZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 07:07:25 -0400
Message-ID: <425FA069.9040602@interia.pl>
Date: Fri, 15 Apr 2005 13:07:21 +0200
From: Tomasz Chmielewski <mangoo@interia.pl>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andre Bender <andre.bender@gmx.de>, linux-kernel@vger.kernel.org
Subject: Re: poor SATA performance under 2.6.11 (with < 2.6.11 is OK)?
References: <425E9902.8000804@interia.pl> <20050414165535.GA15440@irc.pl> <425EE9CF.4030202@interia.pl> <20050414223417.GA23013@shell0.pdx.osdl.net> <425F6C48.9060505@interia.pl> <425F6E27.6040903@gmx.de>
In-Reply-To: <425F6E27.6040903@gmx.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-EMID: af9a8acc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andre Bender wrote:

>>OK so Tomasz Torch suggested that my drive was blacklisted somewhere
>>after 2.6.8.1 (it's the last kernel on which I have good performance).
>>
>>Does drive blacklisting = very poor performance?
>>And no drive blacklisting = good performance, and possibly data corruption?
> 
> 
> That's what has already been told some posts ago. The kernel developers
> don't blacklist anything that works just for fun. There seems to be a
> serious problem when combining this pieces of hardware so the
> combination is blacklisted to get it working properly but with (much)
> less performance.

I see, there were people reporting "drive hangups".
They were reporting it happens quite quickly.

I don't experience those under 2.6.8.1, in which my drive wasn't 
blacklisted yet (it seems it got blacklisted in 2.6.11, see this link
http://www.linuxhq.com/kernel/v2.6/11-rc2-bk6/drivers/scsi/sata_sil.c ).

My setup is SiI 3112 SATA PCI controller, 2x Seagate Barracuda 200 GB, 8 
MB cache, 7200 rpm (Model: ST3200822AS ) connected into one Linux md0 
raid1, ext3 filesystem on md0.

I am running several tests:

1) creating 1 GB file from /dev/zero using dd, then calculating it's 
md5sum (it should always be the same; it stresses drive, too), then 
copying it with a new name, calculating md5sum again - if it doesn't 
match, the script will quit

I run two of these tests in parallel.


2) tar'ring / to a file (so it opens many files), then calculating its 
md5sum (md5sums will differ, but it stresses the drive)


3) copying /dev/hda1 partition (which is 800 megs big on an IDE disk) to
Seagate SATA drives, then calculating it's md5sum (which should be 
always the same, as /dev/hda1 is not used)


4) rsyncing / to /root/test4, then removing it - so it opens many files 
and creates many, too.


These 4 tests are running simultaneously, each in a loop.
I believe it is quite stressing for the drives.

So far no hangup, weird system log, etc. unexpected behaviour.
It's 4 hours they are running now, I know it's not much, but people 
reported almost instant hangups.

Or perhaps my "tests" are wrong?


# cat /proc/scsi/scsi
Attached devices:
Host: scsi1 Channel: 00 Id: 00 Lun: 00
   Vendor: ATA      Model: ST3200822AS      Rev: 3.01
   Type:   Direct-Access                    ANSI SCSI revision: 05
Host: scsi2 Channel: 00 Id: 00 Lun: 00
   Vendor: ATA      Model: ST3200822AS      Rev: 3.01
   Type:   Direct-Access                    ANSI SCSI revision: 05


# lspci -vv (for SiI 3112 SATA PCI controller):

02:09.0 Unknown mass storage controller: Silicon Image, Inc. (formerly 
CMD Technology Inc) SiI 3112 [SATALink/SATARaid] Serial ATA Controller 
(rev 02)
         Subsystem: Silicon Image, Inc. (formerly CMD Technology Inc) 
SiI 3112 SATALink Controller
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
         Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 64, cache line size 08
         Interrupt: pin A routed to IRQ 11
         Region 0: I/O ports at 4800 [size=8]
         Region 1: I/O ports at 4400 [size=4]
         Region 2: I/O ports at 4000 [size=8]
         Region 3: I/O ports at 3c00 [size=4]
         Region 4: I/O ports at 3800 [size=16]
         Region 5: Memory at d0101400 (32-bit, non-prefetchable) [size=512]
         Expansion ROM at <unassigned> [disabled] [size=512K]
         Capabilities: [60] Power Management version 2
                 Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=2 PME-


Tomek

----------------------------------------------------------------------
Startuj z INTERIA.PL! >>> http://link.interia.pl/f186c 

