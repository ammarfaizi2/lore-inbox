Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264869AbUDWQuS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264869AbUDWQuS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 12:50:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264874AbUDWQuS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 12:50:18 -0400
Received: from p213.54.103.128.tisdip.tiscali.de ([213.54.103.128]:33666 "EHLO
	stralsunder-10.homelinux.org") by vger.kernel.org with ESMTP
	id S264869AbUDWQtv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 12:49:51 -0400
Date: Fri, 23 Apr 2004 18:52:02 +0200
From: Andreas Schmidt <andy@space.wh1.tu-dresden.de>
To: linux-kernel@vger.kernel.org
Subject: kernel BUG at buffer.c
Message-ID: <20040423165202.GG24975@rocket>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	Format=Flowed	DelSp=Yes
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 2.0.17
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

lately, I've repeatedly found kernel-bug warnings in my logs. The  
context varies, but time and again the message "kernel BUG at buffer. 
c:575!" pops up.
The box that happens on is running Debian (Woody) with kernel 2.4.25.  
It has an K7TA266 Mainboard, AMD 700MHz processor, 512MB RAM and 3 IDE- 
harddisks (Samsung SV1203N),

I suspect that the latest error was a result of over-burdening the poor  
computer: it was to compress a 25GB diskimage with bzip2 and had been  
running for about 12 hrs before segfaulting. Here the log:

Apr 22 22:41:45 stralsunder-10 kernel: kernel BUG at buffer.c:575!
Apr 22 22:41:45 stralsunder-10 kernel: invalid operand: 0000
Apr 22 22:41:45 stralsunder-10 kernel: CPU:    0
Apr 22 22:41:45 stralsunder-10 kernel: EIP:
0010:[__insert_into_lru_list+28/112]    Tainted: P
Apr 22 22:41:45 stralsunder-10 kernel: EFLAGS: 00010206
Apr 22 22:41:45 stralsunder-10 kernel: eax: 00000000   ebx: 00000002    
ecx: d2fa00c0   edx: c02ab754
Apr 22 22:41:45 stralsunder-10 kernel: esi: d2fa00c0   edi: d2fa00c0    
ebp: 00000001   esp: dc071ebc
Apr 22 22:41:45 stralsunder-10 kernel: ds: 0018   es: 0018   ss: 0018
Apr 22 22:41:45 stralsunder-10 kernel: Process bzip2 (pid: 2263,
stackpage=dc071000)
Apr 22 22:41:45 stralsunder-10 kernel: Stack: 00000002 c0135976  
d2fa00c000000002 d2fa00c0 00001000 c013598a d2fa00c0
Apr 22 22:41:45 stralsunder-10 kernel:        c0136383 d2fa00c0  
00001000 df029180 31dd3000 00000000 00001000 00000000
Apr 22 22:41:45 stralsunder-10 kernel:        c01369f4 df029180  
c134caa4 00000000 00001000 c134caa4 40015000 d3327000
Apr 22 22:41:45 stralsunder-10 kernel: Call Trace:    [__refile_buffer 
+86/96] [refile_buffer+10/16] [__block_commit_write+131/208]
[generic_commit_write+52/96] [do_generic_file_write+654/976]
Apr 22 22:41:45 stralsunder-10 kernel:   [generic_file_write+259/288]
[sys_write+150/240] [system_call+51/56]
Apr 22 22:41:45 stralsunder-10 kernel:
Apr 22 22:41:45 stralsunder-10 kernel: Code: 0f 0b 3f 02 65 4c 21 c0 83  
3a 00 75 05 89 0a 89 49 24 8b 02


In another case, the error occured more randomly. I was upping some  
files per ftp when, once again, a bug occured at buffer.c; however,  
there also seems to have been something wrong with the ext3-journal, as  
can be seen in this entry:

Apr 20 06:22:59 stralsunder-10 kernel: kernel BUG at buffer.c:575!
Apr 20 06:22:59 stralsunder-10 kernel: invalid operand: 0000
Apr 20 06:22:59 stralsunder-10 kernel: CPU:    0
Apr 20 06:22:59 stralsunder-10 kernel: EIP:
0010:[__insert_into_lru_list+28/112]    Tainted: P
Apr 20 06:22:59 stralsunder-10 kernel: EFLAGS: 00010206
Apr 20 06:22:59 stralsunder-10 kernel: eax: 00000000   ebx: 00000002    
ecx: d06140c0   edx: c02ab754
Apr 20 06:22:59 stralsunder-10 kernel: esi: d06140c0   edi: d06140c0    
ebp: 00000001   esp: d227be6c
Apr 20 06:22:59 stralsunder-10 kernel: ds: 0018   es: 0018   ss: 0018
Apr 20 06:22:59 stralsunder-10 kernel: Process proftpd (pid: 32653,
stackpage=d227b000)
Apr 20 06:22:59 stralsunder-10 kernel: Stack: 00000002 c0135976  
d06140c0 00000002 d06140c0 00001000 c013598a d06140c0
Apr 20 06:22:59 stralsunder-10 kernel:        c0136383 d06140c0  
00000220 c2bb3500 0792f220 00000000 00001000 00000000
Apr 20 06:22:59 stralsunder-10 kernel:        c01369f4 c2bb3500  
c1425168 00000000 00000220 c1425168 080abb24 c2bb3500
Apr 20 06:22:59 stralsunder-10 kernel: Call Trace:    [__refile_buffer 
+86/96] [refile_buffer+10/16] [__block_commit_write+131/208]
[generic_commit_write+52/96] [ext3_commit_write+305/448]
Apr 20 06:22:59 stralsunder-10 kernel:   [do_generic_file_write 
+654/976] [generic_file_write+259/288] [ext3_file_write+35/192]  
[sys_write+150/240] [system_call+51/56]
Apr 20 06:22:59 stralsunder-10 kernel:
Apr 20 06:22:59 stralsunder-10 kernel: Code: 0f 0b 3f 02 65 4c 21 c0 83  
3a 00 75 05 89 0a 89 49 24 8b 02
Apr 20 06:22:59 stralsunder-10 kernel:  <0>Assertion failure in  
journal_start() at transaction.c:251: "handle->h_transaction->t_journal  
== journal"
Apr 20 06:22:59 stralsunder-10 kernel: kernel BUG at transaction.c:251!
Apr 20 06:22:59 stralsunder-10 kernel: invalid operand: 0000
Apr 20 06:22:59 stralsunder-10 kernel: CPU:    0
Apr 20 06:22:59 stralsunder-10 kernel: EIP:    0010:[journal_start 
+74/192] Tainted: P
Apr 20 06:22:59 stralsunder-10 kernel: EFLAGS: 00010286
Apr 20 06:22:59 stralsunder-10 kernel: eax: 0000006c   ebx: d09e7440    
ecx: df886000   edx: 00000001
Apr 20 06:22:59 stralsunder-10 kernel: esi: dfe4a600   edi: d227a000    
ebp: 00000040   esp: d227bc10
Apr 20 06:22:59 stralsunder-10 kernel: ds: 0018   es: 0018   ss: 0018
Apr 20 06:22:59 stralsunder-10 kernel: Process proftpd (pid: 32653,
stackpage=d227b000)
Apr 20 06:22:59 stralsunder-10 kernel: Stack: c021a740 c021a96c  
c021a720 000000fb c021a940 d09e7440 c1590400 c5ec1700
Apr 20 06:22:59 stralsunder-10 kernel:        c015e958 dfe4a600  
00000002 c5ec1700 c1590400 00000001 c014635e c5ec1700
Apr 20 06:22:59 stralsunder-10 kernel:        c5ec1700 c5ec176c  
dded1140 c0128c83 c5ec1700 00000001 c5ec1700 c5ec176c
Apr 20 06:22:59 stralsunder-10 kernel: Call Trace:    [ext3_dirty_inode
+88/256] [__mark_inode_dirty+46/144] [do_generic_file_write+211/976]
[check_free_space+290/320] [generic_file_write+259/288]
Apr 20 06:22:59 stralsunder-10 kernel:   [ext3_file_write+35/192]
[do_acct_process+571/592] [acct_process+25/39] [do_exit+105/592]
[do_invalid_op+0/160] [die+86/96]
Apr 20 06:22:59 stralsunder-10 kernel:   [do_invalid_op+140/160]
[__insert_into_lru_list+28/112] [ext3_get_block_handle+426/640]
[ext3_get_block_handle+242/640] [error_code+52/60]  
[__insert_into_lru_list+28/112]
Apr 20 06:22:59 stralsunder-10 kernel:   [__refile_buffer+86/96]
[refile_buffer+10/16] [__block_commit_write+131/208]
[generic_commit_write+52/96] [ext3_commit_write+305/448]
[do_generic_file_write+654/976]
Apr 20 06:22:59 stralsunder-10 kernel:   [generic_file_write+259/288]
[ext3_file_write+35/192] [sys_write+150/240] [system_call+51/56]
Apr 20 06:22:59 stralsunder-10 kernel:
Apr 20 06:22:59 stralsunder-10 kernel: Code: 0f 0b fb 00 20 a7 21 c0 83  
c4 14 ff 43 08 89 d8 eb 59 8d 74

I was planning on upgrading the kernel to 2.4.26 anyway; would that be  
sufficient to resolve these issues, or is there something completely  
different wrong?

Best regards

Andreas


PS: Please CC me as I'm not on this list.
