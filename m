Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277073AbRJDBqP>; Wed, 3 Oct 2001 21:46:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277077AbRJDBqH>; Wed, 3 Oct 2001 21:46:07 -0400
Received: from alcove.wittsend.com ([130.205.0.10]:28302 "EHLO
	alcove.wittsend.com") by vger.kernel.org with ESMTP
	id <S277073AbRJDBqB>; Wed, 3 Oct 2001 21:46:01 -0400
Date: Wed, 3 Oct 2001 21:46:28 -0400
From: "Michael H. Warfield" <mhw@wittsend.com>
To: linux-kernel@vger.kernel.org
Cc: mhw@wittsend.com
Subject: PPP in 2.4.x
Message-ID: <20011003214628.A406@alcove.wittsend.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,

	I've been trying for many months to convert my router system
to the 2.4 kernel.  The system is a heavily upgraded 6.1 system with
5 ethernet interfaces (one 3c905 and one D-Link DFE-570TX 4 port card_
plus WaveLan, plus four ISDN BRI's with the TA interfaces running at
230,400, plus 3 IPSec VPN routes, plus three channels of PPP over
SSL/stunnel through one of the ethernet interfaces (broadband).
The serial interfaces are running a Computone multiport serial card
supporting 8 interfaces at 230,400.  In other words, it's a box with
a LOT of interfaces.

	This is also doing firewalling using ipchains (can't switch
to iptables till it's stable enough that I don't need to worry about
having to drop back to 2.2.19).

	Up until recent versions of 2.4, I could not keep the box up
on a 2.4 kernel for more than a few hours before it would blow an Oops.
Having bigger fish to fry at the time (and not having a serial console
configured at the time) I dropped back to 2.2.19 and tried again when
a later rev would come out.

	Recent revs (since about 2.4.6) began getting more stable and
I finally got a serial console hooked up.  Right now, 2.4.10 will run
with everything banging away at it for a week or so before blowing
an Oops.  This last time, I finally got a trace log from my serial
console and fed it through ksymoops.  That's attached below...

	I've also noticed one other thing.  While the serial interfaces
are up and running full tilt, I periodically get kfree_skb errors printed
to the console and an occasional VJ compression error.  I've attached that
fragment of a log as well.

	Here is the ksymoops output from the failure (the running kernel
and modules do match the ksymoops)...

===============================================
ksymoops 2.4.3 on i586 2.4.10.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.10/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Warning: kfree_skb on hard IRQ c019c5e1
Warning: kfree_skb on hard IRQ c019c5e1
Warning: kfree_skb on hard IRQ c019c5e1
Warning: kfree_skb on hard IRQ c019c5e1
Warning: kfree_skb on hard IRQ c019c5e1
Warning: kfree_skb on hard IRQ c019c5e1
Warning: kfree_skb on hard IRQ c019c5e1
Warning: kfree_skb on hard IRQ c019c5e1
Warning: kfree_skb on hard IRQ c019c5e1
Warning: kfree_skb on hard IRQ c019c5e1
Warning: kfree_skb on hard IRQ c019c5e1
Warning: kfree_skb on hard IRQ c019c5e1
Warning: kfree_skb on hard IRQ c019c5e1
Warning: kfree_skb on hard IRQ c019c5e1
Warning: kfree_skb on hard IRQ c019c5e1
Warning: kfree_skb on hard IRQ c019c5e1
Warning: kfree_skb on hard IRQ c019c5e1
Warning: kfree_skb on hard IRQ c019c5e1
Warning: kfree_skb on hard IRQ c019c5e1
Warning: kfree_skb on hard IRQ c019c5e1
Warning: kfree_skb on hard IRQ c019c5e1
Warning: kfree_skb on hard IRQ c019c5e1
Warning: kfree_skb on hard IRQ c019c5e1
Warning: kfree_skb on hard IRQ c019c5e1
Warning: kfree_skb on hard IRQ c019c5e1
Warning: kfree_skb on hard IRQ c019c5e1
Warning: kfree_skb on hard IRQ c019c5e1
Warning: kfree_skb on hard IRQ c019c5e1
Warning: kfree_skb on hard IRQ c019c5e1
Warning: kfree_skb on hard IRQ c019c5e1
Warning: kfree_skb on hard IRQ c019c5e1
Warning: kfree_skb on hard IRQ c019c5e1
Warning: kfree_skb on hard IRQ c019c5e1
Warning: kfree_skb on hard IRQ c019c5e1
Warning: kfree_skb on hard IRQ c019c5e1
Warning: kfree_skb passed an skb still on a list (from c019c5e1).
invalid operand: 0000
CPU:    0
EIP:    0010:[<c01e4451>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010282
eax: 00000045   ebx: 00000014   ecx: 00000000   edx: 00000082
esi: c2629496   edi: 00000074   ebp: ffff7424   esp: c02e1d38
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=c02e1000)
Stack: c02960e0 c019c5e1 00000074 c2657680 c019c5e1 c1c2cac0 c2629400 c2629600 
       00000000 c1696000 c2629420 c2629420 00000000 c2944f42 c2629582 00000009 
       c019c6f9 c2629400 c2629400 c2629600 00000007 c2629600 00000000 c019c62f 
Call Trace: [<c019c5e1>] [<c019c5e1>] [<c019c6f9>] [<c019c62f>] [<c0198ba4>] 
   [<c0198b30>] [<c01986dd>] [<c019848a>] [<c01ed71e>] [<c01e7b88>] [<c01fc82d>] 
   [<c01ed1d4>] [<c01fc782>] [<c01fc7a0>] [<c01f9d1c>] [<c01ed1d4>] [<c01f9c74>] 
   [<c01f9cd4>] [<c01f9079>] [<c01ed1d4>] [<c01f8d2e>] [<c01f8eb8>] [<c01e80ad>] 
   [<c01166bd>] [<c0107ff4>] [<c01051a0>] [<c0109de8>] [<c01051a0>] [<c01051c3>] 
   [<c010521a>] [<c0105000>] [<c0105027>] 
Code: 0f 0b 83 c4 08 8b 4c 24 0c 8b 51 28 85 d2 74 07 ff 4a 04 8b 

>>EIP; c01e4450 <__kfree_skb+1c/130>   <=====
Trace; c019c5e0 <ppp_async_encode+2e8/304>
Trace; c019c5e0 <ppp_async_encode+2e8/304>
Trace; c019c6f8 <ppp_async_push+b4/178>
Trace; c019c62e <ppp_async_send+32/48>
Trace; c0198ba4 <ppp_push+3c/c0>
Trace; c0198b30 <ppp_send_frame+3cc/404>
Trace; c01986dc <ppp_xmit_process+60/e8>
Trace; c019848a <ppp_start_xmit+1c6/1fc>
Trace; c01ed71e <qdisc_restart+4e/c8>
Trace; c01e7b88 <dev_queue_xmit+e8/234>
Trace; c01fc82c <ip_finish_output2+8c/cc>
Trace; c01ed1d4 <nf_hook_slow+f0/144>
Trace; c01fc782 <ip_finish_output+102/10c>
Trace; c01fc7a0 <ip_finish_output2+0/cc>
Trace; c01f9d1c <ip_forward_finish+48/5c>
Trace; c01ed1d4 <nf_hook_slow+f0/144>
Trace; c01f9c74 <ip_forward+184/1e4>
Trace; c01f9cd4 <ip_forward_finish+0/5c>
Trace; c01f9078 <ip_rcv_finish+1c0/1f8>
Trace; c01ed1d4 <nf_hook_slow+f0/144>
Trace; c01f8d2e <ip_rcv+37e/3b0>
Trace; c01f8eb8 <ip_rcv_finish+0/1f8>
Trace; c01e80ac <net_rx_action+134/208>
Trace; c01166bc <do_softirq+5c/ac>
Trace; c0107ff4 <do_IRQ+98/a8>
Trace; c01051a0 <default_idle+0/28>
Trace; c0109de8 <call_do_IRQ+6/e>
Trace; c01051a0 <default_idle+0/28>
Trace; c01051c2 <default_idle+22/28>
Trace; c010521a <cpu_idle+32/48>
Trace; c0105000 <_stext+0/0>
Trace; c0105026 <rest_init+26/28>
Code;  c01e4450 <__kfree_skb+1c/130>
00000000 <_EIP>:
Code;  c01e4450 <__kfree_skb+1c/130>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c01e4452 <__kfree_skb+1e/130>
   2:   83 c4 08                  addl   $0x8,%esp
Code;  c01e4454 <__kfree_skb+20/130>
   5:   8b 4c 24 0c               movl   0xc(%esp,1),%ecx
Code;  c01e4458 <__kfree_skb+24/130>
   9:   8b 51 28                  movl   0x28(%ecx),%edx
Code;  c01e445c <__kfree_skb+28/130>
   c:   85 d2                     testl  %edx,%edx
Code;  c01e445e <__kfree_skb+2a/130>
   e:   74 07                     je     17 <_EIP+0x17> c01e4466 <__kfree_skb+32/130>
Code;  c01e4460 <__kfree_skb+2c/130>
  10:   ff 4a 04                  decl   0x4(%edx)
Code;  c01e4462 <__kfree_skb+2e/130>
  13:   8b 00                     movl   (%eax),%eax

 <0>Kernel panic: Aiee, killing interrupt handler!
ds: no socket drivers loaded!
03f8 (irq = 4) ittyS3: LSR safety check engaged!

1 warning issued.  Results may not be reliable.
===============================================

	Here is some of the raw log from the console prior to the oops
(just for the kfree_skb and VJ_uncompressed errors):

===============================================
Warning: kfree_skb on hard IRQ c019c5e1
Warning: kfree_skb on hard IRQ c019c5e1
PPP: VJ uncompressed error
PPP: VJ uncompressed error
Warning: kfree_skb on hard IRQ c019c5e1
Warning: kfree_skb on hard IRQ c019c5e1
Warning: kfree_skb on hard IRQ c019c5e1
Warning: kfree_skb on hard IRQ c019c5e1
Warning: kfree_skb on hard IRQ c019c5e1
Warning: kfree_skb on hard IRQ c019c5e1
PPP: VJ uncompressed error
Warning: kfree_skb on hard IRQ c019c5e1
PPP: VJ uncompressed error
PPP: VJ uncompressed error
Warning: kfree_skb on hard IRQ c019c5e1
Warning: kfree_skb on hard IRQ c019c5e1
PPP: VJ uncompressed error
PPP: VJ uncompressed error
Warning: kfree_skb on hard IRQ c019c5e1
Warning: kfree_skb on hard IRQ c019c5e1
Warning: kfree_skb on hard IRQ c019c5e1
Warning: kfree_skb on hard IRQ c019c5e1
PPP: VJ uncompressed error
PPP: VJ uncompressed error
===============================================

	Here are some of the ksyms (sorted by address) in the range of
that address in the error:

===============================================
c01991ac ppp_input_Reffe431f
c0199338 ppp_input_error_Rfb543bc5
c0199f98 ppp_register_channel_Rc5f0ac9e
c019a050 ppp_channel_index_R7585cae0
c019a05c ppp_unit_number_Rcad5c3e8
c019a098 ppp_unregister_channel_R59f92a70
c019a13c ppp_output_wakeup_R0fd70998
c019a5b0 ppp_register_compressor_R9682e733
c019a608 ppp_unregister_compressor_Ra1b928df
c019adf0 slhc_init_R2e0e927f
c019afa8 slhc_free_R2894cfb0
c019b068 slhc_compress_R76135e6c
c019b678 slhc_uncompress_R3bc1319e
c019ba54 slhc_remember_R0bc55868
c019bc0c slhc_toss_Rf89e3455
c01a4ea0 autoirq_setup_R5a5a2280
c01a4eac autoirq_report_R84530c53
===============================================

	Mike
--  
 Michael H. Warfield    |  (770) 985-6132   |  mhw@WittsEnd.com
  (The Mad Wizard)      |  (678) 463-0932   |  http://www.wittsend.com/mhw/
  NIC whois:  MHW9      |  An optimist believes we live in the best of all
 PGP Key: 0xDF1DD471    |  possible worlds.  A pessimist is sure of it!

