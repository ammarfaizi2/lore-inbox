Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268023AbRGVSNO>; Sun, 22 Jul 2001 14:13:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268026AbRGVSNE>; Sun, 22 Jul 2001 14:13:04 -0400
Received: from mail.cs.tu-berlin.de ([130.149.17.13]:40905 "EHLO
	mail.cs.tu-berlin.de") by vger.kernel.org with ESMTP
	id <S268023AbRGVSMs>; Sun, 22 Jul 2001 14:12:48 -0400
Date: Sun, 22 Jul 2001 19:56:02 +0200 (MEST)
From: Peter Daum <gator@cs.tu-berlin.de>
Reply-To: Peter Daum <gator@cs.tu-berlin.de>
To: <linux-kernel@vger.kernel.org>, <linux-atm-general@lists.sourceforge.net>
Subject: ATM (LANE) - related Kernel-Crashes
Message-ID: <Pine.LNX.4.30.0107221926480.4967-100000@swamp.bayern.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hi,

attached below is the output of ksymoops regarding a recent oops.
The machine is currently running Kernel 2.4.4 / atm-0.78.

In the past, I had had several crashes on the same box running
different kernel/atm-versions,. The machine is a HP Netserver
with a ForeRunner LE ATM-NIC (hardware is checked and o.k.). The
crashes seem to occur always at night without any significant
load on the machine or the network, probably while answering a
DHCP request (there is a DHCP server running on it). All the
crashes occured in ATM/LANE code, unfortunately on different
places (often arp-related).

Maybe somebody with more insight into LANE has any idea, what is
going wrong ...

Regards,
                  Peter Daum

 - - - - - 8< - - - - - 8< - - - - - 8< - - - - - 8< - - - - - 8< - - - - -

ksymoops 2.3.7 on i686 2.4.4.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.4/ (default)
     -m /boot/System.map-2.4.4 (specified)

No modules in ksyms, skipping objects
Warning (read_lsmod): no symbols in lsmod, is /proc/modules a valid lsmod file?
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(shmem_file_setup) not found in System.map.  Ignoring ksyms_base entry
Oops: 0000
CPU:    0
EIP:    0010:[<c0212dd1>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010086
eax: 00000000   ebx: c186cea0   ecx: c62a4800   edx: 00074b21
esi: 00000006   edi: c12e1560   ebp: c186cea0   esp: c4179dd8
ds: 0018   es: 0018   ss: 0018
Process zeppelin (pid: 27287, stackpage=c4179000)
Stack: c12c0d40 00000006 c12e1560 c186cea0 00000000 c0199a81 c62a4800 c186cea0
       c12a0000 c186cea0 c12a0000 0f0c0020 c12e1560 c4179eb4 c4997720 4000d000
       00000001 c19c7034 c7ee35a0 4000d000 00000006 c62a4800 c12c0d40 c7f5f580
Call Trace: [<c0199a81>] [<c01992e7>] [<c019825d>] [<c0107cff>] [<c0107e5e>] [<c0106be8>] [<c0212f94>]
       [<c0211560>] [<c0210825>] [<c011cbfe>] [<c011cf92>] [<c01d2005>] [<c0136e87>] [<c0106b3f>]
Code: 8b 68 60 85 db 75 18 8b 54 24 18 52 55 e8 cd 17 00 00 83 c4

>>EIP; c0212dd1 <lec_push+19/140>   <=====
Trace; c0199a81 <dequeue_rx+765/dbc>
Trace; c01992e7 <process_rsq+1b/50>
Trace; c019825d <ns_irq_handler+119/33c>
Trace; c0107cff <handle_IRQ_event+2f/58>
Trace; c0107e5e <do_IRQ+6e/b0>
Trace; c0106be8 <ret_from_intr+0/20>
Trace; c0212f94 <lec_vcc_attach+9c/c0>
Trace; c0211560 <atm_push_raw+0/44>
Trace; c0210825 <atm_ioctl+429/9a8>
Trace; c011cbfe <unmap_fixup+62/12c>
Trace; c011cf92 <do_munmap+246/254>
Trace; c01d2005 <sock_ioctl+21/28>
Trace; c0136e87 <sys_ioctl+16b/184>
Trace; c0106b3f <system_call+33/38>
Code;  c0212dd1 <lec_push+19/140>
00000000 <_EIP>:
Code;  c0212dd1 <lec_push+19/140>   <=====
   0:   8b 68 60                  mov    0x60(%eax),%ebp   <=====
Code;  c0212dd4 <lec_push+1c/140>
   3:   85 db                     test   %ebx,%ebx
Code;  c0212dd6 <lec_push+1e/140>
   5:   75 18                     jne    1f <_EIP+0x1f> c0212df0 <lec_push+38/140>
Code;  c0212dd8 <lec_push+20/140>
   7:   8b 54 24 18               mov    0x18(%esp,1),%edx
Code;  c0212ddc <lec_push+24/140>
   b:   52                        push   %edx
Code;  c0212ddd <lec_push+25/140>
   c:   55                        push   %ebp
Code;  c0212dde <lec_push+26/140>
   d:   e8 cd 17 00 00            call   17df <_EIP+0x17df> c02145b0 <lec_vcc_close+0/308>
Code;  c0212de3 <lec_push+2b/140>
  12:   83 c4 00                  add    $0x0,%esp

Kernel panic: Aiee, killing interrupt handler!
  Receiver lock-up bug exists -- enabling work-around.

2 warnings issued.  Results may not be reliable.

