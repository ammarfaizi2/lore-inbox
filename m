Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131778AbRAXMtj>; Wed, 24 Jan 2001 07:49:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131426AbRAXMt3>; Wed, 24 Jan 2001 07:49:29 -0500
Received: from big-relay-1.ftel.co.uk ([192.65.220.123]:33671 "EHLO
	old-callisto.ftel.co.uk") by vger.kernel.org with ESMTP
	id <S130153AbRAXMtT>; Wed, 24 Jan 2001 07:49:19 -0500
Date: Wed, 24 Jan 2001 12:49:16 GMT
Message-Id: <200101241249.f0OCnG704905@old-callisto.ftel.co.uk>
From: Paul Flinders <P.Flinders@ftel.co.uk>
To: linux-kernel@vger.kernel.org
Subject: 2.4.1-pre7 SMP oops
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


My Dual 866Mhz PIII died whilst compiling gcc with

ksymoops -m /boot/System.map-2.4.1-pre7 < ~/oops 
ksymoops 0.7c on i686 2.4.1-pre7.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.1-pre7/ (default)
     -m /boot/System.map-2.4.1-pre7 (specified)

Warning (compare_maps): ksyms_base symbol acpi_clear_event_R__ver_acpi_clear_event not found in System.map.  Ignoring ksyms_base entry
[rather a lot of similar warnings]
Unable to handle kernel NULL pointer derefernce at virtual address 00000000
 c011f9e3
*pde = 00000000
Oops: 0002
EIP: 0010 : [<c011f9e3>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010086
eax: 00000000   ebx: c0274000      ecx: 00000000       edx: 00000000
esi: 00000000   edi: 00000000      ebp: 00000000       esp: c0275f70
ds: 0018        es: 0018       ss: 0018
Process swapper (pid: 0, stackpage=c0275000)
Stack: 00000000 00000000 00000000 00000000 c01137a6 00000000 c01072a0 c0274000
       c01072a0 c0274000 c0212e3c c01072a0 c0274000 c0274000 c0274000 ?
Call trace: <c01137a6> <c01072a0> <c01072a0> <c01072a0> <c01072a0> <c0100018>
            <c01072cc> <c0107332> <c0105000> <c01001cf>
Code: 6c 24 14 89 ef 56 83 f7 01 57 55 53 e8 f4 fe ff 83 c4 10

>>EIP; c011f9e3 <update_process_times+f/94>   <=====
Trace; c01137a6 <smp_apic_timer_interrupt+e6/f4>
Trace; c01072a0 <default_idle+0/34>
Trace; c01072a0 <default_idle+0/34>
Trace; c01072a0 <default_idle+0/34>
Trace; c01072a0 <default_idle+0/34>
Trace; c0100018 <startup_32+18/cb>
Trace; c01072cc <default_idle+2c/34>
Trace; c0107332 <cpu_idle+3e/54>
Trace; c0105000 <empty_bad_page+0/1000>
Trace; c01001cf <L6+0/2>
Code;  c011f9e3 <update_process_times+f/94>
00000000 <_EIP>:
Code;  c011f9e3 <update_process_times+f/94>   <=====
   0:   6c                        insb   (%dx),%es:(%edi)   <=====
Code;  c011f9e4 <update_process_times+10/94>
   1:   24 14                     and    $0x14,%al
Code;  c011f9e6 <update_process_times+12/94>
   3:   89 ef                     mov    %ebp,%edi
Code;  c011f9e8 <update_process_times+14/94>
   5:   56                        push   %esi
Code;  c011f9e9 <update_process_times+15/94>
   6:   83 f7 01                  xor    $0x1,%edi
Code;  c011f9ec <update_process_times+18/94>
   9:   57                        push   %edi
Code;  c011f9ed <update_process_times+19/94>
   a:   55                        push   %ebp
Code;  c011f9ee <update_process_times+1a/94>
   b:   53                        push   %ebx
Code;  c011f9ef <update_process_times+1b/94>
   c:   e8 f4 fe ff 83            call   83ffff05 <_EIP+0x83ffff05> 4411f8e8 Before first symbol
Code;  c011f9f4 <update_process_times+20/94>
  11:   c4 10                     les    (%eax),%edx

45 warnings issued.  Results may not be reliable.

The code looks a bit odd - it doesn't quite align with the instructions in
update_process_times. The raw OOPS included "CPU: -117" so I guess that
something else randomly corrupted either current or current->processor and
update_process_times/update_one_process fell over as a result.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
