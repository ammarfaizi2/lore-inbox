Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265636AbTGIDWJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 23:22:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265638AbTGIDWJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 23:22:09 -0400
Received: from smtp.easystreet.com ([206.26.36.40]:4744 "EHLO
	easystreet01.easystreet.com") by vger.kernel.org with ESMTP
	id S265636AbTGIDWD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 23:22:03 -0400
From: John Kim <jak@easystreet.com>
To: linux-kernel@vger.kernel.org
Subject: Oops error on scp
Date: Tue, 8 Jul 2003 20:36:34 -0700
User-Agent: KMail/1.5.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307082036.34476.jak@easystreet.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get this oops kernel error when I try to scp a _large_ directory to another 
box, over my internal network.

By large, the total amount of memory I am trying to move probably comes close 
to 30GB.  It is a very reliable error, and happens everytime I try it.  The 
output from the kernel log is:
------------------------
Unable to handle kernel NULL pointer dereference at virtual address 00000200
 printing eip:
c01dead7
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c01dead7>]    Not tainted
EFLAGS: 00010206
eax: cf197e40   ebx: 00000200   ecx: 00000000   edx: 00000200
esi: cee745c0   edi: cee7461c   ebp: 00000000   esp: ce559e74
ds: 0018   es: 0018   ss: 0018
Process ssh (pid: 207, stackpage=ce559000)
Stack: cee745c0 c01deb7b cee745c0 cee745c0 000005a8 c01deb9b cee745c0 cee745c0
       c01decc7 cee745c0 cee745c0 00000000 c01f5e3d cee745c0 c02a51a0 00002000
       ce559f80 00002000 cef00550 cef00538 cef00534 00000000 ce558242 ce558000
Call Trace:    [<c01deb7b>] [<c01deb9b>] [<c01decc7>] [<c01f5e3d>] 
[<c020e23d>]
  [<c01dbcad>] [<c01dbdbe>] [<c0131ed6>] [<c0106d03>]

Code: 8b 1b 8b 42 70 83 f8 01 74 0a ff 4a 70 0f 94 c0 84 c0 74 09
--------------------------

The output from ksymoops is:
-----------------------------
ksymoops 2.4.5 on i686 2.4.20.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.20/ (default)
     -m /boot/System.map-2.4.20 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

No modules in ksyms, skipping objects
Warning (read_lsmod): no symbols in lsmod, is /proc/modules a valid lsmod 
file?
Error (regular_file): read_system_map stat /boot/System.map-2.4.20 failed
ksymoops: No such file or directory
Unable to handle kernel NULL pointer dereference at virtual address 00000200
c01dead7
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c01dead7>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010206
eax: cf197e40   ebx: 00000200   ecx: 00000000   edx: 00000200
esi: cee745c0   edi: cee7461c   ebp: 00000000   esp: ce559e74
ds: 0018   es: 0018   ss: 0018
Process ssh (pid: 207, stackpage=ce559000)
Stack: cee745c0 c01deb7b cee745c0 cee745c0 000005a8 c01deb9b cee745c0 cee745c0
       c01decc7 cee745c0 cee745c0 00000000 c01f5e3d cee745c0 c02a51a0 00002000
       ce559f80 00002000 cef00550 cef00538 cef00534 00000000 ce558242 ce558000
Call Trace:    [<c01deb7b>] [<c01deb9b>] [<c01decc7>] [<c01f5e3d>] 
[<c020e23d>]
  [<c01dbcad>] [<c01dbdbe>] [<c0131ed6>] [<c0106d03>]
Code: 8b 1b 8b 42 70 83 f8 01 74 0a ff 4a 70 0f 94 c0 84 c0 74 09


>>EIP; c01dead7 <alloc_skb+1a7/2c0>   <=====

>>eax; cf197e40 <END_OF_CODE+eea5668/????>
>>esi; cee745c0 <END_OF_CODE+eb81de8/????>
>>edi; cee7461c <END_OF_CODE+eb81e44/????>
>>esp; ce559e74 <END_OF_CODE+e26769c/????>

Trace; c01deb7b <alloc_skb+24b/2c0>
Trace; c01deb9b <alloc_skb+26b/2c0>
Trace; c01decc7 <__kfree_skb+d7/e0>
Trace; c01f5e3d <tcp_recvmsg+66d/900>
Trace; c020e23d <inet_recvmsg+3d/60>
Trace; c01dbcad <sock_recvmsg+3d/660>
Trace; c01dbdbe <sock_recvmsg+14e/660>
Trace; c0131ed6 <default_llseek+2c6/a60>
Trace; c0106d03 <__up_wakeup+1073/1440>

Code;  c01dead7 <alloc_skb+1a7/2c0>
00000000 <_EIP>:
Code;  c01dead7 <alloc_skb+1a7/2c0>   <=====
   0:   8b 1b                     mov    (%ebx),%ebx   <=====
Code;  c01dead9 <alloc_skb+1a9/2c0>
   2:   8b 42 70                  mov    0x70(%edx),%eax
Code;  c01deadc <alloc_skb+1ac/2c0>
   5:   83 f8 01                  cmp    $0x1,%eax
Code;  c01deadf <alloc_skb+1af/2c0>
   8:   74 0a                     je     14 <_EIP+0x14> c01deaeb 
<alloc_skb+1bb/2c0>
Code;  c01deae1 <alloc_skb+1b1/2c0>
   a:   ff 4a 70                  decl   0x70(%edx)
Code;  c01deae4 <alloc_skb+1b4/2c0>
   d:   0f 94 c0                  sete   %al
Code;  c01deae7 <alloc_skb+1b7/2c0>
  10:   84 c0                     test   %al,%al
Code;  c01deae9 <alloc_skb+1b9/2c0>
  12:   74 09                     je     1d <_EIP+0x1d> c01deaf4 
<alloc_skb+1c4/2c0>


2 warnings and 1 error issued.  Results may not be reliable.
------------------------------------------------

Every time I have recreated the error, the mesg:
"Unable to handle kernel NULL pointer dereference at virtual address 00000200"
has appeared (the only variance being that the virtual address changes from 
00000200 to 00000202 when I tried to scp over a different dir).  The oops 
error comes out when I have scp'ied maybe about 3 or 4 GBs, but this is not 
always the case.  I have tried changing filesystems (Reiserfs, ext2, ext3) to 
no avail, and I have run diags on my hard drive.  I am starting to question 
if there is a hardware failure in the RAM??
I don't know--I've never seen/dealt with an oops error before. 

Please advise!

Thanks,
johnny

