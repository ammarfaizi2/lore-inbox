Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293258AbSCOVRw>; Fri, 15 Mar 2002 16:17:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293251AbSCOVRn>; Fri, 15 Mar 2002 16:17:43 -0500
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:37270 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S293258AbSCOVRf>; Fri, 15 Mar 2002 16:17:35 -0500
Message-ID: <3C9264EC.CCCBEDD1@delusion.de>
Date: Fri, 15 Mar 2002 22:17:32 +0100
From: "Udo A. Steinberg" <reality@delusion.de>
Organization: Disorganized
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.6 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
CC: andrew.grover@intel.com
Subject: [OOPS] Kernel powerdown
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

The following oops happens whenever i try to halt my machine
with kernel 2.5.6.

The last messages seen are:

flushing ide devices: hda hdb hde 
Power down.
NMI Watchdog detected LOCKUP on CPU0

The relevant ACPI output is:

ACPI: Core Subsystem version [20011018]
ACPI: Subsystem enabled
ACPI: System firmware supports S0 S1 S3 S4 S5
Processor[0]: C0 C1 C2, 8 throttling states
ACPI: Power Button (FF) found
ACPI: Multiple power buttons detected, ignoring fixed-feature
ACPI: Power Button (CM) found

If you need more info, let me know.

-Udo.



ksymoops 2.4.4 on i686 2.5.6.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.5.6/ (default)
     -m /boot/System.map-2.5.6 (specified)

Error (regular_file): read_ksyms stat /proc/ksyms failed
ksymoops: No such file or directory
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
NMI Watchdog detected LOCKUP on CPU0, eip c01b42f6, registers:
CPU:    0
EIP:    0010:[<c01b42f6>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00000002
eax: 0029611a   ebx: 007ab8cc   ecx: aa1fd773   edx: 00000011
esi: 00003c01   edi: 00000001   ebp: bffffd3c   esp: cd947e30
ds: 0018   es: 0018   ss: 0018
Stack: 00003c01 c01b4343 007ab8cc c01b4379 007ab8cc c01b686a 00002710 00003c01 
       c01beeda 00002710 ffffffff 00000005 00000001 05003607 00000001 cd947e74 
       07074343 00000001 00000005 00000000 00000000 c01ce6cd 00000005 cd946000 
Call Trace: [<c01b4343>] [<c01b4379>] [<c01b686a>] [<c01beeda>] [<c01ce6cd>] 
   [<c01ce717>] [<c010550b>] [<c011fa3d>] [<c0113a19>] [<c011de5f>] [<c011def2>] 
   [<c011e234>] [<c011eb81>] [<c01140cc>] [<c011d2c6>] [<c011d230>] [<c011d40a>] 
   [<c0107047>] 
Code: 39 d8 72 f6 5b c3 8d 74 26 00 8b 44 24 04 eb 0a 8d 76 00 8d 

>>EIP; c01b42f6 <__rdtsc_delay+16/20>   <=====
Trace; c01b4343 <__delay+13/30>
Trace; c01b4379 <__udelay+19/20>
Trace; c01b686a <acpi_os_stall+3a/40>
Trace; c01beeda <acpi_enter_sleep_state+18a/1c0>
Trace; c01ce6cd <sm_osl_suspend+3d/80>
Trace; c01ce717 <sm_osl_power_down+7/10>
Trace; c010550b <machine_power_off+b/10>
Trace; c011fa3d <sys_reboot+15d/270>
Trace; c0113a19 <wake_up_process+9/10>
Trace; c011de5f <deliver_signal+4f/60>
Trace; c011def2 <send_sig_info+82/b0>
Trace; c011e234 <kill_something_info+144/170>
Trace; c011eb81 <sys_kill+51/60>
Trace; c01140cc <schedule+20c/250>
Trace; c011d2c6 <schedule_timeout+86/a0>
Trace; c011d230 <process_timeout+0/10>
Trace; c011d40a <sys_nanosleep+11a/1f0>
Trace; c0107047 <syscall_call+7/b>
Code;  c01b42f6 <__rdtsc_delay+16/20>
00000000 <_EIP>:
Code;  c01b42f6 <__rdtsc_delay+16/20>   <=====
   0:   39 d8                     cmp    %ebx,%eax   <=====
Code;  c01b42f8 <__rdtsc_delay+18/20>
   2:   72 f6                     jb     fffffffa <_EIP+0xfffffffa> c01b42f0 <__rdtsc_delay+10/20>
Code;  c01b42fa <__rdtsc_delay+1a/20>
   4:   5b                        pop    %ebx
Code;  c01b42fb <__rdtsc_delay+1b/20>
   5:   c3                        ret    
Code;  c01b42fc <__rdtsc_delay+1c/20>
   6:   8d 74 26 00               lea    0x0(%esi,1),%esi
Code;  c01b4300 <__loop_delay+0/30>
   a:   8b 44 24 04               mov    0x4(%esp,1),%eax
Code;  c01b4304 <__loop_delay+4/30>
   e:   eb 0a                     jmp    1a <_EIP+0x1a> c01b4310 <__loop_delay+10/30>
Code;  c01b4306 <__loop_delay+6/30>
  10:   8d 76 00                  lea    0x0(%esi),%esi
Code;  c01b4309 <__loop_delay+9/30>
  13:   8d 00                     lea    (%eax),%eax


1 error issued.  Results may not be reliable.
