Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130153AbRAXMTb>; Wed, 24 Jan 2001 07:19:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131253AbRAXMTV>; Wed, 24 Jan 2001 07:19:21 -0500
Received: from ikar.t17.ds.pwr.wroc.pl ([156.17.210.253]:15877 "HELO
	ikar.t17.ds.pwr.wroc.pl") by vger.kernel.org with SMTP
	id <S130153AbRAXMTI>; Wed, 24 Jan 2001 07:19:08 -0500
Date: Wed, 24 Jan 2001 13:14:31 +0100
From: Arkadiusz Miskiewicz <misiek@pld.ORG.PL>
To: linux-kernel@vger.kernel.org, chaffee@cs.berkeley.edu
Subject: vfat <-> vfat copying of ~700MB file, so slow!
Message-ID: <20010124131431.A19957@ikar.t17.ds.pwr.wroc.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
X-URL: http://www.t17.ds.pwr.wroc.pl/~misiek/ipv6/
X-Operating-System: Linux dark 4.0.20 #119 Tue Jan 16 12:21:53 MET 2001 i986 pld
Organization: Polish(ed) Linux Distribution Team
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Copying between vfat <-> vfat partitions is so slow. It seems
that it's vfat/msdos kernel driver problem because I tried to copy
this file between few partitions (all these on the same disc):

hda: IBM-DTLA-307030, ATA DISK drive
hda: 60036480 sectors (30739 MB) w/1916KiB Cache, CHS=3737/255/63, UDMA(33)

hdparm settings:
/dev/hda:
 multcount    = 16 (on)
 I/O support  =  0 (default 16-bit)
 unmaskirq    =  0 (off)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 nowerr       =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 3737/255/63, sectors = 60036480, start = 0

I tried it on 2.4.0 kernel, P166MMX, 96MB RAM, Soyo 5XB5 mainboard:
00:00.0 Host bridge: Intel Corporation 430TX - 82439TX MTXC (rev 01)
00:07.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01)

File was about 700MB and:

vfat -> ext2 -- by whole time, copying speed was about 3,6-3,8MB/s
ext2 -> vfat -- similar results
vfat -> vfat -- 3,4MB/s at beggining of copying,
		2,3MB/s after 1 minute of copying,
		1,7MB/s - 2 min,
		1,4MB/s - 3 min
		1,3MB/s - 4   - about 45% of file already copied
		1,2MB/s	- 5   - 51%
		1,1MB/s	- 6   - 58%
		1,0MB/s	- 7   - 63%
		1,0MB/s - 8   - 67%
		0,95MB/s - 9  - 72%
		0,91MB/s - 10 - 76%
		0,87MB/s - 11 - 81%
		0,84MB/s - 12 - 85%
		0,81MB/s - 13 -	88%
		0,78MB/s - 14 - 92%
		0,76MB/s - 15 - 96%
		0,74MB/s - 16 minute, 99% of file

so average speed is about 730kb/s only !!! I was copying under midnight
commander (4.5.51) so these speed values are from mc.

Patches or comments welcome.

-- 
Arkadiusz Mi¶kiewicz, AM2-6BONE    [ PLD GNU/Linux IPv6 ]
http://www.t17.ds.pwr.wroc.pl/~misiek/ipv6/   [ enabled ]
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
