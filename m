Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263518AbTJQUN6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 16:13:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263606AbTJQUN6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 16:13:58 -0400
Received: from mx2.it.wmich.edu ([141.218.1.94]:6557 "EHLO mx2.it.wmich.edu")
	by vger.kernel.org with ESMTP id S263518AbTJQUNx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 16:13:53 -0400
Message-ID: <3F904D7F.50403@wmich.edu>
Date: Fri, 17 Oct 2003 16:13:51 -0400
From: Ed Sweetman <ed.sweetman@wmich.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20031010 Debian/1.4-6
X-Accept-Language: en
MIME-Version: 1.0
To: Alex Tomas <alex@clusterfs.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] EXT3 extents against 2.6.0-test7
References: <20031013222747.37f5ee7b.alex@clusterfs.com>	<3F8B1BA1.4020800@wmich.edu>	<20031014212359.42243025.alex@clusterfs.com>	<3F9043E7.3070606@wmich.edu> <20031018001001.25e85002.alex@clusterfs.com>
In-Reply-To: <20031018001001.25e85002.alex@clusterfs.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


How am i supposed to know which directory in the fs this corruption 
takes place in?   I can tell you the size of the partitions that have 
extents enabled, From that error message i dont even know which 
partition it was.  And judging by the dmesg last modified time, this 
happened 2 days ago

Filesystem            Size  Used Avail Use% Mounted on
                       101G   85G   16G  85% dir1
                        92G   38G   50G  44% dir2

Filesystem            Inodes   IUsed   IFree IUse% Mounted on
                       103040    3619   99421    4% dir1
                      12222464      61 12222403    1% dir2

Isn't it possible though that this happened in one of the non-extents 
enabled partitions though?  Since they still have the ability to read 
extents in files, they have to try and look them up every time for 
everything dont they?  Anyways, the two partitions above are the only 
ones i actually enable extents on.

Alex Tomas wrote:
> uhuh!
> 
> is it possible to know size of that directory ?
> 
> thanks!
> 
> On Fri, 17 Oct 2003 15:32:55 -0400
> Ed Sweetman <ed.sweetman@wmich.edu> wrote:
> 
> 
>>kernel BUG at fs/ext3/extents.c:389!
>>invalid operand: 0000 [#1]
>>CPU:    0
>>EIP:    0060:[<c0198127>]    Not tainted
>>EFLAGS: 00010282
>>EIP is at ext3_ext_find_extent+0x277/0x570
>>eax: 00009ac6   ebx: e5257580   ecx: 00000000   edx: e2184940
>>esi: 00000000   edi: 00000000   ebp: 00000000   esp: ca6adddc
>>ds: 007b   es: 007b   ss: 0068
>>Process find (pid: 10373, threadinfo=ca6ac000 task=ca97b380)
>>Stack: 00000030 00000050 e7db0200 00458006 00000400 00000000 e2184940 
>>e5257580
>>        00000000 00000000 00000000 00000000 e5257614 e5257614 e5257580 
>>c0199f02
>>        e5257614 00000000 e2184940 e5257580 e5257614 c018fac1 e5257604 
>>00000000
>>Call Trace:
>>  [<c0199f02>] ext3_ext_get_block+0xb2/0x320
>>  [<c018fac1>] ext3_read_inode+0x221/0x2d0
>>  [<c016b74f>] d_splice_alias+0x4f/0x130
>>  [<c018d57d>] ext3_getblk+0x25d/0x2b0
>>  [<c018d603>] ext3_bread+0x33/0xb0
>>  [<c018a3e1>] ext3_readdir+0x141/0x4e0
>>  [<c0165a7a>] vfs_readdir+0x7a/0x80
>>  [<c0165db0>] filldir64+0x0/0x140
>>  [<c0165f5f>] sys_getdents64+0x6f/0xa9
>>  [<c0165db0>] filldir64+0x0/0x140
>>  [<c01092e7>] syscall_call+0x7/0xb
>>
>>Code: 0f 0b 85 01 51 fe 2e c0 66 85 c0 0f 84 ee 00 00 00 8b 7c 24
>>
>>
>>I'm not sure why this is happening.  Perhaps due to these ext3 locking 
>>fixes that have been going into the kernel or what?
>>
>>Upon rebooting my last kernel for the first time in a couple of weeks it 
>>crashed due to fs errors.  Now i'm getting this.  I only use extents on 
>>a couple non-system partitions, so if i lose anything it's not a huge 
>>deal but I'd like to find out why these errors are suddenly creeping up 
>>so Any other info that's needed just ask and i'll give it.
> 
> 


