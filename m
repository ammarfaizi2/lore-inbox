Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754329AbWKMJ2g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754329AbWKMJ2g (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 04:28:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754331AbWKMJ2g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 04:28:36 -0500
Received: from relay.uni-heidelberg.de ([129.206.100.212]:25305 "EHLO
	relay.uni-heidelberg.de") by vger.kernel.org with ESMTP
	id S1754329AbWKMJ2f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 04:28:35 -0500
Message-ID: <45583ABE.6080909@uni-hd.de>
Date: Mon, 13 Nov 2006 10:28:30 +0100
From: Martin Braun <mbraun@uni-hd.de>
Reply-To: mbraun@uni-hd.de
User-Agent: Thunderbird 1.5.0.8 (X11/20061025)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: xfs kernel BUG again in 2.6.17.11
References: <44E1D9CA.30805@uni-hd.de> <20060816101122.E2740551@wobbly.melbourne.sgi.com> <44EB228F.6020903@uni-hd.de> <20060823134211.E2968256@wobbly.melbourne.sgi.com>
In-Reply-To: <20060823134211.E2968256@wobbly.melbourne.sgi.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi ,

is it possible that the xfs  kernel bug is in the 2.6.17.11 Kernel again?
we got obviously the same bug as with 2.6.17.8:


Nov 13 09:27:01 pers109 kernel: Access to block zero: fs: <sdc1> inode:
637540399 start_block : 0 start_off : 23812530000000 blkcnt : 84
extent-state : 0
Nov 13 09:27:01 pers109 kernel: ------------[ cut here ]------------
Nov 13 09:27:01 pers109 kernel: kernel BUG at <bad filename>:50307!
Nov 13 09:27:01 pers109 kernel: invalid opcode: 0000 [#2]
Nov 13 09:27:01 pers109 kernel: SMP
Nov 13 09:27:01 pers109 kernel: CPU:    1
Nov 13 09:27:01 pers109 kernel: EIP:    0060:[<c0258984>]    Not tainted VLI
Nov 13 09:27:01 pers109 kernel: EFLAGS: 00010246   (2.6.17.11 #1)
Nov 13 09:27:01 pers109 kernel: EIP is at cmn_err+0xa0/0xaa
Nov 13 09:27:01 pers109 kernel: eax: c047d144   ebx: c04385a0   ecx:
c046f9bc   edx: 00000282
Nov 13 09:27:01 pers109 kernel: esi: c33a3cb0   edi: c055e120   ebp:
00000000   esp: c33a3b70
Nov 13 09:27:01 pers109 kernel: ds: 007b   es: 007b   ss: 0068
Nov 13 09:27:01 pers109 kernel: Process smbd (pid: 26181,
threadinfo=c33a2000 task=e00bead0)
Nov 13 09:27:01 pers109 kernel: Stack: c0447536 c042a5d5 c055e120
00000282 ec894ae0 c33a3cb0 00000000 e2d85c80
Nov 13 09:27:01 pers109 kernel:        c01fed1d 00000000 c04385a0
f69e3a00 2600182f 00000000 00000000 00000000
Nov 13 09:27:01 pers109 kernel:        30000000 00238125 00000084
00000000 00000000 c33a3cb0 00000000 00000000
Nov 13 09:27:01 pers109 kernel: Call Trace:
Nov 13 09:27:01 pers109 kernel:  <c01fed1d>
xfs_bmap_search_extents+0xf5/0xf7  <c0200217> xfs_bmapi+0x229/0x162c
Nov 13 09:27:01 pers109 kernel:  <c0115eb1>
default_wake_function+0x0/0x12  <c03bb980> ip_output+0x189/0x270
Nov 13 09:27:01 pers109 kernel:  <c015a22b> mark_buffer_dirty+0x25/0x29
 <c015b131> __block_commit_write+0x7e/0xb4
Nov 13 09:27:01 pers109 kernel:  <c0141441> __pagevec_lru_add+0xa2/0xb5
 <c0255c13> xfs_zero_eof+0x1ca/0x340
Nov 13 09:27:01 pers109 kernel:  <c039d882> memcpy_toiovec+0x37/0x5c
<c0172283> file_update_time+0xa1/0xc0
Nov 13 09:27:01 pers109 kernel:  <c0256273> xfs_write+0x4ea/0xda5
<c0396d39> sock_aio_read+0x83/0x8e
Nov 13 09:27:01 pers109 kernel:  <c025153f> xfs_file_aio_write+0x8f/0x9a
 <c0157d33> do_sync_write+0xd5/0x130
Nov 13 09:27:01 pers109 kernel:  <c012d743>
autoremove_wake_function+0x0/0x4b  <c0157e59> vfs_write+0xcb/0x195
Nov 13 09:27:01 pers109 kernel:  <c01580fe> sys_pwrite64+0x73/0x80
<c01027ef> sysenter_past_esp+0x54/0x75
Nov 13 09:27:01 pers109 kernel: Code: c0 c7 44 24 08 20 e1 55 c0 c7 04
24 36 75 44 c0 89 44 24 04 e8 8b 29 ec ff b8 44 d1 47 c0 8b 54 24 0c e8
bc ff 1a 00 85 ed 75 02 <0f> 0b 83 c4 10 5b 5e 5f 5d c3 55 b8 07 00 00
00 57 bf 20 e1 55
Nov 13 09:27:01 pers109 kernel: EIP: [<c0258984>] cmn_err+0xa0/0xaa
SS:ESP 0068:c33a3b70

I will remove the corresponding block...

thanks,
martin


> On Tue, Aug 22, 2006 at 05:28:15PM +0200, Martin Braun wrote:
>> Hi Nathan,
>>
>> since I haven't repaired the fs we had a crash again (see below).
>>
>> unfortunately we copied at the time of the crash over iscsi some files
>> to an xfs-fs on a nas.
>> and the directory was completely deleted. neither a xfs-check or a
>> xfs_repair did find something. was that due to the combination of iscsi
>> and xfs?
> 
> Sorry for not getting back to you earlier, I've been too busy. :(
> 
> I think you will need to clear out the affected inode (looks like a
> form of corruption that repair doesn't know about today) - you'll
> need to forcibly remove that inode via xfs_db, something like:
> 
> # xfs_db -x -c 'inode 35141650' -c 'write core.mode 0' /dev/sdc1
> # xfs_repair /dev/sdc1
> 
> cheers.
> 
> ps: Barry, looks like repair needs some work in this area...
> 
>> Aug 22 12:48:12 pers109 kernel: Access to block zero: fs: <sdc1> inode:
>> 35141650 start_block : 0 start_off : 3a1531 blkcnt : c
>>  extent-state : 0
>> Aug 22 12:48:12 pers109 kernel: ------------[ cut here ]------------
>> Aug 22 12:48:12 pers109 kernel: kernel BUG at <bad filename>:50307!
>> Aug 22 12:48:12 pers109 kernel: invalid opcode: 0000 [#1]
>> Aug 22 12:48:12 pers109 kernel: SMP
>> Aug 22 12:48:12 pers109 kernel: Modules linked in: iscsi_tcp libiscsi
>> scsi_transport_iscsi
>> Aug 22 12:48:12 pers109 kernel: CPU:    0
>> Aug 22 12:48:12 pers109 kernel: EIP:    0060:[<c025cb74>]    Not tainted VLI
>> Aug 22 12:48:12 pers109 kernel: EFLAGS: 00010246   (2.6.17.8 #5)
>> Aug 22 12:48:12 pers109 kernel: EIP is at cmn_err+0xa0/0xaa
>> Aug 22 12:48:12 pers109 kernel: eax: c048a2c4   ebx: c04359e4   ecx:
>> c047c9bc   edx: 00000282
>> Aug 22 12:48:12 pers109 kernel: esi: e595dcb0   edi: c056a120   ebp:
>> 00000000   esp: e595db70
>> Aug 22 12:48:12 pers109 kernel: ds: 007b   es: 007b   ss: 0068
>> Aug 22 12:48:12 pers109 kernel: Process smbd (pid: 25510,
>> threadinfo=e595c000 task=d9628a90)
>> Aug 22 12:48:12 pers109 kernel: Stack: c044497a c0427525 c056a120
>> 00000282 f3507260 e595dcb0 00000000 d9f9de00
>> Aug 22 12:48:12 pers109 kernel:        c0202f0d 00000000 c04359e4
>> f686cba0 02183812 00000000 00000000 00000000
>> Aug 22 12:48:12 pers109 kernel:        003a1531 00000000 0000000c
>> 00000000 00000000 e595dcb0 00000000 00000000
>> Aug 22 12:48:12 pers109 kernel: Call Trace:
>> Aug 22 12:48:12 pers109 kernel:  <c0202f0d>
>> xfs_bmap_search_extents+0xf5/0xf7  <c0204407> xfs_bmapi+0x229/0x162c
>> Aug 22 12:48:12 pers109 kernel:  <c039d890> dev_queue_xmit+0x1f4/0x26f
>> <c03b8660> ip_output+0x189/0x270
>> Aug 22 12:48:12 pers109 kernel:  <c012018e> __do_softirq+0x6e/0xdc
>> <c0104d7a> do_IRQ+0x1e/0x24
>> Aug 22 12:48:12 pers109 kernel:  <c0103222> common_interrupt+0x1a/0x20
>> <c0259e03> xfs_zero_eof+0x1ca/0x340
>> Aug 22 12:48:12 pers109 kernel:  <c039a342> memcpy_toiovec+0x37/0x5c
>> <c01762b3> file_update_time+0xa1/0xc0
>> Aug 22 12:48:12 pers109 kernel:  <c025a463> xfs_write+0x4ea/0xda5
>> <c0393654> sock_aio_read+0x83/0x8e
>> Aug 22 12:48:12 pers109 kernel:  <c016e098> fasync_helper+0x4b/0xd3
>> <c028dc12> copy_to_user+0x3c/0x4a
>> Aug 22 12:48:12 pers109 kernel:  <c025572f> xfs_file_aio_write+0x8f/0x9a
>>  <c015ba73> do_sync_write+0xd5/0x130
>> Aug 22 12:48:12 pers109 kernel:  <c012de03>
>> autoremove_wake_function+0x0/0x4b  <c015bb99> vfs_write+0xcb/0x195
>> Aug 22 12:48:12 pers109 kernel:  <c015be3e> sys_pwrite64+0x73/0x80
>> <c01027ef> sysenter_past_esp+0x54/0x75
>> Aug 22 12:48:12 pers109 kernel: Code: c0 c7 44 24 08 20 a1 56 c0 c7 04
>> 24 7a 49 44 c0 89 44 24 04 e8 ab eb eb ff b8 c4 a2 48 c
>> 0 8b 54 24 0c e8 fc 95 1a 00 85 ed 75 02 <0f> 0b 83 c4 10 5b 5e 5f 5d c3
>> 55 b8 07 00 00 00 57 bf 20 a1 56
>> Aug 22 12:48:12 pers109 kernel: EIP: [<c025cb74>] cmn_err+0xa0/0xaa
>> SS:ESP 0068:e595db70
>>
>>
>>
>>
>>
>>
>>  Scott schrieb:
>>> Hi Martin,
>>>
>>> On Tue, Aug 15, 2006 at 04:27:22PM +0200, Martin Braun wrote:
>>>> ...
>>>> What does this bug mean?
>>>> ...
>>>> Aug 15 15:01:02 pers109 kernel: Access to block zero: fs: <sdc1> inode:
>>>> 254474718 start_block : 0 start_off : c0a0b0e8a099
>>>> 0 blkcnt : 90000 extent-state : 0
>>>> Aug 15 15:01:02 pers109 kernel: ------------[ cut here ]------------
>>>> Aug 15 15:01:02 pers109 kernel: kernel BUG at <bad filename>:50307!
>>> It means XFS detected ondisk corruption in inode# 254474718, and
>>> paniced your system (stupidly; a fix for this is around, will be
>>> merged with the next mainline update).  For me, a more interesting
>>> question is how that inode got into this state... have you had any
>>> crashes recently (i.e. has the filesystem journal needed to be
>>> replayed recently?)  Can you send the output of:
>>>
>>> 	# xfs_db -c 'inode 254474718' -c print /dev/sdc1
>>>
>>> You'll need to run xfs_repair on that filesystem to fix this up,
>>> but please send us that output first.
>>>
>>> thanks.
>>>
> 
