Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264898AbUFLShu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264898AbUFLShu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jun 2004 14:37:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264903AbUFLShu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jun 2004 14:37:50 -0400
Received: from p213.54.72.94.tisdip.tiscali.de ([213.54.72.94]:40576 "EHLO
	stralsunder-10.homelinux.org") by vger.kernel.org with ESMTP
	id S264898AbUFLShp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jun 2004 14:37:45 -0400
Date: Sat, 12 Jun 2004 20:37:42 +0200
From: Andreas Schmidt <andy@space.wh1.tu-dresden.de>
To: linux-kernel@vger.kernel.org
Subject: Frequent system freezes after kernel bug
Message-ID: <20040612183742.GE1733@rocket>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	Format=Flowed	DelSp=Yes
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 2.0.17
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

in the last few days I have experienced frequent system freezes  
apparently related to kernel bugs on one box here. Unfortunately,  
that's just the same system serving as router and local fileserver for  
me and my roommates, so it is quite disturbing to have to reboot it up  
to three times a day.

This box runs under Debian stable; I noticed these particular bugs  
starting with kernel 2.4.24. Yesterday, I updated from 2.4.25 to  
2.4.26, but today it died again twice.

The first log entry looked unfamiliar to me:
> kernel: Unable to handle kernel paging request at virtual address  
> 35fb6a3f
> kernel:  printing eip:
> kernel: c014782c
> kernel: Oops: 0000
> kernel: CPU:    0
> kernel: EIP:    0010:[iput+44/592]    Tainted: P
> kernel: EFLAGS: 00010202
> kernel: eax: 00000000   ebx: 00000000   ecx: ddd20050   edx: ddd20050
> kernel: esi: ddd20040   edi: 35fb6a1f   ebp: 00001f0f   esp: c1599f20
> kernel: ds: 0018   es: 0018   ss: 0018
> kernel: Process kswapd (pid: 4, stackpage=c1599000)
> kernel: Stack: c3756c58 c3756c40 ddd20040 c0145406 ddd20040 00000000  
> c144e040 00000006
> kernel:        ffffffff c014570b 00002744 c012cdfa 00000006 000001d0  
> 0000001f 000001d0
> kernel:        c024a49c c024a49c c1598000 00003401 000001d0 c024a49c  
> c012d06f c1599fa8
> kernel: Call Trace:    [prune_dcache+214/336] [shrink_dcache_memory 
> +27/64] [shrink_cache+650/880] [shrink_caches+47/64]  
> [try_to_free_pages_zone+96/240]
> kernel:   [kswapd_balance_pgdat+74/160] [kswapd_balance+22/48]  
> [kswapd+157/192] [arch_kernel_thread+40/64]
> kernel:
> kernel: Code: 8b 5f 20 85 db 74 0d 8b 43 18 85 c0 74 06 56 ff d0 83  
> c4 04


Entires like this one have popped up frequently before, however:
> kernel: kernel BUG at buffer.c:575!
> kernel: invalid operand: 0000
> kernel: CPU:    0
> kernel: EIP:   0010:[__insert_into_lru_list+28/112]    Tainted: P
> kernel: EFLAGS: 00010206
> kernel: eax: 00000000   ebx: 00000002   ecx: d06e40c0   edx: c02ad6cc
> kernel: esi: d06e40c0   edi: d06e40c0   ebp: 00000001   esp: cc3b7e6c
> kernel: ds: 0018   es: 0018   ss: 0018
> kernel: Process proftpd (pid: 3311, stackpage=cc3b7000)
> kernel: Stack: 00000002 c0135a36 d06e40c0 00000002 d06e40c0 00001000  
> c0135a4a d06e40c0
> kernel:        c0136443 d06e40c0 00000006 dabae5c0 10aad006 00000000  
> 00001000 00000000
> kernel:        c0136ab4 dabae5c0 c12c5a00 00000000 00000006 c12c5a00  
> 0811346a dabae5c0
> kernel: Call Trace:    [__refile_buffer+86/96] [refile_buffer+10/16]  
> [__block_commit_write+131/208] [generic_commit_write+52/96]  
> [ext3_commit_write+305/448]
> kernel:   [do_generic_file_write+654/976] [generic_file_write 
> +259/288] [ext3_file_write+35/192] [sys_write+150/240] [system_call 
> +51/56]
> kernel:
> kernel: Code: 0f 0b 3f 02 e5 57 21 c0 83 3a 00 75 05 89 0a 89 49 24  
> 8b 02
> kernel:  <0>Assertion failure in journal_start() at transaction. 
> c:251: "handle->h_transaction->t_journal == journal"
> kernel: kernel BUG at transaction.c:251!
> kernel: invalid operand: 0000
> kernel: CPU:    0
> kernel: EIP:    0010:[journal_start+74/192]    Tainted: P
> kernel: EFLAGS: 00010282
> kernel: eax: 0000006c   ebx: d55f9580   ecx: dfc72000   edx: 00000001
> kernel: esi: dfe49800   edi: cc3b6000   ebp: 00000040   esp: cc3b7c10
> kernel: ds: 0018   es: 0018   ss: 0018
> kernel: Process proftpd (pid: 3311, stackpage=cc3b7000)
> kernel: Stack: c021b240 c021b46c c021b220 000000fb c021b440 d55f9580  
> dfae8c00 deddb740
> kernel:        c015ea38 dfe49800 00000002 deddb740 dfae8c00 00000001  
> c014642e deddb740
> kernel:        deddb740 deddb7ac dd377ac0 c0128c93 deddb740 00000001  
> deddb740 deddb7ac
> kernel: Call Trace:    [ext3_dirty_inode+88/256] [__mark_inode_dirty 
> +46/144] [do_generic_file_write+211/976] [check_free_space+290/320]  
> [generic_file_write+259/288]
> kernel:   [ext3_file_write+35/192] [do_acct_process+571/592]  
> [acct_process+25/39] [do_exit+105/592] [do_invalid_op+0/160] [die 
> +86/96]
> kernel:   [do_invalid_op+140/160] [__insert_into_lru_list+28/112]  
> [ext3_get_block_handle+426/640] [ext3_get_block_handle+242/640]  
> [error_code+52/60] [__insert_into_lru_list+28/112]
> kernel:   [__refile_buffer+86/96] [refile_buffer+10/16]  
> [__block_commit_write+131/208] [generic_commit_write+52/96]  
> [ext3_commit_write+305/448] [do_generic_file_write+654/976]
> kernel:   [generic_file_write+259/288] [ext3_file_write+35/192]  
> [sys_write+150/240] [system_call+51/56]
> kernel:
> kernel: Code: 0f 0b fb 00 20 b2 21 c0 83 c4 14 ff 43 08 89 d8 eb 59  
> 8d 74


When these bugs occur, the computer doesn't die right away. One can  
still issue commands, or login. It's just that after any such action  
one never gets to see the prompt again. Issuing "init 6" right from the  
console usually starts ok, then stops with a couple of hanging PIDs  
reported (I really don't know what those processes are; they might well  
be the terminals.) Nothing but a hard reset works then...

So, does anybody know what that is all about and what I could do so  
these freezes don't happen again?

Thanks a lot and best regards,

Andreas (quite desperate by now)

