Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289953AbSAPOoh>; Wed, 16 Jan 2002 09:44:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289954AbSAPOo2>; Wed, 16 Jan 2002 09:44:28 -0500
Received: from alcove.wittsend.com ([130.205.0.10]:22443 "EHLO
	alcove.wittsend.com") by vger.kernel.org with ESMTP
	id <S289953AbSAPOoQ>; Wed, 16 Jan 2002 09:44:16 -0500
Date: Wed, 16 Jan 2002 09:44:14 -0500
From: "Michael H. Warfield" <mhw@wittsend.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: mhw@wittsend.com
Subject: Oops on 2.4.17 and up...  Address: 5a5a5a5a
Message-ID: <20020116094414.A27571@alcove.wittsend.com>
Mail-Followup-To: lkml <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,

	I had been running my gateway on 2.4.16 for quite a while and
then upgraded it to 2.4.17 and started gettin an Oops about once a day.
Problem also tested and exists on 2.4.18pre2 and 2.4.18pre3.  Ends up
with "Unable to handle kernel paging request at virtual address 5a5a5a5a"
and the EIP ends up 0010:5a5a5a5a.  Hmmm...  That's ascii ZZZZ.

	A ksymoops is attached below...

	System is IDE based and has Magic SysRq enabled.

	A SysRq sync seems to work but an unmount gives me another
oops with scheduling in interrupt handler:

] SysRq : Emergency Sync
] Syncing device 03:01 ... OK
] Syncing device 03:06 ... OK
] Syncing device 03:05 ... OK
] Syncing device 03:07 ... OK
] Done.
] SysRq : Emergency Sync
] Syncing device 03:01 ... OK
] Syncing device 03:06 ... OK
] Syncing device 03:05 ... OK
] Syncing device 03:07 ... OK
] Done.
] SysRq : Emergency Sync
] Syncing device 03:01 ... OK
] Syncing device 03:06 ... OK
] Syncing device 03:05 ... OK
] Syncing device 03:07 ... OK
] Done.
] SysRq : Emergency Remount R/O
] Remounting device 03:01 ... Scheduling in interrupt
] invalid operand: 0000
] CPU:    0
] EIP:    0010:[<c01111bb>]    Not tainted
] EFLAGS: 00010286
] eax: 00000018   ebx: ffffffff   ecx: c344c000   edx: 00000001
] esi: c02ee000   edi: c02efda4   ebp: c02efd8c   esp: c02efd44
] ds: 0018   es: 0018   ss: 0018

	(I can generate a ksymoops for the emergency remount, if anyone
thinks it matters.)

	Fsck after reboot is often pretty dirty and half the time
has an unexpected inconsistency requiring manual fsck.

	Notes:  System is running latest FreeSWAN IPSec snapshot
and has multiple PPP links running over a Computone Multiport
Serial board along with 5 ethernet interfaces and a PPP link running
over an stunnel process.  It's a busy box...  :-/

	There are no unusual messages in /var/log/messages prior to
the failure (I have some diagnostic code in the Computone driver
watching for unusual conditions in the driver, I haven't even been
getting board timeouts).

	Any ideas what may be causing this or what I can do to isolate
the proble further?

	Mike
-- 
 Michael H. Warfield    |  (770) 985-6132   |  mhw@WittsEnd.com
  /\/\|=mhw=|\/\/       |  (678) 463-0932   |  http://www.wittsend.com/mhw/
  NIC whois:  MHW9      |  An optimist believes we live in the best of all
 PGP Key: 0xDF1DD471    |  possible worlds.  A pessimist is sure of it!

ksymoops 2.4.3 on i586 2.4.18-pre3.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.18-pre3/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

banshee.wittsend.com login: Unable to handle kernel paging request at virtual address 5a5a5a5a
5a5a5a5a
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<5a5a5a5a>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010282
eax: c032f44c   ebx: 5a5a5a5a   ecx: c2556a20   edx: c3ed2770
esi: c032e3e0   edi: 00000000   ebp: 5a5a5a5a   esp: c02eff34
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=c02ef000)
Stack: c011a7e4 5a5a5a5a 00000000 c032e3e0 00000000 c032e680 c010abdb c02effa8 
       c02d44e4 c011781e c0117760 00000000 c032e680 00000001 fffffffe c011757d 
       c032e680 00000000 00000000 c02d44e4 c02effa0 00000046 c0107ff4 c01051a0 
Call Trace: [<c011a7e4>] [<c010abdb>] [<c011781e>] [<c0117760>] [<c011757d>] 
   [<c0107ff4>] [<c01051a0>] [<c0109da8>] [<c01051a0>] [<c01051c3>] [<c010521a>] 
   [<c0105000>] [<c0105027>] 
Code:  Bad EIP value.

>>EIP; 5a5a5a5a Before first symbol   <=====
Trace; c011a7e4 <timer_bh+244/288>
Trace; c010abda <timer_interrupt+76/124>
Trace; c011781e <bh_action+1a/44>
Trace; c0117760 <tasklet_hi_action+44/64>
Trace; c011757c <do_softirq+5c/ac>
Trace; c0107ff4 <do_IRQ+98/a8>
Trace; c01051a0 <default_idle+0/28>
Trace; c0109da8 <call_do_IRQ+6/e>
Trace; c01051a0 <default_idle+0/28>
Trace; c01051c2 <default_idle+22/28>
Trace; c010521a <cpu_idle+32/48>
Trace; c0105000 <_stext+0/0>
Trace; c0105026 <rest_init+26/28>

 <0>Kernel panic: Aiee, killing interrupt handler!

1 warning issued.  Results may not be reliable.
