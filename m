Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318744AbSHAMVu>; Thu, 1 Aug 2002 08:21:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318762AbSHAMVu>; Thu, 1 Aug 2002 08:21:50 -0400
Received: from srv.cip.physik.tu-muenchen.de ([129.187.137.223]:54545 "EHLO
	srv.cip.physik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id <S318744AbSHAMVm>; Thu, 1 Aug 2002 08:21:42 -0400
Message-Id: <200208011224.g71COrW05657@pc02.e18.physik.tu-muenchen.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Kernel panic on Dual Athlon MP 
Date: Thu, 01 Aug 2002 14:24:53 +0200
From: Lars Schmitt <lschmitt@e18.physik.tu-muenchen.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

We are running a number of dual Athlon MP machines with Tyan Tiger MPX,
3ware RAID controllers and 3COM 3C996T GigE. These machines have serious
stability problems and crash in particular when large file copies from 
the RAID to the network are initiated.

I have been trying the following RH kernels:

- 2.4.9-31 with the bcm5700 driver
- 2.4.18-3 with the tg3 driver

The result essentially is the same. It crashes with kernel panic -
see the message appended below.

For both kernels the preceding oops points to the network driver's
interrupt routine, although the drivers are different.

> On 2002-03-15 18:54:24 Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>> Some gige cards don't seem to work with some dual athlon bioses. Other than
>> that it should be fine

Could you specify that a bit more? In particular, am I likely to
have such an unlucky combination? Would a BIOS upgrade help or
should I get a different GigE card?

It seems that the kernel option "mem=nopentium" improves the situation 
a bit but does not remove the crashes completely. Somebody suggested
to also use the "noapic" option, which however would reduce the 
performance of the system. Could you comment on this.

> On 2002-07-22 15:35:18 Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>> In your case thats the memory handling stuff that the NVidia module
>> happens to trip. Its actually a kernel related thing not their fault.
>> There is a horrible work around in 2.4.19-rc2, and people are working on
>> the right fixes for this.

Could you explain the changes in 2.4.19-rc2 (or was it rc3?) ?
Will the right fixes already be in 2.4.19-final?

Thanks very much for your help.

Yours,
	Lars Schmitt

PS: I don't quite understand, why there are the warnings from ksymoops
not loading certain modules.
-----------
Dr. Lars Schmitt       
Lars.Schmitt<@>ph.tum.de                               Lars.Schmitt<@>cern.ch 
TU Muenchen, Physik-Department, E18                            CERN,  Div. EP 
James-Franck-Str. 1, 85747 Garching                         CH-1211 Geneva 23 

----------
ksymoops 2.4.1 on i686 2.4.9-31.1.cernsmp.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.9-31.1.cernsmp/ (default)
     -m /boot/System.map-2.4.9-31.1.cernsmp (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Error (expand_objects): cannot stat(/lib/ext3.o) for ext3
ksymoops: No such file or directory
Error (expand_objects): cannot stat(/lib/jbd.o) for jbd
ksymoops: No such file or directory
Error (expand_objects): cannot stat(/lib/3w-xxxx.o) for 3w-xxxx
ksymoops: No such file or directory
Error (expand_objects): cannot stat(/lib/sd_mod.o) for sd_mod
ksymoops: No such file or directory
Error (expand_objects): cannot stat(/lib/scsi_mod.o) for scsi_mod
ksymoops: No such file or directory
Warning (compare_maps): ksyms_base symbol GPLONLY_IO_APIC_get_PCI_irq_vector not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): mismatch on symbol partition_name  , ksyms_base says c01c2ca0, System.map says c01601a0.  Ignoring ksyms_base entry
Warning (compare_maps): mismatch on symbol nlmsvc_grace_period  , lockd says f8a92a74, /lib/modules/2.4.9-31.1.cernsmp/kernel/fs/lockd/lockd.o says f8a91ed4.  Ignoring /lib/modules/2.4.9-31.1.cernsmp/kernel/fs/lockd/lockd.o entry
Warning (compare_maps): mismatch on symbol nlmsvc_ops  , lockd says f8a92a70, /lib/modules/2.4.9-31.1.cernsmp/kernel/fs/lockd/lockd.o says f8a91ed0.  Ignoring /lib/modules/2.4.9-31.1.cernsmp/kernel/fs/lockd/lockd.o entry
Warning (compare_maps): mismatch on symbol nlmsvc_timeout  , lockd says f8a92a78, /lib/modules/2.4.9-31.1.cernsmp/kernel/fs/lockd/lockd.o says f8a91ed8.  Ignoring /lib/modules/2.4.9-31.1.cernsmp/kernel/fs/lockd/lockd.o entry
Warning (compare_maps): mismatch on symbol nfs_debug  , sunrpc says f8ab8c60, /lib/modules/2.4.9-31.1.cernsmp/kernel/net/sunrpc/sunrpc.o says f8ab8940.  Ignoring /lib/modules/2.4.9-31.1.cernsmp/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol nfsd_debug  , sunrpc says f8ab8c64, /lib/modules/2.4.9-31.1.cernsmp/kernel/net/sunrpc/sunrpc.o says f8ab8944.  Ignoring /lib/modules/2.4.9-31.1.cernsmp/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol nlm_debug  , sunrpc says f8ab8c68, /lib/modules/2.4.9-31.1.cernsmp/kernel/net/sunrpc/sunrpc.o says f8ab8948.  Ignoring /lib/modules/2.4.9-31.1.cernsmp/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol rpc_debug  , sunrpc says f8ab8c5c, /lib/modules/2.4.9-31.1.cernsmp/kernel/net/sunrpc/sunrpc.o says f8ab893c.  Ignoring /lib/modules/2.4.9-31.1.cernsmp/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol rpc_garbage_args  , sunrpc says f8ab8c3c, /lib/modules/2.4.9-31.1.cernsmp/kernel/net/sunrpc/sunrpc.o says f8ab891c.  Ignoring /lib/modules/2.4.9-31.1.cernsmp/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol rpc_success  , sunrpc says f8ab8c2c, /lib/modules/2.4.9-31.1.cernsmp/kernel/net/sunrpc/sunrpc.o says f8ab890c.  Ignoring /lib/modules/2.4.9-31.1.cernsmp/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol rpc_system_err  , sunrpc says f8ab8c40, /lib/modules/2.4.9-31.1.cernsmp/kernel/net/sunrpc/sunrpc.o says f8ab8920.  Ignoring /lib/modules/2.4.9-31.1.cernsmp/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol xdr_one  , sunrpc says f8ab8c24, /lib/modules/2.4.9-31.1.cernsmp/kernel/net/sunrpc/sunrpc.o says f8ab8904.  Ignoring /lib/modules/2.4.9-31.1.cernsmp/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol xdr_two  , sunrpc says f8ab8c28, /lib/modules/2.4.9-31.1.cernsmp/kernel/net/sunrpc/sunrpc.o says f8ab8908.  Ignoring /lib/modules/2.4.9-31.1.cernsmp/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol xdr_zero  , sunrpc says f8ab8c20, /lib/modules/2.4.9-31.1.cernsmp/kernel/net/sunrpc/sunrpc.o says f8ab8900.  Ignoring /lib/modules/2.4.9-31.1.cernsmp/kernel/net/sunrpc/sunrpc.o entry
Warning (map_ksym_to_module): cannot match loaded module ext3 to a unique module object.  Trace may not be reliable.
Warning (compare_maps): mismatch on symbol tw_device_extension_list  , 3w-xxxx says f8825600, /lib/modules/2.4.9-31.1.cernsmp/kernel/drivers/scsi/3w-xxxx.o says f8825480.  Ignoring /lib/modules/2.4.9-31.1.cernsmp/kernel/drivers/scsi/3w-xxxx.o entry
Warning (compare_maps): mismatch on symbol sd  , sd_mod says f881cda0, /lib/modules/2.4.9-31.1.cernsmp/kernel/drivers/scsi/sd_mod.o says f881cd00.  Ignoring /lib/modules/2.4.9-31.1.cernsmp/kernel/drivers/scsi/sd_mod.o entry
Warning (compare_maps): mismatch on symbol proc_scsi  , scsi_mod says f881827c, /lib/modules/2.4.9-31.1.cernsmp/kernel/drivers/scsi/scsi_mod.o says f8816ab4.  Ignoring /lib/modules/2.4.9-31.1.cernsmp/kernel/drivers/scsi/scsi_mod.o entry
Warning (compare_maps): mismatch on symbol scsi_devicelist  , scsi_mod says f88182a8, /lib/modules/2.4.9-31.1.cernsmp/kernel/drivers/scsi/scsi_mod.o says f8816ae0.  Ignoring /lib/modules/2.4.9-31.1.cernsmp/kernel/drivers/scsi/scsi_mod.o entry
Warning (compare_maps): mismatch on symbol scsi_hostlist  , scsi_mod says f88182a4, /lib/modules/2.4.9-31.1.cernsmp/kernel/drivers/scsi/scsi_mod.o says f8816adc.  Ignoring /lib/modules/2.4.9-31.1.cernsmp/kernel/drivers/scsi/scsi_mod.o entry
Warning (compare_maps): mismatch on symbol scsi_hosts  , scsi_mod says f88182ac, /lib/modules/2.4.9-31.1.cernsmp/kernel/drivers/scsi/scsi_mod.o says f8816ae4.  Ignoring /lib/modules/2.4.9-31.1.cernsmp/kernel/drivers/scsi/scsi_mod.o entry
Warning (compare_maps): mismatch on symbol scsi_logging_level  , scsi_mod says f8818278, /lib/modules/2.4.9-31.1.cernsmp/kernel/drivers/scsi/scsi_mod.o says f8816ab0.  Ignoring /lib/modules/2.4.9-31.1.cernsmp/kernel/drivers/scsi/scsi_mod.o entry
Unable to handle kernel NULL pointer dereference at virtual address 00000000
f8a52ebb
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[3c59x:__insmod_3c59x_O/lib/modules/2.4.9-31.1.cernsmp/kernel/driv+-106821/96]    Tainted: PF
EIP:    0010:[<f8a52ebb>]    Tainted: PF
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000016   ebx: f4c88140   ecx: 00000005   edx: 0000010f
esi: 00000000   edi: f4c8a45c   ebp: 0000000b   esp: c02f1f2c
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=c02f1000)
Stack: f4c88140 0000001d f4c88000 f8a4b73f f4c88140 f6ddc140 00000000 04000001 
       c0108ace 0000000b f4c88000 c02f1f94 c02f1f94 c0331ac0 0000000b 00000000 
       c0108cd4 0000000b c02f1f94 f6ddc140 f6ddc140 c0105420 c02f0000 c02f0000 
Call Trace: [3c59x:__insmod_3c59x_O/lib/modules/2.4.9-31.1.cernsmp/kernel/driv+-137409/96] bcm5700_probe [bcm5700] 0x10df 
Call Trace: [<f8a4b73f>] bcm5700_probe [bcm5700] 0x10df 
[<c0108ace>] handle_IRQ_event [kernel] 0x5e 
[<c0108cd4>] do_IRQ [kernel] 0xa4 
[<c0105420>] default_idle [kernel] 0x0 
[<c0105420>] default_idle [kernel] 0x0 
[<c022cb7c>] call_do_IRQ [kernel] 0x5 
[<c0105420>] default_idle [kernel] 0x0 
[<c0105420>] default_idle [kernel] 0x0 
[<c010544d>] default_idle [kernel] 0x2d 
[<c01054d2>] cpu_idle [kernel] 0x52 
[<c0105000>] stext [kernel] 0x0 
[<c022bc80>] .rodata.str1.32 [kernel] 0x4a0 
Code: c7 06 00 00 00 00 8b 93 94 2c 00 00 8d 83 90 2c 00 00 85 d2 

>>EIP; f8a52ebb <[bcm5700]LM_ServiceInterrupts+24b/2e0>   <=====
Trace; f8a4b73f <[bcm5700]bcm5700_interrupt+bf/220>
Trace; c0108ace <handle_IRQ_event+5e/90>
Trace; c0108cd4 <do_IRQ+a4/f0>
Trace; c0105420 <default_idle+0/40>
Trace; c0105420 <default_idle+0/40>
Trace; c022cb7c <call_do_IRQ+5/d>
Trace; c0105420 <default_idle+0/40>
Trace; c0105420 <default_idle+0/40>
Trace; c010544d <default_idle+2d/40>
Trace; c01054d2 <cpu_idle+52/70>
Trace; c0105000 <_stext+0/0>
Trace; c022bc80 <llc_oui+870/1748>
Code;  f8a52ebb <[bcm5700]LM_ServiceInterrupts+24b/2e0>
00000000 <_EIP>:
Code;  f8a52ebb <[bcm5700]LM_ServiceInterrupts+24b/2e0>   <=====
   0:   c7 06 00 00 00 00         movl   $0x0,(%esi)   <=====
Code;  f8a52ec1 <[bcm5700]LM_ServiceInterrupts+251/2e0>
   6:   8b 93 94 2c 00 00         mov    0x2c94(%ebx),%edx
Code;  f8a52ec7 <[bcm5700]LM_ServiceInterrupts+257/2e0>
   c:   8d 83 90 2c 00 00         lea    0x2c90(%ebx),%eax
Code;  f8a52ecd <[bcm5700]LM_ServiceInterrupts+25d/2e0>
  12:   85 d2                     test   %edx,%edx

 <0>Kernel panic: Aiee, killing interrupt handler!

24 warnings and 5 errors issued.  Results may not be reliable.
