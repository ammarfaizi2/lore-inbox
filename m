Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271962AbRHVInA>; Wed, 22 Aug 2001 04:43:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271961AbRHVImu>; Wed, 22 Aug 2001 04:42:50 -0400
Received: from mail.cs.tu-berlin.de ([130.149.17.13]:58006 "EHLO
	mail.cs.tu-berlin.de") by vger.kernel.org with ESMTP
	id <S271962AbRHVImk>; Wed, 22 Aug 2001 04:42:40 -0400
Date: Wed, 22 Aug 2001 10:31:44 +0200 (MEST)
From: Peter Daum <gator@cs.tu-berlin.de>
Reply-To: Peter Daum <gator@cs.tu-berlin.de>
To: <linux-kernel@vger.kernel.org>, <inux-atm-general@lists.sourceforge.net>
Subject: again: ATM (LANE) - related Kernel-Crashes
Message-ID: <Pine.LNX.4.30.0108221029560.3610-100000@swamp.bayern.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

... it happened again -
attached below is the output of ksymoops regarding a recent oops.
The machine is currently running Kernel 2.4.7 / atm-0.78.

In the past, I had had several crashes running different
kernel/atm-versions,. The machines are HP Netserver with a ForeRunner
LE ATM-NIC (hardware is checked and o.k.). The other network equipment
(ATM-, Ether-switches .. is also mostly by Fore Systems. The crashes
seem to occur always at night without any significant load on the
machine or the network. All the crashes occured in ATM/LANE code,
unfortunately on different places. Besides that, I personally can't
identify any particular pattern.

Maybe somebody with more insight into LANE has any idea, what is
going wrong ...

Is anybody else experiencing similar problems? The ATM-system is
labelled "experimental", is it generally that unstable? As far as I
can see, the MTBF seems to be about 2 weeks (unfortunately, I don't
have much alternatives ...)

Regards,
                  Peter Daum

 - - - - - 8< - - - - - 8< - - - - - 8< - - - - - 8< - - - - - 8< - - - - -

ksymoops 2.4.0 on i686 2.4.7.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.7/ (default)
     -m /boot/System.map-2.4.7 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

No modules in ksyms, skipping objects
Warning (read_lsmod): no symbols in lsmod, is /proc/modules a valid lsmod file?
Oops: 0000
CPU:    0
EIP:    0010:[<c02118d1>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010086
eax: 00000000   ebx: c1592960   ecx: ce5d3600   edx: 000332be
esi: 00000006   edi: c15dd560   ebp: c1592960   esp: cf221dd8
ds: 0018   es: 0018   ss: 0018
Process zeppelin (pid: 214, stackpage=cf221000)
Stack: cfece440 00000006 c15dd560 c1592960 00000000 c019e041 ce5d3600 c1592960
       c15a0000 c1592960 c15a0000 0f0c0020 c15dd560 cf221eb4 cfccc800 c2dd03a0
       40017000 00000001 cf21705c cfccc800 00000006 ce5d3600 cfece440 cfecf860
Call Trace: [<c019e041>] [<c019d8ad>] [<c019c80d>] [<c0107eaf>] [<c010800e>] [<c0106d98>] [<c0211a94>]
       [<c020ffe0>] [<c020f2a5>] [<c011d1fe>] [<c011d59d>] [<c01ce885>] [<c01372e7>] [<c0106d0f>]
Code: 8b 68 60 85 db 75 18 8b 54 24 18 52 55 e8 dd 17 00 00 83 c4

>>EIP; c02118d1 <lec_push+19/140>   <=====
Trace; c019e041 <dequeue_rx+75d/db4>
Trace; c019d8ad <process_rsq+15/4c>
Trace; c019c80d <ns_irq_handler+119/33c>
Trace; c0107eaf <handle_IRQ_event+2f/58>
Trace; c010800e <do_IRQ+6e/b0>
Trace; c0106d98 <ret_from_intr+0/7>
Trace; c0211a94 <lec_vcc_attach+9c/c0>
Trace; c020ffe0 <atm_push_raw+0/44>
Trace; c020f2a5 <atm_ioctl+429/9a8>
Trace; c011d1fe <unmap_fixup+62/12c>
Trace; c011d59d <do_munmap+251/260>
Trace; c01ce885 <sock_ioctl+21/28>
Trace; c01372e7 <sys_ioctl+16b/184>
Trace; c0106d0f <system_call+33/38>
Code;  c02118d1 <lec_push+19/140>
00000000 <_EIP>:
Code;  c02118d1 <lec_push+19/140>   <=====
   0:   8b 68 60                  mov    0x60(%eax),%ebp   <=====
Code;  c02118d4 <lec_push+1c/140>
   3:   85 db                     test   %ebx,%ebx
Code;  c02118d6 <lec_push+1e/140>
   5:   75 18                     jne    1f <_EIP+0x1f> c02118f0 <lec_push+38/140>
Code;  c02118d8 <lec_push+20/140>
   7:   8b 54 24 18               mov    0x18(%esp,1),%edx
Code;  c02118dc <lec_push+24/140>
   b:   52                        push   %edx
Code;  c02118dd <lec_push+25/140>
   c:   55                        push   %ebp
Code;  c02118de <lec_push+26/140>
   d:   e8 dd 17 00 00            call   17ef <_EIP+0x17ef> c02130c0 <lec_vcc_close+0/308>
Code;  c02118e3 <lec_push+2b/140>
  12:   83 c4 00                  add    $0x0,%esp

Kernel panic: Aiee, killing interrupt handler!

2 warnings issued.  Results may not be reliable.

