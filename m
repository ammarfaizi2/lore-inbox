Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261847AbVCYWsB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261847AbVCYWsB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 17:48:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261848AbVCYWpO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 17:45:14 -0500
Received: from mailwasher.lanl.gov ([192.65.95.54]:33882 "EHLO
	mailwasher-b.lanl.gov") by vger.kernel.org with ESMTP
	id S261847AbVCYWnF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 17:43:05 -0500
Message-ID: <424493F5.8050503@mesatop.com>
Date: Fri, 25 Mar 2005 15:43:01 -0700
From: Steven Cole <elenstev@mesatop.com>
User-Agent: Thunderbird 1.0 (Multics)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: jason@stdbev.com, linux-kernel@vger.kernel.org,
       Chris Wright <chrisw@osdl.org>
Subject: Re: 2.6.12-rc1-mm3 (cannot read cd-rom, 2.6.12-rc1 is OK)
References: <20050325002154.335c6b0b.akpm@osdl.org>	<42446B86.7080403@mesatop.com>	<424471CB.3060006@mesatop.com>	<20050325122433.12469909.akpm@osdl.org>	<4244812C.3070402@mesatop.com>	<761c884705af2ea412c083d849598ca7@stdbev.com>	<20050325140654.430714e2.akpm@osdl.org> <20050325142336.12687e09.akpm@osdl.org>
In-Reply-To: <20050325142336.12687e09.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-PMX-Version: 4.7.0.111621
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Andrew Morton <akpm@osdl.org> wrote:
> 
>>It's the new rock-ridge bounds checking.
> 
> 
> Try this, please?

OK, you caught me just as I was headed out the door. ;)

The patch fixed it for me.  Wheee.

[root@spc1 steven]# uname -r
2.6.12-rc1-mm3-GX110
[root@spc1 steven]# mount /dev/hdc /mnt/cdrom
mount: block device /dev/hdc is write-protected, mounting read-only
[root@spc1 steven]# df -T
Filesystem    Type    Size  Used Avail Use% Mounted on
/dev/hda1     ext3    304M   96M  193M  34% /
/dev/hda9 reiserfs    8.3G  7.9G  335M  97% /home
/dev/hda8     ext3    464M  8.1M  432M   2% /tmp
/dev/hda6     ext3    7.4G  1.5G  5.5G  22% /usr
/dev/hda7     ext3    1.9G   97M  1.7G   6% /var
/dev/hdc   iso9660    2.9M  2.9M     0 100% /mnt/cdrom
[root@spc1 steven]# ls -l /mnt/cdrom
total 2578
-rw-rw-rw-  1 501 501 2639360 Aug  7  2003 snmp-opc server 30.msi
[root@spc1 steven]# dmesg | tail
[   49.932278] EXT3 FS on hda8, internal journal
[   49.932292] EXT3-fs: mounted filesystem with ordered data mode.
[   49.966250] kjournald starting.  Commit interval 5 seconds
[   49.966659] EXT3 FS on hda6, internal journal
[   49.966669] EXT3-fs: mounted filesystem with ordered data mode.
[   49.994929] kjournald starting.  Commit interval 5 seconds
[   49.995334] EXT3 FS on hda7, internal journal
[   49.995345] EXT3-fs: mounted filesystem with ordered data mode.
[   57.117794] PCI: Found IRQ 5 for device 0000:01:0c.0
[  123.944869] ISO 9660 Extensions: IEEE_P1282


Steven
