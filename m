Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263231AbVCEAUe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263231AbVCEAUe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 19:20:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263421AbVCEASa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 19:18:30 -0500
Received: from smtp06.auna.com ([62.81.186.16]:54176 "EHLO smtp06.retemail.es")
	by vger.kernel.org with ESMTP id S263316AbVCDXzf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 18:55:35 -0500
Date: Fri, 04 Mar 2005 23:55:21 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: Something is broken with SATA RAID ?
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
References: <1109810381l.5754l.0l@werewolf.able.es>
	<20050303005210.GA1140@havoc.gtf.org>
In-Reply-To: <20050303005210.GA1140@havoc.gtf.org> (from jgarzik@pobox.com
	on Thu Mar  3 01:52:10 2005)
X-Mailer: Balsa 2.3.0
Message-Id: <1109980521l.13844l.0l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 03.03, Jeff Garzik wrote:
> On Thu, Mar 03, 2005 at 12:39:41AM +0000, J.A. Magallon wrote:
> > Hi...
> > 
> > I posted this in other mail, but now I can confirm this.
> > 
> > I have a box with a SATA RAID-5, and with 2.6.11-rc3-mm2+libata-dev1
> > works like a charm as a samba server, I dropped it 12Gb from an
> > osx client, and people does backups from W2k boxes and everything was fine.
> > With 2.6.11-rc4-mm1, it hangs shortly after the mac starts copying
> > files. No oops, no messages... It even hanged on a local copy (wget),
> > so I will discard samba as the buggy piece in the puzzle.
> > 
> > I'm going to make a definitive test with rc5-mm1 vs rc5-mm1+libata-dev1.
> > I already know that plain rc5-mm1 hangs. I have to wait the md reconstruction
> > of the 1.2 TB to check rc5-mm1+libata (and no user putting things there...)
> 
> Please eliminate -mm and -libata-dev from the equation.
> 

One piece at last...
I have tried
- 2.6.11
- 2.6.11 + libata-dev1 + netdev1 + shrinkers-at-tail + 1Gb-lowmem

Bot work fine and survived several gigas dumped both through smb and afp.
Happy man ;).

If there was something strange, it must be in -mm. rc5-mm1 did not work,
but plain 2.6.11 works. I will try 2.6.11-mm1 on monday...

Just a note. Net throughput seems a bit slower in the second case (measured
with iftop). And it degrades over time. With a 8 Gb copy, it started at
about 50Mb/s and dropped to 25 at the end. Not sure if the one to blame
is linux or osx...

Hardware (just for the record): 
2 x PDC20319 (FastTrak S150 TX4) (rev 02)
6 x 250Gb Maxtor 7Y250M0  YAR5, 3 on each.

RAID-5
nada:~# mdadm -D /dev/md0
/dev/md0:
        Version : 00.90.01
  Creation Time : Fri Sep  3 02:17:28 2004
     Raid Level : raid5
     Array Size : 1225557760 (1168.78 GiB 1254.97 GB)
    Device Size : 245111552 (233.76 GiB 250.99 GB)
   Raid Devices : 6
  Total Devices : 6
Preferred Minor : 0
    Persistence : Superblock is persistent

    Update Time : Fri Mar  4 21:34:00 2005
          State : clean
 Active Devices : 6
Working Devices : 6
 Failed Devices : 0
  Spare Devices : 0

         Layout : left-symmetric
     Chunk Size : 256K

           UUID : fd6fcad0:21da140b:072a82b1:11b3db21
         Events : 0.156336

    Number   Major   Minor   RaidDevice State
       0       8        1        0      active sync   /dev/sda1
       1       8       17        1      active sync   /dev/sdb1
       2       8       33        2      active sync   /dev/sdc1
       3       8       49        3      active sync   /dev/sdd1
       4       8       65        4      active sync   /dev/sde1
       5       8       81        5      active sync   /dev/sdf1

/dev/md0:
 Timing cached reads:   756 MB in  2.01 seconds = 376.93 MB/sec
 Timing buffered disk reads:  158 MB in  3.02 seconds =  52.26 MB/sec

Thanks.

--
J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
werewolf!able!es                         \         It's better when it's free
Mandrakelinux release 10.2 (Cooker) for i586
Linux 2.6.11-jam1 (gcc 3.4.3 (Mandrakelinux 10.2 3.4.3-3mdk)) #1


