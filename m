Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261814AbVCYVXm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261814AbVCYVXm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 16:23:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261812AbVCYVXm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 16:23:42 -0500
Received: from mailwasher.lanl.gov ([192.65.95.54]:39231 "EHLO
	mailwasher-b.lanl.gov") by vger.kernel.org with ESMTP
	id S261814AbVCYVW7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 16:22:59 -0500
Message-ID: <4244812C.3070402@mesatop.com>
Date: Fri, 25 Mar 2005 14:22:52 -0700
From: Steven Cole <elenstev@mesatop.com>
User-Agent: Thunderbird 1.0 (Multics)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc1-mm3 (cannot read cd-rom, 2.6.12-rc1 is OK)
References: <20050325002154.335c6b0b.akpm@osdl.org>	<42446B86.7080403@mesatop.com>	<424471CB.3060006@mesatop.com> <20050325122433.12469909.akpm@osdl.org>
In-Reply-To: <20050325122433.12469909.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-PMX-Version: 4.7.0.111621
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Steven Cole <elenstev@mesatop.com> wrote:
> 
>> > [   49.198779] EXT3-fs: mounted filesystem with ordered data mode.
>> > [   56.310394] PCI: Found IRQ 5 for device 0000:01:0c.0
>> > [  222.804956] rock: directory entry would overflow storage
>> > [  222.804978] rock: sig=0x5245, size=8, remaining=0
>> > [  235.551953] rock: directory entry would overflow storage
>> > [  235.551969] rock: sig=0x5850, size=36, remaining=34
>> > [  235.551976] rock: directory entry would overflow storage
>> > [  235.551981] rock: sig=0x5850, size=36, remaining=34
>> > 
>> > Sorry, I don't have the time to do further troubleshooting, but I
>> > hope this is enough information.  The .config for this machine was
>> > posted earlier in another thread here:
>> > http://marc.theaimsgroup.com/?l=linux-kernel&m=111167720523853&w=2
>> > 
>> > Steven
>>
>> I found a few more minutes to test two more kernels.  The problem
>> first occured with 2.6.12-rc1-mm2:
>>
>> 2.6.12-rc1     reads the cd-rom OK as reported earlier
>> 2.6.12-rc1-mm1 also reads the cd-rom OK
>> 2.6.12-rc1-mm2 broken same as -mm3 described as above
>> 2.6.12-rc1-mm3 broken as reported earlier
> 
> 
> Are you really really sure about that?  -mm3 included both the bk-ide-dev
> tree and the isofs changes.  2.6.12-rc1-mm2 had neither.
> 

Just to be really really sure, I repeated the tests.  I even checked
that the image/label combination in /etc/lilo.conf was what I intended,
but the uname -r should show what's what.

Same results, -mm2 broken, and -mm1 reads the disk.  I even tried
other CD's just to make sure I didn't have something weird.  Same results.

[root@spc1 steven]# uname -r
2.6.12-rc1-mm2-GX110
[root@spc1 steven]# mount /dev/hdc /mnt/cdrom
mount: block device /dev/hdc is write-protected, mounting read-only
[root@spc1 steven]# df -T
Filesystem    Type    Size  Used Avail Use% Mounted on
/dev/hda1     ext3    304M   96M  193M  34% /
/dev/hda9 reiserfs    8.3G  7.5G  818M  91% /home
/dev/hda8     ext3    464M  8.1M  432M   2% /tmp
/dev/hda6     ext3    7.4G  1.5G  5.5G  22% /usr
/dev/hda7     ext3    1.9G   96M  1.7G   6% /var
/dev/hdc   iso9660    2.9M  2.9M     0 100% /mnt/cdrom
[root@spc1 steven]# ls -l /mnt/cdrom
total 0
[root@spc1 steven]# dmesg | tail
[   51.205871] EXT3 FS on hda6, internal journal
[   51.205880] EXT3-fs: mounted filesystem with ordered data mode.
[   51.234132] kjournald starting.  Commit interval 5 seconds
[   51.234544] EXT3 FS on hda7, internal journal
[   51.234553] EXT3-fs: mounted filesystem with ordered data mode.
[   58.357329] PCI: Found IRQ 5 for device 0000:01:0c.0
[  146.301026] rock: directory entry would overflow storage
[  146.301044] rock: sig=0x5245, size=8, remaining=0
[  158.388397] rock: directory entry would overflow storage
[  158.388415] rock: sig=0x5850, size=36, remaining=34
[root@spc1 steven]#

Machine rebooted here.

[root@spc1 steven]# uname -r
2.6.12-rc1-mm1-GX110
[root@spc1 steven]# mount /dev/hdc /mnt/cdrom
mount: block device /dev/hdc is write-protected, mounting read-only
[root@spc1 steven]# df -T
Filesystem    Type    Size  Used Avail Use% Mounted on
/dev/hda1     ext3    304M   96M  193M  34% /
/dev/hda9 reiserfs    8.3G  7.5G  818M  91% /home
/dev/hda8     ext3    464M  8.1M  432M   2% /tmp
/dev/hda6     ext3    7.4G  1.5G  5.5G  22% /usr
/dev/hda7     ext3    1.9G   96M  1.7G   6% /var
/dev/hdc   iso9660    2.9M  2.9M     0 100% /mnt/cdrom
[root@spc1 steven]# ls -l /mnt/cdrom
total 2578
-rw-rw-rw-  1 501 501 2639360 Aug  7  2003 snmp-opc server 30.msi
[root@spc1 steven]# dmesg | tail
[   50.267382] EXT3 FS on hda8, internal journal
[   50.267395] EXT3-fs: mounted filesystem with ordered data mode.
[   50.301423] kjournald starting.  Commit interval 5 seconds
[   50.301763] EXT3 FS on hda6, internal journal
[   50.301774] EXT3-fs: mounted filesystem with ordered data mode.
[   50.330087] kjournald starting.  Commit interval 5 seconds
[   50.330503] EXT3 FS on hda7, internal journal
[   50.330516] EXT3-fs: mounted filesystem with ordered data mode.
[   57.453061] PCI: Found IRQ 5 for device 0000:01:0c.0
[  187.450836] ISO 9660 Extensions: IEEE_P1282
[root@spc1 steven]#

Steven
