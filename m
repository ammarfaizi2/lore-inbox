Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262750AbUCPKgA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 05:36:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262756AbUCPKgA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 05:36:00 -0500
Received: from anor.ics.muni.cz ([147.251.4.35]:15338 "EHLO anor.ics.muni.cz")
	by vger.kernel.org with ESMTP id S262750AbUCPKfK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 05:35:10 -0500
Date: Tue, 16 Mar 2004 11:35:08 +0100
From: Jan Kasprzak <kas@informatics.muni.cz>
To: linux-kernel@vger.kernel.org
Subject: XFS oops on 2.4.25
Message-ID: <20040316103508.GC18684@fi.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2i
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hello,

	I have got the following Oops on my XFS fileserver. The system crashed,
but the Oops itself is not critical, because the system had probably drive
cabling errors (there were error messages from the RAID controller before
the Oops). I am reporting this just to note there may be unhandled error
recovery paths in XFS code.

Unable to handle kernel NULL pointer dereference at virtual address 00000004
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c01ea814>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010286
eax: 00000000   ebx: eb0c7264   ecx: 00000000   edx: ffffffff
esi: f7bb4818   edi: da8542f0   ebp: eb0c7264   esp: f7ecbe48
ds: 0018   es: 0018   ss: 0018
Process xfslogd/0 (pid: 9, stackpage=f7ecb000)
Stack: 00000000 00000000 0000231a 0000028f 00000001 da8542f0 f7bb4818 f7bb4800
       c01ea577 f7bb4818 da8542f0 d54781fa 00000000 0000231a 0000028f 0000231a
       0000028f da8542f0 d6644628 c01ea188 f7bb4800 da8542f0 0000231a 0000028f
Call Trace:    [<c01ea577>] [<c01ea188>] [<c01e9f86>] [<c01dc5c8>] [<c01dc6db>]
  [<c01dafed>] [<c0115771>] [<c020138e>] [<c011e6cf>] [<c02023cc>] [<c0105000>]
  [<c020244f>] [<c010586b>] [<c0202420>]
Code: 89 78 04 83 c4 14 5b 5e 5f c3 89 3e 89 7e 04 89 37 89 77 04
 
 
>>EIP; c01ea814 <xfs_ail_insert+64/80>   <=====
 
Trace; c01ea577 <xfs_trans_update_ail+67/e0>
Trace; c01ea188 <xfs_trans_chunk_committed+128/170>
Trace; c01e9f86 <xfs_trans_committed+56/130>
Trace; c01dc5c8 <xlog_state_do_callback+1a8/260>
Trace; c01dc6db <xlog_state_done_syncing+5b/70>
Trace; c01dafed <xlog_iodone+4d/e0>
Trace; c0115771 <schedule+2a1/4a0>
Trace; c020138e <pagebuf_iodone_sched+4e/50>
Trace; c011e6cf <__run_task_queue+5f/70>
Trace; c02023cc <pagebuf_iodone_daemon+17c/180>
Trace; c0105000 <_stext+0/0>
Trace; c020244f <pagebuf_logiodone_daemon+2f/40>
Trace; c010586b <arch_kernel_thread+2b/40>
Trace; c0202420 <pagebuf_logiodone_daemon+0/40>
 
Code;  c01ea814 <xfs_ail_insert+64/80>
00000000 <_EIP>:
Code;  c01ea814 <xfs_ail_insert+64/80>   <=====
   0:   89 78 04                  mov    %edi,0x4(%eax)   <=====
Code;  c01ea817 <xfs_ail_insert+67/80>
   3:   83 c4 14                  add    $0x14,%esp
Code;  c01ea81a <xfs_ail_insert+6a/80>
   6:   5b                        pop    %ebx
Code;  c01ea81b <xfs_ail_insert+6b/80>
   7:   5e                        pop    %esi
Code;  c01ea81c <xfs_ail_insert+6c/80>
   8:   5f                        pop    %edi
Code;  c01ea81d <xfs_ail_insert+6d/80>
   9:   c3                        ret
Code;  c01ea81e <xfs_ail_insert+6e/80>
   a:   89 3e                     mov    %edi,(%esi)
Code;  c01ea820 <xfs_ail_insert+70/80>
   c:   89 7e 04                  mov    %edi,0x4(%esi)
Code;  c01ea823 <xfs_ail_insert+73/80>
   f:   89 37                     mov    %esi,(%edi)
Code;  c01ea825 <xfs_ail_insert+75/80>
  11:   89 77 04                  mov    %esi,0x4(%edi)

More info available on request.

-Yenya

-- 
| Jan "Yenya" Kasprzak  <kas at {fi.muni.cz - work | yenya.net - private}> |
| GPG: ID 1024/D3498839      Fingerprint 0D99A7FB206605D7 8B35FCDE05B18A5E |
| http://www.fi.muni.cz/~kas/   Czech Linux Homepage: http://www.linux.cz/ |
 Any compiler or language that likes to hide things like memory allocations
 behind your back just isn't a good choice for a kernel.   --Linus Torvalds
