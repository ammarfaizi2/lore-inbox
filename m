Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269987AbTHFQUy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 12:20:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269994AbTHFQUy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 12:20:54 -0400
Received: from www.13thfloor.at ([212.16.59.250]:12704 "EHLO www.13thfloor.at")
	by vger.kernel.org with ESMTP id S269987AbTHFQUr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 12:20:47 -0400
Date: Wed, 6 Aug 2003 18:20:54 +0200
From: Herbert =?iso-8859-1?Q?P=F6tzl?= <herbert@13thfloor.at>
To: joshua.gooding@csm.com.au
Cc: linux-kernel@vger.kernel.org
Subject: Re: Server Crash
Message-ID: <20030806162054.GA18622@www.13thfloor.at>
Reply-To: herbert@13thfloor.at
Mail-Followup-To: joshua.gooding@csm.com.au,
	linux-kernel@vger.kernel.org
References: <OFD147BB6C.1AE55395-ON69256D7A.00175728-69256D7A.0017759F@csm.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <OFD147BB6C.1AE55395-ON69256D7A.00175728-69256D7A.0017759F@csm.com.au>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 06, 2003 at 01:46:14PM +0930, joshua.gooding@csm.com.au wrote:

Hi Joshua!

> Hi All,
> 
> Is anyone able to tell me what the below error means. This has been
> happening on a few of our servers every once and a while. Where are running
> Redhat 7.2 with 2.4.9-31smp kernel. After this error occurs the server is
> unusable and requires a restart. Posted this problem here a while ago and
> tried upgrading the kernal and quota packages but the issue still seems to
> occur
> 
> Aug  6 08:15:00 server kernel: VFS: dqput: trying to free free dquot
> Aug  6 08:15:00 server kernel: VFS: device 08:05, dquot of group 11001530
> Aug  6 08:15:00 server kernel: remove_free_dquot: dquot not on the free
> list??

this BUG() means that a dquot structure was removed
which, at this moment was not on the free list of quotas
(where it should have been for removal) ...

further this resulted in a bad access ...

this is a problem, which is probably fixed in
later versions of the quota code, but YMMV ...

HTH,
Herbert

> Aug  6 08:15:00 server kernel: Unable to handle kernel NULL pointer
> dereference at virtual address 00000004
> Aug  6 08:15:00 server kernel:  printing eip:
> Aug  6 08:15:00 server kernel: c01583a3
> Aug  6 08:15:00 server kernel: *pde = 00000000
> Aug  6 08:15:00 server kernel: Oops: 0002
> Aug  6 08:15:00 server kernel: Kernel 2.4.9-31smp
> Aug  6 08:15:00 server kernel: CPU:    0
> Aug  6 08:15:01 server kernel: EIP:    0010:[prune_dqcache+115/192]    Not
> tainted
> Aug  6 08:15:01 server kernel: EIP:    0010:[<c01583a3>]    Not tainted
> Aug  6 08:15:01 server kernel: EFLAGS: 00010246
> Aug  6 08:15:01 server xinetd: xinetd startup succeeded
> Aug  6 08:15:01 server kernel: EIP is at prune_dqcache [kernel] 0x73
> Aug  6 08:15:01 server kernel: eax: 00000000   ebx: cc6d1960   ecx:
> cc6d1968   edx: 00000000
> Aug  6 08:15:01 server kernel: esi: 00000000   edi: 00000000   ebp:
> 000000d2   esp: d373bd90
> Aug  6 08:15:01 server kernel: ds: 0018   es: 0018   ss: 0018
> Aug  6 08:15:01 server kernel: Process php (pid: 28721, stackpage=d373b000)
> Aug  6 08:15:01 server kernel: Stack: db5f9000 c1c85470 d373a000 000000d2
> 00000a21 000000d2 c0158405 00000002
> Aug  6 08:15:01 server kernel:        c013605b 00000006 000000d2 c1c85470
> 000000d2 c1c8537c 000000d2 000000d2
> Aug  6 08:15:01 server kernel:        00000000 d373a000 00000001 c01361c8
> 000000d2 00000001 d373a000 c0136eb1
> Aug  6 08:15:01 server kernel: Call Trace: [shrink_dqcache_memory+21/48]
> shrink_dqcache_memory [kernel] 0x15
> Aug  6 08:15:01 server kernel: Call Trace: [<c0158405>]
> shrink_dqcache_memory [kernel] 0x15
> Aug  6 08:15:01 server kernel: [do_try_to_free_pages+43/80]
> do_try_to_free_pages [kernel] 0x2b
> Aug  6 08:15:02 server kernel: [<c013605b>] do_try_to_free_pages [kernel]
> 0x2b
> Aug  6 08:15:02 server kernel: [try_to_free_pages+40/64] try_to_free_pages
> [kernel] 0x28
> Aug  6 08:15:02 server kernel: [<c01361c8>] try_to_free_pages [kernel] 0x28
> Aug  6 08:15:02 server kernel: [_wrapped_alloc_pages+449/624]
> _wrapped_alloc_pages [kernel] 0x1c1
> Aug  6 08:15:02 server kernel: [<c0136eb1>] _wrapped_alloc_pages [kernel]
> 0x1c1
> Aug  6 08:15:02 server kernel: [__alloc_pages+15/160] __alloc_pages
> [kernel] 0xf
> Aug  6 08:15:02 server kernel: [<c0136f6f>] __alloc_pages [kernel] 0xf
> Aug  6 08:15:02 server kernel: [shmem_getpage_locked+711/1008]
> shmem_getpage_locked [kernel] 0x2c7
> Aug  6 08:15:02 server kernel: [<c013a067>] shmem_getpage_locked [kernel]
> 0x2c7
> Aug  6 08:15:02 server kernel: [shmem_getpage+90/256] shmem_getpage
> [kernel] 0x5a
> Aug  6 08:15:02 server kernel: [<c013a1ea>] shmem_getpage [kernel] 0x5a
> Aug  6 08:15:02 server kernel: [shmem_nopage+46/352] shmem_nopage [kernel]
> 0x2e
> Aug  6 08:15:02 server kernel: [<c013a2be>] shmem_nopage [kernel] 0x2e
> Aug  6 08:15:02 server kernel: [do_no_page+125/288] do_no_page [kernel]
> 0x7d
> Aug  6 08:15:02 server kernel: [<c012b28d>] do_no_page [kernel] 0x7d
> Aug  6 08:15:02 server kernel: [handle_mm_fault+107/224] handle_mm_fault
> [kernel] 0x6b
> Aug  6 08:15:02 server kernel: [<c012b39b>] handle_mm_fault [kernel] 0x6b
> Aug  6 08:15:02 server kernel:
> [eepro100:__insmod_eepro100_O/lib/modules/2.4.9-31smp/kernel/drivers/+-1089158/96]
>  scsi_io_completion
> _Rsmp_708d15eb [scsi_mod] 0x28a
> Aug  6 08:15:02 server kernel: [<e080817a>]
> scsi_io_completion_Rsmp_708d15eb [scsi_mod] 0x28a
> Aug  6 08:15:03 server kernel: [call_do_IRQ+5/13] call_do_IRQ [kernel] 0x5
> Aug  6 08:15:03 server kernel: [<c022ea10>] call_do_IRQ [kernel] 0x5
> Aug  6 08:15:03 server kernel: [do_page_fault+0/1216] do_page_fault
> [kernel] 0x0
> Aug  6 08:15:03 server kernel: [<c01176e0>] do_page_fault [kernel] 0x0
> Aug  6 08:15:03 server kernel: [do_page_fault+422/1216] do_page_fault
> [kernel] 0x1a6
> Aug  6 08:15:03 server kernel: [<c0117886>] do_page_fault [kernel] 0x1a6
> Aug  6 08:15:03 server kernel:
> [eepro100:__insmod_eepro100_O/lib/modules/2.4.9-31smp/kernel/drivers/+-1117799/96]
>  scsi_do_cmd_Rsmp_8
> 0fdff72 [scsi_mod] 0x649
> Aug  6 08:15:03 server kernel: [<e0801199>] scsi_do_cmd_Rsmp_80fdff72
> [scsi_mod] 0x649
> Aug  6 08:15:03 server kernel:
> [eepro100:__insmod_eepro100_O/lib/modules/2.4.9-31smp/kernel/drivers/+-1118512/96]
>  scsi_do_cmd_Rsmp_8
> 0fdff72 [scsi_mod] 0x380
> Aug  6 08:15:03 server kernel: [<e0800ed0>] scsi_do_cmd_Rsmp_80fdff72
> [scsi_mod] 0x380
> Aug  6 08:15:03 server kernel: [schedule+1020/1600] schedule [kernel] 0x3fc
> Aug  6 08:15:03 server kernel: [<c011877c>] schedule [kernel] 0x3fc
> Aug  6 08:15:03 server kernel: [do_page_fault+0/1216] do_page_fault
> [kernel] 0x0
> Aug  6 08:15:03 server kernel: [<c01176e0>] do_page_fault [kernel] 0x0
> Aug  6 08:15:03 server kernel: [error_code+56/64] error_code [kernel] 0x38
> Aug  6 08:15:03 server kernel: [<c0107298>] error_code [kernel] 0x38
> Aug  6 08:15:03 server kernel:
> Aug  6 08:15:03 server kernel:
> Aug  6 08:15:03 server kernel: Code: 89 50 04 89 02 c7 41 04 00 00 00 00 c7
> 43 08 00 00 00 00 8b
> Aug  6 08:15:03 server kernel:  remove_free_dquot: dquot not on the free
> list??
> Aug  6 08:15:03 server kernel: Unable to handle kernel NULL pointer
> dereference at virtual address 00000004
> Aug  6 08:15:03 server kernel:  printing eip:
> Aug  6 08:15:03 server kernel: c01583a3
> Aug  6 08:15:03 server kernel: *pde = 00000000
> Aug  6 08:15:03 server kernel: Oops: 0002
> Aug  6 08:15:03 server kernel: Kernel 2.4.9-31smp
> Aug  6 08:15:03 server kernel: CPU:    0
> Aug  6 08:15:03 server kernel: EIP:    0010:[prune_dqcache+115/192]    Not
> tainted
> Aug  6 08:15:03 server kernel: EIP:    0010:[<c01583a3>]    Not tainted
> Aug  6 08:15:03 server kernel: EFLAGS: 00010202
> Aug  6 08:15:03 server kernel: EIP is at prune_dqcache [kernel] 0x73
> Aug  6 08:15:03 server kernel: eax: 00000000   ebx: cc6d1960   ecx:
> cc6d1968   edx: 00000000
> Aug  6 08:15:03 server kernel: esi: 00000001   edi: 00000000   ebp:
> 000000d2   esp: d8b83cc8
> Aug  6 08:15:03 server kernel: ds: 0018   es: 0018   ss: 0018
> Aug  6 08:15:03 server kernel: Process xinetd (pid: 28761,
> stackpage=d8b83000)
> Aug  6 08:15:03 server kernel: Stack: 00000001 00000000 00000a30 c1c85470
> 00000a30 000000d2 c0158405 00000002
> Aug  6 08:15:04 server kernel:        c013605b 00000006 000000d2 c1c85470
> 000000d2 c1c8537c 000000d2 000000d2
> Aug  6 08:15:04 server kernel:        00000000 d8b82000 00000001 c01361c8
> 000000d2 00000001 d8b82000 c0136eb1
> Aug  6 08:15:04 server kernel: Call Trace: [shrink_dqcache_memory+21/48]
> shrink_dqcache_memory [kernel] 0x15
> Aug  6 08:15:04 server kernel: Call Trace: [<c0158405>]
> shrink_dqcache_memory [kernel] 0x15
> Aug  6 08:15:04 server kernel: [do_try_to_free_pages+43/80]
> do_try_to_free_pages [kernel] 0x2b
> Aug  6 08:15:04 server kernel: [<c013605b>] do_try_to_free_pages [kernel]
> 0x2b
> Aug  6 08:15:04 server kernel: [try_to_free_pages+40/64] try_to_free_pages
> [kernel] 0x28
> Aug  6 08:15:04 server kernel: [<c01361c8>] try_to_free_pages [kernel] 0x28
> Aug  6 08:15:04 server kernel: [_wrapped_alloc_pages+449/624]
> _wrapped_alloc_pages [kernel] 0x1c1
> Aug  6 08:15:04 server kernel: [<c0136eb1>] _wrapped_alloc_pages [kernel]
> 0x1c1
> Aug  6 08:15:04 server kernel: [__alloc_pages+15/160] __alloc_pages
> [kernel] 0xf
> Aug  6 08:15:04 server kernel: [<c0136f6f>] __alloc_pages [kernel] 0xf
> Aug  6 08:15:04 server kernel: [do_anonymous_page+62/272] do_anonymous_page
> [kernel] 0x3e
> Aug  6 08:15:04 server kernel: [<c012b13e>] do_anonymous_page [kernel] 0x3e
> Aug  6 08:15:04 server kernel: [do_no_page+50/288] do_no_page [kernel] 0x32
> Aug  6 08:15:04 server kernel: [<c012b242>] do_no_page [kernel] 0x32
> Aug  6 08:15:04 server kernel: [handle_mm_fault+107/224] handle_mm_fault
> [kernel] 0x6b
> Aug  6 08:15:04 server kernel: [<c012b39b>] handle_mm_fault [kernel] 0x6b
> Aug  6 08:15:04 server kernel: [dput+28/400] dput [kernel] 0x1c
> Aug  6 08:15:04 server kernel: [<c015118c>] dput [kernel] 0x1c
> Aug  6 08:15:04 server kernel: [do_page_fault+0/1216] do_page_fault
> [kernel] 0x0
> Aug  6 08:15:04 server kernel: [<c01176e0>] do_page_fault [kernel] 0x0
> Aug  6 08:15:04 server kernel: [do_page_fault+422/1216] do_page_fault
> [kernel] 0x1a6
> Aug  6 08:15:04 server kernel: [<c0117886>] do_page_fault [kernel] 0x1a6
> Aug  6 08:15:04 server kernel: [filemap_nopage+186/1280] filemap_nopage
> [kernel] 0xba
> Aug  6 08:15:04 server kernel: [<c012f06a>] filemap_nopage [kernel] 0xba
> Aug  6 08:15:04 server kernel: [do_no_page+125/288] do_no_page [kernel]
> 0x7d
> Aug  6 08:15:04 server kernel: [<c012b28d>] do_no_page [kernel] 0x7d
> Aug  6 08:15:04 server kernel: [do_page_fault+0/1216] do_page_fault
> [kernel] 0x0
> Aug  6 08:15:04 server kernel: [<c01176e0>] do_page_fault [kernel] 0x0
> Aug  6 08:15:04 server kernel: [error_code+56/64] error_code [kernel] 0x38
> Aug  6 08:15:04 server kernel: [<c0107298>] error_code [kernel] 0x38
> Aug  6 08:15:05 server kernel: [ksoftirqd+232/272] ksoftirqd [kernel] 0xe8
> Aug  6 08:15:05 server kernel: [<c0120018>] ksoftirqd [kernel] 0xe8
> Aug  6 08:15:05 server kernel: [file_read_actor+128/256] file_read_actor
> [kernel] 0x80
> Aug  6 08:15:05 server kernel: [<c012ea60>] file_read_actor [kernel] 0x80
> Aug  6 08:15:05 server kernel: [do_generic_file_read+643/1504]
> do_generic_file_read [kernel] 0x283
> Aug  6 08:15:05 server kernel: [<c012e683>] do_generic_file_read [kernel]
> 0x283
> Aug  6 08:15:05 server kernel: [generic_file_read+100/128]
> generic_file_read [kernel] 0x64
> Aug  6 08:15:05 server kernel: [<c012eb44>] generic_file_read [kernel] 0x64
> Aug  6 08:15:05 server kernel: [file_read_actor+0/256] file_read_actor
> [kernel] 0x0
> Aug  6 08:15:05 server kernel: [<c012e9e0>] file_read_actor [kernel] 0x0
> Aug  6 08:15:05 server kernel: [sys_read+150/288] sys_read [kernel] 0x96
> Aug  6 08:15:05 server kernel: [<c013dc66>] sys_read [kernel] 0x96
> Aug  6 08:15:05 server kernel: [system_call+51/56] system_call [kernel]
> 0x33
> Aug  6 08:15:05 server kernel: [<c010719b>] system_call [kernel] 0x33
> Aug  6 08:15:05 server kernel:
> Aug  6 08:15:05 server kernel:
> Aug  6 08:15:05 server kernel: Code: 89 50 04 89 02 c7 41 04 00 00 00 00 c7
> 43 08 00 00 00 00 8b
> Aug  6 08:15:07 server dhcpd: DHCPREQUEST for 10.151.6.123 from
> 00:80:ad:71:d8:ff (LIBRARYOFFICE) via eth1
> Aug  6 08:15:07 server dhcpd: DHCPACK on 10.151.6.123 to 00:80:ad:71:d8:ff
> (LIBRARYOFFICE) via eth1
> 
> *** logging stops here. Server dies shortly after ***
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
