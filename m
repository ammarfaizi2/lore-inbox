Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282062AbRLOJLk>; Sat, 15 Dec 2001 04:11:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282064AbRLOJLa>; Sat, 15 Dec 2001 04:11:30 -0500
Received: from smtp2.mail.idir.net ([209.242.64.158]:56338 "EHLO
	smtp2.idir.net") by vger.kernel.org with ESMTP id <S282062AbRLOJLT>;
	Sat, 15 Dec 2001 04:11:19 -0500
From: "Edward Killips" <ekillips@skyenet.net>
To: <linux-kernel@vger.kernel.org>
Subject: RE: Oops - 2.4.17rc1 (with iptables 2.4.6)
Date: Sat, 15 Dec 2001 04:02:50 -0500
Message-ID: <HDEPLLEDCLIFHEIOKJGFIEHJCNAA.ekillips@skyenet.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <20011215005641.A810@china.patternbook.com>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just upgraded to rc1 and get the following oops in with the netfilter
code.

ksymoops 2.4.3 on i586 2.4.17-rc1.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.17-rc1/ (default)
     -m /boot/System.map (specified)

c0216e84
*pde = 00000000
Oops:  0000
CPU: 0
EIP: 0010:[c0216e84>] Not tainted
EFLAGS: 00010202
eax: 00000000 ebx: 5a5a5a5a ecx: 00000000 eds: 00000010
esi: 00000010 edi: d43de084 ebp: 00000000 esp: c02bfe58
ds: 0018 es: 0018 ss: 0018
Stack: 00000000 00000000 d43de084 00000000 d6968814 d43de084 00000000
c02193ca
       d43de084 5a5a5a5a 5a5a5a5a 00000050 00000000 00000000 c02193a0
c020f696
       c032f240 00000000 00000000 00000000 c02193a0 c020f6c8 d43de084
00000000
Call Trace: [<c02193a0>] [<d88919e9>] [<c020f696>] [<c01293a0>] [<c020f6c8>]
[<c01291f9>] [<c02193a0>] [<d88919e9>] [<c020a1d8>] [<c011902b>]
[<co118f40>]
[<c0118d6c>] [<c0108681>] [<c01053c0>] [<c01053c0>] [<c01053e3>]
[<c010544e>]
[<c0105000>]
Code: 8b 78 3c 89 d8 89 da 25 f0 f0 f0 f0 81 e2 0f 0f 0f 0f c1 e8
Using defaults from ksymoops -t elf32-i386 -a i386

Trace; c02193a0 <ip_rcv_finish+0/1e0>
Trace; d88919e8 <[lt_modem]UART_CopyDteTxData+44/dc>
Trace; c020f696 <nf_hook_slow+b6/140>
Trace; c01293a0 <kmem_cache_destroy+20/e0>
Trace; c020f6c8 <nf_hook_slow+e8/140>
Trace; c01291f8 <kmem_cache_create+308/3b0>
Trace; c02193a0 <ip_rcv_finish+0/1e0>
Trace; d88919e8 <[lt_modem]UART_CopyDteTxData+44/dc>
Trace; c020a1d8 <net_rx_action+138/210>
Trace; c011902a <bh_action+1a/40>
Trace; c0118d6c <do_softirq+4c/90>
Trace; c0108680 <do_IRQ+90/a0>
Trace; c01053c0 <default_idle+0/30>
Trace; c01053c0 <default_idle+0/30>
Trace; c01053e2 <default_idle+22/30>
Trace; c010544e <cpu_idle+3e/60>
Trace; c0105000 <_stext+0/0>
Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   8b 78 3c                  mov    0x3c(%eax),%edi
Code;  00000002 Before first symbol
   3:   89 d8                     mov    %ebx,%eax
Code;  00000004 Before first symbol
   5:   89 da                     mov    %ebx,%edx
Code;  00000006 Before first symbol
   7:   25 f0 f0 f0 f0            and    $0xf0f0f0f0,%eax
Code;  0000000c Before first symbol
   c:   81 e2 0f 0f 0f 0f         and    $0xf0f0f0f,%edx
Code;  00000012 Before first symbol
  12:   c1 e8 00                  shr    $0x0,%eax

<0>Kernel panic: Aiee, Killing interrupt handler!

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Whit Blauvelt
Sent: Saturday, December 15, 2001 12:57 AM
To: linux-kernel@vger.kernel.org
Subject: Oops - 2.4.17rc1 (with iptables 2.4.6)


Turns out it didn't leave a trace in the logs, but had a hard Oops less than
an hour into running this on a box that's been rock-solid stable for a
couple years, most recently running 2.2.19.

Sorry I didn't hand copy the Oops screen - no time for that. Back to 2.2.19.
So this isn't so useful a report, except maybe to caution going beyond the
"rc" stage too soon on this one, just in case.

The iptables patch applied to it was just with the standard features,
nothing experimental.

Whit
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

