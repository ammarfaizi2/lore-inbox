Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261829AbTJAAvY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 20:51:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261835AbTJAAvY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 20:51:24 -0400
Received: from rekin6.o2.pl ([212.126.20.11]:63384 "EHLO rekin.go2.pl")
	by vger.kernel.org with ESMTP id S261829AbTJAAvW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 20:51:22 -0400
From: kernel@o2.pl
To: linux-kernel@vger.kernel.org
Subject: =?iso-8859-2?Q?2.4.23-pre5=20oops,=202.4.21=20works=20fine?=
Date: Wed, 1 Oct 2003 02:51:20 +0100
Content-Type: text/plain; charset="iso-8859-2";
Content-Transfer-Encoding: 8bit
X-Mailer: first3.pl WebMailv4.01. Usluga Poczty Elektronicznej dla o2.pl
X-Originator: 217.97.85.66
Message-Id: <20031001005120.61197D0B03@rekin.go2.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oops happens in init scripts just after the eth devices init and befor atm init, which fails. Thought it might be the ATM init problem while not module that showed up in 2.4.22 but now I see some e1000 mesg in the trace.

I hope someone will be able to find the bug here.
Well, here it goes:

SMP, e1000s, atm, monolithic kernel 2.4.23-pre5

ksymoops 2.4.4 on i686 2.4.21.  Options used
     -v vmlinux (specified)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.21/ (default)
     -m System.map (specified)

Error (regular_file): read_ksyms stat /proc/ksyms failed
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Oct  1 01:45:01 prowler kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000010
Oct  1 01:45:01 prowler kernel: c0239ce3
Oct  1 01:45:01 prowler kernel: *pde = 00000000
Oct  1 01:45:01 prowler kernel: Oops: 0002
Oct  1 01:45:01 prowler kernel: CPU:    0
Oct  1 01:45:01 prowler kernel: EIP:    0010:[<c0239ce3>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Oct  1 01:45:01 prowler kernel: EFLAGS: 00010246
Oct  1 01:45:01 prowler kernel: eax: 00000000   ebx: f76ff600   ecx: c0283764   edx: 00000000
Oct  1 01:45:01 prowler kernel: esi: f6ac2db4   edi: 00000000   ebp: f76ff600   esp: f6f31ef8
Oct  1 01:45:01 prowler kernel: ds: 0018   es: 0018   ss: 0018
Oct  1 01:45:01 prowler kernel: Process atmarpd (pid: 694, stackpage=f6f31000)
Oct  1 01:45:01 prowler kernel: Stack: c19bf268 000001f0 090ce0c4 ffffffff f6f31f28 c023ec84 c19b8280 f73ded00
Oct  1 01:45:01 prowler kernel:        f7163f80 f7163f80 c01c756f 00000003 f73ded00 f76ff6b0 000001f0 f6ac2db4
Oct  1 01:45:01 prowler kernel:        00000000 3130315b c0005d32 f6ac2db4 00000000 00000014 f6ac2db4 c01c8093
Oct  1 01:45:01 prowler kernel: Call Trace:    [<c023ec84>] [<c01c756f>] [<c01c8093>] [<c02384b5>] [<c01c7b99>]
Oct  1 01:45:01 prowler kernel:   [<c0143987>] [<c01070c3>]
Oct  1 01:45:01 prowler kernel: Code: f0 ff 48 10 a1 4c 4d 34 c0 8b 40 18 83 48 14 08 85 d2 75 06

>>EIP; c0239ce3 <prio2band+103/2a0>   <=====
Trace; c023ec84 <large_digits.1+48c4/23f20>
Trace; c01c756f <__lock_sock+3f/f0>
Trace; c01c8093 <alloc_skb+153/1c0>
Trace; c02384b5 <e1000_igp_cable_length_table+375/fa0>
Trace; c01c7b99 <sock_def_readable+29/70>
Trace; c0143987 <vfs_rename_dir+7/4c0>
Trace; c01070c3 <system_call+33/38>
Code;  c0239ce3 <prio2band+103/2a0>
00000000 <_EIP>:
Code;  c0239ce3 <prio2band+103/2a0>   <=====
   0:   f0 ff 48 10               lock decl 0x10(%eax)   <=====
Code;  c0239ce7 <prio2band+107/2a0>
   4:   a1 4c 4d 34 c0            mov    0xc0344d4c,%eax
Code;  c0239cec <prio2band+10c/2a0>
   9:   8b 40 18                  mov    0x18(%eax),%eax
Code;  c0239cef <prio2band+10f/2a0>
   c:   83 48 14 08               orl    $0x8,0x14(%eax)
Code;  c0239cf3 <prio2band+113/2a0>
  10:   85 d2                     test   %edx,%edx
Code;  c0239cf5 <prio2band+115/2a0>
  12:   75 06                     jne    1a <_EIP+0x1a> c0239cfd <prio2band+11d/2a0>


1 error issued.  Results may not be reliable.


Krzysztof
