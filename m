Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262050AbTIALVm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 07:21:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262484AbTIALVd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 07:21:33 -0400
Received: from smtp803.mail.sc5.yahoo.com ([66.163.168.182]:8232 "HELO
	smtp803.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262050AbTIALU5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 07:20:57 -0400
Message-ID: <3F532C67.6070904@sbcglobal.net>
Date: Mon, 01 Sep 2003 06:24:23 -0500
From: Wes Janzen <superchkn@sbcglobal.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Panagiotis Papadakos <papadako@csd.uoc.gr>
Subject: Re: IOMEGA ZIP 100 ATAPI problems with 2.6
References: <Pine.GSO.4.53.0308310037230.27956@oneiro.csd.uch.gr> <3F515301.4040305@sbcglobal.net>
In-Reply-To: <3F515301.4040305@sbcglobal.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again,

Well, I compiled kernel 2.6.0-test4-mm4 with debugging info, I was 
previously using test4-mm3....  Now hdparm -i doesn't cause any 
problems, but I now I get this when first accessing the drive:

Sep  1 05:59:57 rybBIT kernel: ide-floppy: hda: I/O error, pc =  0, key 
=  2, asc =  4, ascq =  1
Sep  1 05:59:57 rybBIT kernel: hda: 98304kB, 196608 blocks, 512 sector size
Sep  1 05:59:57 rybBIT kernel:  hda: hda4
Sep  1 06:00:00 rybBIT kernel:  hda: hda4
Sep  1 06:00:00 rybBIT kernel: hda: drive_cmd: status=0x51 { DriveReady 
SeekComplete Error }
Sep  1 06:00:00 rybBIT kernel: hda: drive_cmd: error=0x04
Sep  1 06:00:07 rybBIT kernel:  hda: hda4
Sep  1 06:00:07 rybBIT kernel:  hda: hda4
Sep  1 06:00:12 rybBIT kernel: hda: drive_cmd: status=0x51 { DriveReady 
SeekComplete Error }
Sep  1 06:00:12 rybBIT kernel: hda: drive_cmd: error=0x04
Sep  1 06:00:35 rybBIT kernel: hda: drive_cmd: status=0x51 { DriveReady 
SeekComplete Error }
Sep  1 06:00:35 rybBIT kernel: hda: drive_cmd: error=0x04
Sep  1 06:00:39 rybBIT kernel: hda: drive_cmd: status=0x51 { DriveReady 
SeekComplete Error }
Sep  1 06:00:39 rybBIT kernel: hda: drive_cmd: error=0x04

After that I get:

Sep  1 06:17:57 rybBIT kernel:  hda: hda4
Sep  1 06:18:27 rybBIT last message repeated 3 times
Sep  1 06:19:29 rybBIT last message repeated 2 times
Sep  1 06:19:47 rybBIT kernel:  hda: hda4

Whenever I mount or umount the drive, and they cause quite a pause in 
the process (about 5-10 seconds of system freezing).

Otherwise it seems harmless since I can read/write the drive.  This is 
an internal IDE unit I'm using.

Oh yeah, eject doesn't eject it.  I'm pretty sure it used to with 2.4.18...

-Wes-

Wes Janzen wrote:

> Hi,
>
> Just for the record in case no one else has on of these things, I have 
> been able to write to mine in every test kernel I've tried (started at 
> 2.5.68).  I have never tried hdparm -I /dev/hda though, which got me 
> the stuff below.  Looks like I should recompile with debugging info, eh?
> I'm using a VIA MVP3 586B IDE on this thing, if it matters.
>
> -Wes-
>
> Aug 30 20:39:51 rybBIT kernel: ide-floppy: hda: I/O error, pc =  0, 
> key =  2, asc = 3a, ascq =  0
> Aug 30 20:39:51 rybBIT kernel: ide-floppy: hda: I/O error, pc = 1b, 
> key =  2, asc = 3a, ascq =  0
> Aug 30 20:39:51 rybBIT kernel: hda: No disk in drive
> Aug 30 20:39:51 rybBIT kernel: ide-floppy: hda: I/O error, pc = 1e, 
> key =  2, asc = 3a, ascq =  0
> Aug 30 20:39:52 rybBIT kernel: Unable to handle kernel NULL pointer 
> dereference at virtual address 00000000
> Aug 30 20:39:52 rybBIT kernel:  printing eip:
> Aug 30 20:39:52 rybBIT kernel: c022d09a
> Aug 30 20:39:52 rybBIT kernel: *pde = 00000000
> Aug 30 20:39:52 rybBIT kernel: Oops: 0000 [#1]
> Aug 30 20:39:52 rybBIT kernel: PREEMPT
> Aug 30 20:39:52 rybBIT kernel: CPU:    0
> Aug 30 20:39:52 rybBIT kernel: EIP:    
> 0060:[generic_ide_ioctl+666/1696]    Not tainted VLI
> Aug 30 20:39:52 rybBIT kernel: EFLAGS: 00010246
> Aug 30 20:39:52 rybBIT kernel: EIP is at generic_ide_ioctl+0x29a/0x6a0
> Aug 30 20:39:52 rybBIT kernel: eax: 00000000   ebx: 00000000   ecx: 
> cf8e4000   edx: 00000000
> Aug 30 20:39:52 rybBIT kernel: esi: d7fe1860   edi: 0804fc2c   ebp: 
> c03587a0   esp: cf8e5de4
> Aug 30 20:39:52 rybBIT kernel: ds: 007b   es: 007b   ss: 0068
> Aug 30 20:39:52 rybBIT kernel: Process hdparm (pid: 22903, 
> threadinfo=cf8e4000 task=d33286b0)
> Aug 30 20:39:52 rybBIT kernel: Stack: 00000000 c03e02ac d2d919a0 
> c0122980 cf8e5e0c c0116def 0804fc2c c03e02ac
> Aug 30 20:39:52 rybBIT kernel:        00000301 cb3b0000 d9a73cb6 
> d7fe1860 00000301 0804fc2c cf8e5e1c cf8e5e1c
> Aug 30 20:39:52 rybBIT kernel:        c010c170 00000001 c03d6348 
> 0000000a 00000046 cf8e5e5c c0116b51 d2d919a0
> Aug 30 20:39:52 rybBIT kernel: Call Trace:
> Aug 30 20:39:52 rybBIT kernel:  [process_timeout+0/32] 
> process_timeout+0x0/0x20
> Aug 30 20:39:52 rybBIT kernel:  [wake_up_process+15/32] 
> wake_up_process+0xf/0x20
> Aug 30 20:39:52 rybBIT kernel:  [_end+426272734/1069611816] 
> idefloppy_ioctl+0x36/0x180 [ide_floppy]
> Aug 30 20:39:52 rybBIT kernel:  [handle_IRQ_event+48/96] 
> handle_IRQ_event+0x30/0x60
> Aug 30 20:39:52 rybBIT kernel:  [recalc_task_prio+113/416] 
> recalc_task_prio+0x71/0x1a0
> Aug 30 20:39:52 rybBIT kernel:  [find_get_page+29/64] 
> find_get_page+0x1d/0x40
> Aug 30 20:39:52 rybBIT kernel:  [filemap_nopage+186/768] 
> filemap_nopage+0xba/0x300
> Aug 30 20:39:52 rybBIT kernel:  [filemap_nopage+604/768] 
> filemap_nopage+0x25c/0x300
> Aug 30 20:39:52 rybBIT kernel:  [do_no_page+478/864] 
> do_no_page+0x1de/0x360
> Aug 30 20:39:52 rybBIT kernel:  [handle_mm_fault+162/320] 
> handle_mm_fault+0xa2/0x140
> Aug 30 20:39:52 rybBIT kernel:  [do_page_fault+526/1031] 
> do_page_fault+0x20e/0x407
> Aug 30 20:39:52 rybBIT kernel:  [tty_write+466/736] tty_write+0x1d2/0x2e0
> Aug 30 20:39:52 rybBIT kernel:  [blkdev_ioctl+133/829] 
> blkdev_ioctl+0x85/0x33d
> Aug 30 20:39:52 rybBIT kernel:  [sys_ioctl+253/608] sys_ioctl+0xfd/0x260
> Aug 30 20:39:52 rybBIT kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
> Aug 30 20:39:52 rybBIT kernel:
> Aug 30 20:39:52 rybBIT kernel: Code: c0 75 3a 8b 44 24 34 83 c0 04 89 
> c2 83 c2 04 19 db 39 51 18 83 db 00 85 db 75 22 8b 74 24 2c b8
> 00 00 00 00 8b 7c 24 34 8b 56 38 <8b> 12 89 57 04 85 c0 ba 00 00 00 00 
> 0f 84 ba fd ff ff ba f2 ff
>
>
> Panagiotis Papadakos wrote:
>
>> With all of the 2.5, 2.6 kernels I have tried(currently 
>> 2.6.0-test4-mm3),
>> I
>> have problems with my Zip.I can mount and umount it cleanly but when 
>> I try
>> to write something from it in my disk either cp will just
>> segfault or my system will just reboot. Also when I am in KDE it will
>> lockup my system and kernel reports the messages that are in the end of
>> the mail.
>> Also with hdparm -I /dev/hdd the kernel prints the following message:
>> hdd: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
>> hdd: drive_cmd: error=0x04
>>
>> P.S.
>> The Zip works with 2.4 kernels...
>>
>> Regards
>>        Panagiotis Papadakos
>>
>>
>> Aug 30 23:34:37 Santorini kernel: EXT2-fs warning: mounting unchecked 
>> fs,
>> running e2fsck is recommended
>> Aug 30 23:37:56 Santorini kernel: swap_free: Bad swap file entry 
>> e0bdd5be
>> Aug 30 23:37:56 Santorini kernel: swap_free: Bad swap file entry 
>> d83246f2
>> Aug 30 23:37:56 Santorini kernel: swap_free: Bad swap file entry 
>> 900f6684
>> Aug 30 23:37:56 Santorini kernel: swap_free: Bad swap file entry 
>> f8a0b9e2
>> Aug 30 23:37:56 Santorini kernel: swap_free: Bad swap file entry 
>> 5034ad24
>> Aug 30 23:37:56 Santorini kernel: swap_free: Bad swap file entry 
>> 10c94e23
>> Aug 30 23:37:56 Santorini kernel: swap_free: Bad swap file entry 
>> 504d416e
>> Aug 30 23:37:56 Santorini kernel: swap_free: Bad swap file entry 
>> e0ad353f
>> Aug 30 23:37:56 Santorini kernel: swap_free: Bad swap offset entry
>> 00ddb4e2
>> Aug 30 23:37:56 Santorini kernel: swap_free: Bad swap file entry 
>> b8d54fef
>> Aug 30 23:37:56 Santorini kernel: swap_free: Bad swap file entry 
>> 68983486
>> .                                                                       
>> .
>> ................... And much more of such messages 
>> ......................
>>
>> And then:
>>
>> Aug 30 23:37:56 Santorini kernel: Unable to handle kernel paging request
>> at virtual address 00200200
>> Aug 30 23:37:56 Santorini kernel:  printing eip:
>> Aug 30 23:37:56 Santorini kernel: c013c0ba
>> Aug 30 23:37:56 Santorini kernel: *pde = 00000000
>> Aug 30 23:37:56 Santorini kernel: Oops: 0000 [#1]
>> Aug 30 23:37:56 Santorini kernel: PREEMPT
>> Aug 30 23:37:56 Santorini kernel: CPU:    0
>> Aug 30 23:37:56 Santorini kernel: EIP:    0060:[<c013c0ba>]    
>> Tainted: P
>> VLI
>> Aug 30 23:37:56 Santorini kernel: EFLAGS: 00210046
>> Aug 30 23:37:56 Santorini kernel: EIP is at free_pages_bulk+0x17a/0x280
>> Aug 30 23:37:56 Santorini kernel: eax: 00000000   ebx: c1054b28   ecx:
>> c1054b30   edx: 00200200
>> Aug 30 23:37:56 Santorini kernel: esi: 000011e0   edi: ffffffff   ebp:
>> 000008f0   esp: dd281bc4
>> Aug 30 23:37:56 Santorini kernel: ds: 007b   es: 007b   ss: 0068
>> Aug 30 23:37:56 Santorini kernel: Process kdeinit (pid: 7874,
>> threadinfo=dd280000 task=dada7940)
>> Aug 30 23:37:56 Santorini kernel: Stack: c035eb74 c1054b00 c035ec34
>> 00000000 00000001 c1054b00 c035ebb0 0000000d
>> Aug 30 23:37:56 Santorini kernel:        c1028000 c035ebb0 00200082
>> ffffffff c035eb74 c10bc2f0 dd280000 c035ec50
>> Aug 30 23:37:56 Santorini kernel:        c013c713 c035eb74 00000002
>> c035ec50 00000000 00200202 c035eb74 c257c4cc
>> Aug 30 23:37:56 Santorini kernel: Call Trace:
>> Aug 30 23:37:56 Santorini kernel:  [<c013c713>]
>> free_hot_cold_page+0xf3/0x100
>> Aug 30 23:37:56 Santorini kernel:  [<c0144af7>]
>> clear_page_tables+0xb7/0xc0
>> Aug 30 23:37:56 Santorini kernel:  [<c01490c9>] exit_mmap+0xb9/0x1a0
>> Aug 30 23:37:56 Santorini kernel:  [<c011d269>] mmput+0x79/0xf0
>> Aug 30 23:37:56 Santorini kernel:  [<c015f751>] exec_mmap+0xb1/0x100
>> Aug 30 23:37:56 Santorini kernel:  [<c015f8cc>] 
>> flush_old_exec+0x12c/0x870
>> Aug 30 23:37:56 Santorini kernel:  [<c015f690>] kernel_read+0x50/0x60
>> Aug 30 23:37:56 Santorini kernel:  [<c017e3b0>]
>> load_elf_binary+0x2c0/0xb40
>> Aug 30 23:37:56 Santorini kernel:  [<c011cfa0>]
>> autoremove_wake_function+0x0/0x50
>> Aug 30 23:37:56 Santorini kernel:  [<c011d167>] mm_init+0x97/0xe0
>> Aug 30 23:37:56 Santorini kernel:  [<c015f1c2>] copy_strings+0x1e2/0x220
>> Aug 30 23:37:56 Santorini kernel:  [<c017e0f0>] 
>> load_elf_binary+0x0/0xb40
>> Aug 30 23:37:56 Santorini kernel:  [<c016040c>]
>> search_binary_handler+0x18c/0x2c0
>> Aug 30 23:37:56 Santorini kernel:  [<c0160747>] do_execve+0x207/0x280
>> Aug 30 23:37:56 Santorini kernel:  [<c0109a12>] sys_execve+0x42/0x80
>> Aug 30 23:37:56 Santorini kernel:  [<c0305f27>] syscall_call+0x7/0xb
>> Aug 30 23:37:56 Santorini kernel:
>> Aug 30 23:37:56 Santorini kernel: Code: ff 85 c0 0f 85 e9 00 00 00 8b 44
>> 24 14 8b 54 24 44 89 44 24 04 89 14 24 e8 94 fd
>> ff ff 85 c0 0f 85 c0 00 00 00 8d 4b 08 8b 51 04 <39> 0a 0f 85 a5 00 
>> 00 00
>> 8b 43 08 39 48 04 0f 85 8c 00 00 00 01
>> Aug 30 23:37:56 Santorini kernel:  <6>note: kdeinit[7874] exited with
>> preempt_count 3
>> Aug 30 23:37:56 Santorini kernel: ------------[ cut here ]------------
>> Aug 30 23:37:56 Santorini kernel: kernel BUG at 
>> include/linux/list.h:148!
>> Aug 30 23:37:56 Santorini kernel: invalid operand: 0000 [#2]
>> Aug 30 23:37:56 Santorini kernel: PREEMPT
>> Aug 30 23:37:56 Santorini kernel: CPU:    0
>> Aug 30 23:37:56 Santorini kernel: EIP:    0060:[<c013c167>]    
>> Tainted: P
>> VLI
>> Aug 30 23:37:56 Santorini kernel: EFLAGS: 00010006
>> Aug 30 23:37:56 Santorini kernel: EIP is at free_pages_bulk+0x227/0x280
>> Aug 30 23:37:56 Santorini kernel: eax: 00000000   ebx: c128fac8   ecx:
>> c128fad0   edx: d0645000
>> Aug 30 23:37:56 Santorini kernel: esi: 0000f644   edi: ffffffff   ebp:
>> 00007b22   esp: d0ba5e74
>> Aug 30 23:37:56 Santorini kernel: ds: 007b   es: 007b   ss: 0068
>> Aug 30 23:37:56 Santorini kernel: Process kdeinit (pid: 9173,
>> threadinfo=d0ba4000 task=d0bdad20)
>> Aug 30 23:37:56 Santorini kernel: Stack: c035eb74 c128faa0 c035ec34
>> 00000000 00000001 c128faa0 c035ebb0 00000000
>> Aug 30 23:37:56 Santorini kernel:        c1028000 c035ebb0 00000086
>> ffffffff c035eb74 c149ead0 d0ba4000 c035ec50
>> Aug 30 23:37:56 Santorini kernel:        c013c713 c035eb74 0000000f
>> c035ec50 00000000 00000202 c035eb74 dd912008
>> Aug 30 23:37:56 Santorini kernel: Call Trace:
>> Aug 30 23:37:56 Santorini kernel:  [<c013c713>]
>> free_hot_cold_page+0xf3/0x100
>> Aug 30 23:37:56 Santorini kernel:  [<c016751a>] poll_freewait+0x3a/0x50
>> Aug 30 23:37:56 Santorini kernel:  [<c0167897>] do_select+0x1b7/0x2d0
>> Aug 30 23:37:56 Santorini kernel:  [<c0167530>] __pollwait+0x0/0xd0
>> Aug 30 23:37:56 Santorini kernel:  [<c0167c9f>] sys_select+0x2bf/0x4c0
>> Aug 30 23:37:56 Santorini kernel:  [<c0305f27>] syscall_call+0x7/0xb
>> Aug 30 23:37:56 Santorini kernel:
>> Aug 30 23:37:56 Santorini kernel: Code: e0 ff 48 14 8b 40 08 a8 08 75 0c
>> 8b 44 24 1c 83 c4 30 5b 5e 5f 5d c3 e8 48 f5 fd
>> ff eb ed 0f 0b 95 00 72 17 31 c0 e9 67 ff ff ff <0f> 0b 94 00 72 17 
>> 31 c0
>> e9 4e ff ff ff 0f 0b ca 00 58 e9 31 c0
>> Aug 30 23:37:56 Santorini kernel:  <6>note: kdeinit[9173] exited with
>> preempt_count 2
>> Aug 30 23:37:56 Santorini kernel: Unable to handle kernel paging request
>> at virtual address 00200200
>> Aug 30 23:37:56 Santorini kernel:  printing eip:
>> Aug 30 23:37:56 Santorini kernel: c013c0ba
>> Aug 30 23:37:56 Santorini kernel: *pde = 00000000
>> Aug 30 23:37:56 Santorini kernel: Oops: 0000 [#3]
>> Aug 30 23:37:56 Santorini kernel: PREEMPT
>> Aug 30 23:37:56 Santorini kernel: CPU:    0
>> Aug 30 23:37:56 Santorini kernel: EIP:    0060:[<c013c0ba>]    
>> Tainted: P
>> VLI
>> Aug 30 23:37:56 Santorini kernel: EFLAGS: 00010046
>> Aug 30 23:37:56 Santorini kernel: EIP is at free_pages_bulk+0x17a/0x280
>> Aug 30 23:37:56 Santorini kernel: eax: 00000000   ebx: c14d8820   ecx:
>> c14d8828   edx: 00200200
>> Aug 30 23:37:56 Santorini kernel: esi: 0001e035   edi: ffffffff   ebp:
>> 0000f01a   esp: d0ba5c0c
>> Aug 30 23:37:56 Santorini kernel: ds: 007b   es: 007b   ss: 0068
>> Aug 30 23:37:56 Santorini kernel: Process kdeinit (pid: 9173,
>> threadinfo=d0ba4000 task=d0bdad20)
>> Aug 30 23:37:56 Santorini kernel: Stack: c035eb74 c14d8848 c035ec34
>> 00000000 00000001 c14d8848 c035ebb0 00000002
>> Aug 30 23:37:56 Santorini kernel:        c1028000 c035ebb0 00000086
>> ffffffff c035eb74 c12ad960 d0ba4000 c035ec50
>> Aug 30 23:37:56 Santorini kernel:        c013c713 c035eb74 0000000d
>> c035ec50 00000000 00000202 c035eb74 d123b148
>> Aug 30 23:37:56 Santorini kernel: Call Trace:
>> Aug 30 23:37:56 Santorini kernel:  [<c013c713>]
>> free_hot_cold_page+0xf3/0x100
>> Aug 30 23:37:56 Santorini kernel:  [<c0145132>] 
>> zap_pte_range+0x142/0x180
>> Aug 30 23:37:56 Santorini kernel:  [<c01451bb>] zap_pmd_range+0x4b/0x70
>> Aug 30 23:37:56 Santorini kernel:  [<c0145223>] 
>> unmap_page_range+0x43/0x70
>> Aug 30 23:37:56 Santorini kernel:  [<c0145331>] unmap_vmas+0xe1/0x210
>> Aug 30 23:37:56 Santorini kernel:  [<c0149093>] exit_mmap+0x83/0x1a0
>> Aug 30 23:37:56 Santorini kernel:  [<c011d269>] mmput+0x79/0xf0
>> Aug 30 23:37:56 Santorini kernel:  [<c01214bc>] do_exit+0x12c/0x400
>> Aug 30 23:37:56 Santorini kernel:  [<c010b880>] do_invalid_op+0x0/0xd0
>> Aug 30 23:37:56 Santorini kernel:  [<c010b589>] die+0xf9/0x100
>> Aug 30 23:37:56 Santorini kernel:  [<c010b949>] do_invalid_op+0xc9/0xd0
>> Aug 30 23:37:56 Santorini kernel:  [<c013c167>]
>> free_pages_bulk+0x227/0x280
>> Aug 30 23:37:56 Santorini kernel:  [<c011ff3d>] profile_hook+0x2d/0x4b
>> Aug 30 23:37:56 Santorini kernel:  [<c01161ee>]
>> smp_apic_timer_interrupt+0x2e/0x100
>> Aug 30 23:37:56 Santorini kernel:  [<c03068b6>]
>> apic_timer_interrupt+0x1a/0x20
>> Aug 30 23:37:56 Santorini kernel:  [<c011ff3d>] profile_hook+0x2d/0x4b
>> Aug 30 23:37:56 Santorini kernel:  [<c0306933>] error_code+0x2f/0x38
>> Aug 30 23:37:56 Santorini kernel:  [<c013c167>]
>> free_pages_bulk+0x227/0x280
>> Aug 30 23:37:56 Santorini kernel:  [<c013c713>]
>> free_hot_cold_page+0xf3/0x100
>> Aug 30 23:37:56 Santorini kernel:  [<c016751a>] poll_freewait+0x3a/0x50
>> Aug 30 23:37:56 Santorini kernel:  [<c0167897>] do_select+0x1b7/0x2d0
>> Aug 30 23:37:56 Santorini kernel:  [<c0167530>] __pollwait+0x0/0xd0
>> Aug 30 23:37:56 Santorini kernel:  [<c0167c9f>] sys_select+0x2bf/0x4c0
>> Aug 30 23:37:56 Santorini kernel:  [<c0305f27>] syscall_call+0x7/0xb
>> Aug 30 23:37:56 Santorini kernel:
>> Aug 30 23:37:56 Santorini kernel: Code: ff 85 c0 0f 85 e9 00 00 00 8b 44
>> 24 14 8b 54 24 44 89 44 24 04 89 14 24 e8 94 fd
>> ff ff 85 c0 0f 85 c0 00 00 00 8d 4b 08 8b 51 04 <39> 0a 0f 85 a5 00 
>> 00 00
>> 8b 43 08 39 48 04 0f 85 8c 00 00 00 01
>> Aug 30 23:37:56 Santorini kernel:  <6>note: kdeinit[9173] exited with
>> preempt_count 5
>> Aug 30 23:37:56 Santorini kernel: ------------[ cut here ]------------
>> Aug 30 23:37:56 Santorini kernel: kernel BUG at 
>> include/linux/list.h:148!
>> Aug 30 23:37:56 Santorini kernel: invalid operand: 0000 [#4]
>> Aug 30 23:37:56 Santorini kernel: PREEMPT
>> Aug 30 23:37:56 Santorini kernel: CPU:    0
>> Aug 30 23:37:56 Santorini kernel: EIP:    0060:[<c013c167>]    
>> Tainted: P
>> VLI
>> Aug 30 23:37:56 Santorini kernel: EFLAGS: 00010002
>> Aug 30 23:37:56 Santorini kernel: EIP is at free_pages_bulk+0x227/0x280
>> Aug 30 23:37:56 Santorini kernel: eax: 00000000   ebx: c11e1608   ecx:
>> c11e1610   edx: c0b79d80
>> Aug 30 23:37:56 Santorini kernel: esi: 0000b08c   edi: ffffffff   ebp:
>> 00005846   esp: d0ba59f4
>> Aug 30 23:37:56 Santorini kernel: ds: 007b   es: 007b   ss: 0068
>> Aug 30 23:37:56 Santorini kernel: Process kdeinit (pid: 9173,
>> threadinfo=d0ba4000 task=d0bdad20)
>> Aug 30 23:37:56 Santorini kernel: Stack: c035eb74 c11e15e0 c035ec34
>> 00000000 00000001 c11e15e0 c035ebb0 00000004
>> Aug 30 23:37:56 Santorini kernel:        c1028000 c035ebb0 00000082
>> ffffffff c035eb74 c1278fd0 d0ba4000 c035ec50
>> Aug 30 23:37:56 Santorini kernel:        c013c713 c035eb74 0000000b
>> c035ec50 00000000 00000206 c035eb74 d3af6580
>> Aug 30 23:37:56 Santorini kernel: Call Trace:
>> Aug 30 23:37:56 Santorini kernel:  [<c013c713>]
>> free_hot_cold_page+0xf3/0x100
>> Aug 30 23:37:56 Santorini kernel:  [<c01615f1>] pipe_release+0xc1/0xd0
>> Aug 30 23:37:56 Santorini kernel:  [<c01617c0>]
>> pipe_write_release+0x0/0x40
>> Aug 30 23:37:56 Santorini kernel:  [<c01617fb>]
>> pipe_write_release+0x3b/0x40
>> Aug 30 23:37:56 Santorini kernel:  [<c01551f8>] __fput+0x118/0x130
>> Aug 30 23:37:56 Santorini kernel:  [<c0153719>] filp_close+0x59/0x90
>> Aug 30 23:37:56 Santorini kernel:  [<c01208c4>] 
>> put_files_struct+0x54/0xc0
>> Aug 30 23:37:56 Santorini kernel:  [<c01214f7>] do_exit+0x167/0x400
>> Aug 30 23:37:56 Santorini kernel:  [<c01196e0>] do_page_fault+0x0/0x454
>> Aug 30 23:37:56 Santorini kernel:  [<c010b589>] die+0xf9/0x100
>> Aug 30 23:37:56 Santorini kernel:  [<c011980c>] 
>> do_page_fault+0x12c/0x454
>> Aug 30 23:37:56 Santorini kernel:  [<c025f316>] 
>> __ide_dma_begin+0x36/0x50
>> Aug 30 23:37:56 Santorini kernel:  [<c025f4c3>] 
>> __ide_dma_count+0x13/0x20
>> Aug 30 23:37:56 Santorini kernel:  [<c025f1f0>] __ide_dma_read+0xd0/0xe0
>> Aug 30 23:37:56 Santorini kernel:  [<c025e8d0>] ide_dma_intr+0x0/0xc0
>> Aug 30 23:37:56 Santorini kernel:  [<c025ee10>] 
>> dma_timer_expiry+0x0/0x90
>> Aug 30 23:37:56 Santorini kernel:  [<c024dcfd>] 
>> do_rw_taskfile+0x1bd/0x2b0
>> Aug 30 23:37:56 Santorini kernel:  [<c01196e0>] do_page_fault+0x0/0x454
>> Aug 30 23:37:56 Santorini kernel:  [<c0306933>] error_code+0x2f/0x38
>> Aug 30 23:37:56 Santorini kernel:  [<c013c0ba>]
>> free_pages_bulk+0x17a/0x280
>> Aug 30 23:37:56 Santorini kernel:  [<c013c713>]
>> free_hot_cold_page+0xf3/0x100
>> Aug 30 23:37:56 Santorini kernel:  [<c0145132>] 
>> zap_pte_range+0x142/0x180
>> Aug 30 23:37:56 Santorini kernel:  [<c01451bb>] zap_pmd_range+0x4b/0x70
>> Aug 30 23:37:56 Santorini kernel:  [<c0145223>] 
>> unmap_page_range+0x43/0x70
>> Aug 30 23:37:56 Santorini kernel:  [<c0145331>] unmap_vmas+0xe1/0x210
>> Aug 30 23:37:56 Santorini kernel:  [<c0149093>] exit_mmap+0x83/0x1a0
>> Aug 30 23:37:56 Santorini kernel:  [<c011d269>] mmput+0x79/0xf0
>> Aug 30 23:37:56 Santorini kernel:  [<c01214bc>] do_exit+0x12c/0x400
>> Aug 30 23:37:56 Santorini kernel:  [<c010b880>] do_invalid_op+0x0/0xd0
>> Aug 30 23:37:56 Santorini kernel:  [<c010b589>] die+0xf9/0x100
>> Aug 30 23:37:56 Santorini kernel:  [<c010b949>] do_invalid_op+0xc9/0xd0
>> Aug 30 23:37:56 Santorini kernel:  [<c013c167>]
>> free_pages_bulk+0x227/0x280
>> Aug 30 23:37:56 Santorini kernel:  [<c011ff3d>] profile_hook+0x2d/0x4b
>> Aug 30 23:37:56 Santorini kernel:  [<c01161ee>]
>> smp_apic_timer_interrupt+0x2e/0x100
>> Aug 30 23:37:56 Santorini kernel:  [<c03068b6>]
>> apic_timer_interrupt+0x1a/0x20
>> Aug 30 23:37:56 Santorini kernel:  [<c011ff3d>] profile_hook+0x2d/0x4b
>> Aug 30 23:37:56 Santorini kernel:  [<c0306933>] error_code+0x2f/0x38
>> Aug 30 23:37:56 Santorini kernel:  [<c013c167>]
>> free_pages_bulk+0x227/0x280
>> Aug 30 23:37:56 Santorini kernel:  [<c013c713>]
>> free_hot_cold_page+0xf3/0x100
>> Aug 30 23:37:56 Santorini kernel:  [<c016751a>] poll_freewait+0x3a/0x50
>> Aug 30 23:37:56 Santorini kernel:  [<c0167897>] do_select+0x1b7/0x2d0
>> Aug 30 23:37:56 Santorini kernel:  [<c0167530>] __pollwait+0x0/0xd0
>> Aug 30 23:37:56 Santorini kernel:  [<c0167c9f>] sys_select+0x2bf/0x4c0
>> Aug 30 23:37:56 Santorini kernel:  [<c0305f27>] syscall_call+0x7/0xb
>> Aug 30 23:37:56 Santorini kernel:
>> Aug 30 23:37:56 Santorini kernel: Code: e0 ff 48 14 8b 40 08 a8 08 75 0c
>> 8b 44 24 1c 83 c4 30 5b 5e 5f 5d c3 e8 48 f5 fd
>> ff eb ed 0f 0b 95 00 72 17 31 c0 e9 67 ff ff ff <0f> 0b 94 00 72 17 
>> 31 c0
>> e9 4e ff ff ff 0f 0b ca 00 58 e9 31 c0
>> Aug 30 23:37:56 Santorini kernel:  <6>note: kdeinit[9173] exited with
>> preempt_count 7
>> Aug 30 23:37:56 Santorini kernel: Unable to handle kernel paging request
>> at virtual address 00200200
>> Aug 30 23:37:56 Santorini kernel:  printing eip:
>> Aug 30 23:37:56 Santorini kernel: c013c0ba
>> Aug 30 23:37:56 Santorini kernel: *pde = 00000000
>> Aug 30 23:37:56 Santorini kernel: Oops: 0000 [#5]
>> Aug 30 23:37:56 Santorini kernel: PREEMPT
>> Aug 30 23:37:56 Santorini kernel: CPU:    0
>> Aug 30 23:37:56 Santorini kernel: EIP:    0060:[<c013c0ba>]    
>> Tainted: P
>> VLI
>> Aug 30 23:37:56 Santorini kernel: EFLAGS: 00010046
>> Aug 30 23:37:56 Santorini kernel: EIP is at free_pages_bulk+0x17a/0x280
>> Aug 30 23:37:56 Santorini kernel: eax: 00000000   ebx: c1470810   ecx:
>> c1470818   edx: 00200200
>> Aug 30 23:37:56 Santorini kernel: esi: 0001b69b   edi: ffffffff   ebp:
>> 0000db4d   esp: d0b45e74
>> Aug 30 23:37:56 Santorini kernel: ds: 007b   es: 007b   ss: 0068
>> Aug 30 23:37:56 Santorini kernel: Process artsd (pid: 9178,
>> threadinfo=d0b44000 task=d0bdb350)
>> Aug 30 23:37:56 Santorini kernel: Stack: c035eb74 c1470838 c035ec34
>> 00000000 00000001 c1470838 c035ebb0 00000001
>> Aug 30 23:37:56 Santorini kernel:        c1028000 c035ebb0 00000086
>> ffffffff c035eb74 c1343d70 d0b44000 c035ec50
>> Aug 30 23:37:56 Santorini kernel:        c013c713 c035eb74 0000000e
>> c035ec50 00000000 00000202 c035eb74 d4e56008
>> Aug 30 23:37:56 Santorini kernel: Call Trace:
>> Aug 30 23:37:56 Santorini kernel:  [<c013c713>]
>> free_hot_cold_page+0xf3/0x100
>> Aug 30 23:37:57 Santorini kernel:  [<c016751a>] poll_freewait+0x3a/0x50
>> Aug 30 23:37:57 Santorini kernel:  [<c0167897>] do_select+0x1b7/0x2d0
>> Aug 30 23:37:57 Santorini kernel:  [<c0167530>] __pollwait+0x0/0xd0
>> Aug 30 23:37:57 Santorini kernel:  [<c0167c9f>] sys_select+0x2bf/0x4c0
>> Aug 30 23:37:57 Santorini kernel:  [<c0305f27>] syscall_call+0x7/0xb
>> Aug 30 23:37:57 Santorini kernel:
>> Aug 30 23:37:57 Santorini kernel: Code: ff 85 c0 0f 85 e9 00 00 00 8b 44
>> 24 14 8b 54 24 44 89 44 24 04 89 14 24 e8 94 fd
>> ff ff 85 c0 0f 85 c0 00 00 00 8d 4b 08 8b 51 04 <39> 0a 0f 85 a5 00 
>> 00 00
>> 8b 43 08 39 48 04 0f 85 8c 00 00 00 01
>> Aug 30 23:37:57 Santorini kernel:  <6>note: artsd[9178] exited with
>> preempt_count 2
>>
>> Aug 30 23:37:57 Santorini kernel: ------------[ cut here ]------------
>> Aug 30 23:37:57 Santorini kernel: kernel BUG at 
>> include/linux/list.h:148!
>> Aug 30 23:37:57 Santorini kernel: invalid operand: 0000 [#6]
>> Aug 30 23:37:57 Santorini kernel: PREEMPT
>> Aug 30 23:37:57 Santorini kernel: CPU:    0
>> Aug 30 23:37:57 Santorini kernel: EIP:    0060:[<c013c167>]    
>> Tainted: P
>> VLI
>> Aug 30 23:37:57 Santorini kernel: EFLAGS: 00210016
>> Aug 30 23:37:57 Santorini kernel: EIP is at free_pages_bulk+0x227/0x280
>> Aug 30 23:37:57 Santorini kernel: eax: 00000000   ebx: c13955d0   ecx:
>> c13955d8   edx: c10da398
>> Aug 30 23:37:57 Santorini kernel: esi: 00015ef0   edi: fffffffe   ebp:
>> 000057bc   esp: d68f3e3c
>> Aug 30 23:37:57 Santorini kernel: ds: 007b   es: 007b   ss: 0068
>> Aug 30 23:37:57 Santorini kernel: Process kdeinit (pid: 3095,
>> threadinfo=d68f2000 task=c2850670)
>> Aug 30 23:37:57 Santorini kernel: Stack: c035eb74 c1395580 c035ec34
>> 00000000 00000001 c1395580 c035ebbc 00000009
>> Aug 30 23:37:57 Santorini kernel:        c1028000 c035ebb0 00200086
>> ffffffff c035eb74 c1140460 d68f2000 c035ec50
>> Aug 30 23:37:57 Santorini kernel:        c013c713 c035eb74 00000006
>> c035ec50 00000000 00200202 c035eb74 c4346f58
>> Aug 30 23:37:57 Santorini kernel: Call Trace:
>> Aug 30 23:37:57 Santorini kernel:  [<c013c713>]
>> free_hot_cold_page+0xf3/0x100
>> Aug 30 23:37:57 Santorini kernel:  [<c0145132>] 
>> zap_pte_range+0x142/0x180
>> Aug 30 23:37:57 Santorini kernel:  [<c0145eff>] do_wp_page+0x2af/0x300
>> Aug 30 23:37:57 Santorini kernel:  [<c01451bb>] zap_pmd_range+0x4b/0x70
>> Aug 30 23:37:57 Santorini kernel:  [<c0145223>] 
>> unmap_page_range+0x43/0x70
>> Aug 30 23:37:57 Santorini kernel:  [<c0145331>] unmap_vmas+0xe1/0x210
>> Aug 30 23:37:57 Santorini kernel:  [<c0149093>] exit_mmap+0x83/0x1a0
>> Aug 30 23:37:57 Santorini kernel:  [<c011d269>] mmput+0x79/0xf0
>> Aug 30 23:37:57 Santorini kernel:  [<c01214bc>] do_exit+0x12c/0x400
>> Aug 30 23:37:57 Santorini kernel:  [<c011b6f0>]
>> default_wake_function+0x0/0x30
>> Aug 30 23:37:57 Santorini kernel:  [<c012182a>] do_group_exit+0x3a/0xb0
>> Aug 30 23:37:57 Santorini kernel:  [<c0305f27>] syscall_call+0x7/0xb
>> Aug 30 23:37:57 Santorini kernel:
>> Aug 30 23:37:57 Santorini kernel: Code: e0 ff 48 14 8b 40 08 a8 08 75 0c
>> 8b 44 24 1c 83 c4 30 5b 5e 5f 5d c3 e8 48 f5 fd
>> ff eb ed 0f 0b 95 00 72 17 31 c0 e9 67 ff ff ff <0f> 0b 94 00 72 17 
>> 31 c0
>> e9 4e ff ff ff 0f 0b ca 00 58 e9 31 c0
>> Aug 30 23:37:57 Santorini kernel:  <6>note: kdeinit[3095] exited with
>> preempt_count 3
>>
>> -
>> To unsubscribe from this list: send the line "unsubscribe 
>> linux-kernel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
>>
>>  
>>
>
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

