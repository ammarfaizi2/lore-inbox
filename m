Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272563AbTHEIAq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 04:00:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272567AbTHEIAp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 04:00:45 -0400
Received: from mail3.ithnet.com ([217.64.64.7]:20459 "HELO
	heather-ng.ithnet.com") by vger.kernel.org with SMTP
	id S272563AbTHEIAn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 04:00:43 -0400
X-Sender-Authentification: SMTPafterPOP by <info@euro-tv.de> from 217.64.64.14
Date: Tue, 5 Aug 2003 10:00:40 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, green@namesys.com
Subject: decoded problem in 2.4.22-pre10
Message-Id: <20030805100040.079b1b24.skraw@ithnet.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

the testbox crashed again this night, unfortunately I made a mistake yesterday
and started vmware once. Although only the usual modules were loaded at crash
time and not the application, the kernel was tainted of course.
Nevertheless I present the data:

Everthing started with this it seems:

journal-2332: Trying to log block 4316, which is a log block
 (device sd(8,17))

Then:


ksymoops 2.4.8 on i686 2.4.22-pre10.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.22-pre10/ (default)
     -m /boot/System.map-2.4.22-pre10 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

kernel BUG at prints.c:341!
invalid operand: 0000
CPU:    1
EIP:    0010:[<c018bca5>]    Tainted: PF
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010286
eax: 00000053   ebx: f7117000   ecx: f59ae000   edx: f5f2ff7c
esi: f6e63740   edi: f8acc310   ebp: f8ac727c   esp: f59afd28
ds: 0018   es: 0018   ss: 0018
Process nfsd (pid: 1726, stackpage=f59af000)
Stack: c02b48dc c037dba0 c037c720 f7117000 c019d12c f7117000 c02bbdc0 000010dc
       00000006 f7117000 00000001 f8aa63e4 00000004 00000002 00000000 00000001
       00000002 3f2f143f f598e000 f2aebb60 f2aeb560 f2abf000 f2ac4000 f8acc310
Call Trace:    [<c019d12c>] [<c019bafc>] [<c019c3b2>] [<c014519f>] [<c019c47f>]
  [<c0183eff>] [<f8c84fc8>] [<f8c854f4>] [<c028e61f>] [<f8c814fe>] [<f8c91c60>]
  [<f8c80699>] [<f8c65938>] [<f8c91c60>] [<f8c91a28>] [<f8c91a58>] [<f8c80411>]
  [<f8c91a20>] [<c010592e>] [<f8c80210>]
Code: 0f 0b 55 01 ef 48 2b c0 85 db b8 f8 48 2b c0 74 0c 0f b7 43


>>EIP; c018bca5 <reiserfs_panic+45/80>   <=====

>>ebx; f7117000 <_end+36d6bde0/3852ee40>
>>ecx; f59ae000 <_end+35602de0/3852ee40>
>>edx; f5f2ff7c <_end+35b84d5c/3852ee40>
>>esi; f6e63740 <_end+36ab8520/3852ee40>
>>edi; f8acc310 <[3w-xxxx]tw_device_extension_list+1e9050/271da0>
>>ebp; f8ac727c <[3w-xxxx]tw_device_extension_list+1e3fbc/271da0>
>>esp; f59afd28 <_end+35604b08/3852ee40>

Trace; c019d12c <do_journal_end+bac/bb0>
Trace; c019bafc <journal_end_sync+3c/a0>
Trace; c019c3b2 <__commit_trans_index+72/a0>
Trace; c014519f <fsync_buffers_list+18f/1b0>
Trace; c019c47f <reiserfs_commit_for_inode+3f/80>
Trace; c0183eff <reiserfs_sync_file+6f/d0>
Trace; f8c84fc8 <[lockd]nlmclt_decode_testres+28/160>
Trace; f8c854f4 <[lockd]nlm_procname+4/20>
Trace; c028e61f <inet_sendmsg+3f/50>
Trace; f8c814fe <[lockd]nlmsvc_notify_blocked+4e/f0>
Trace; f8c91c60 <[nfsd]nfsd_access+a0/100>
Trace; f8c80699 <[lockd]lockd_up+49/140>
Trace; f8c65938 <[vmnet]__constant_c_and_count_memset+4a/75>
Trace; f8c91c60 <[nfsd]nfsd_access+a0/100>
Trace; f8c91a28 <[nfsd]nfsd_setattr+3f8/590>
Trace; f8c91a58 <[nfsd]nfsd_setattr+428/590>
Trace; f8c80411 <[lockd]lockd+e1/320>
Trace; f8c91a20 <[nfsd]nfsd_setattr+3f0/590>
Trace; c010592e <arch_kernel_thread+2e/40>
Trace; f8c80210 <[lockd]__constant_c_and_count_memset+50/c9>

Code;  c018bca5 <reiserfs_panic+45/80>
00000000 <_EIP>:
Code;  c018bca5 <reiserfs_panic+45/80>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c018bca7 <reiserfs_panic+47/80>
   2:   55                        push   %ebp
Code;  c018bca8 <reiserfs_panic+48/80>
   3:   01 ef                     add    %ebp,%edi
Code;  c018bcaa <reiserfs_panic+4a/80>
   5:   48                        dec    %eax
Code;  c018bcab <reiserfs_panic+4b/80>
   6:   2b c0                     sub    %eax,%eax
Code;  c018bcad <reiserfs_panic+4d/80>
   8:   85 db                     test   %ebx,%ebx
Code;  c018bcaf <reiserfs_panic+4f/80>
   a:   b8 f8 48 2b c0            mov    $0xc02b48f8,%eax
Code;  c018bcb4 <reiserfs_panic+54/80>
   f:   74 0c                     je     1d <_EIP+0x1d>
Code;  c018bcb6 <reiserfs_panic+56/80>
  11:   0f b7 43 00               movzwl 0x0(%ebx),%eax


1 warning issued.  Results may not be reliable.

Regards,
Stephan
