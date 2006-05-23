Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751174AbWEWS0j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751174AbWEWS0j (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 14:26:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751183AbWEWS0j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 14:26:39 -0400
Received: from cpe-66-25-142-253.austin.res.rr.com ([66.25.142.253]:32476 "EHLO
	kinison.puremagic.com") by vger.kernel.org with ESMTP
	id S1751174AbWEWS0i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 14:26:38 -0400
Date: Tue, 23 May 2006 13:26:32 -0500 (CDT)
From: Evan Harris <eharris@puremagic.com>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: ext3-fs transient corruption with devmapper over md raid, kernel
 2.6.16.14
Message-ID: <Pine.LNX.4.62.0605231225450.11814@kinison.puremagic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I just recently upgraded a machine to use devmapper for an encrypted 
filesystem on top of a software raid5 array.  System is running a 
stock 2.6.16.14 kernel with no additional patches.

Under periods of high disk load on that array, I get various errors like the 
following:

May 23 06:26:48 localhost kernel: EXT3-fs error (device dm-0): ext3_readdir: bad entry in directory #108298277: rec_len %% 4 != 0 - offset=0, inode=857743392, rec_len=12853, name_len=52
May 23 06:27:01 localhost kernel: EXT3-fs error (device dm-0): ext3_readdir: bad entry in directory #109215774: rec_len is smaller than minimal - offset=0, inode=0, rec_len=0, name_len=0
May 23 06:27:23 localhost kernel: EXT3-fs error (device dm-0): ext3_readdir: bad entry in directory #109232146: rec_len is smaller than minimal - offset=0, inode=0, rec_len=0, name_len=0
May 23 06:27:27 localhost kernel: EXT3-fs error (device dm-0): ext3_readdir: bad entry in directory #109282688: rec_len is smaller than minimal - offset=0, inode=1048832, rec_len=0, name_len=0
May 23 06:27:27 localhost kernel: EXT3-fs error (device dm-0): ext3_readdir: bad entry in directory #109297749: rec_len %% 4 != 0 - offset=0, inode=1309226288, rec_len=8303, name_len=67
May 23 06:28:07 localhost kernel: EXT3-fs error (device dm-0): ext3_readdir: bad entry in directory #109871722: rec_len %% 4 != 0 - offset=0, inode=6586752, rec_len=1581, name_len=0
May 23 06:28:21 localhost kernel: EXT3-fs error (device dm-0): ext3_readdir: bad entry in directory #110412086: rec_len is smaller than minimal - offset=0, inode=1048832, rec_len=0, name_len=0
May 23 06:28:23 localhost kernel: EXT3-fs error (device dm-0): ext3_readdir: bad entry in directory #110428194: rec_len is smaller than minimal - offset=0, inode=0, rec_len=1, name_len=0
May 23 06:28:24 localhost kernel: EXT3-fs error (device dm-0): ext3_readdir: bad entry in directory #110428301: rec_len %% 4 != 0 - offset=0, inode=1767526191, rec_len=13679, name_len=77
May 23 06:28:25 localhost kernel: EXT3-fs error (device dm-0): ext3_readdir: bad entry in directory #110444639: directory entry across blocks - offset=0, inode=538976288, rec_len=24892, name_len=32

After the errors occur, if I then unmount and fsck the devmapper device, it 
finds no errors.  If the disk load isn't heavy, the errors never seem to 
crop up.  There are no messages concerning the underlying md device or any 
of the member disks of the md device.

This is not completely reproducible, but appears to be commonly triggered by 
the nightly updatedb/find cronjob running concurrently with a hefty rsync 
process on a filesystem with about 3 million files.

Other md devices on the same machine that are NOT used via devmapper are not 
showing these problems.

System is running AMD64 stable distribution of Debian, using devmapper with 
dm_crypt and aes_x86_64 kernel modules.

I found a couple of other similar reports via google, but most were pretty 
old, and none seemed to have applicable resolutions.

Happy to provide any further info that may be useful.

Evan
