Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261643AbVBWWRN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261643AbVBWWRN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 17:17:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261621AbVBWWOa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 17:14:30 -0500
Received: from mailwasher.lanl.gov ([192.65.95.54]:43476 "EHLO
	mailwasher-b.lanl.gov") by vger.kernel.org with ESMTP
	id S261648AbVBWWKq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 17:10:46 -0500
Message-ID: <421CFF5E.4030402@mesatop.com>
Date: Wed, 23 Feb 2005 15:10:38 -0700
From: Steven Cole <elenstev@mesatop.com>
User-Agent: Mozilla Thunderbird 1.0 (Macintosh/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Steven Cole <elenstev@mesatop.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc4-mm1 (VFS: Cannot open root device "301")
References: <20050223014233.6710fd73.akpm@osdl.org>	<421CB161.7060900@mesatop.com> <20050223121759.5cb270ee.akpm@osdl.org>
In-Reply-To: <20050223121759.5cb270ee.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-PMX-Version: 4.7.0.111621
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Steven Cole <elenstev@mesatop.com> wrote:

>> I am having trouble getting recent -mm kernels to boot on my test box.
>> For 2.6.11-rc3-mm2 and 2.6.11-rc4-mm1 I get the following:
>>
>> VFS: Cannot open root device "301" or unknown-block(3,1)
>> Please append a correct "root=" boot option
>> Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(3,1)
>>
[snipped]
> 
> Please set CONFIG_BASE_FULL=y.  Check that this causes CONFIG_BASE_SMALL=0,
> then retest.

Yes, that worked.  2.6.11-rc4-mm1 now boots OK, but hdb1 seems to be missing.

[root@spc1 steven]# uname -r
2.6.11-rc4-mm1-GX110
[root@spc1 steven]# mount -t reiser4 /dev/hdb1 /reiser4_testing
mount: special device /dev/hdb1 does not exist

Reading another post (and looking in /dev), I tried hdq:

[root@spc1 steven]# mount -t reiser4 /dev/hdq1 /reiser4_testing
[root@spc1 steven]# df -T
Filesystem    Type    Size  Used Avail Use% Mounted on
/dev/hda1     ext3    304M   75M  214M  26% /
/dev/hda9 reiserfs    8.3G  3.9G  4.4G  48% /home
/dev/hda8     ext3    464M  8.1M  432M   2% /tmp
/dev/hda6     ext3    7.4G  1.7G  5.4G  24% /usr
/dev/hda7     ext3    1.9G   86M  1.7G   5% /var
/dev/hdq1  reiser4     18G  217M   18G   2% /reiser4_testing

Snipped from dmesg:

hda: ST320423A, ATA DISK drive
hdb: WDC WD200BB-75AUA1, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: SONY CD-RW CRX160E, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
Probing IDE interface ide2...
Probing IDE interface ide3...
Probing IDE interface ide4...
Probing IDE interface ide5...
hda: max request size: 128KiB
hda: 40011300 sectors (20485 MB) w/512KiB Cache, CHS=39693/16/63, UDMA(66)
hda: cache flushes not supported
  /dev/ide/host0/bus0/target0/lun0: p1 p2 < p5 p6 p7 p8 p9 >
hdb: max request size: 128KiB
hdb: 39102336 sectors (20020 MB) w/2048KiB Cache, CHS=38792/16/63, UDMA(66)
hdb: cache flushes not supported
  /dev/ide/host0/bus0/target1/lun0: p1


Steven
