Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262329AbUCWHd7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 02:33:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262345AbUCWHd7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 02:33:59 -0500
Received: from smtp3.adl2.internode.on.net ([203.16.214.203]:1811 "EHLO
	smtp3.adl2.internode.on.net") by vger.kernel.org with ESMTP
	id S262329AbUCWHd4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 02:33:56 -0500
Message-ID: <405FE85C.5000307@internode.on.net>
Date: Tue, 23 Mar 2004 18:03:48 +1030
From: John Pearson <huiac@internode.on.net>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040309)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: strange ext3 corruption problem on 2.6.x
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK,

I've seen this one now, too; here's my datapoint:

First, under vanilla 2.6.3:

EXT3-fs error (device dm-0): ext3_readdir: bad entry in directory 
#917711: rec_len % 4 != 0 - offset=0, inode=1182746341, rec_len=16861, 
name_len=185
Aborting journal on device dm-0.
ext3_abort called.
EXT3-fs abort (device dm-0): ext3_journal_start: Detected aborted journal
Remounting filesystem read-only
 


Then, under 2.6.4+skas3:
 

EXT3-fs error (device dm-3): ext3_readdir: bad entry in directory 
#510327: directory entry across blocks - offset=0, inode=0, 
rec_len=5044, name_len=113
Aborting journal on device dm-3.
ext3_abort called.
EXT3-fs abort (device dm-3): ext3_journal_start: Detected aborted journal
Remounting filesystem read-only



I'm running ext3 over raid5;  In both cases, fsck spotted the aborted 
journal and checked the FS, which came up clean.

No other issues in many days of uptime, including kernel compiles, etc., 
so I'm reasonably confident of the RAM and hardware generally.

I wouldn't describe either volume as seeing heavy use - there's rarely 
more than one reader, and almost never more than one writer.

dm-3 has had no writes since last boot (it serves images to diskless 
clients, including NFS roots mounted ro); dm-0 had seen a few writes 
(it's a read-mostly FTP server containing mirrors of debian-security and 
a few other things, synced about once a month).

'directory #510327' on dm-3 is a manpage directory, which shows a size 
of 20480 and contains 751 files; 'directory #917711' on dm-0 has a size 
of 8192 and contains 101 files.

The box is a UMP Athlon XP with 512Mb DDR RAM on a VIA VT8237-based
board, using on-board IDE + a Promise 20268 controller (but as the RAID 
layer works, I doubt it's the hardware).
