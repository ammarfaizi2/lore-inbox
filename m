Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267835AbTB1MJJ>; Fri, 28 Feb 2003 07:09:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267829AbTB1MJJ>; Fri, 28 Feb 2003 07:09:09 -0500
Received: from compsciinn-gw.customer.ALTER.NET ([157.130.84.134]:56962 "EHLO
	picard.csi-inc.com") by vger.kernel.org with ESMTP
	id <S267821AbTB1MJC>; Fri, 28 Feb 2003 07:09:02 -0500
Message-ID: <015d01c2df23$9c22f020$f6de11cc@black>
From: "Mike Black" <mblack@csi-inc.com>
To: "linux-kernel" <linux-kernel@vger.kernel.org>,
       "linux-raid" <linux-raid@vger.kernel.org>
Subject: RAID SCSI binding
Date: Fri, 28 Feb 2003 07:19:15 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux 2.4.20 (but not unique to this kernel -- been this way for over a year):
I have a RAID5 array that doesn't startup properly during boot (I have to stop it and restart after the system is up).  I've had
this problem forever and have been trying to fix it.
Here's what it looks like when it's up and running:
md4 : active raid5 sdn1[0] sdt1[6] sds1[5] sdr1[4] sdq1[3] sdp1[2] sdo1[1]
     216490752 blocks level 5, 128k chunk, algorithm 0 [7/7] [UUUUUUU]
The partitions types are set to 0x83 and the array is being manually started in rc.local instead of doing auto-start.

I think I finally have and idea of what's happening.  The major device # may be confusing the RAID bootup process.

During boot the devices are listed properly but then they don't all get bound.

Feb 28 05:42:48 yeti kernel:  sda: sda1
Feb 28 05:42:48 yeti kernel:  sdb: sdb1
Feb 28 05:42:48 yeti kernel:  sdc: sdc1
Feb 28 05:42:48 yeti kernel:  sdd: sdd1
Feb 28 05:42:48 yeti kernel:  sde: sde1
Feb 28 05:42:48 yeti kernel:  sdf: sdf1
Feb 28 05:42:48 yeti kernel:  sdg: sdg1
Feb 28 05:42:48 yeti kernel:  sdh: sdh1
Feb 28 05:42:48 yeti kernel:  sdi: sdi1
Feb 28 05:42:48 yeti kernel:  sdj: sdj1
Feb 28 05:42:48 yeti kernel:  sdk: sdk1
Feb 28 05:42:48 yeti kernel:  sdl: sdl1
Feb 28 05:42:48 yeti kernel:  sdm: sdm1
Feb 28 05:42:48 yeti kernel:  sdn: sdn1
Feb 28 05:42:48 yeti kernel:  sdo: sdo1
Feb 28 05:42:48 yeti kernel:  sdp: sdp1
Feb 28 05:42:48 yeti kernel:  sdq: sdq1
Feb 28 05:42:48 yeti kernel:  sdr: sdr1
Feb 28 05:42:48 yeti kernel:  sds: sds1
Feb 28 05:42:48 yeti kernel:  sdt: sdt1
Feb 28 05:42:49 yeti kernel:  [events: 000000bc]
Feb 28 05:42:49 yeti kernel: md: bind<sdo1,1>
Feb 28 05:42:49 yeti kernel:  [events: 000000bc]
Feb 28 05:42:49 yeti kernel: md: bind<sdp1,2>
Feb 28 05:42:49 yeti kernel:  [events: 000000bc]
Feb 28 05:42:49 yeti kernel: md: bind<sdn1,3>
Feb 28 05:42:49 yeti kernel:  [events: 000000ab]
Feb 28 05:42:49 yeti kernel: md: bind<sdb1,1>
Feb 28 05:42:49 yeti kernel:  [events: 000000ab]
Feb 28 05:42:49 yeti kernel: md: bind<sdc1,2>
Feb 28 05:42:49 yeti kernel:  [events: 000000ab]
Feb 28 05:42:49 yeti kernel: md: bind<sda1,3>
Feb 28 05:42:49 yeti kernel:  [events: 000000ab]
Feb 28 05:42:49 yeti kernel: md: bind<sde1,4>
Feb 28 05:42:49 yeti kernel:  [events: 000000ab]
Feb 28 05:42:49 yeti kernel: md: bind<sdf1,5>
Feb 28 05:42:49 yeti kernel:  [events: 000000ab]
Feb 28 05:42:49 yeti kernel: md: bind<sdg1,6>
Feb 28 05:42:49 yeti kernel:  [events: 000000ab]
Feb 28 05:42:49 yeti kernel: md: bind<sdh1,7>
Feb 28 05:42:49 yeti kernel:  [events: 000000ab]
Feb 28 05:42:49 yeti kernel: md: bind<sdi1,8>
Feb 28 05:42:49 yeti kernel:  [events: 000000ab]
Feb 28 05:42:49 yeti kernel: md: bind<sdj1,9>
Feb 28 05:42:49 yeti kernel:  [events: 000000ab]
Feb 28 05:42:49 yeti kernel: md: bind<sdk1,10>
Feb 28 05:42:49 yeti kernel:  [events: 000000ab]
Feb 28 05:42:49 yeti kernel: md: bind<sdl1,11>
Feb 28 05:42:49 yeti kernel:  [events: 000000ab]
Feb 28 05:42:49 yeti kernel: md: bind<sdd1,12>
Feb 28 05:42:49 yeti kernel:  [events: 000000ab]
Feb 28 05:42:49 yeti kernel: md: bind<sdm1,13>

Note that sdq,sdr,sds , and sdt do not get an md: bind entry
The raid ends up in /proc/mdstat with just sdn,o,p in it.
I then stop and restart the array and everything is OK.
Feb 28 05:53:30 yeti kernel: md: md4 stopped.
Feb 28 05:53:30 yeti kernel: md: unbind<sdn1,2>
Feb 28 05:53:30 yeti kernel: md: export_rdev(sdn1)
Feb 28 05:53:30 yeti kernel: md: unbind<sdp1,1>
Feb 28 05:53:30 yeti kernel: md: export_rdev(sdp1)
Feb 28 05:53:30 yeti kernel: md: unbind<sdo1,0>
Feb 28 05:53:30 yeti kernel: md: export_rdev(sdo1)
Feb 28 05:53:34 yeti kernel:  [events: 000000bc]
Feb 28 05:53:34 yeti kernel: md: bind<sdo1,1>
Feb 28 05:53:34 yeti kernel:  [events: 000000bc]
Feb 28 05:53:34 yeti kernel: md: bind<sdp1,2>
Feb 28 05:53:34 yeti kernel:  [events: 000000bc]
Feb 28 05:53:34 yeti kernel: md: bind<sdq1,3>
Feb 28 05:53:34 yeti kernel:  [events: 000000bc]
Feb 28 05:53:34 yeti kernel: md: bind<sdr1,4>
Feb 28 05:53:34 yeti kernel:  [events: 000000bc]
Feb 28 05:53:34 yeti kernel: md: bind<sds1,5>
Feb 28 05:53:34 yeti kernel:  [events: 000000bc]
Feb 28 05:53:34 yeti kernel: md: bind<sdt1,6>
Feb 28 05:53:34 yeti kernel:  [events: 000000bc]
Feb 28 05:53:34 yeti kernel: md: bind<sdn1,7>
Feb 28 05:53:34 yeti kernel: md: sdn1's event counter: 000000bc
Feb 28 05:53:34 yeti kernel: md: sdt1's event counter: 000000bc
Feb 28 05:53:34 yeti kernel: md: sdn1's event counter: 000000bc
Feb 28 05:53:34 yeti kernel: md: sdt1's event counter: 000000bc
Feb 28 05:53:34 yeti kernel: md: sds1's event counter: 000000bc
Feb 28 05:53:34 yeti kernel: md: sdr1's event counter: 000000bc
Feb 28 05:53:34 yeti kernel: md: sdq1's event counter: 000000bc
Feb 28 05:53:34 yeti kernel: md: sdp1's event counter: 000000bc
Feb 28 05:53:34 yeti kernel: md: sdo1's event counter: 000000bc
Feb 28 05:53:34 yeti kernel: md4: max total readahead window set to 3072k
Feb 28 05:53:34 yeti kernel: md4: 6 data-disks, max readahead per data-disk: 512k
Feb 28 05:53:34 yeti kernel: raid5: device sdn1 operational as raid disk 0
Feb 28 05:53:34 yeti kernel: raid5: device sdt1 operational as raid disk 6
Feb 28 05:53:34 yeti kernel: raid5: device sds1 operational as raid disk 5
Feb 28 05:53:34 yeti kernel: raid5: device sdr1 operational as raid disk 4
Feb 28 05:53:34 yeti kernel: raid5: device sdq1 operational as raid disk 3
Feb 28 05:53:34 yeti kernel: raid5: device sdp1 operational as raid disk 2
Feb 28 05:53:34 yeti kernel: raid5: device sdo1 operational as raid disk 1
Feb 28 05:53:34 yeti kernel: raid5: allocated 7483kB for md4
Feb 28 05:53:34 yeti kernel: md: updating md4 RAID superblock on device
Feb 28 05:53:34 yeti kernel: md: sdn1 [events: 000000bd]<6>(write) sdn1's sb offset: 36081856
Feb 28 05:53:34 yeti kernel: md: sdt1 [events: 000000bd]<6>(write) sdt1's sb offset: 36081856
Feb 28 05:53:34 yeti kernel: md: sds1 [events: 000000bd]<6>(write) sds1's sb offset: 36081856
Feb 28 05:53:34 yeti kernel: md: sdr1 [events: 000000bd]<6>(write) sdr1's sb offset: 36081856
Feb 28 05:53:34 yeti kernel: md: sdq1 [events: 000000bd]<6>(write) sdq1's sb offset: 36081856
Feb 28 05:53:34 yeti kernel: md: sdp1 [events: 000000bd]<6>(write) sdp1's sb offset: 36081856
Feb 28 05:53:34 yeti kernel: md: sdo1 [events: 000000bd]<6>(write) sdo1's sb offset: 36081856


I noticed that the major node is different starting at sdq.

brw-rw----    1 root     disk       8, 208 Feb 22  2002 /dev/sdn
brw-rw----    1 root     disk       8, 224 Feb 22  2002 /dev/sdo
brw-rw----    1 root     disk       8, 240 Feb 22  2002 /dev/sdp
brw-rw----    1 root     disk      65,   0 Feb 22  2002 /dev/sdq
brw-rw----    1 root     disk      65,  16 Feb 22  2002 /dev/sdr
brw-rw----    1 root     disk      65,  32 Feb 22  2002 /dev/sds
brw-rw----    1 root     disk      65,  48 Feb 22  2002 /dev/sdt

So it looks to me like the md driver doesn't like the raid system crossing the major device boundary for some odd reason.
Although I'm not sure why I can stop and restart after the system is totally up but not start it in rc.local using the same
commands:

We're not hitting the 27 maximum disks so that isn't it.

Looking thru the code in md.c I don't quite see where the problem is (or may be).

Michael D. Black mblack@csi-inc.com
http://www.csi-inc.com/
http://www.csi-inc.com/~mike
321-676-2923, x203
Melbourne FL

