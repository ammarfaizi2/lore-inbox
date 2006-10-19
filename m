Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946126AbWJSPuZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946126AbWJSPuZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 11:50:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946136AbWJSPuZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 11:50:25 -0400
Received: from host106-7.junet.se ([193.11.106.7]:12469 "EHLO smtp.azoff.se")
	by vger.kernel.org with ESMTP id S1946135AbWJSPuY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 11:50:24 -0400
Message-ID: <45379EBE.4050906@azoff.se>
Date: Thu, 19 Oct 2006 17:50:22 +0200
From: =?UTF-8?B?VG9yYmrDtnJuIFN2ZW5zc29u?= <lkml@azoff.se>
User-Agent: Thunderbird 1.5.0.5 (X11/20060920)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: grsecurity@grsecurity.net
Subject: ext3 oops with 2.4.33.3-grsec
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello!

I do not know if this is related to my random reboots of the server with
a 2.4.33.3-grsec kernel, but two days ago I got this oops recorded[0] in
/var/log/kern.log. At the time of the oops, nothing special was running
and this time, the server did _not_ reboot. Last time the server did
reboot I got another oops[1], but that time, I didn't have
CONFIG_FRAME_POINTER set. As I have little experience in kernel hacking,
I do not know if these two are completely different bugs or of one is a
result of the ofter, This older bug is around a week old.
When I am testing with 2.4.33-grsec with the same(?) grsec-patch
(version 2.1.9), I do not get any random reboots _or_ oops.

The server is running a Debian Sarge system.

The related kernel config is also attached.

These references are also attached below.
[0] http://www.azoff.se/error/debian/oops/oops_decoded_061017
[1] http://www.azoff.se/error/debian/oops/oops_decoded_061011
[2] http://www.azoff.se/error/debian/oops/config-2.4.33.3-grsec


- --
Torbjörn Svensson <lkml (at) azoff (dot) se>
Please CC me as I am not subscribed to the list!





[0] ---------------------------
ksymoops 2.4.9 on i686 2.4.33.3-grsec.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.33.3-grsec/ (default)
     -m /boot/System.map-2.4.33.3-grsec_2006-09-27 (specified)

Error (regular_file): read_ksyms stat /proc/ksyms failed
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
kernel BUG at transaction.c:251!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c01bad1e>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010282
eax: 0000006c   ebx: f73045c4   ecx: f7304000   edx: f732df08
esi: f7304000   edi: f7aa9cc0   ebp: f7305e68   esp: f7305e48
ds: 0018   es: 0018   ss: 0018
Process apcupsd (pid: 12746, stackpage=f7305000)
Stack: c03d1160 c03ccd96 c03cd345 000000fb c03d3160 f73045c4 f77ac7c0
f77ac7c0
       f7305e88 c01b5351 f7aa9cc0 00000002 00000000 00000001 f77ac7c0
f75d9800
       f7305ea0 c019b5c1 f77ac7c0 00000000 00000000 f77ac7c0 f7305efc
c0179961
Call Trace:    [<c01b5351>] [<c019b5c1>] [<c0179961>] [<c01967e9>]
[<c017a019>]
  [<c01b03c5>] [<c018688e>] [<c01573d3>]
Code: 0f 0b ea 45 d3 3c c0 fb 00 ff 43 08 89 d8 8b 5d f4 8b 75 f8


>>EIP; c01bad1e <ext3_clear_journal_err+ae/c0>   <=====

Trace; c01b5351 <ext3_do_update_inode+1c1/410>
Trace; c019b5c1 <__mark_inode_dirty+51/a0>
Trace; c0179961 <do_odirect_fallback+21/80>
Trace; c01967e9 <do_select+f9/200>
Trace; c017a019 <__mprotect_fixup+99/430>
Trace; c01b03c5 <ext3_group_sparse+45/60>
Trace; c018688e <do_readv_writev+20e/230>
Trace; c01573d3 <mem_parity_error+23/40>

Code;  c01bad1e <ext3_clear_journal_err+ae/c0>
00000000 <_EIP>:
Code;  c01bad1e <ext3_clear_journal_err+ae/c0>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c01bad20 <ext3_clear_journal_err+b0/c0>
   2:   ea 45 d3 3c c0 fb 00      ljmp   $0xfb,$0xc03cd345
Code;  c01bad27 <ext3_clear_journal_err+b7/c0>
   9:   ff 43 08                  incl   0x8(%ebx)
Code;  c01bad2a <ext3_clear_journal_err+ba/c0>
   c:   89 d8                     mov    %ebx,%eax
Code;  c01bad2c <ext3_clear_journal_err+bc/c0>
   e:   8b 5d f4                  mov    0xfffffff4(%ebp),%ebx
Code;  c01bad2f <ext3_clear_journal_err+bf/c0>
  11:   8b 75 f8                  mov    0xfffffff8(%ebp),%esi

CPU:    0
EIP:    0010:[<c016d64c>]    Not tainted
EFLAGS: 00010006
eax: c22172dc   ebx: f7304000   ecx: ffffffff   edx: 00000082
esi: c2214180   edi: f7304000   ebp: f7305d20   esp: f7305d14
ds: 0018   es: 0018   ss: 0018
Process apcupsd (pid: 12746, stackpage=f7305000)
Stack: 00000000 c0157d70 f7304000 f7305d34 c016d6cf f7304568 00000000
f7ade280
       f7305d50 c016800a f7304000 0000000b f7305e14 00000000 c0157d70
f7305d68
       c0157aa2 0000000b c03c660e 00000000 f7305e14 f7305e04 c0157e26
c03c660e
Call Trace:    [<c0157d70>] [<c016d6cf>] [<c016800a>] [<c0157d70>]
[<c0157aa2>]
  [<c0157e26>] [<c01bad1e>] [<c0166b2a>] [<c0166bfd>] [<c01574f4>]
[<c01bad1e>]
  [<c01b5351>] [<c019b5c1>] [<c0179961>] [<c01967e9>] [<c017a019>]
[<c01b03c5>]
  [<c018688e>] [<c01573d3>]
Code: 8b 1a 89 54 24 04 89 04 24 e8 76 ff 00 00 ff 0d 80 34 44 c0


>>EIP; c016d64c <force_sig_info+1c/a0>   <=====

Trace; c0157d70 <enable_irq+60/90>
Trace; c016d6cf <force_sig_info+9f/a0>
Trace; c016800a <sys_sysinfo+8a/140>
Trace; c0157d70 <enable_irq+60/90>
Trace; c0157aa2 <startup_none+2/10>
Trace; c0157e26 <do_IRQ+86/a0>
Trace; c01bad1e <ext3_clear_journal_err+ae/c0>
Trace; c0166b2a <inter_module_put+5a/80>
Trace; c0166bfd <release_task+3d/160>
Trace; c01574f4 <do_nmi+74/80>
Trace; c01bad1e <ext3_clear_journal_err+ae/c0>
Trace; c01b5351 <ext3_do_update_inode+1c1/410>
Trace; c019b5c1 <__mark_inode_dirty+51/a0>
Trace; c0179961 <do_odirect_fallback+21/80>
Trace; c01967e9 <do_select+f9/200>
Trace; c017a019 <__mprotect_fixup+99/430>
Trace; c01b03c5 <ext3_group_sparse+45/60>
Trace; c018688e <do_readv_writev+20e/230>
Trace; c01573d3 <mem_parity_error+23/40>

Code;  c016d64c <force_sig_info+1c/a0>
00000000 <_EIP>:
Code;  c016d64c <force_sig_info+1c/a0>   <=====
   0:   8b 1a                     mov    (%edx),%ebx   <=====
Code;  c016d64e <force_sig_info+1e/a0>
   2:   89 54 24 04               mov    %edx,0x4(%esp)
Code;  c016d652 <force_sig_info+22/a0>
   6:   89 04 24                  mov    %eax,(%esp)
Code;  c016d655 <force_sig_info+25/a0>
   9:   e8 76 ff 00 00            call   ff84 <_EIP+0xff84>
Code;  c016d65a <force_sig_info+2a/a0>
   e:   ff 0d 80 34 44 c0         decl   0xc0443480


1 error issued.  Results may not be reliable.




[1] ----------------------------------------------
ksymoops 2.4.9 on i686 2.4.33.3-grsec.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.33.3-grsec/ (default)
     -m /boot/System.map-2.4.33.3-grsec_2006-09-27 (specified)

Error (regular_file): read_ksyms stat /proc/ksyms failed
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Unable to handle kernel NULL pointer dereference at virtual address 00000010
c0187269
*pgd = 0000000000000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0187269>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010203
eax: 00000000   ebx: 00000004   ecx: 00000004   edx: 00000000
esi: 400c4807   edi: fffffff7   ebp: bffff0d8   esp: f5121f50
ds: 0018   es: 0018   ss: 0018
Process apcupsd (pid: 15156, stackpage=f5121000)
Stack: c0195847 c01680db f5121f5c 452caa21 0006e132 f5120000 452ca9e5
f5120000
       0808b930 08084e60 bffff0d8 c01563d3 00000004 400c4807 bfffefa0
0808b930
       08084e60 bffff0d8 00000036 0000002b 0000002b 00000036 402ac614
00000023
Call Trace:    [<c0195847>] [<c01680db>] [<c01563d3>]
Code: 8b 14 88 85 d2 74 03 ff 42 14 89 d0 c3 8d 76 00 8d bc 27 00


>>EIP; c0187269 <fget+19/30>   <=====

Trace; c0195847 <sys_ioctl+27/260>
Trace; c01680db <sys_time+1b/60>
Trace; c01563d3 <system_call+33/50>

Code;  c0187269 <fget+19/30>
00000000 <_EIP>:
Code;  c0187269 <fget+19/30>   <=====
   0:   8b 14 88                  mov    (%eax,%ecx,4),%edx   <=====
Code;  c018726c <fget+1c/30>
   3:   85 d2                     test   %edx,%edx
Code;  c018726e <fget+1e/30>
   5:   74 03                     je     a <_EIP+0xa>
Code;  c0187270 <fget+20/30>
   7:   ff 42 14                  incl   0x14(%edx)
Code;  c0187273 <fget+23/30>
   a:   89 d0                     mov    %edx,%eax
Code;  c0187275 <fget+25/30>
   c:   c3                        ret
Code;  c0187276 <fget+26/30>
   d:   8d 76 00                  lea    0x0(%esi),%esi
Code;  c0187279 <fget+29/30>
  10:   8d bc 27 00 00 00 00      lea    0x0(%edi),%edi

 <1>Unable to handle kernel paging request at virtual address 1ff5ac65
c018714b
*pgd = 0000000000000000
Oops: 0000
CPU:    0
EIP:    0010:[<c018714b>]    Not tainted
EFLAGS: 00010282
eax: ced85094   ebx: ced85094   ecx: f51200e0   edx: ced85094
esi: b9170a63   edi: f5120000   ebp: 1ff5ac5d   esp: f5121df4
ds: 0018   es: 0018   ss: 0018
Process apcupsd (pid: 15156, stackpage=f5121000)
Stack: 00000400 c03ca58e f5121f1c f6829cc0 f5120000 0000000b c01674f1
f5120000
       0000000b f5121f1c f6829cc0 00000010 f687969c c0156ab3 0000000b
c03ce4f0
       00000000 350cf000 c0162210 c03ce4f0 f5121f1c 00000000 f5120000
f5121e84
Call Trace:    [<c01674f1>] [<c0156ab3>] [<c0162210>] [<c0163354>]
[<c01630f2>]
  [<c0163040>] [<c01967ff>] [<c01967ff>] [<c0161f80>] [<c01564f4>]
[<c0187269>]
  [<c0195847>] [<c01680db>] [<c01563d3>]
Code: 8b 7d 08 ff 48 14 0f 94 c0 84 c0 75 14 8b 5c 24 08 8b 74 24


>>EIP; c018714b <fput+1b/120>   <=====

Trace; c01674f1 <do_exit+61/280>
Trace; c0156ab3 <die+73/80>
Trace; c0162210 <do_page_fault+290/7e0>
Trace; c0163354 <schedule+204/330>
Trace; c01630f2 <schedule_timeout+62/b0>
Trace; c0163040 <process_timeout+0/50>
Trace; c01967ff <do_select+10f/200>
Trace; c01967ff <do_select+10f/200>
Trace; c0161f80 <do_page_fault+0/7e0>
Trace; c01564f4 <error_code+34/40>
Trace; c0187269 <fget+19/30>
Trace; c0195847 <sys_ioctl+27/260>
Trace; c01680db <sys_time+1b/60>
Trace; c01563d3 <system_call+33/50>

Code;  c018714b <fput+1b/120>
00000000 <_EIP>:
Code;  c018714b <fput+1b/120>   <=====
   0:   8b 7d 08                  mov    0x8(%ebp),%edi   <=====
Code;  c018714e <fput+1e/120>
   3:   ff 48 14                  decl   0x14(%eax)
Code;  c0187151 <fput+21/120>
   6:   0f 94 c0                  sete   %al
Code;  c0187154 <fput+24/120>
   9:   84 c0                     test   %al,%al
Code;  c0187156 <fput+26/120>
   b:   75 14                     jne    21 <_EIP+0x21>
Code;  c0187158 <fput+28/120>
   d:   8b 5c 24 08               mov    0x8(%esp),%ebx
Code;  c018715c <fput+2c/120>
  11:   8b 74 24 00               mov    0x0(%esp),%esi

 <1>Unable to handle kernel NULL pointer dereference at virtual address
00000004
c016755a
*pgd = 0000000000000000
Oops: 0002
CPU:    0
EIP:    0010:[<c016755a>]    Not tainted
EFLAGS: 00010202
eax: f1a53800   ebx: 00000004   ecx: ffffffff   edx: f5120000
esi: f5c1de40   edi: f5120000   ebp: 0000000b   esp: f5121cb4
ds: 0018   es: 0018   ss: 0018
Process apcupsd (pid: 15156, stackpage=f5121000)
Stack: f1a53840 0000000b f5121dc0 f5c1de40 1ff5ac65 f687969c c0156ab3
0000000b
       c03ce4f0 00000000 350cf1fc c0162210 c03ce4f0 f5121dc0 00000000
00000001
       c00bdd20 00000019 00000000 00000000 00000001 c023f66b c2211000
00000016
Call Trace:    [<c0156ab3>] [<c0162210>] [<c023f66b>] [<c02ad723>]
[<c0244473>]
  [<c024373d>] [<c0166111>] [<c0161f80>] [<c01564f4>] [<c018714b>]
[<c01674f1>]
  [<c0156ab3>] [<c0162210>] [<c0163354>] [<c01630f2>] [<c0163040>]
[<c01967ff>]
  [<c01967ff>] [<c0161f80>] [<c01564f4>] [<c0187269>] [<c0195847>]
[<c01680db>]
  [<c01563d3>]
Code: ff 0b 0f 94 c0 84 c0 0f 85 e4 00 00 00 8b b7 58 05 00 00 85


>>EIP; c016755a <do_exit+ca/280>   <=====

Trace; c0156ab3 <die+73/80>
Trace; c0162210 <do_page_fault+290/7e0>
Trace; c023f66b <scrup+13b/150>
Trace; c02ad723 <vgacon_cursor+d3/1a0>
Trace; c0244473 <poke_blanked_console+53/70>
Trace; c024373d <vt_console_print+21d/310>
Trace; c0166111 <__call_console_drivers+51/60>
Trace; c0161f80 <do_page_fault+0/7e0>
Trace; c01564f4 <error_code+34/40>
Trace; c018714b <fput+1b/120>
Trace; c01674f1 <do_exit+61/280>
Trace; c0156ab3 <die+73/80>
Trace; c0162210 <do_page_fault+290/7e0>
Trace; c0163354 <schedule+204/330>
Trace; c01630f2 <schedule_timeout+62/b0>
Trace; c0163040 <process_timeout+0/50>
Trace; c01967ff <do_select+10f/200>
Trace; c01967ff <do_select+10f/200>
Trace; c0161f80 <do_page_fault+0/7e0>
Trace; c01564f4 <error_code+34/40>
Trace; c0187269 <fget+19/30>
Trace; c0195847 <sys_ioctl+27/260>
Trace; c01680db <sys_time+1b/60>
Trace; c01563d3 <system_call+33/50>

Code;  c016755a <do_exit+ca/280>
00000000 <_EIP>:
Code;  c016755a <do_exit+ca/280>   <=====
   0:   ff 0b                     decl   (%ebx)   <=====
Code;  c016755c <do_exit+cc/280>
   2:   0f 94 c0                  sete   %al
Code;  c016755f <do_exit+cf/280>
   5:   84 c0                     test   %al,%al
Code;  c0167561 <do_exit+d1/280>
   7:   0f 85 e4 00 00 00         jne    f1 <_EIP+0xf1>
Code;  c0167567 <do_exit+d7/280>
   d:   8b b7 58 05 00 00         mov    0x558(%edi),%esi
Code;  c016756d <do_exit+dd/280>
  13:   85 00                     test   %eax,(%eax)

 <1>Unable to handle kernel NULL pointer dereference at virtual address
00000003
c016cd8a
*pgd = 0000000000000000
Oops: 0000
CPU:    0
EIP:    0010:[<c016cd8a>]    Not tainted
EFLAGS: 00010006
eax: c22172dc   ebx: f5120000   ecx: ffffffff   edx: 00000003
esi: 00000000   edi: f5120000   ebp: 0000000b   esp: f5121b54
ds: 0018   es: 0018   ss: 0018
Process apcupsd (pid: 15156, stackpage=f5121000)
Stack: 0000000b c015a2d8 f5120000 c016ce0e f5120568 00000000 00000000
c0167590
       f5120000 0000000b f5121c80 00000002 00000004 0000000b c0156ab3
0000000b
       c03ce4f0 00000002 350cf000 c0162210 c03ce4f0 f5121c80 00000002
00000000
Call Trace:    [<c015a2d8>] [<c016ce0e>] [<c0167590>] [<c0156ab3>]
[<c0162210>]
  [<c03469d0>] [<c0346801>] [<c03469d0>] [<c0267983>] [<c02fbc1e>]
[<c02fbd57>]
  [<c02fbe5a>] [<c0161f80>] [<c01564f4>] [<c016755a>] [<c0156ab3>]
[<c0162210>]
  [<c023f66b>] [<c02ad723>] [<c0244473>] [<c024373d>] [<c0166111>]
[<c0161f80>]
  [<c01564f4>] [<c018714b>] [<c01674f1>] [<c0156ab3>] [<c0162210>]
[<c0163354>]
  [<c01630f2>] [<c0163040>] [<c01967ff>] [<c01967ff>] [<c0161f80>]
[<c01564f4>]
  [<c0187269>] [<c0195847>] [<c01680db>] [<c01563d3>]
Code: 8b 1a 89 54 24 04 89 04 24 e8 98 03 01 00 ff 0d 80 74 44 c0


>>EIP; c016cd8a <flush_sigqueue+2a/50>   <=====

Trace; c015a2d8 <call_do_IRQ+5/d>
Trace; c016ce0e <exit_sighand+3e/60>
Trace; c0167590 <do_exit+100/280>
Trace; c0156ab3 <die+73/80>
Trace; c0162210 <do_page_fault+290/7e0>
Trace; c03469d0 <ip_rcv_finish+0/230>
Trace; c0346801 <ip_rcv+3a1/400>
Trace; c03469d0 <ip_rcv_finish+0/230>
Trace; c0267983 <via_rhine_rx+183/420>
Trace; c02fbc1e <netif_receive_skb+11e/1e0>
Trace; c02fbd57 <process_backlog+77/110>
Trace; c02fbe5a <net_rx_action+6a/100>
Trace; c0161f80 <do_page_fault+0/7e0>
Trace; c01564f4 <error_code+34/40>
Trace; c016755a <do_exit+ca/280>
Trace; c0156ab3 <die+73/80>
Trace; c0162210 <do_page_fault+290/7e0>
Trace; c023f66b <scrup+13b/150>
Trace; c02ad723 <vgacon_cursor+d3/1a0>
Trace; c0244473 <poke_blanked_console+53/70>
Trace; c024373d <vt_console_print+21d/310>
Trace; c0166111 <__call_console_drivers+51/60>
Trace; c0161f80 <do_page_fault+0/7e0>
Trace; c01564f4 <error_code+34/40>
Trace; c018714b <fput+1b/120>
Trace; c01674f1 <do_exit+61/280>
Trace; c0156ab3 <die+73/80>
Trace; c0162210 <do_page_fault+290/7e0>
Trace; c0163354 <schedule+204/330>
Trace; c01630f2 <schedule_timeout+62/b0>
Trace; c0163040 <process_timeout+0/50>
Trace; c01967ff <do_select+10f/200>
Trace; c01967ff <do_select+10f/200>
Trace; c0161f80 <do_page_fault+0/7e0>
Trace; c01564f4 <error_code+34/40>
Trace; c0187269 <fget+19/30>
Trace; c0195847 <sys_ioctl+27/260>
Trace; c01680db <sys_time+1b/60>
Trace; c01563d3 <system_call+33/50>

Code;  c016cd8a <flush_sigqueue+2a/50>
00000000 <_EIP>:
Code;  c016cd8a <flush_sigqueue+2a/50>   <=====
   0:   8b 1a                     mov    (%edx),%ebx   <=====
Code;  c016cd8c <flush_sigqueue+2c/50>
   2:   89 54 24 04               mov    %edx,0x4(%esp)
Code;  c016cd90 <flush_sigqueue+30/50>
   6:   89 04 24                  mov    %eax,(%esp)
Code;  c016cd93 <flush_sigqueue+33/50>
   9:   e8 98 03 01 00            call   103a6 <_EIP+0x103a6>
Code;  c016cd98 <flush_sigqueue+38/50>
   e:   ff 0d 80 74 44 c0         decl   0xc0447480


1 error issued.  Results may not be reliable.




[2] --------------------------------------------
CONFIG_X86=y
CONFIG_UID16=y
CONFIG_EXPERIMENTAL=y
CONFIG_MK7=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_ALIGNMENT_16=y
CONFIG_X86_HAS_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_USE_3DNOW=y
CONFIG_X86_PGE=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_F00F_WORKS_OK=y
CONFIG_X86_MCE=y
CONFIG_HIGHMEM4G=y
CONFIG_HIGHMEM=y
CONFIG_MTRR=y
CONFIG_X86_TSC=y
CONFIG_NET=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
CONFIG_SYSVIPC=y
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_ELF=y
CONFIG_ACPI=y
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_BUS=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_MMCONFIG=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_SYSTEM=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_THERMAL=y
CONFIG_PARPORT=y
CONFIG_PARPORT_PC=y
CONFIG_PARPORT_PC_CML1=y
CONFIG_PNP=y
CONFIG_BLK_DEV_FD=y
CONFIG_BLK_DEV_LOOP=y
CONFIG_BLK_STATS=y
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_RAID1=y
CONFIG_MD_MULTIPATH=y
CONFIG_PACKET=y
CONFIG_NETFILTER=y
CONFIG_FILTER=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_NET_IPIP=y
CONFIG_SYN_COOKIES=y
CONFIG_IP_NF_CONNTRACK=y
CONFIG_IP_NF_FTP=y
CONFIG_IP_NF_IRC=y
CONFIG_IP_NF_IPTABLES=y
CONFIG_IP_NF_MATCH_LIMIT=y
CONFIG_IP_NF_MATCH_MAC=y
CONFIG_IP_NF_MATCH_PKTTYPE=y
CONFIG_IP_NF_MATCH_MARK=y
CONFIG_IP_NF_MATCH_MULTIPORT=y
CONFIG_IP_NF_MATCH_TOS=y
CONFIG_IP_NF_MATCH_LENGTH=y
CONFIG_IP_NF_MATCH_TTL=y
CONFIG_IP_NF_MATCH_TCPMSS=y
CONFIG_IP_NF_MATCH_HELPER=y
CONFIG_IP_NF_MATCH_STATE=y
CONFIG_IP_NF_MATCH_CONNTRACK=y
CONFIG_IP_NF_FILTER=y
CONFIG_IP_NF_TARGET_REJECT=y
CONFIG_IP_NF_TARGET_MIRROR=y
CONFIG_IP_NF_NAT=y
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=y
CONFIG_IP_NF_TARGET_REDIRECT=y
CONFIG_IP_NF_NAT_IRC=y
CONFIG_IP_NF_NAT_FTP=y
CONFIG_IP_NF_MANGLE=y
CONFIG_IP_NF_TARGET_TOS=y
CONFIG_IP_NF_TARGET_MARK=y
CONFIG_IP_NF_TARGET_LOG=y
CONFIG_IPV6=y
CONFIG_IP6_NF_IPTABLES=y
CONFIG_IP6_NF_MATCH_LIMIT=y
CONFIG_IP6_NF_MATCH_MAC=y
CONFIG_IP6_NF_MATCH_RT=y
CONFIG_IP6_NF_MATCH_OPTS=y
CONFIG_IP6_NF_MATCH_FRAG=y
CONFIG_IP6_NF_MATCH_HL=y
CONFIG_IP6_NF_MATCH_MULTIPORT=y
CONFIG_IP6_NF_MATCH_MARK=y
CONFIG_IP6_NF_MATCH_IPV6HEADER=y
CONFIG_IP6_NF_MATCH_LENGTH=y
CONFIG_IP6_NF_FILTER=y
CONFIG_IP6_NF_TARGET_LOG=y
CONFIG_IP6_NF_MANGLE=y
CONFIG_IP6_NF_TARGET_MARK=y
CONFIG_BRIDGE=y
CONFIG_NET_SCHED=y
CONFIG_NET_SCH_CBQ=y
CONFIG_NET_SCH_HTB=y
CONFIG_NET_SCH_CSZ=y
CONFIG_NET_SCH_HFSC=y
CONFIG_NET_SCH_PRIO=y
CONFIG_NET_SCH_RED=y
CONFIG_NET_SCH_SFQ=y
CONFIG_NET_SCH_TEQL=y
CONFIG_NET_SCH_TBF=y
CONFIG_NET_SCH_GRED=y
CONFIG_NET_SCH_DSMARK=y
CONFIG_NET_SCH_INGRESS=y
CONFIG_NET_QOS=y
CONFIG_NET_ESTIMATOR=y
CONFIG_NET_CLS=y
CONFIG_NET_CLS_TCINDEX=y
CONFIG_NET_CLS_ROUTE4=y
CONFIG_NET_CLS_ROUTE=y
CONFIG_NET_CLS_FW=y
CONFIG_NET_CLS_U32=y
CONFIG_NET_CLS_RSVP=y
CONFIG_NET_CLS_RSVP6=y
CONFIG_NET_CLS_POLICE=y
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDECD=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_BLK_DEV_GENERIC=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_PDC202XX_OLD=y
CONFIG_BLK_DEV_PDC202XX_NEW=y
CONFIG_BLK_DEV_VIA82CXXX=y
CONFIG_IDEDMA_AUTO=y
CONFIG_BLK_DEV_PDC202XX=y
CONFIG_SCSI=y
CONFIG_BLK_DEV_SD=y
CONFIG_SD_EXTRA_DEVS=40
CONFIG_CHR_DEV_SG=y
CONFIG_SCSI_DEBUG_QUEUES=y
CONFIG_SCSI_MULTI_LUN=y
CONFIG_SCSI_CONSTANTS=y
CONFIG_NETDEVICES=y
CONFIG_TUN=y
CONFIG_NET_ETHERNET=y
CONFIG_NET_PCI=y
CONFIG_VIA_RHINE=y
CONFIG_E1000=y
CONFIG_PPP=y
CONFIG_PPP_MULTILINK=y
CONFIG_PPP_FILTER=y
CONFIG_PPP_ASYNC=y
CONFIG_PPP_SYNC_TTY=y
CONFIG_PPP_DEFLATE=y
CONFIG_PPP_BSDCOMP=y
CONFIG_PPPOE=y
CONFIG_NET_RADIO=y
CONFIG_NET_WIRELESS=y
CONFIG_INPUT=y
CONFIG_INPUT_KEYBDEV=y
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=y
CONFIG_SERIAL_CONSOLE=y
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_PRINTER=y
CONFIG_MOUSE=y
CONFIG_PSMOUSE=y
CONFIG_RTC=y
CONFIG_AGP=y
CONFIG_QUOTA=y
CONFIG_EXT3_FS=y
CONFIG_JBD=y
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_PROC_FS=y
CONFIG_DEVFS_FS=y
CONFIG_DEVFS_MOUNT=y
CONFIG_DEVPTS_FS=y
CONFIG_EXT2_FS=y
CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
CONFIG_NFS_DIRECTIO=y
CONFIG_NFSD=y
CONFIG_NFSD_V3=y
CONFIG_NFSD_TCP=y
CONFIG_SUNRPC=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_SMB_FS=y
CONFIG_SMB_NLS_DEFAULT=y
CONFIG_SMB_NLS_REMOTE="iso-8859-1"
CONFIG_SMB_UNIX=y
CONFIG_ZISOFS_FS=y
CONFIG_MSDOS_PARTITION=y
CONFIG_SMB_NLS=y
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_ISO8859_1=y
CONFIG_VGA_CONSOLE=y
CONFIG_VIDEO_SELECT=y
CONFIG_FB=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_FB_VESA=y
CONFIG_VIDEO_SELECT=y
CONFIG_FBCON_CFB8=y
CONFIG_FBCON_CFB16=y
CONFIG_FBCON_CFB24=y
CONFIG_FBCON_CFB32=y
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
CONFIG_USB=y
CONFIG_USB_DEVICEFS=y
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_UHCI_ALT=y
CONFIG_USB_OHCI=y
CONFIG_USB_STORAGE=y
CONFIG_USB_PRINTER=y
CONFIG_USB_HID=y
CONFIG_USB_HIDINPUT=y
CONFIG_USB_HIDDEV=y
CONFIG_DEBUG_KERNEL=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_FRAME_POINTER=y
CONFIG_LOG_BUF_SHIFT=0
CONFIG_CRYPTO=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_MD4=y
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_WP512=y
CONFIG_CRYPTO_DES=y
CONFIG_CRYPTO_BLOWFISH=y
CONFIG_CRYPTO_AES=y
CONFIG_CRYPTO_ARC4=y
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRC32=y
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_GRKERNSEC=y
CONFIG_CRYPTO=y
CONFIG_CRYPTO_SHA256=y
CONFIG_GRKERNSEC_CUSTOM=y
CONFIG_GRKERNSEC_PAX_PT_PAX_FLAGS=y
CONFIG_GRKERNSEC_PAX_NO_ACL_FLAGS=y
CONFIG_GRKERNSEC_PAX_NOEXEC=y
CONFIG_GRKERNSEC_PAX_SEGMEXEC=y
CONFIG_GRKERNSEC_PAX_MPROTECT=y
CONFIG_GRKERNSEC_PAX_ASLR=y
CONFIG_GRKERNSEC_PAX_RANDKSTACK=y
CONFIG_GRKERNSEC_PAX_RANDUSTACK=y
CONFIG_GRKERNSEC_PAX_RANDMMAP=y
CONFIG_GRKERNSEC_PAX_MEMORY_SANITIZE=y
CONFIG_GRKERNSEC_PAX_MEMORY_UDEREF=y
CONFIG_GRKERNSEC_KMEM=y
CONFIG_GRKERNSEC_IO=y
CONFIG_RTC=y
CONFIG_GRKERNSEC_PROC_MEMMAP=y
CONFIG_GRKERNSEC_BRUTE=y
CONFIG_GRKERNSEC_HIDESYM=y
CONFIG_GRKERNSEC_ACL_MAXTRIES=3
CONFIG_GRKERNSEC_ACL_TIMEOUT=30
CONFIG_GRKERNSEC_PROC=y
CONFIG_GRKERNSEC_PROC_USERGROUP=y
CONFIG_GRKERNSEC_PROC_GID=51
CONFIG_GRKERNSEC_PROC_ADD=y
CONFIG_GRKERNSEC_LINK=y
CONFIG_GRKERNSEC_FIFO=y
CONFIG_GRKERNSEC_CHROOT=y
CONFIG_GRKERNSEC_CHROOT_MOUNT=y
CONFIG_GRKERNSEC_CHROOT_DOUBLE=y
CONFIG_GRKERNSEC_CHROOT_PIVOT=y
CONFIG_GRKERNSEC_CHROOT_CHDIR=y
CONFIG_GRKERNSEC_CHROOT_CHMOD=y
CONFIG_GRKERNSEC_CHROOT_FCHDIR=y
CONFIG_GRKERNSEC_CHROOT_MKNOD=y
CONFIG_GRKERNSEC_CHROOT_SHMAT=y
CONFIG_GRKERNSEC_CHROOT_UNIX=y
CONFIG_GRKERNSEC_CHROOT_FINDTASK=y
CONFIG_GRKERNSEC_CHROOT_NICE=y
CONFIG_GRKERNSEC_CHROOT_SYSCTL=y
CONFIG_GRKERNSEC_CHROOT_CAPS=y
CONFIG_GRKERNSEC_AUDIT_GROUP=y
CONFIG_GRKERNSEC_AUDIT_GID=100
CONFIG_GRKERNSEC_AUDIT_MOUNT=y
CONFIG_GRKERNSEC_SIGNAL=y
CONFIG_GRKERNSEC_FORKFAIL=y
CONFIG_GRKERNSEC_TIME=y
CONFIG_GRKERNSEC_PROC_IPADDR=y
CONFIG_GRKERNSEC_EXECVE=y
CONFIG_GRKERNSEC_SHM=y
CONFIG_GRKERNSEC_DMESG=y
CONFIG_GRKERNSEC_RANDPID=y
CONFIG_GRKERNSEC_RANDNET=y
CONFIG_GRKERNSEC_RANDSRC=y
CONFIG_GRKERNSEC_FLOODTIME=10
CONFIG_GRKERNSEC_FLOODBURST=4
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFN569eY7jmtvbDP0RAgu9AJ9gG1vm2ThPQ4zUtLVkCfOu9yYfzQCeKxMZ
AyvtdSH0kb2pzVoiUvTIa+s=
=Pgwl
-----END PGP SIGNATURE-----
