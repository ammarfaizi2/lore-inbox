Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312619AbSE2A1h>; Tue, 28 May 2002 20:27:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312681AbSE2A1g>; Tue, 28 May 2002 20:27:36 -0400
Received: from virtmail.zianet.com ([216.234.192.37]:50309 "HELO zianet.com")
	by vger.kernel.org with SMTP id <S312619AbSE2A1f>;
	Tue, 28 May 2002 20:27:35 -0400
Message-ID: <3CF3CDC6.6040500@zianet.com>
Date: Tue, 28 May 2002 12:34:46 -0600
From: kwijibo@zianet.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0+) Gecko/20020527
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Software RAID/Filesystem problems?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have run into a problem with software raid with large filesystems.
I am not sure if this is a software raid limitation or a filesystem
limitation.  I currently have two 3ware raid controllers that have
1.1TB (yes, terrabyte) of space on each.  I want to stripe the two
hardware raid controllers using software raid but when I try to make
the raid using the command mkraid /dev/md0 it pukes out this:

DESTROYING the contents of /dev/md0 in 5 seconds, Ctrl-C if unsure!
handling MD device /dev/md0
analyzing super-block
disk 0: /dev/sdb1, 1120597978kB, raid superblock at 1120597888kB
disk 1: /dev/sdc1, 1120597978kB, raid superblock at 1120597888kB
raid0: looking at sdb1
raid0:   comparing sdb1(1120597888) with sdb1(1120597888)
raid0:   END
raid0:   ==> UNIQUE
raid0: 1 zones
raid0: looking at sdc1
raid0:   comparing sdc1(1120597888) with sdb1(1120597888)
raid0:   EQUAL
raid0: FINAL 1 zones
raid0: zone 0
raid0: checking sdb1 ... contained as device 0
  (1120597888) is smallest!.
raid0: checking sdc1 ... contained as device 1
raid0: zone->nb_dev: 2, size: -2053771520
raid0: current zone offset: 1120597888
raid0: done.
raid0 : md_size is -2053771520 blocks.
raid0 : conf->smallest->size is -2053771520 blocks.
raid0 : nb_zone is 1.
raid0 : Allocating 8 bytes for hash.


Notice the huge negative numbers -2053771520.  I have tried this with
a couple different block sizes but it doesn't help.  When I build a 
filesystem
on it, in this case I am trying reiserfs, it builds it but in the 
message log I
have these errors:

09:00: rw=0, want=134217729, limit=-2053771520
attempt to access beyond end of device
09:00: rw=0, want=134217730, limit=-2053771520
attempt to access beyond end of device
09:00: rw=0, want=134217731, limit=-2053771520
attempt to access beyond end of device

There are quite a few, I didn't post them all.  Then when I mount the fs
it only reports it as about a 93GB filesystem instead of the 2.2TB it should
be.  I did this same configuration in RAID 1(mirror) and it all worked 
well, no
errors and the reported filesystem size was correct.  So I guess my question
is: Am I hitting a kernel limit here or a filesystem limit, or is this 
just a plain
ol bug?  What is the current maximum filesystem size?  I need to I can try
ext3 but it always takes a bit to format.  This is on RedHat 7.3 with the
stock 2.4.18-4smp kernel.  I also tried it with the standard 2.4.18 
kernel with
the same results.   Any suggestions/information would be appreciated.  Let
me know if any more info would help, I usually forget info that is 
important.

Here is a copy of my /etc/raidtab (currently set up for mirroring, not 
stripping)

raiddev /dev/md0
        raid-level      1
        nr-raid-disks   2
        persistent-superblock   1
        chunk-size      4
        device  /dev/sdb1
        raid-disk       0
        device  /dev/sdc1
        raid-disk       1

Thanks,
Steven




