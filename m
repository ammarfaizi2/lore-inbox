Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262784AbTKSSUZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Nov 2003 13:20:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263938AbTKSSUZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Nov 2003 13:20:25 -0500
Received: from relay-3m.club-internet.fr ([194.158.104.42]:17558 "EHLO
	relay-3m.club-internet.fr") by vger.kernel.org with ESMTP
	id S262784AbTKSSTy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Nov 2003 13:19:54 -0500
From: pinotj@club-internet.fr
To: linux-kernel@vger.kernel.org
Subject: [Oops]  i386 mm/slab.c (cache_flusharray)
Date: Wed, 19 Nov 2003 19:19:53 CET
Mime-Version: 1.0
X-Mailer: Medianet/v2.0
Message-Id: <mnet1.1069265993.8009.pinotj@club-internet.fr>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is an Oops from the kernel 2.6.0-test9 + cset-20031115_0206.txt.gz (means all current patches till 03/11/14 [PATCH] PPC32: cancel syscall restart on signal delivery ).

Seems to come from the cache_flusharray function of mm/slab.c
It occurs in general during heavy load (compilation of kernel or xfree86...), is quite reproductible but not automatic.
Same Oops on different distro/gcc (slack 9.1 et lfs 5.0).
Arch is i386 (AMD athlon-tbird 1.2GHz)

I never had this problem with 2.6.0-test8 and before.

This oops is very annoying, I got it around 5 times a day. I'm sorry but I don't have the skill to patch this. If someone can help :-) Please CC me in answer, I'm not on the lkml.

Regards,

Jerome Pinot

---
ksymoops 2.4.9 on i686 2.6.0-test9.  Options used
     -V (default)
     -K (specified)
     -l /proc/modules (default)
     -o /mnt/lfs/lib/modules/2.6.0-test9 (specified)
     -m /mnt/lfs/boot/System.map (specified)

No modules in ksyms, skipping objects
No ksyms, skipping lsmod
kernel BUG at mm/slab.c:1957!
invalid operand: 0000 [#1]
CPU:    0
EIP:    0060:[free_block+336/752]    Not tainted
EIP:    0060:[<c015ad40>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010096
eax: 00000045   ebx: 00000006   ecx: c0693854   edx: c056e4f8
esi: cd09a000   edi: cd09a018   ebp: cf821c68   esp: cf821c3c
ds: 007b   es: 007b   ss: 0068
Stack: c0502240 c0502e1d cd09af18 c0652a00 00000001 0000003a cd09af18 0000000f
       cffdef08 c4bcd180 00000010 cf821ca0 c015afba cffed800 cffdef08 00000010
       00000282 c1161ca0 00000000 00000001 cffee730 00000010 00010c00 c4bcd180
Call Trace:
 [<c015afba>] cache_flusharray+0xda/0x2b0
 [<c015b7ad>] kmem_cache_free+0x1ad/0x3a0
 [<c018158c>] free_buffer_head+0x2c/0x60
 [<c018158c>] free_buffer_head+0x2c/0x60
 [<c0181353>] try_to_free_buffers+0x143/0x220
 [<c0294bab>] linvfs_release_page+0x7b/0x80
 [<c017f243>] try_to_release_page+0x53/0x60
 [<c015fec7>] shrink_list+0x8b7/0xac0
 [<c010cadc>] common_interrupt+0x18/0x20
 [<c015e489>] __pagevec_release+0x29/0x40
 [<c01602d5>] shrink_cache+0x205/0x610
 [<c0161228>] shrink_zone+0x78/0xa0
 [<c01615fa>] balance_pgdat+0x17a/0x200
 [<c0161759>] kswapd+0xd9/0xf0
 [<c01274f0>] autoremove_wake_function+0x0/0x50
 [<c010c046>] ret_from_fork+0x6/0x14
 [<c01274f0>] autoremove_wake_function+0x0/0x50
 [<c0161680>] kswapd+0x0/0xf0
 [<c01092a9>] kernel_thread_helper+0x5/0xc
Code: 0f 0b a5 07 82 15 50 c0 8b 46 14 8b 4d e8 31 db 89 04 8f 89


>>EIP; c015ad40 <free_block+150/2f0>   <=====

>>ecx; c0693854 <per_cpu__runqueues+4b4/940>
>>edx; c056e4f8 <log_wait+18/20>
>>esi; cd09a000 <__crc_unregister_sound_dsp+164f0/974e1>
>>edi; cd09a018 <__crc_unregister_sound_dsp+16508/974e1>
>>ebp; cf821c68 <__crc_scsi_register_driver+6c7b9/1f2ec0>
>>esp; cf821c3c <__crc_scsi_register_driver+6c78d/1f2ec0>

Trace; c015afba <cache_flusharray+da/2b0>
Trace; c015b7ad <kmem_cache_free+1ad/3a0>
Trace; c018158c <free_buffer_head+2c/60>
Trace; c018158c <free_buffer_head+2c/60>
Trace; c0181353 <try_to_free_buffers+143/220>
Trace; c0294bab <linvfs_release_page+7b/80>
Trace; c017f243 <try_to_release_page+53/60>
Trace; c015fec7 <shrink_list+8b7/ac0>
Trace; c010cadc <common_interrupt+18/20>
Trace; c015e489 <__pagevec_release+29/40>
Trace; c01602d5 <shrink_cache+205/610>
Trace; c0161228 <shrink_zone+78/a0>
Trace; c01615fa <balance_pgdat+17a/200>
Trace; c0161759 <kswapd+d9/f0>
Trace; c01274f0 <autoremove_wake_function+0/50>
Trace; c010c046 <ret_from_fork+6/14>
Trace; c01274f0 <autoremove_wake_function+0/50>
Trace; c0161680 <kswapd+0/f0>
Trace; c01092a9 <kernel_thread_helper+5/c>

Code;  c015ad40 <free_block+150/2f0>
00000000 <_EIP>:
Code;  c015ad40 <free_block+150/2f0>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c015ad42 <free_block+152/2f0>
   2:   a5                        movsl  %ds:(%esi),%es:(%edi)
Code;  c015ad43 <free_block+153/2f0>
   3:   07                        pop    %es
Code;  c015ad44 <free_block+154/2f0>
   4:   82                        (bad)
Code;  c015ad45 <free_block+155/2f0>
   5:   15 50 c0 8b 46            adc    $0x468bc050,%eax
Code;  c015ad4a <free_block+15a/2f0>
   a:   14 8b                     adc    $0x8b,%al
Code;  c015ad4c <free_block+15c/2f0>
   c:   4d                        dec    %ebp
Code;  c015ad4d <free_block+15d/2f0>
   d:   e8 31 db 89 04            call   489db43 <_EIP+0x489db43>
Code;  c015ad52 <free_block+162/2f0>
  12:   8f 89 00 00 00 00         popl   0x0(%ecx)

Unable to handle kernel paging request at virtual address 00100104
c015ac3c
*pde = 00000000
Oops: 0002 [#2]
CPU:    0
EIP:    0060:[free_block+76/752]    Not tainted
EIP:    0060:[<c015ac3c>]    Not tainted
EFLAGS: 00010017
eax: 00100100   ebx: 00000000   ecx: cd09a810   edx: 00200200
esi: cd09a000   edi: c7430018   ebp: c558bafc   esp: c558bad0
ds: 007b   es: 007b   ss: 0068
Stack: c558badc 00000086 80010c00 ccf77000 cffdc080 0000001a cd09a810 0000000b 
       cffdef08 cd09a180 00000010 c558bb34 c015afba cffed800 cffdef08 00000010
       00000286 c11d0c68 00000000 00000001 cffee730 00000010 00010c00 cd09a180 
Call Trace:
 [<c015afba>] cache_flusharray+0xda/0x2b0
 [<c015b7ad>] kmem_cache_free+0x1ad/0x3a0
 [<c018158c>] free_buffer_head+0x2c/0x60
 [<c018158c>] free_buffer_head+0x2c/0x60
 [<c0181353>] try_to_free_buffers+0x143/0x220
 [<c0294bab>] linvfs_release_page+0x7b/0x80
 [<c017f243>] try_to_release_page+0x53/0x60
 [<c015fec7>] shrink_list+0x8b7/0xac0
 [<c0123eef>] schedule+0x36f/0x8a0
 [<c015e489>] __pagevec_release+0x29/0x40
 [<c01602d5>] shrink_cache+0x205/0x610
 [<c0127515>] autoremove_wake_function+0x25/0x50
 [<c0161228>] shrink_zone+0x78/0xa0
 [<c01612ee>] shrink_caches+0x9e/0xc0
 [<c01613b7>] try_to_free_pages+0xa7/0x170
 [<c015541a>] __alloc_pages+0x1fa/0x380
 [<c0165c17>] do_anonymous_page+0xc7/0x520
 [<c017a899>] do_sync_write+0x89/0xc0
 [<c01668f2>] handle_mm_fault+0x132/0x310
 [<c0121940>] do_page_fault+0x350/0x56a
 [<c01698de>] do_brk+0x14e/0x230
 [<c016790e>] sys_brk+0xee/0x120
 [<c01215f0>] do_page_fault+0x0/0x56a
 [<c010cb79>] error_code+0x2d/0x38
Code: 89 50 04 89 02 c7 46 04 00 02 20 00 c7 06 00 01 10 00 89 c8


>>EIP; c015ac3c <free_block+4c/2f0>   <=====

>>eax; 00100100 <__crc_prepare_to_wait_exclusive+ce3e5/1424fd>
>>ecx; cd09a810 <__crc_unregister_sound_dsp+16d00/974e1>
>>edx; 00200200 <__crc___user_walk+3d8ad/1cb584>
>>esi; cd09a000 <__crc_unregister_sound_dsp+164f0/974e1>
>>edi; c7430018 <__crc_inet_getsockopt+60fc6/20c3c2>
>>ebp; c558bafc <__crc_fat_write_inode+336fc/668510>
>>esp; c558bad0 <__crc_fat_write_inode+336d0/668510>

Trace; c015afba <cache_flusharray+da/2b0>
Trace; c015b7ad <kmem_cache_free+1ad/3a0>
Trace; c018158c <free_buffer_head+2c/60>
Trace; c018158c <free_buffer_head+2c/60>
Trace; c0181353 <try_to_free_buffers+143/220>
Trace; c0294bab <linvfs_release_page+7b/80>
Trace; c017f243 <try_to_release_page+53/60>
Trace; c015fec7 <shrink_list+8b7/ac0>
Trace; c0123eef <schedule+36f/8a0>
Trace; c015e489 <__pagevec_release+29/40>
Trace; c01602d5 <shrink_cache+205/610>
Trace; c0127515 <autoremove_wake_function+25/50>
Trace; c0161228 <shrink_zone+78/a0>
Trace; c01612ee <shrink_caches+9e/c0>
Trace; c01613b7 <try_to_free_pages+a7/170>
Trace; c015541a <__alloc_pages+1fa/380>
Trace; c0165c17 <do_anonymous_page+c7/520>
Trace; c017a899 <do_sync_write+89/c0>
Trace; c01668f2 <handle_mm_fault+132/310>
Trace; c0121940 <do_page_fault+350/56a>
Trace; c01698de <do_brk+14e/230>
Trace; c016790e <sys_brk+ee/120>
Trace; c01215f0 <do_page_fault+0/56a>
Trace; c010cb79 <error_code+2d/38>

Code;  c015ac3c <free_block+4c/2f0>
00000000 <_EIP>:
Code;  c015ac3c <free_block+4c/2f0>   <=====
   0:   89 50 04                  mov    %edx,0x4(%eax)   <=====
Code;  c015ac3f <free_block+4f/2f0>
   3:   89 02                     mov    %eax,(%edx)
Code;  c015ac41 <free_block+51/2f0>
   5:   c7 46 04 00 02 20 00      movl   $0x200200,0x4(%esi)
Code;  c015ac48 <free_block+58/2f0>
   c:   c7 06 00 01 10 00         movl   $0x100100,(%esi)
Code;  c015ac4e <free_block+5e/2f0>
  12:   89 c8                     mov    %ecx,%eax

Call Trace:
 [<c0124411>] schedule+0x891/0x8a0
 [<c0163ae1>] unmap_page_range+0x41/0x70
 [<c0163d24>] unmap_vmas+0x214/0x330
 [<c0169adb>] exit_mmap+0xcb/0x2b0
 [<c0127935>] mmput+0xb5/0x150
 [<c012e062>] do_exit+0x1b2/0x960
 [<c01215f0>] do_page_fault+0x0/0x56a
 [<c01215f0>] do_page_fault+0x0/0x56a
 [<c010d367>] die+0x227/0x230
 [<c01217d6>] do_page_fault+0x1e6/0x56a
 [<c0122d1e>] recalc_task_prio+0x8e/0x1b0
 [<c0122f9a>] try_to_wake_up+0x15a/0x290
 [<c01215f0>] do_page_fault+0x0/0x56a
 [<c010cb79>] error_code+0x2d/0x38
 [<c015ac3c>] free_block+0x4c/0x2f0
 [<c015afba>] cache_flusharray+0xda/0x2b0
 [<c015b7ad>] kmem_cache_free+0x1ad/0x3a0
 [<c018158c>] free_buffer_head+0x2c/0x60
 [<c018158c>] free_buffer_head+0x2c/0x60
 [<c0181353>] try_to_free_buffers+0x143/0x220
 [<c0294bab>] linvfs_release_page+0x7b/0x80
 [<c017f243>] try_to_release_page+0x53/0x60
 [<c015fec7>] shrink_list+0x8b7/0xac0
 [<c0123eef>] schedule+0x36f/0x8a0
 [<c015e489>] __pagevec_release+0x29/0x40
 [<c01602d5>] shrink_cache+0x205/0x610
 [<c0127515>] autoremove_wake_function+0x25/0x50
 [<c0161228>] shrink_zone+0x78/0xa0
 [<c01612ee>] shrink_caches+0x9e/0xc0
 [<c01613b7>] try_to_free_pages+0xa7/0x170
 [<c015541a>] __alloc_pages+0x1fa/0x380
 [<c0165c17>] do_anonymous_page+0xc7/0x520
 [<c017a899>] do_sync_write+0x89/0xc0
 [<c01668f2>] handle_mm_fault+0x132/0x310
 [<c0121940>] do_page_fault+0x350/0x56a
 [<c01698de>] do_brk+0x14e/0x230
 [<c016790e>] sys_brk+0xee/0x120
 [<c01215f0>] do_page_fault+0x0/0x56a
 [<c010cb79>] error_code+0x2d/0x38
Call Trace:
 [<c0124411>] schedule+0x891/0x8a0
 [<c0163ae1>] unmap_page_range+0x41/0x70
 [<c0163d24>] unmap_vmas+0x214/0x330
 [<c0169adb>] exit_mmap+0xcb/0x2b0
 [<c0127935>] mmput+0xb5/0x150
 [<c012e062>] do_exit+0x1b2/0x960
 [<c01215f0>] do_page_fault+0x0/0x56a
 [<c01215f0>] do_page_fault+0x0/0x56a
 [<c010d367>] die+0x227/0x230
 [<c01217d6>] do_page_fault+0x1e6/0x56a
 [<c0122d1e>] recalc_task_prio+0x8e/0x1b0
 [<c0122f9a>] try_to_wake_up+0x15a/0x290
 [<c01215f0>] do_page_fault+0x0/0x56a
 [<c010cb79>] error_code+0x2d/0x38
 [<c015ac3c>] free_block+0x4c/0x2f0
 [<c015afba>] cache_flusharray+0xda/0x2b0
 [<c015b7ad>] kmem_cache_free+0x1ad/0x3a0
 [<c018158c>] free_buffer_head+0x2c/0x60
 [<c018158c>] free_buffer_head+0x2c/0x60
 [<c0181353>] try_to_free_buffers+0x143/0x220
 [<c0294bab>] linvfs_release_page+0x7b/0x80
 [<c017f243>] try_to_release_page+0x53/0x60
 [<c015fec7>] shrink_list+0x8b7/0xac0
 [<c0123eef>] schedule+0x36f/0x8a0
 [<c015e489>] __pagevec_release+0x29/0x40
 [<c01602d5>] shrink_cache+0x205/0x610
 [<c0127515>] autoremove_wake_function+0x25/0x50
 [<c0161228>] shrink_zone+0x78/0xa0
 [<c01612ee>] shrink_caches+0x9e/0xc0
 [<c01613b7>] try_to_free_pages+0xa7/0x170
 [<c015541a>] __alloc_pages+0x1fa/0x380
 [<c0165c17>] do_anonymous_page+0xc7/0x520
 [<c017a899>] do_sync_write+0x89/0xc0
 [<c01668f2>] handle_mm_fault+0x132/0x310
 [<c0121940>] do_page_fault+0x350/0x56a
 [<c01698de>] do_brk+0x14e/0x230
 [<c016790e>] sys_brk+0xee/0x120
 [<c01215f0>] do_page_fault+0x0/0x56a
 [<c010cb79>] error_code+0x2d/0x38
Call Trace:
 [<c0124411>] schedule+0x891/0x8a0
 [<c0163ae1>] unmap_page_range+0x41/0x70
 [<c0163d24>] unmap_vmas+0x214/0x330
 [<c0169adb>] exit_mmap+0xcb/0x2b0
 [<c0127935>] mmput+0xb5/0x150
 [<c012e062>] do_exit+0x1b2/0x960
 [<c01215f0>] do_page_fault+0x0/0x56a
 [<c01215f0>] do_page_fault+0x0/0x56a
 [<c010d367>] die+0x227/0x230
 [<c01217d6>] do_page_fault+0x1e6/0x56a
 [<c0122d1e>] recalc_task_prio+0x8e/0x1b0
 [<c0122f9a>] try_to_wake_up+0x15a/0x290
 [<c01215f0>] do_page_fault+0x0/0x56a
 [<c010cb79>] error_code+0x2d/0x38
 [<c015ac3c>] free_block+0x4c/0x2f0
 [<c015afba>] cache_flusharray+0xda/0x2b0
 [<c015b7ad>] kmem_cache_free+0x1ad/0x3a0
 [<c018158c>] free_buffer_head+0x2c/0x60
 [<c018158c>] free_buffer_head+0x2c/0x60
 [<c0181353>] try_to_free_buffers+0x143/0x220
 [<c0294bab>] linvfs_release_page+0x7b/0x80
 [<c017f243>] try_to_release_page+0x53/0x60
 [<c015fec7>] shrink_list+0x8b7/0xac0
 [<c0123eef>] schedule+0x36f/0x8a0
 [<c015e489>] __pagevec_release+0x29/0x40
 [<c01602d5>] shrink_cache+0x205/0x610
 [<c0127515>] autoremove_wake_function+0x25/0x50
 [<c0161228>] shrink_zone+0x78/0xa0
 [<c01612ee>] shrink_caches+0x9e/0xc0
 [<c01613b7>] try_to_free_pages+0xa7/0x170
 [<c015541a>] __alloc_pages+0x1fa/0x380
 [<c0165c17>] do_anonymous_page+0xc7/0x520
 [<c017a899>] do_sync_write+0x89/0xc0
 [<c01668f2>] handle_mm_fault+0x132/0x310
 [<c0121940>] do_page_fault+0x350/0x56a
 [<c01698de>] do_brk+0x14e/0x230
 [<c016790e>] sys_brk+0xee/0x120
 [<c01215f0>] do_page_fault+0x0/0x56a
 [<c010cb79>] error_code+0x2d/0x38
Call Trace:
 [<c0126b1b>] __might_sleep+0xab/0xd0
 [<c01677b9>] remove_shared_vm_struct+0x39/0xa0
 [<c0169be1>] exit_mmap+0x1d1/0x2b0
 [<c0127935>] mmput+0xb5/0x150
 [<c012e062>] do_exit+0x1b2/0x960
 [<c01215f0>] do_page_fault+0x0/0x56a
 [<c01215f0>] do_page_fault+0x0/0x56a
 [<c010d367>] die+0x227/0x230
 [<c01217d6>] do_page_fault+0x1e6/0x56a
 [<c0122d1e>] recalc_task_prio+0x8e/0x1b0
 [<c0122f9a>] try_to_wake_up+0x15a/0x290
 [<c01215f0>] do_page_fault+0x0/0x56a
 [<c010cb79>] error_code+0x2d/0x38
 [<c015ac3c>] free_block+0x4c/0x2f0
 [<c015b7ad>] kmem_cache_free+0x1ad/0x3a0
 [<c018158c>] free_buffer_head+0x2c/0x60
 [<c018158c>] free_buffer_head+0x2c/0x60
 [<c0181353>] try_to_free_buffers+0x143/0x220
 [<c0294bab>] linvfs_release_page+0x7b/0x80
 [<c017f243>] try_to_release_page+0x53/0x60
 [<c015fec7>] shrink_list+0x8b7/0xac0
 [<c0123eef>] schedule+0x36f/0x8a0
 [<c015e489>] __pagevec_release+0x29/0x40
 [<c01602d5>] shrink_cache+0x205/0x610
 [<c0127515>] autoremove_wake_function+0x25/0x50
 [<c0161228>] shrink_zone+0x78/0xa0
 [<c01612ee>] shrink_caches+0x9e/0xc0
 [<c01613b7>] try_to_free_pages+0xa7/0x170
 [<c015541a>] __alloc_pages+0x1fa/0x380
 [<c0165c17>] do_anonymous_page+0xc7/0x520
 [<c017a899>] do_sync_write+0x89/0xc0
 [<c01668f2>] handle_mm_fault+0x132/0x310
 [<c0121940>] do_page_fault+0x350/0x56a
 [<c01698de>] do_brk+0x14e/0x230
 [<c016790e>] sys_brk+0xee/0x120
 [<c01215f0>] do_page_fault+0x0/0x56a
 [<c010cb79>] error_code+0x2d/0x38
Warning (Oops_read): Code line not seen, dumping what data is available


Trace; c0124411 <schedule+891/8a0>
Trace; c0163ae1 <unmap_page_range+41/70>
Trace; c0163d24 <unmap_vmas+214/330>
Trace; c0169adb <exit_mmap+cb/2b0>
Trace; c0127935 <mmput+b5/150>
Trace; c012e062 <do_exit+1b2/960>
Trace; c01215f0 <do_page_fault+0/56a>
Trace; c01215f0 <do_page_fault+0/56a>
Trace; c010d367 <die+227/230>
Trace; c01217d6 <do_page_fault+1e6/56a>
Trace; c0122d1e <recalc_task_prio+8e/1b0>
Trace; c0122f9a <try_to_wake_up+15a/290>
Trace; c01215f0 <do_page_fault+0/56a>
Trace; c010cb79 <error_code+2d/38>
Trace; c015ac3c <free_block+4c/2f0>
Trace; c015afba <cache_flusharray+da/2b0>
Trace; c015b7ad <kmem_cache_free+1ad/3a0>
Trace; c018158c <free_buffer_head+2c/60>
Trace; c018158c <free_buffer_head+2c/60>
Trace; c0181353 <try_to_free_buffers+143/220>
Trace; c0294bab <linvfs_release_page+7b/80>
Trace; c017f243 <try_to_release_page+53/60>
Trace; c015fec7 <shrink_list+8b7/ac0>
Trace; c0123eef <schedule+36f/8a0>
Trace; c015e489 <__pagevec_release+29/40>
Trace; c01602d5 <shrink_cache+205/610>
Trace; c0127515 <autoremove_wake_function+25/50>
Trace; c0161228 <shrink_zone+78/a0>
Trace; c01612ee <shrink_caches+9e/c0>
Trace; c01613b7 <try_to_free_pages+a7/170>
Trace; c015541a <__alloc_pages+1fa/380>
Trace; c0165c17 <do_anonymous_page+c7/520>
Trace; c017a899 <do_sync_write+89/c0>
Trace; c01668f2 <handle_mm_fault+132/310>
Trace; c0121940 <do_page_fault+350/56a>
Trace; c01698de <do_brk+14e/230>
Trace; c016790e <sys_brk+ee/120>
Trace; c01215f0 <do_page_fault+0/56a>
Trace; c010cb79 <error_code+2d/38>
Trace; c0124411 <schedule+891/8a0>
Trace; c0163ae1 <unmap_page_range+41/70>
Trace; c0163d24 <unmap_vmas+214/330>
Trace; c0169adb <exit_mmap+cb/2b0>
Trace; c0127935 <mmput+b5/150>
Trace; c012e062 <do_exit+1b2/960>
Trace; c01215f0 <do_page_fault+0/56a>
Trace; c01215f0 <do_page_fault+0/56a>
Trace; c010d367 <die+227/230>
Trace; c01217d6 <do_page_fault+1e6/56a>
Trace; c0122d1e <recalc_task_prio+8e/1b0>
Trace; c0122f9a <try_to_wake_up+15a/290>
Trace; c01215f0 <do_page_fault+0/56a>
Trace; c010cb79 <error_code+2d/38>
Trace; c015ac3c <free_block+4c/2f0>
Trace; c015afba <cache_flusharray+da/2b0>
Trace; c015b7ad <kmem_cache_free+1ad/3a0>
Trace; c018158c <free_buffer_head+2c/60>
Trace; c018158c <free_buffer_head+2c/60>
Trace; c0181353 <try_to_free_buffers+143/220>
Trace; c0294bab <linvfs_release_page+7b/80>
Trace; c017f243 <try_to_release_page+53/60>
Trace; c015fec7 <shrink_list+8b7/ac0>
Trace; c0123eef <schedule+36f/8a0>
Trace; c015e489 <__pagevec_release+29/40>
Trace; c01602d5 <shrink_cache+205/610>
Trace; c0127515 <autoremove_wake_function+25/50>
Trace; c0161228 <shrink_zone+78/a0>
Trace; c01612ee <shrink_caches+9e/c0>
Trace; c01613b7 <try_to_free_pages+a7/170>
Trace; c015541a <__alloc_pages+1fa/380>
Trace; c0165c17 <do_anonymous_page+c7/520>
Trace; c017a899 <do_sync_write+89/c0>
Trace; c01668f2 <handle_mm_fault+132/310>
Trace; c0121940 <do_page_fault+350/56a>
Trace; c01698de <do_brk+14e/230>
Trace; c016790e <sys_brk+ee/120>
Trace; c01215f0 <do_page_fault+0/56a>
Trace; c010cb79 <error_code+2d/38>
Trace; c0124411 <schedule+891/8a0>
Trace; c0163ae1 <unmap_page_range+41/70>
Trace; c0163d24 <unmap_vmas+214/330>
Trace; c0169adb <exit_mmap+cb/2b0>
Trace; c0127935 <mmput+b5/150>
Trace; c012e062 <do_exit+1b2/960>
Trace; c01215f0 <do_page_fault+0/56a>
Trace; c01215f0 <do_page_fault+0/56a>
Trace; c010d367 <die+227/230>
Trace; c01217d6 <do_page_fault+1e6/56a>
Trace; c0122d1e <recalc_task_prio+8e/1b0>
Trace; c0122f9a <try_to_wake_up+15a/290>
Trace; c01215f0 <do_page_fault+0/56a>
Trace; c010cb79 <error_code+2d/38>
Trace; c015ac3c <free_block+4c/2f0>
Trace; c015afba <cache_flusharray+da/2b0>
Trace; c015b7ad <kmem_cache_free+1ad/3a0>
Trace; c018158c <free_buffer_head+2c/60>
Trace; c018158c <free_buffer_head+2c/60>
Trace; c0181353 <try_to_free_buffers+143/220>
Trace; c0294bab <linvfs_release_page+7b/80>
Trace; c017f243 <try_to_release_page+53/60>
Trace; c015fec7 <shrink_list+8b7/ac0>
Trace; c0123eef <schedule+36f/8a0>
Trace; c015e489 <__pagevec_release+29/40>
Trace; c01602d5 <shrink_cache+205/610>
Trace; c0127515 <autoremove_wake_function+25/50>
Trace; c0161228 <shrink_zone+78/a0>
Trace; c01612ee <shrink_caches+9e/c0>
Trace; c01613b7 <try_to_free_pages+a7/170>
Trace; c015541a <__alloc_pages+1fa/380>
Trace; c0165c17 <do_anonymous_page+c7/520>
Trace; c017a899 <do_sync_write+89/c0>
Trace; c01668f2 <handle_mm_fault+132/310>
Trace; c0121940 <do_page_fault+350/56a>
Trace; c01698de <do_brk+14e/230>
Trace; c016790e <sys_brk+ee/120>
Trace; c01215f0 <do_page_fault+0/56a>
Trace; c010cb79 <error_code+2d/38>
Trace; c0126b1b <__might_sleep+ab/d0>
Trace; c01677b9 <remove_shared_vm_struct+39/a0>
Trace; c0169be1 <exit_mmap+1d1/2b0>
Trace; c0127935 <mmput+b5/150>
Trace; c012e062 <do_exit+1b2/960>
Trace; c01215f0 <do_page_fault+0/56a>
Trace; c01215f0 <do_page_fault+0/56a>
Trace; c010d367 <die+227/230>
Trace; c01217d6 <do_page_fault+1e6/56a>
Trace; c0122d1e <recalc_task_prio+8e/1b0>
Trace; c0122f9a <try_to_wake_up+15a/290>
Trace; c01215f0 <do_page_fault+0/56a>
Trace; c010cb79 <error_code+2d/38>
Trace; c015ac3c <free_block+4c/2f0>
Trace; c015b7ad <kmem_cache_free+1ad/3a0>
Trace; c018158c <free_buffer_head+2c/60>
Trace; c018158c <free_buffer_head+2c/60>
Trace; c0181353 <try_to_free_buffers+143/220>
Trace; c0294bab <linvfs_release_page+7b/80>
Trace; c017f243 <try_to_release_page+53/60>
Trace; c015fec7 <shrink_list+8b7/ac0>
Trace; c0123eef <schedule+36f/8a0>
Trace; c015e489 <__pagevec_release+29/40>
Trace; c01602d5 <shrink_cache+205/610>
Trace; c0127515 <autoremove_wake_function+25/50>
Trace; c0161228 <shrink_zone+78/a0>
Trace; c01612ee <shrink_caches+9e/c0>
Trace; c01613b7 <try_to_free_pages+a7/170>
Trace; c015541a <__alloc_pages+1fa/380>
Trace; c0165c17 <do_anonymous_page+c7/520>
Trace; c017a899 <do_sync_write+89/c0>
Trace; c01668f2 <handle_mm_fault+132/310>
Trace; c0121940 <do_page_fault+350/56a>
Trace; c01698de <do_brk+14e/230>
Trace; c016790e <sys_brk+ee/120>
Trace; c01215f0 <do_page_fault+0/56a>
Trace; c010cb79 <error_code+2d/38>

