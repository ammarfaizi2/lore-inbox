Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270822AbRHNUdd>; Tue, 14 Aug 2001 16:33:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270817AbRHNUdZ>; Tue, 14 Aug 2001 16:33:25 -0400
Received: from albatross.mail.pas.earthlink.net ([207.217.120.120]:40950 "EHLO
	albatross.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S270822AbRHNUdG>; Tue, 14 Aug 2001 16:33:06 -0400
Date: Tue, 14 Aug 2001 15:32:55 -0500
From: J Troy Piper <jtp@dok.org>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@zip.com.au>,
        ext3-users@redhat.com
Subject: [BUG] linux-2.4.7-ac7 Assertion failure in journal_revoke() at revoke.c:307
Message-ID: <20010814153255.A1377@dok.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="BOKacYhQ+x31HxR3"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Greetings all,

I have hit a kernel BUG in revoke.c in kernel 2.4.7-ac7 twice today while 
attempting to perform the same operation (patching stock 2.4.8 kernel src  
with "patch -p1 <  patch-2.4.8-ac4").  Syslog entries follow.  Please 
email me if you want/need my kernel config or any other information.

Thanks,
jtp


--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename=BUG

Aug 14 15:11:42 paranoia kernel: Assertion failure in journal_revoke() at revoke.c:307: "!(__builtin_constant_p(BH_Revoked) ? constant_test_bit((BH_Revoked),(&bh->b_state)) : variable_test_bit((BH_Revoked),(&bh->b_state)))"
Aug 14 15:11:42 paranoia kernel: kernel BUG at revoke.c:307!
Aug 14 15:11:42 paranoia kernel: invalid operand: 0000
Aug 14 15:11:42 paranoia kernel: CPU:    0
Aug 14 15:11:42 paranoia kernel: EIP:    0010:[journal_revoke+220/384]
Aug 14 15:11:42 paranoia kernel: EIP:    0010:[<c015ebac>]
Aug 14 15:11:42 paranoia kernel: EFLAGS: 00010286
Aug 14 15:11:42 paranoia kernel: eax: 0000001c   ebx: c0b5ddc4   ecx: c02e685c   edx: 00001fd9
Aug 14 15:11:42 paranoia kernel: esi: c35ea000   edi: c0b5ddc4   ebp: 0000000a   esp: c3d53ccc
Aug 14 15:11:42 paranoia kernel: ds: 0018   es: 0018   ss: 0018
Aug 14 15:11:42 paranoia kernel: Process patch (pid: 2270, stackpage=c3d53000)
Aug 14 15:11:42 paranoia kernel: Stack: c028f702 00000133 0000120b c18c8da4 00000000 c2f6a21c c0152b1e c2f6a21c 
Aug 14 15:11:42 paranoia kernel:        0000120b c0b5ddc4 c3a80ca4 c2c950a4 00000003 00001000 0000120b c18c8eec 
Aug 14 15:11:42 paranoia kernel:        c2f6a21c c18c8da4 c01545e2 c2f6a21c 00000000 c18c8da4 c0b5ddc4 0000120b 
Aug 14 15:11:42 paranoia kernel: Call Trace: [ext3_forget+190/288] [ext3_clear_blocks+146/192] [ext3_free_data+179/224] [ext3_truncate+308/960] [truncate_list_pages+441/464] 
Aug 14 15:11:42 paranoia kernel: Call Trace: [<c0152b1e>] [<c01545e2>] [<c01546c3>] [<c0154994>] [<c01206c9>] 
Aug 14 15:11:42 paranoia kernel:    [vmtruncate+361/384] [inode_setattr+38/224] [ext3_setattr+151/176] [notify_change+94/288] [do_truncate+107/160] [lookup_hash+66/144] 
Aug 14 15:11:42 paranoia kernel:    [<c011e8d9>] [<c0142a86>] [<c01553f7>] [<c0142bfe>] [<c012ca3b>] [<c01392e2>] 
Aug 14 15:11:42 paranoia kernel:    [open_namei+1095/1456] [kmem_cache_free+544/720] [filp_open+52/96] [sys_open+54/176] [system_call+51/64] 
Aug 14 15:11:42 paranoia kernel:    [<c0139937>] [<c01263b0>] [<c012d944>] [<c012dc46>] [<c0106ce3>] 
Aug 14 15:11:42 paranoia kernel: 
Aug 14 15:11:42 paranoia kernel: Code: 0f 0b 58 5a 0f ab 6b 18 b8 0b 00 00 00 0f ab 43 18 85 ff 74 
Aug 14 15:11:42 paranoia kernel:  <0>Assertion failure in journal_start() at transaction.c:217: "handle->h_transaction->t_journal == journal"
Aug 14 15:11:42 paranoia kernel: kernel BUG at transaction.c:217!
Aug 14 15:11:42 paranoia kernel: invalid operand: 0000
Aug 14 15:11:42 paranoia kernel: CPU:    0
Aug 14 15:11:42 paranoia kernel: EIP:    0010:[journal_start+97/224]
Aug 14 15:11:42 paranoia kernel: EIP:    0010:[<c0159ee1>]
Aug 14 15:11:42 paranoia kernel: EFLAGS: 00010286
Aug 14 15:11:42 paranoia kernel: eax: 00000021   ebx: c2f6a21c   ecx: c02e685c   edx: 000023ca
Aug 14 15:11:42 paranoia kernel: esi: c3d52000   edi: c35ffda4   ebp: c35ea200   esp: c3d53a5c
Aug 14 15:11:42 paranoia kernel: ds: 0018   es: 0018   ss: 0018
Aug 14 15:11:42 paranoia kernel: Process patch (pid: 2270, stackpage=c3d53000)
Aug 14 15:11:42 paranoia kernel: Stack: c028d760 000000d9 c2f6a21c c2f6a21c ffffffe2 c35ffda4 c3d53b30 c01555c6 
Aug 14 15:11:42 paranoia kernel:        c35ea200 00000001 4a494847 4e4d4c4b 5251504f 56555453 c35ffda4 c35f4800 
Aug 14 15:11:42 paranoia kernel:        00000001 c01412ca c35ffda4 c3d52000 04043000 00000000 c0123437 c35ffda4 
Aug 14 15:11:42 paranoia kernel: Call Trace: [ext3_dirty_inode+54/192] [__mark_inode_dirty+42/112] [generic_file_write+631/1568] [vgacon_cursor+401/416] [do_acct_process+521/544] 
Aug 14 15:11:42 paranoia kernel: Call Trace: [<c01555c6>] [<c01412ca>] [<c0123437>] [<c02279c1>] [<c01176e9>] 
Aug 14 15:11:43 paranoia kernel:    [vt_console_print+764/784] [acct_process+31/48] [do_exit+108/496] [bust_spinlocks+62/80] [die+70/96] [do_invalid_op+0/208] 
Aug 14 15:11:43 paranoia kernel:    [<c01b073c>] [<c011771f>] [<c0113f9c>] [<c010e29e>] [<c01072b6>] [<c0107600>] 
Aug 14 15:11:43 paranoia kernel:    [do_invalid_op+191/208] [journal_revoke+220/384] [set_cursor+105/128] [vt_console_print+748/784] [__call_console_drivers+57/80] [call_console_drivers+234/240] 
Aug 14 15:11:43 paranoia kernel:    [<c01076bf>] [<c015ebac>] [<c01acff9>] [<c01b072c>] [<c01115a9>] [<c011171a>] 
Aug 14 15:11:43 paranoia kernel:    [error_code+56/64] [journal_revoke+220/384] [ext3_forget+190/288] [ext3_clear_blocks+146/192] [ext3_free_data+179/224] [ext3_truncate+308/960] 
Aug 14 15:11:43 paranoia kernel:    [<c0106e08>] [<c015ebac>] [<c0152b1e>] [<c01545e2>] [<c01546c3>] [<c0154994>] 
Aug 14 15:11:43 paranoia kernel:    [truncate_list_pages+441/464] [vmtruncate+361/384] [inode_setattr+38/224] [ext3_setattr+151/176] [notify_change+94/288] [do_truncate+107/160] 
Aug 14 15:11:43 paranoia kernel:    [<c01206c9>] [<c011e8d9>] [<c0142a86>] [<c01553f7>] [<c0142bfe>] [<c012ca3b>] 
Aug 14 15:11:43 paranoia kernel:    [lookup_hash+66/144] [open_namei+1095/1456] [kmem_cache_free+544/720] [filp_open+52/96] [sys_open+54/176] [system_call+51/64] 
Aug 14 15:11:43 paranoia kernel:    [<c01392e2>] [<c0139937>] [<c01263b0>] [<c012d944>] [<c012dc46>] [<c0106ce3>] 
Aug 14 15:11:43 paranoia kernel: 
Aug 14 15:11:43 paranoia kernel: Code: 0f 0b 5e 5f 8b 4b 08 89 d8 41 89 4b 08 eb 66 6a 70 6a 10 68 

--BOKacYhQ+x31HxR3--
