Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932260AbWC3SKY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932260AbWC3SKY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 13:10:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932261AbWC3SKY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 13:10:24 -0500
Received: from mail1.ugr.es ([150.214.35.28]:53997 "EHLO mail1.ugr.es")
	by vger.kernel.org with ESMTP id S932260AbWC3SKX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 13:10:23 -0500
From: ruben@ugr.es
Message-ID: <55426.87.218.171.47.1143742209.squirrel@goliat7.ugr.es>
Date: Thu, 30 Mar 2006 20:10:09 +0200 (CEST)
Subject: oops in generic_delete_inode when doing frequent i/o to disk
To: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.6
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1] One line Summary of problem: sun java and freenet makes kernel
2.6.16.1 oops and crashes the machine on AMD64.
-------------------------------------------------------------
[2] Full Description

When running a java application which writes to disk constantly for a long
time, an oops is generated.
This oops will crash the machine eventually.
I think the oops will be generated as well with any program which writes
constantly to disc, but I have only one such program:
Freenet running on Sun Java. The versions of the programs are described
below.

Some oops are shown below, with the disassembled functions and code.
I hope you find this useful in finding the bug.

There are some sections in the REPORTING BUGS which I think are not relevant
to the code, so I omited them. These include /proc/ioports, /proc/iomem,
lspci -vvv and /proc/scsi/scsi.
Please contact me if you need any more information.
-------------------------------------------------------------
[3.] Keywords

oops, generic_delete_inode, frequent and continuous i/o to disk
-------------------------------------------------------------
[4.] Kernel version (from /proc/version):
Linux version 2.6.16.1 (root@blackhole) (gcc version 4.0.2 20050808
(prerelease) (Ubuntu 4.0.1-4ubuntu9)) #4 PREEMPT Thu Mar 30 00:07:11 CEST
2006
-------------------------------------------------------------
[5.] Most recent kernel version which did not have the bug:
Kernel 2.6.12-9-amd-generic from Ubuntu 5.2 has the bug as well.
I don't have older kernels, will test if requested.
--------------------------------------------------------------
[6.] Output of Oops.. message (if applicable) with symbolic information
     resolved (see Documentation/oops-tracing.txt)

Oops:

Mar 30 10:21:19 blackhole kernel: [18628.027629] Modules linked in:
snd_rtctimer rfcomm l2cap bluetooth powernow_k8 cpufreq_userspace
cpufreq_stats
freq_table cpufreq_powersave cpufreq_ondemand cpufreq_conservative lp
video thermal processor fan container button battery ac ipv6 mousedev
tsdev ide_cd cdrom parport_pc parport pcspkr psmouse rtc ide_generic
snd_seq_dummy snd_seq_oss snd_seq_midi snd_seq_midi_event snd_seq
snd_via82xx gameport
snd_ac97_codec snd_ac97_bus snd_pcm_oss snd_mixer_oss snd_pcm snd_timer
snd_page_alloc snd_mpu401_uart snd_rawmidi snd_seq_device snd soundcore
i2c_viapro ehci_hcd uhci_hcd generic sata_via libata scsi_mod bt878 tuner
bttv video_buf firmware_class compat_ioctl32 i2c_algo_bit v4l2_common
btcx_risc ir_common tveeprom i2c_core videodev sk98lin skge shpchp
pci_hotplug aes dm_crypt loop dm_mod md_mod unix
Mar 30 10:21:19 blackhole kernel: [18628.027667] Pid: 21039, comm: java
Not tainted 2.6.16.1 #4
Mar 30 10:21:19 blackhole kernel: [18628.027671] RIP:
0010:[generic_delete_inode+283/387]
<ffffffff8017fb8b>{generic_delete_inode+283}
Mar 30 10:21:19 blackhole kernel: [18628.027677] RSP:
0018:ffff8100041fbec8  EFLAGS: 00010246
Mar 30 10:21:19 blackhole kernel: [18628.027681] RAX: 0000000000000000
RBX: ffff810037a93750 RCX: ffff81000ea24870
Mar 30 10:21:19 blackhole kernel: [18628.027687] RDX: ffff800001f7f2b0
RSI: ffff81003ba72680 RDI: ffff81003223f240
Mar 30 10:21:19 blackhole kernel: [18628.027691] RBP: ffffffff801c694e
R08: 0000000000000002 R09: 00000000000000a0
Mar 30 10:21:19 blackhole kernel: [18628.027695] R10: 0000000000000000
R11: 0000000000000000 R12: ffff81003f718ed0
Mar 30 10:21:19 blackhole kernel: [18628.027699] R13: ffff81003e349000
R14: 0000000000000000 R15: 00002aaaab2d7b40
Mar 30 10:21:19 blackhole kernel: [18628.027704] FS: 
0000000044304960(0063) GS:ffffffff803fa000(0000) knlGS:00000000f750d6c0
Mar 30 10:21:19 blackhole kernel: [18628.027708] CS:  0010 DS: 0000 ES:
0000 CR0: 0000000080050033
Mar 30 10:21:19 blackhole kernel: [18628.027712] CR2: ffff800001f7f2b0
CR3: 0000000028507000 CR4: 00000000000006e0
Mar 30 10:21:19 blackhole kernel: [18628.027717] Process java (pid: 21039,
threadinfo ffff8100041fa000, task ffff81003ef5e380)
Mar 30 10:21:19 blackhole kernel: [18628.027720] Stack: ffffffff8017fbf3
0000000000000000 ffff810037a93750 ffffffff80176ba6
Mar 30 10:21:19 blackhole kernel: [18628.027727]        ffff81000b34a7c8
ffff81003dab4080 0000004612bd64da ffff81003e34900b
Mar 30 10:21:19 blackhole kernel: [18628.027733]        0000000000000010
0000000000000000
Mar 30 10:21:19 blackhole kernel: [18628.027736] Call Trace:
<ffffffff8017fbf3>{generic_drop_inode+0}
Mar 30 10:21:19 blackhole kernel: [18628.027744]       
<ffffffff80176ba6>{do_unlinkat+213} <ffffffff8010a76e>{system_call+126}
Mar 30 10:21:19 blackhole kernel: [18628.027771]
Mar 30 10:21:19 blackhole kernel: [18628.027772] Code: 48 89 02 74 04 48
89 50 08 48 c7 03 00 00 00 00 48 c7 43 08
Mar 30 10:21:19 blackhole kernel: [18628.027789]  <6>note: java[21039]
exited with preempt_count 1


gdb /usr/src/linux/vmlinux
gdb> disassemble generic_delete_inode
Dump of assembler code for function generic_delete_inode:
0xffffffff8017fa70 <generic_delete_inode+0>:    push   %rbp
0xffffffff8017fa71 <generic_delete_inode+1>:    push   %rbx
0xffffffff8017fa72 <generic_delete_inode+2>:    mov    %rdi,%rbx
0xffffffff8017fa75 <generic_delete_inode+5>:    push   %rax
0xffffffff8017fa76 <generic_delete_inode+6>:    mov    0x100(%rdi),%rax
0xffffffff8017fa7d <generic_delete_inode+13>:   mov    0x10(%rdi),%rcx
0xffffffff8017fa81 <generic_delete_inode+17>:   mov    0x38(%rax),%rbp
0xffffffff8017fa85 <generic_delete_inode+21>:   lea    0x10(%rdi),%rax
0xffffffff8017fa89 <generic_delete_inode+25>:   mov    0x8(%rax),%rdx
0xffffffff8017fa8d <generic_delete_inode+29>:   mov    %rdx,0x8(%rcx)
0xffffffff8017fa91 <generic_delete_inode+33>:   mov    %rcx,(%rdx)
0xffffffff8017fa94 <generic_delete_inode+36>:   mov    %rax,0x8(%rax)
0xffffffff8017fa98 <generic_delete_inode+40>:   mov    %rax,0x10(%rdi)
0xffffffff8017fa9c <generic_delete_inode+44>:   lea    0x20(%rdi),%rax
0xffffffff8017faa0 <generic_delete_inode+48>:   mov    0x20(%rdi),%rcx
0xffffffff8017faa4 <generic_delete_inode+52>:   mov    0x8(%rax),%rdx
0xffffffff8017faa8 <generic_delete_inode+56>:   mov    %rdx,0x8(%rcx)
0xffffffff8017faac <generic_delete_inode+60>:   mov    %rcx,(%rdx)
0xffffffff8017faaf <generic_delete_inode+63>:   mov    %rax,0x8(%rax)
0xffffffff8017fab3 <generic_delete_inode+67>:   orq    $0x10,0x218(%rdi)
0xffffffff8017fabb <generic_delete_inode+75>:   mov    %rax,0x20(%rdi)
0xffffffff8017fabf <generic_delete_inode+79>:   decl   2426923(%rip)      
 # 0xffffffff803d02f0 <inodes_stat>
0xffffffff8017fac5 <generic_delete_inode+85>:   mov    %gs:0x10,%rax
0xffffffff8017face <generic_delete_inode+94>:   decl  
0xffffffffffffe044(%rax)
0xffffffff8017fad4 <generic_delete_inode+100>:  mov    %gs:0x10,%rax
0xffffffff8017fadd <generic_delete_inode+109>:  mov   
0xffffffffffffe038(%rax),%eax
0xffffffff8017fae3 <generic_delete_inode+115>:  mov    %eax,%eax
0xffffffff8017fae5 <generic_delete_inode+117>:  test   $0x8,%al
0xffffffff8017fae7 <generic_delete_inode+119>:  je     0xffffffff8017faee
<generic_delete_inode+126>
0xffffffff8017fae9 <generic_delete_inode+121>:  callq  0xffffffff802decf9
<preempt_schedule>
0xffffffff8017faee <generic_delete_inode+126>:  testb  $0x2,0x229(%rbx)
0xffffffff8017faf5 <generic_delete_inode+133>:  jne    0xffffffff8017fb07
<generic_delete_inode+151>
0xffffffff8017faf7 <generic_delete_inode+135>:  mov    2463842(%rip),%rax 
      # 0xffffffff803d9360 <security_ops>
0xffffffff8017fafe <generic_delete_inode+142>:  mov    %rbx,%rdi
0xffffffff8017fb01 <generic_delete_inode+145>:  callq  *0x190(%rax)
0xffffffff8017fb07 <generic_delete_inode+151>:  mov    0x38(%rbp),%rbp
0xffffffff8017fb0b <generic_delete_inode+155>:  test   %rbp,%rbp
0xffffffff8017fb0e <generic_delete_inode+158>:  je     0xffffffff8017fb57
<generic_delete_inode+231>
0xffffffff8017fb10 <generic_delete_inode+160>:  mov    %rbx,%rdi
0xffffffff8017fb13 <generic_delete_inode+163>:  callq  0xffffffff801809be
<is_bad_inode>
0xffffffff8017fb18 <generic_delete_inode+168>:  test   %eax,%eax
0xffffffff8017fb1a <generic_delete_inode+170>:  jne    0xffffffff8017fb50
<generic_delete_inode+224>
0xffffffff8017fb1c <generic_delete_inode+172>:  mov    0x100(%rbx),%rax
0xffffffff8017fb23 <generic_delete_inode+179>:  test   %rax,%rax
0xffffffff8017fb26 <generic_delete_inode+182>:  jne    0xffffffff8017fb32
<generic_delete_inode+194>
0xffffffff8017fb28 <generic_delete_inode+184>:  ud2a
0xffffffff8017fb2a <generic_delete_inode+186>:  pushq  $0xffffffff802fec56
0xffffffff8017fb2f <generic_delete_inode+191>:  retq   $0x41
0xffffffff8017fb32 <generic_delete_inode+194>:  testb  $0x3,0x120(%rax)
0xffffffff8017fb39 <generic_delete_inode+201>:  je     0xffffffff8017fb50
<generic_delete_inode+224>
0xffffffff8017fb3b <generic_delete_inode+203>:  testb  $0x20,0x228(%rbx)
0xffffffff8017fb42 <generic_delete_inode+210>:  jne    0xffffffff8017fb50
<generic_delete_inode+224>
---Type <return> to continue, or q <return> to quit---
0xffffffff8017fb44 <generic_delete_inode+212>:  mov    0x40(%rax),%rax
0xffffffff8017fb48 <generic_delete_inode+216>:  or    
$0xffffffffffffffff,%esi
0xffffffff8017fb4b <generic_delete_inode+219>:  mov    %rbx,%rdi
0xffffffff8017fb4e <generic_delete_inode+222>:  callq  *(%rax)
0xffffffff8017fb50 <generic_delete_inode+224>:  mov    %rbx,%rdi
0xffffffff8017fb53 <generic_delete_inode+227>:  callq  *%ebp
0xffffffff8017fb55 <generic_delete_inode+229>:  jmp    0xffffffff8017fb6d
<generic_delete_inode+253>
0xffffffff8017fb57 <generic_delete_inode+231>:  lea    0x118(%rbx),%rdi
0xffffffff8017fb5e <generic_delete_inode+238>:  xor    %esi,%esi
0xffffffff8017fb60 <generic_delete_inode+240>:  callq  0xffffffff80150984
<truncate_inode_pages>
0xffffffff8017fb65 <generic_delete_inode+245>:  mov    %rbx,%rdi
0xffffffff8017fb68 <generic_delete_inode+248>:  callq  0xffffffff8017f483
<clear_inode>
0xffffffff8017fb6d <generic_delete_inode+253>:  mov    %gs:0x10,%rax
0xffffffff8017fb76 <generic_delete_inode+262>:  incl  
0xffffffffffffe044(%rax)
0xffffffff8017fb7c <generic_delete_inode+268>:  mov    0x8(%rbx),%rdx
0xffffffff8017fb80 <generic_delete_inode+272>:  test   %rdx,%rdx
0xffffffff8017fb83 <generic_delete_inode+275>:  je     0xffffffff8017fba3
<generic_delete_inode+307>
0xffffffff8017fb85 <generic_delete_inode+277>:  mov    (%rbx),%rax
0xffffffff8017fb88 <generic_delete_inode+280>:  test   %rax,%rax
0xffffffff8017fb8b <generic_delete_inode+283>:  mov    %rax,(%rdx)
0xffffffff8017fb8e <generic_delete_inode+286>:  je     0xffffffff8017fb94
<generic_delete_inode+292>
0xffffffff8017fb90 <generic_delete_inode+288>:  mov    %rdx,0x8(%rax)
0xffffffff8017fb94 <generic_delete_inode+292>:  movq   $0x0,(%rbx)
0xffffffff8017fb9b <generic_delete_inode+299>:  movq   $0x0,0x8(%rbx)
0xffffffff8017fba3 <generic_delete_inode+307>:  mov    %gs:0x10,%rax
0xffffffff8017fbac <generic_delete_inode+316>:  decl  
0xffffffffffffe044(%rax)
0xffffffff8017fbb2 <generic_delete_inode+322>:  mov    %gs:0x10,%rax
0xffffffff8017fbbb <generic_delete_inode+331>:  mov   
0xffffffffffffe038(%rax),%eax
0xffffffff8017fbc1 <generic_delete_inode+337>:  mov    %eax,%eax
0xffffffff8017fbc3 <generic_delete_inode+339>:  test   $0x8,%al
0xffffffff8017fbc5 <generic_delete_inode+341>:  je     0xffffffff8017fbcc
<generic_delete_inode+348>
0xffffffff8017fbc7 <generic_delete_inode+343>:  callq  0xffffffff802decf9
<preempt_schedule>
0xffffffff8017fbcc <generic_delete_inode+348>:  mov    %rbx,%rdi
0xffffffff8017fbcf <generic_delete_inode+351>:  callq  0xffffffff8017ec70
<wake_up_inode>
0xffffffff8017fbd4 <generic_delete_inode+356>:  cmpq   $0x20,0x218(%rbx)
0xffffffff8017fbdc <generic_delete_inode+364>:  je     0xffffffff8017fbe8
<generic_delete_inode+376>
0xffffffff8017fbde <generic_delete_inode+366>:  ud2a
0xffffffff8017fbe0 <generic_delete_inode+368>:  pushq  $0xffffffff80300d05
0xffffffff8017fbe5 <generic_delete_inode+373>:  retq   $0x422
0xffffffff8017fbe8 <generic_delete_inode+376>:  pop    %rax
0xffffffff8017fbe9 <generic_delete_inode+377>:  mov    %rbx,%rdi
0xffffffff8017fbec <generic_delete_inode+380>:  pop    %rbx
0xffffffff8017fbed <generic_delete_inode+381>:  pop    %rbp
0xffffffff8017fbee <generic_delete_inode+382>:  jmpq   0xffffffff8017eb2e
<destroy_inode>
End of assembler dump.
(gdb)

cat bug.c
char str[] =
"\x48\x89\x02\x74\x04\x48\x89\x50\x08\x48\xc7\x03\x00\x00\x00\x00\x48\xc7\x43\x08";
main(){}

(gdb) disassemble str
Dump of assembler code for function str:
0x0000000000500820 <str+0>:     mov    %rax,(%rdx)
0x0000000000500823 <str+3>:     je     0x500829 <str+9>
0x0000000000500825 <str+5>:     mov    %rdx,0x8(%rax)
0x0000000000500829 <str+9>:     movq   $0x0,(%rbx)
0x0000000000500830 <str+16>:    movq   $0x0,0x8(%rbx)
End of assembler dump.
(gdb)

The code doesn't seem to be corrupt.

I have some other oops with the same code and different stack:

-----------Begin oops -------------

Mar 30 02:23:12 blackhole kernel: [ 4290.494412] Modules linked in:
snd_rtctimer rfcomm l2cap bluetooth powernow_k8 cpufreq_userspace
cpufreq_stats freq_table cpufreq_powersave cpufreq_ondemand
cpufreq_conservative lp video thermal processor fan container button
battery ac ipv6 mousedev tsdev ide_cd cdrom parport_pc parport pcspkr
psmouse rtc ide_generic snd_seq_dummy snd_seq_oss snd_seq_midi
snd_seq_midi_event snd_seq snd_via82xx gameport snd_ac97_codec
snd_ac97_bus
snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd_page_alloc snd_mpu401_uart
snd_rawmidi snd_seq_device snd soundcore i2c_viapro ehci_hcd uhci_hcd
generic sata_via libata scsi_mod bt878 tuner bttv video_buf firmware_class
compat_ioctl32 i2c_algo_bit v4l2_common btcx_risc ir_common tveeprom
i2c_core videodev sk98lin skge shpchp pci_hotplug aes dm_crypt loop dm_mod
md_mod unix
Mar 30 02:23:12 blackhole kernel: [ 4290.494450] Pid: 12645, comm: java
Not tainted 2.6.16.1 #4
Mar 30 02:23:12 blackhole kernel: [ 4290.494453] RIP:
0010:[generic_delete_inode+283/387]
<ffffffff8017fb8b>{generic_delete_inode+283}
Mar 30 02:23:12 blackhole kernel: [ 4290.494460] RSP:
0018:ffff810027d21ec8  EFLAGS: 00010246
Mar 30 02:23:12 blackhole kernel: [ 4290.494464] RAX: 0000000000000000
RBX: ffff81003b055690 RCX: ffff81000ea24870
Mar 30 02:23:12 blackhole kernel: [ 4290.494469] RDX: ffff800001fa50d0
RSI: ffff81003ba72680 RDI: ffff81002aafab88
Mar 30 02:23:12 blackhole kernel: [ 4290.494474] RBP: ffffffff801c694e
R08: 0000000000000002 R09: 0000000000000340
Mar 30 02:23:12 blackhole kernel: [ 4290.494477] R10: 0000000000000000
R11: 0000000000000000 R12: ffff81003f9e1c38
Mar 30 02:23:12 blackhole kernel: [ 4290.494482] R13: ffff81003e2fb000
R14: 0000000000000000 R15: 00002aaab019f410
Mar 30 02:23:12 blackhole kernel: [ 4290.494487] FS: 
0000000047f40960(0063) GS:ffffffff803fa000(0000) knlGS:00000000f5bc2bb0
Mar 30 02:23:12 blackhole kernel: [ 4290.494491] CS:  0010 DS: 0000 ES:
0000 CR0: 0000000080050033
Mar 30 02:23:12 blackhole kernel: [ 4290.494495] CR2: ffff800001fa50d0
CR3: 000000000e3c3000 CR4: 00000000000006e0
Mar 30 02:23:12 blackhole kernel: [ 4290.494500] Process java (pid: 12645,
threadinfo ffff810027d20000, task ffff810021d82340)
Mar 30 02:23:12 blackhole kernel: [ 4290.494503] Stack: ffffffff8017fbf3
0000000000000000 ffff81003b055690 ffffffff80176ba6
Mar 30 02:23:12 blackhole kernel: [ 4290.494510]        ffff810010fde468
ffff81003dab4080 00000009ca093089 ffff81003e2fb006
Mar 30 02:23:12 blackhole kernel: [ 4290.494516]        0000000000000010
ffffffff00000000
Mar 30 02:23:12 blackhole kernel: [ 4290.494520] Call Trace:
<ffffffff8017fbf3>{generic_drop_inode+0}
Mar 30 02:23:12 blackhole kernel: [ 4290.494527]       
<ffffffff80176ba6>{do_unlinkat+213}
<ffffffff801816c5>{mntput_no_expire+23}
Mar 30 02:23:12 blackhole kernel: [ 4290.494540]       
<ffffffff80165a73>{filp_close+89} <ffffffff8010a76e>{system_call+126}
Mar 30 02:23:12 blackhole kernel: [ 4290.494560]
Mar 30 02:23:12 blackhole kernel: [ 4290.494561] Code: 48 89 02 74 04 48
89 50 08 48 c7 03 00 00 00 00 48 c7 43 08
Mar 30 02:23:12 blackhole kernel: [ 4290.494578]  <6>note: java[12645]
exited with preempt_count 1

----------End oops -----------
----------Begin oops ---------
Mar 30 14:35:00 blackhole kernel: [26295.049536] Modules linked in:
snd_rtctimer rfcomm l2cap bluetooth powernow_k8 cpufreq_userspace
cpufreq_stats freq_table cpufreq_powersave cpufreq_ondemand
cpufreq_conservative lp video thermal processor fan container button
battery ac ipv6 mousedev tsdev ide_cd cdrom parport_pc parport pcspkr
psmouse rtc ide_generic snd_seq_dummy snd_seq_oss snd_seq_midi
snd_seq_midi_event snd_seq snd_via82xx gameport snd_ac97_codec
snd_ac97_bus
snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd_page_alloc snd_mpu401_uart
snd_rawmidi snd_seq_device snd soundcore i2c_viapro ehci_hcd uhci_hcd
generic sata_via libata scsi_mod bt878 tuner bttv video_buf firmware_class
compat_ioctl32 i2c_algo_bit v4l2_common btcx_risc ir_common tveeprom
i2c_core videodev sk98lin skge shpchp pci_hotplug aes dm_crypt loop dm_mod
md_mod unix
Mar 30 14:35:00 blackhole kernel: [26295.049699] Pid: 140, comm: kswapd0
Not tainted 2.6.16.1 #4
Mar 30 14:35:00 blackhole kernel: [26295.049711] RIP:
0010:[dispose_list+114/319] <ffffffff8017f5ff>{dispose_list+114}Mar 30
14:35:00 blackhole kernel: [26295.049727] RSP: 0018:ffff81003fdd7d78 
EFLAGS: 00010246
Mar 30 14:35:00 blackhole kernel: [26295.049743] RAX: 0000000000000000
RBX: ffff81003487a760 RCX: 0000000000000036
Mar 30 14:35:00 blackhole kernel: [26295.049757] RDX: ffff800001f64870
RSI: ffff81003487a8d8 RDI: ffffffffffffffff
Mar 30 14:35:00 blackhole kernel: [26295.049770] RBP: ffff81003487a750
R08: ffff810001cd4228 R09: 0000000000000006
Mar 30 14:35:00 blackhole kernel: [26295.049783] R10: 0000000000000006
R11: ffffffff801b4912 R12: 000000000000001b
Mar 30 14:35:00 blackhole kernel: [26295.049795] R13: ffff81003fdd7da8
R14: 0000000000000080 R15: 0000000000000080
Mar 30 14:35:00 blackhole kernel: [26295.049809] FS: 
00000000424e6960(0000) GS:ffffffff803fa000(0000) knlGS:000000007c355bb0
Mar 30 14:35:00 blackhole kernel: [26295.049827] CS:  0010 DS: 0018 ES:
0018 CR0: 000000008005003b
Mar 30 14:35:00 blackhole kernel: [26295.049838] CR2: ffff800001f64870
CR3: 0000000028507000 CR4: 00000000000006e0
Mar 30 14:35:00 blackhole kernel: [26295.049852] Process kswapd0 (pid:
140, threadinfo ffff81003fdd6000, task ffff81003fd0f040)
Mar 30 14:35:00 blackhole kernel: [26295.049869] Stack: 0000000000000000
ffff810027f21438 ffff810027f21448 0000000000000080
Mar 30 14:35:00 blackhole kernel: [26295.049885]        0000000000000000
ffffffff8017f8b3 ffff8100286199f8 ffff81002944fa78
Mar 30 14:35:00 blackhole kernel: [26295.049906]        ffff81003fdd7db8
ffff81003ffa84c0
Mar 30 14:35:00 blackhole kernel: [26295.049919] Call Trace:
<ffffffff8017f8b3>{shrink_icache_memory+487}
Mar 30 14:35:00 blackhole kernel: [26295.049944]       
<ffffffff80150b4b>{shrink_slab+223} <ffffffff80151f19>{balance_pgdat+568}
Mar 30 14:35:00 blackhole kernel: [26295.049982]       
<ffffffff80152150>{kswapd+255}
<ffffffff8013aa0c>{autoremove_wake_function+0}
Mar 30 14:35:00 blackhole kernel: [26295.050012]       
<ffffffff8010b286>{child_rip+8} <ffffffff80152051>{kswapd+0}
Mar 30 14:35:00 blackhole kernel: [26295.050042]       
<ffffffff8010b27e>{child_rip+0}
Mar 30 14:35:00 blackhole kernel: [26295.050061]
Mar 30 14:35:00 blackhole kernel: [26295.050062] Code: 48 89 02 74 04 48
89 50 08 48 c7 43 f0 00 00 00 00 48 c7 43
Mar 30 14:35:00 blackhole kernel: [26295.050303]  <6>note: kswapd0[140]
exited with preempt_count 1
-----------end oops------------
-----------begin oops----------
Mar 30 18:19:38 blackhole kernel: [33029.714304] Modules linked in:
snd_rtctimer rfcomm l2cap bluetooth powernow_k8 cpufreq_userspace
cpufreq_stats freq_table cpufreq_powersave cpufreq_ondemand
cpufreq_conservative lp video thermal processor fan container button
battery ac ipv6 mousedev tsdev ide_cd cdrom parport_pc parport pcspkr
psmouse rtc ide_generic snd_seq_dummy snd_seq_oss snd_seq_midi
snd_seq_midi_event snd_seq snd_via82xx gameport snd_ac97_codec
snd_ac97_bus
snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd_page_alloc snd_mpu401_uart
snd_rawmidi snd_seq_device snd soundcore i2c_viapro ehci_hcd uhci_hcd
generic sata_via libata scsi_mod bt878 tuner bttv video_buf firmware_class
compat_ioctl32 i2c_algo_bit v4l2_common btcx_risc ir_common tveeprom
i2c_core videodev sk98lin skge shpchp pci_hotplug aes dm_crypt loop dm_mod
md_mod unix
Mar 30 18:19:38 blackhole kernel: [33029.714467] Pid: 10977, comm: java
Not tainted 2.6.16.1 #4
Mar 30 18:19:38 blackhole kernel: [33029.714478] RIP:
0010:[generic_delete_inode+283/387]
<ffffffff8017fb8b>{generic_delete_inode+283}
Mar 30 18:19:38 blackhole kernel: [33029.714494] RSP:
0018:ffff81003b049ec8  EFLAGS: 00010246
Mar 30 18:19:38 blackhole kernel: [33029.714511] RAX: 0000000000000000
RBX: ffff810027c396d0 RCX: ffff8100016dedf8
Mar 30 18:19:38 blackhole kernel: [33029.714524] RDX: ffff800001f78520
RSI: 0000000000000004 RDI: ffff81002ade5fa8
Mar 30 18:19:38 blackhole kernel: [33029.714538] RBP: ffffffff801c694e
R08: ffff8100016dedf8 R09: 00000000fffffffa
Mar 30 18:19:38 blackhole kernel: [33029.714550] R10: 0000000000000004
R11: 0000000000000004 R12: ffff810009b1f080
Mar 30 18:19:38 blackhole kernel: [33029.714563] R13: ffff81003e2ff000
R14: 0000000000000000 R15: 00002aaaad255a00
Mar 30 18:19:38 blackhole kernel: [33029.714577] FS: 
0000000041bdd960(0063) GS:ffffffff803fa000(0000) knlGS:000000007c85abb0
Mar 30 18:19:38 blackhole kernel: [33029.714594] CS:  0010 DS: 0000 ES:
0000 CR0: 0000000080050033
Mar 30 18:19:38 blackhole kernel: [33029.714606] CR2: ffff800001f78520
CR3: 0000000002eda000 CR4: 00000000000006e0
Mar 30 18:19:38 blackhole kernel: [33029.714620] Process java (pid: 10977,
threadinfo ffff81003b048000, task ffff810018582760)
Mar 30 18:19:38 blackhole kernel: [33029.714636] Stack: ffffffff8017fbf3
0000000000000000 ffff810027c396d0 ffffffff80176ba6
Mar 30 18:19:38 blackhole kernel: [33029.714653]        ffff81000ed304a8
ffff81003dab4080 00000012b838aae8 ffff81003e2ff000
Mar 30 18:19:38 blackhole kernel: [33029.714675]        0000000000000010
0000000000000000
Mar 30 18:19:38 blackhole kernel: [33029.714686] Call Trace:
<ffffffff8017fbf3>{generic_drop_inode+0}
Mar 30 18:19:38 blackhole kernel: [33029.714704]       
<ffffffff80176ba6>{do_unlinkat+213} <ffffffff8010a76e>{system_call+126}
Mar 30 18:19:38 blackhole kernel: [33029.714750]
Mar 30 18:19:38 blackhole kernel: [33029.714751] Code: 48 89 02 74 04 48
89 50 08 48 c7 03 00 00 00 00 48 c7 43 08
Mar 30 18:19:38 blackhole kernel: [33029.714997]  <6>note: java[10977]
exited with preempt_count 1
-----------end oops----------

----------------------------------------------------------------------------------------------------
[7.] A small shell script or example program which triggers the
     problem (if possible)

How to recreate:
-AMD64
-kernel 2.6.16.1
-java version "1.5.0_06"
-freenet Build 5106 (http://freenet.sourceforge.net/)

Run freenet with this java version in 64 bit mode for a few
hours. I have one oops every 6 hours, more or less.

---------------------------------------------------------------------------------

[8.] Environment

[8.1.] Software (add the output of the ver_linux script here)

./ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux blackhole 2.6.16.1 #4 PREEMPT Thu Mar 30 00:07:11 CEST 2006 x86_64
GNU/Linux

Gnu C                  4.0.2
Gnu make               3.80
binutils               2.16.1
util-linux             2.12p
mount                  2.12p
module-init-tools      3.2-pre7
e2fsprogs              1.38
jfsutils               1.1.8
reiserfsprogs          3.6.19
reiser4progs           1.0.4
xfsprogs               2.6.28
PPP                    2.4.3
Linux C Library        2.3.5
Dynamic linker (ldd)   2.3.5
Procps                 3.2.5
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.2.1
udev                   060
Modules Loaded         rfcomm l2cap bluetooth powernow_k8
cpufreq_userspace cpufreq_stats freq_table cpufreq_powersave
cpufreq_ondemand cpufreq_conservative lp video thermal processor fan
container button battery ac ipv6 mousedev tsdev ide_cd cdrom parport_pc
parport pcspkr psmouse rtc ide_generic snd_seq_dummy snd_seq_oss
snd_seq_midi snd_seq_midi_event snd_seq snd_via82xx gameport
snd_ac97_codec snd_ac97_bus snd_pcm_oss snd_mixer_oss snd_pcm snd_timer
snd_page_alloc snd_mpu401_uart snd_rawmidi snd_seq_device snd soundcore
i2c_viapro ehci_hcd uhci_hcd generic sata_via libata scsi_mod bt878 tuner
bttv video_buf firmware_class compat_ioctl32 i2c_algo_bit v4l2_common
btcx_risc ir_common tveeprom i2c_core videodev sk98lin skge shpchp
pci_hotplug aes dm_crypt loop dm_mod md_mod unix

[8.2.] Processor information (from /proc/cpuinfo):

$cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 15
model           : 47
model name      : AMD Athlon(tm) 64 Processor 3200+
stepping        : 2
cpu MHz         : 1000.000
cache size      : 512 KB
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 clflush mmx fxsr sse sse2 syscall nx mmxext fxsr_opt lm
3dnowext 3dnow pni lahf_lm
bogomips        : 2007.70
TLB size        : 1024 4K pages
clflush size    : 64
cache_alignment : 64
address sizes   : 40 bits physical, 48 bits virtual
power management: ts fid vid ttp tm stc

[8.3.] Module information (from /proc/modules):

cat /proc/modules
rfcomm 38824 0 - Live 0xffffffff882d8000
l2cap 27016 5 rfcomm, Live 0xffffffff882d0000
bluetooth 51620 4 rfcomm,l2cap, Live 0xffffffff882c2000
powernow_k8 10384 0 - Live 0xffffffff882be000
cpufreq_userspace 4884 1 - Live 0xffffffff882bb000
cpufreq_stats 6024 0 - Live 0xffffffff882b8000
freq_table 5256 2 powernow_k8,cpufreq_stats, Live 0xffffffff882b5000
cpufreq_powersave 2432 0 - Live 0xffffffff882b3000
cpufreq_ondemand 7084 0 - Live 0xffffffff882b0000
cpufreq_conservative 7980 0 - Live 0xffffffff882ad000
lp 13056 0 - Live 0xffffffff882a8000
video 17800 0 - Live 0xffffffff882a2000
thermal 15500 0 - Live 0xffffffff8829d000
processor 26456 2 powernow_k8,thermal, Live 0xffffffff88295000
fan 5512 0 - Live 0xffffffff88292000
container 5376 0 - Live 0xffffffff8828f000
button 7968 0 - Live 0xffffffff8828c000
battery 10888 0 - Live 0xffffffff88288000
ac 5896 0 - Live 0xffffffff88285000
ipv6 267680 251 - Live 0xffffffff88242000
mousedev 12928 1 - Live 0xffffffff8823d000
tsdev 8960 0 - Live 0xffffffff88239000
ide_cd 40864 0 - Live 0xffffffff8822e000
cdrom 36792 1 ide_cd, Live 0xffffffff88224000
parport_pc 37488 1 - Live 0xffffffff88219000
parport 40588 2 lp,parport_pc, Live 0xffffffff8820e000
pcspkr 4104 0 - Live 0xffffffff8820b000
psmouse 39564 0 - Live 0xffffffff88200000
rtc 15352 0 - Live 0xffffffff881fb000
ide_generic 1792 0 [permanent], Live 0xffffffff881f6000
snd_seq_dummy 4484 0 - Live 0xffffffff881f8000
snd_seq_oss 32868 0 - Live 0xffffffff881ec000
snd_seq_midi 9536 0 - Live 0xffffffff881e8000
snd_seq_midi_event 8320 2 snd_seq_oss,snd_seq_midi, Live 0xffffffff881e4000
snd_seq 54552 6 snd_seq_dummy,snd_seq_oss,snd_seq_midi,snd_seq_midi_event,
Live 0xffffffff881d5000
snd_via82xx 30120 1 - Live 0xffffffff881cc000
gameport 16784 1 snd_via82xx, Live 0xffffffff881c6000
snd_ac97_codec 102588 1 snd_via82xx, Live 0xffffffff881ab000
snd_ac97_bus 3072 1 snd_ac97_codec, Live 0xffffffff881a9000
snd_pcm_oss 52256 0 - Live 0xffffffff8819b000
snd_mixer_oss 17920 1 snd_pcm_oss, Live 0xffffffff88195000
snd_pcm 95372 3 snd_via82xx,snd_ac97_codec,snd_pcm_oss, Live
0xffffffff8817c000
snd_timer 26120 2 snd_seq,snd_pcm, Live 0xffffffff88174000
snd_page_alloc 11536 2 snd_via82xx,snd_pcm, Live 0xffffffff88170000
snd_mpu401_uart 8576 1 snd_via82xx, Live 0xffffffff8816c000
snd_rawmidi 28064 2 snd_seq_midi,snd_mpu401_uart, Live 0xffffffff88164000
snd_seq_device 9872 5
snd_seq_dummy,snd_seq_oss,snd_seq_midi,snd_seq,snd_rawmidi, Live
0xffffffff88160000
snd 60928 13
snd_seq_oss,snd_seq,snd_via82xx,snd_ac97_codec,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_timer,snd_mpu401_uart,snd_rawmidi,snd_seq_device,
Live 0xffffffff88150000
soundcore 11680 1 snd, Live 0xffffffff8814c000
i2c_viapro 9880 0 - Live 0xffffffff88148000
ehci_hcd 32136 0 - Live 0xffffffff8813f000
uhci_hcd 32544 0 - Live 0xffffffff88136000
generic 5764 0 [permanent], Live 0xffffffff88133000
sata_via 9988 0 - Live 0xffffffff8812f000
libata 61720 1 sata_via, Live 0xffffffff8811e000
scsi_mod 147992 1 libata, Live 0xffffffff880f8000
bt878 12620 0 - Live 0xffffffff880f3000
tuner 52780 0 - Live 0xffffffff880e5000
bttv 194620 1 bt878, Live 0xffffffff880b4000
video_buf 23812 1 bttv, Live 0xffffffff880ad000
firmware_class 11904 1 bttv, Live 0xffffffff880a9000
compat_ioctl32 9088 1 bttv, Live 0xffffffff880a5000
i2c_algo_bit 9608 1 bttv, Live 0xffffffff880a1000
v4l2_common 9984 3 tuner,bttv,compat_ioctl32, Live 0xffffffff8809d000
btcx_risc 5512 1 bttv, Live 0xffffffff8809a000
ir_common 10884 1 bttv, Live 0xffffffff88096000
tveeprom 17040 1 bttv, Live 0xffffffff88090000
i2c_core 23832 5 i2c_viapro,tuner,bttv,i2c_algo_bit,tveeprom, Live
0xffffffff88089000
videodev 12032 1 bttv, Live 0xffffffff88085000
sk98lin 146016 0 - Live 0xffffffff88060000
skge 39056 0 - Live 0xffffffff88055000
shpchp 45440 0 - Live 0xffffffff88048000
pci_hotplug 29672 1 shpchp, Live 0xffffffff8803f000
aes 27304 2 - Live 0xffffffff88037000
dm_crypt 12560 1 - Live 0xffffffff88032000
loop 16656 2 - Live 0xffffffff8802c000
dm_mod 55144 3 dm_crypt, Live 0xffffffff8801d000
md_mod 76056 0 - Live 0xffffffff88009000
unix 31160 657 - Live 0xffffffff88000000

[8.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)

I don't think it is relevant, will post if asked

[8.5.] PCI information ('lspci -vvv' as root)

I don't think it is relevant, will post if asked

[8.6.] SCSI information (from /proc/scsi/scsi)

I don't think it is relevant, will post if asked

[8.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):


[X.] Other notes, patches, fixes, workarounds:

Will post if I find a way to make the oops go away.






