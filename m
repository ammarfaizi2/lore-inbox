Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282870AbRLLXTn>; Wed, 12 Dec 2001 18:19:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282874AbRLLXTe>; Wed, 12 Dec 2001 18:19:34 -0500
Received: from ns1.webley.com ([207.25.7.30]:59146 "EHLO skip1.webley.com")
	by vger.kernel.org with ESMTP id <S282870AbRLLXTV>;
	Wed, 12 Dec 2001 18:19:21 -0500
Message-ID: <3C17E5EA.3000103@webley.com>
Date: Wed, 12 Dec 2001 17:19:06 -0600
From: Nicholas Harring <nharring@webley.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Oops in 2.4.16
Content-Type: multipart/mixed;
 boundary="------------000603060002090202040300"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000603060002090202040300
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello all,
I received an oops in 2.4.16, attached is the output in plain text of 
running ksymoops on the text dumped in /var/log/messages.
Symptoms when oops resulted:
Box had become mostly unresponsive on ssh logins, with user shells 
locking up and not responding approx 90 seconds after login.
As root on sucessive new consoles I attempted to issue, in order, 
/sbin/reboot /sbin/halt and /sbin/init 0 with strace attached to each.
reboot terminated normally  but did not trigger a reboot. halt 
segfaulted however I lost the strace output (sorry). init also 
terminated normally, however
I then walked to the console and saw oops text on the screen. At the 
time I also had a large amount, 700+ Meg, of file system data in cache 
as I was attempting to stress
the VM and used a recursive grep on the / filesystem to force caching.
Config details:
Quad PIII Xeon
1GB Ram

Thanks in advance for help on this,
also, please cc me directly as well as the list as I'm not a regular 
reader of the messages here.
Sincerely,
Nicholas Harring
System Administrator
Webley Systems, Inc

--------------000603060002090202040300
Content-Type: text/plain;
 name="2.4.16-oops"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.4.16-oops"

ksymoops 2.4.0 on i686 2.4.16.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.16/ (default)
     -m /boot/System.map-2.4.16 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

No modules in ksyms, skipping objects
Warning (read_lsmod): no symbols in lsmod, is /proc/modules a valid lsmod file?
Unable to handle kernel NULL pointer dereference at virtual address 00000000
c01ad622
*pde = 00000000
Oops: 0000
CPU:    3
EIP:    0010:[tdfx__vm_info+166/424]
EIP:    0010:[<c01ad622>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010287
eax: 00000000   ebx: 00000032   ecx: ecf07000   edx: f7da9000
esi: f0efff98   edi: ecf07000   ebp: ecf07000   esp: f0efff0c
ds: 0018   es: 0018   ss: 0018
Process grep (pid: 8445, stackpage=f0eff000)
Stack: f7da9000 f0efff98 ecf07000 f7da9020 00000000 f7da9000 c02906b4 c02906b7
c02906bb c02906bf c01ad75a ecf07000 f0efff98 00000000 00000c00 f0efff94
f7da9000 f109af20 00000c00 ecf07000 00111000 c014d80a ecf07000 f0efff98
Call Trace: [tdfx_vm_info+54/76] [proc_file_read+242/404] [sys_read+143/196] [system_call+51/56]
Call Trace: [<c01ad75a>] [<c014d80a>] [<c0132147>] [<c0106d1b>]
Code: 8b 38 39 c7 0f 84 bd 00 00 00 8d 74 26 00 8b 77 08 85 f6 0f

>>EIP; c01ad622 <detect_uart_irq+e2/178>   <=====
Trace; c01ad75a <size_fifo+a2/158>
Trace; c014d80a <load_elf_binary+976/a88>
Trace; c0132147 <shmem_file_setup+cb/120>
Trace; c0106d1b <lcall7+4b/4c>
Code;  c01ad622 <detect_uart_irq+e2/178>
00000000 <_EIP>:
Code;  c01ad622 <detect_uart_irq+e2/178>   <=====
   0:   8b 38                     mov    (%eax),%edi   <=====
Code;  c01ad624 <detect_uart_irq+e4/178>
   2:   39 c7                     cmp    %eax,%edi
Code;  c01ad626 <detect_uart_irq+e6/178>
   4:   0f 84 bd 00 00 00         je     c7 <_EIP+0xc7> c01ad6e9 <size_fifo+31/158>
Code;  c01ad62c <detect_uart_irq+ec/178>
   a:   8d 74 26 00               lea    0x0(%esi,1),%esi
Code;  c01ad630 <detect_uart_irq+f0/178>
   e:   8b 77 08                  mov    0x8(%edi),%esi
Code;  c01ad633 <detect_uart_irq+f3/178>
  11:   85 f6                     test   %esi,%esi
Code;  c01ad635 <detect_uart_irq+f5/178>
  13:   0f 00 00                  sldt   (%eax)


2 warnings issued.  Results may not be reliable.

--------------000603060002090202040300--

