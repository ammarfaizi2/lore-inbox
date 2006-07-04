Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750946AbWGDGSZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750946AbWGDGSZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 02:18:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751088AbWGDGSZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 02:18:25 -0400
Received: from neo-u2.ops-netman.net ([63.95.249.169]:48859 "EHLO
	neo-u2.ops-netman.net") by vger.kernel.org with ESMTP
	id S1750946AbWGDGSY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 02:18:24 -0400
Date: Tue, 4 Jul 2006 06:18:21 +0000 (GMT)
From: morrowc+kernel@ops-netman.net
X-X-Sender: morrowc@neo-u2.ops-netman.net
To: Willy Tarreau <w@1wt.eu>
Cc: morrowc+kernel@ops-netman.net, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: crashes of 2.4.31hf2.6  kernel (oops included)
In-Reply-To: <20060704040953.GA2037@1wt.eu>
Message-ID: <Pine.LNX.4.61.0607040615090.23681@arb-h2.bcf-argzna.arg>
References: <Pine.LNX.4.61.0607040139320.13542@arb-h2.bcf-argzna.arg>
 <20060704040953.GA2037@1wt.eu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 4 Jul 2006, Willy Tarreau wrote:

> On Tue, Jul 04, 2006 at 02:22:00AM +0000, morrowc+kernel@ops-netman.net wrote:
>>
>> I applied the HF2.6 patch to a current 2.4.31 kernel source tree,
>> re-built/re-installed and recieve some 'new' errors... Below is the
>> standard (from: http://kernel.org/pub/linux/docs/lkml/reporting-bugs.html)
>> form + oops output. Hopefully this isn't a 'new' problem, though i'd
>> rather like to not upgrade this box to 2.6 if possible (yet).
>>
>> To: linux-kernel@vger.kernel.org
>> From: morrowc+kernel@ops-netman.net
>> Subject: PROBLEM: crashes of 2.4.31 kernel (oops included)
>>
>>
>>> From URL - http://kernel.org/pub/linux/docs/lkml/reporting-bugs.html
>>
>>
>> [1.] One line summary of the problem: kernel panic/oops system hangs
>> [2.] Full description of the problem/report:
>> After some random period of time (from 1 hour to several days) kernel
>> receives an 'oops' and dies. Requires power cycle to recover. I've a few
>> of the 'oops' output saved and converted with ksymoops if required
>> (included one below) Error looks like it might be the ethernet driver
>> or perhaps the tcp connection maintenance...
>
> Do all the oops report a crash in tcp_synack_timer() ? This one got a
> wrong pointer for the call to req->class->rtx_syn_ack(). This really
> smells like memory corruption. Have you tried memtest86 on your box ?
> If not, could you let it run for a while (a whole night or at least
> one hour) ?

a previous good oops/ksymoops output: (a double oops it seems, 2 oops 
outputs)

more output-ksymoops-06-29-02
ksymoops 2.4.9 on i686 2.4.31.  Options used
      -v /usr/src/linux-2.4.31/vmlinux (specified)
      -k /proc/ksyms (default)
      -l /proc/modules (default)
      -o /lib/modules/2.4.31/ (default)
      -m /boot/System.map-2.4.31 (default)

Error (regular_file): read_system_map stat /boot/System.map-2.4.31 failed
Unable to handle kernel NULL pointer dereference at virtual address 
00000005
c01f4126
c0e1axf3: c800b
0000*p01de   = e b00x:00 0e0c0e01b
esi: 00000202   edi: 00000020   ebp: e1c5e080   esp: d684d940
ds: 0018   es: 0018   ss: 0018
Process cleanup (pid: 30702, stackpage=d684d000)
Stack: e1582700 d647bd20 e1c5e080 efdcf000 00000020 efcfa400 c0268201 
e1c5e080
        00000020 c030ebfc e1c5e080 c030ec0c c02bcdc4 e1c5e080 00000008 
c030ebe0
        c01f8a29 e1c5e080 efdcf000 efd766e8 efdcf000 c030ebec 00000000 
c01f8b0d
Call Trace:    [<c0268201>] [<c01f8a29>] [<c01f8b0d>] [<c01f8c85>] 
[<c011ee66>]
   [<c010af26>] [<c010d5c8>] [<c0180402>] [<c016a422>] [<c016d800>] 
[<c0116ac1>]
   [<c0116ac1>] [<c0176ce5>] [<c01767ec>] [<c0178f1d>] [<c0179263>] 
[<c016dbf8>]
   [<c0179453>] [<c0184e0f>] [<c018541e>] [<c0173fc1>] [<c018ba95>] 
[<c0175482>]
   [<c018bd5d>] [<c013fe12>] [<c013e6bf>] [<c013e766>] [<c0108efb>]
Code: 89 50 04 89 81 20 4f 34 c0 c7 43 04 00 00 00 00 c7 03 00 00
Using defaults from ksymoops -t elf32-i386 -a i386


>>ebp; e1c5e080 <_end+21915ae0/307f8ac0>
>>esp; d684d940 <_end+165053a0/307f8ac0>

Trace; c0268201 <packet_rcv_spkt+1f1/220>
Trace; c01f8a29 <netif_receive_skb+159/1b0>
Trace; c01f8b0d <process_backlog+8d/130>
Trace; c01f8c85 <net_rx_action+d5/180>
Trace; c011ee66 <do_softirq+d6/e0>
Trace; c010af26 <do_IRQ+e6/f0>
Trace; c010d5c8 <call_do_IRQ+5/d>
Trace; c0180402 <leaf_delete_items_entirely+1d2/210>
Trace; c016a422 <balance_leaf_when_delete+82/470>
Trace; c016d800 <balance_leaf+2ff0/3010>
Trace; c0116ac1 <schedule+2c1/550>
Trace; c0116ac1 <schedule+2c1/550>
Trace; c0176ce5 <is_leaf_removable+a5/140>
Trace; c01767ec <check_right+11c/140>
Trace; c0178f1d <clear_all_dirty_bits+1d/30>
Trace; c0179263 <wait_tb_buffers_until_unlocked+333/350>
Trace; c016dbf8 <do_balance+98/110>
Trace; c0179453 <fix_nodes+1d3/3f0>
Trace; c0184e0f <reiserfs_cut_from_item+19f/4a0>
Trace; c018541e <reiserfs_do_truncate+29e/570>
Trace; c0173fc1 <reiserfs_truncate_file+e1/290>
Trace; c018ba95 <journal_end+25/30>
Trace; c0175482 <reiserfs_file_release+272/490>
Trace; c018bd5d <journal_end_sync+3d/90>
Trace; c013fe12 <fput+112/140>
Trace; c013e6bf <filp_close+8f/d0>
Trace; c013e766 <sys_close+66/80>
Trace; c0108efb <system_call+33/38>

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
    0:   89 50 04                  mov    %edx,0x4(%eax)
Code;  00000003 Before first symbol
    3:   89 81 20 4f 34 c0         mov    %eax,0xc0344f20(%ecx)
Code;  00000009 Before first symbol
    9:   c7 43 04 00 00 00 00      movl   $0x0,0x4(%ebx)
Code;  00000010 Before first symbol
   10:   c7 03 00 00 00 00         movl   $0x0,(%ebx)

esi: 00000020   edi: 00000202   ebp: 00000000   esp: e9e8db40
ds: 0018   es: 0018   ss: 0018
Process trivial-rewrite (pid: 496, stackpage=e9e8d000)
Stack: 00000000 c01f3ccc efdcf180 00000020 c35e4010 c01be966 000000a7 
00000020
        efdcf000 00000095 00000000 00000001 0000003f 00000009 efdcf000 
efdcf180
        00004050 f0804000 c01be48e efdcf000 c01be33a efdcf000 00000086 
00000014
Call Trace:    [<c01f3ccc>] [<c01be966>] [<c01be48e>] [<c01be33a>] 
[<c010acb9>]
   [<c010aed8>] [<c010d5c8>] [<c01a96d9>] [<c01aeba1>] [<c011a212>] 
[<c011a305>]
   [<c011a653>] [<c011a57f>] [<c0115680>] [<c01158b6>] [<c0202e56>] 
[<c01f839f>]
   [<c023614c>] [<c02360a0>] [<c02360a0>] [<c0202483>] [<c02360a0>] 
[<c0115680>]
   [<c0108fec>] [<f0b60e60>] [<f0b610cf>] [<f0b656c0>] [<f0b6114d>] 
[<f0b61ed8>]
   [<c02361c0>] [<c0231b20>] [<c0202074>] [<c0231b20>] [<c0231b20>] 
[<c020241b>]
   [<c0231b20>] [<f0b64ec0>] [<c023194d>] [<c0231b20>] [<c01f89b4>] 
[<c01f8b0d>]
   [<c01f8c85>] [<c011ee66>] [<c010af26>] [<c010d5c8>] [<c014f743>] 
[<c011e54b>]
   [<c0108efb>]
Code: 89 50 04 89 81 20 4f 34 c0 c7 43 04 00 00 00 00 c7 03 00 00


>>esp; e9e8db40 <_end+29b455a0/307f8ac0>

Trace; c01f3ccc <alloc_skb+cc/1e0>
Trace; c01be966 <speedo_rx+276/390>
Trace; c01be48e <speedo_interrupt+1de/220>
Trace; c01be33a <speedo_interrupt+8a/220>
Trace; c010acb9 <handle_IRQ_event+79/b0>
Trace; c010aed8 <do_IRQ+98/f0>
Trace; c010d5c8 <call_do_IRQ+5/d>
Trace; c01a96d9 <serial_in+19/30>
Trace; c01aeba1 <serial_console_write+81/220>
Trace; c011a212 <__call_console_drivers+62/70>
Trace; c011a305 <call_console_drivers+65/120>
Trace; c011a653 <release_console_sem+53/b0>
Trace; c011a57f <printk+14f/180>
Trace; c0115680 <do_page_fault+0/575>
Trace; c01158b6 <do_page_fault+236/575>
Trace; c0202e56 <qdisc_restart+16/1a0>
Trace; c01f839f <dev_queue_xmit+23f/330>
Trace; c023614c <ip_finish_output2+ac/120>
Trace; c02360a0 <ip_finish_output2+0/120>
Trace; c02360a0 <ip_finish_output2+0/120>
Trace; c0202483 <nf_hook_slow+133/210>
Trace; c02360a0 <ip_finish_output2+0/120>
Trace; c0115680 <do_page_fault+0/575>
Trace; c0108fec <error_code+34/3c>
Trace; f0b60e60 <[ip_conntrack]destroy_conntrack+0/180>
Trace; f0b610cf <[ip_conntrack]__ip_conntrack_find+4f/90>
Trace; f0b656c0 <[ip_conntrack]ip_conntrack_protocol_udp+0/40>
Trace; f0b6114d <[ip_conntrack]ip_conntrack_find_get+3d/90>
Trace; f0b61ed8 <[ip_conntrack]ip_conntrack_in+1d8/2b0>
Trace; c02361c0 <ip_queue_xmit2+0/239>
Trace; c0231b20 <ip_rcv_finish+0/23f>
Trace; c0202074 <nf_iterate+54/a0>
Trace; c0231b20 <ip_rcv_finish+0/23f>
Trace; c0231b20 <ip_rcv_finish+0/23f>
Trace; c020241b <nf_hook_slow+cb/210>
Trace; c0231b20 <ip_rcv_finish+0/23f>
Trace; f0b64ec0 <[ip_conntrack]ip_conntrack_in_ops+0/0>
Trace; c023194d <ip_rcv+3dd/440>
Trace; c0231b20 <ip_rcv_finish+0/23f>
Trace; c01f89b4 <netif_receive_skb+e4/1b0>
Trace; c01f8b0d <process_backlog+8d/130>
Trace; c01f8c85 <net_rx_action+d5/180>
Trace; c011ee66 <do_softirq+d6/e0>
Trace; c010af26 <do_IRQ+e6/f0>
Trace; c010d5c8 <call_do_IRQ+5/d>
Trace; c014f743 <.text.lock.ioctl+0/2d>
Trace; c011e54b <sys_time+1b/60>
Trace; c0108efb <system_call+33/38>

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
    0:   89 50 04                  mov    %edx,0x4(%eax)
Code;  00000003 Before first symbol
    3:   89 81 20 4f 34 c0         mov    %eax,0xc0344f20(%ecx)
Code;  00000009 Before first symbol
    9:   c7 43 04 00 00 00 00      movl   $0x0,0x4(%ebx)
Code;  00000010 Before first symbol
   10:   c7 03 00 00 00 00         movl   $0x0,(%ebx)


1 error issued.  Results may not be reliable.


One looks like network-based, one like a reiserfs problem :(

I can attempt the memtest86 for an hour or so perhaps early tomorrow 
morning while everyone sleeps.


>
> Also, I see that you're using the eepro100 driver. Nothing wrong with
> it, but could you retry with the e100 driver ? It would help us eliminate
> a variable in the diag.
>

I can try the e100 driver instead, I'll switch to that after the memtest 
runs for a bit.

>> [3.] Keywords (i.e., modules, networking, kernel):
>> networking kernel oops
>> [4.] Kernel version (from /proc/version):
>> Linux version 2.4.31 (root@neo-u2.ops-netman.net) (gcc version 3.3.5
>> (Debian 1:3.3.5-13)) #2 SMP Tue Jun 27 00:59:16 GMT 2006
>>
>> (actually 2.4.21HF2.6 patch applied)
>>
>> [5.] Output of Oops.. message (if applicable) with symbolic information
>>       resolved (see Documentation/oops-tracing.txt)
>>
>> ksymoops 2.4.9 on i686 2.4.31.  Options used
>>      -v /usr/src/linux-2.4.31/vmlinux (specified)
>>      -k /proc/ksyms (default)
>>      -l /proc/modules (default)
>>      -o /lib/modules/2.4.31/ (default)
>>      -m /usr/src/linux-2.4.31/System.map (specified)
>>
>> Unable to handle kernel paging request at virtual address 08040124
>> c024b03f
>> *pde = 20528067
>> Oops: 0000
>> CPU:    1
>> EIP:    0010:[<c024b03f>]    Not tainted
>> Using defaults from ksymoops -t elf32-i386 -a i386
>> EFLAGS: 00010246
>> eax: 08040120   ebx: e9850b00   ecx: 00000000   edx: ec606c00
>> esi: ee3c2500   edi: ee3c2000   ebp: ec606d3c   esp: dcfbb95c
>> ds: 0018   es: 0018   ss: 0018
>> Process cleanup (pid: 10270, stackpage=dcfbb000)
>> Stack: ec606c00 e9850b00 00000000 00000011 0000013b 01e761f0 00000005
>> 00000005
>>        ec606c00 c024b200 ec606d3c 00000001 c024b4b6 ec606c00 c32de800
>>        dcfbb9a4
>>        ec606c00 c024b200 00000020 c012310e ec606c00 00000000 ec606bc0
>>        d37fdf04 Call Trace:    [<c024b200>] [<c024b4b6>] [<c024b200>] [<c012310e>]
>> [<c011f205>]
>>   [<c011f0b3>] [<c011ee66>] [<c010af26>] [<c010d5c8>] [<c0180309>]
>>   [<c016a422>]
>>   [<c016d800>] [<c0116ac1>] [<c0116ac1>] [<c0177702>] [<c0176d3e>]
>>   [<c0178f1d>]
>>   [<c01790dd>] [<c016dbf8>] [<c0179453>] [<c0184e0f>] [<c018541e>]
>>   [<c0173fc1>]
>>   [<c018ba95>] [<c0175482>] [<c018bd5d>] [<c018c5ee>] [<c0140f0e>]
>>   [<c013fe12>]
>>   [<c013e6bf>] [<c013e766>] [<c0108efb>]
>> Code: ff 50 04 85 c0 0f 85 8b 00 00 00 0f b6 43 10 fe c0 88 43 10
>>
>>
>>>> EIP; c024b03f <tcp_synack_timer+ff/1f0>   <=====
>>
>>>> ebx; e9850b00 <_end+29508560/307f8ac0>
>>>> edx; ec606c00 <_end+2c2be660/307f8ac0>
>>>> esi; ee3c2500 <_end+2e079f60/307f8ac0>
>>>> edi; ee3c2000 <_end+2e079a60/307f8ac0>
>>>> ebp; ec606d3c <_end+2c2be79c/307f8ac0>
>>>> esp; dcfbb95c <_end+1cc733bc/307f8ac0>
>>
>> Trace; c024b200 <tcp_keepalive_timer+0/2ce>
>> Trace; c024b4b6 <tcp_keepalive_timer+2b6/2ce>
>> Trace; c024b200 <tcp_keepalive_timer+0/2ce>
>> Trace; c012310e <timer_bh+1be/3f0>
>> Trace; c011f205 <bh_action+45/70>
>> Trace; c011f0b3 <tasklet_hi_action+63/b0>
>> Trace; c011ee66 <do_softirq+d6/e0>
>> Trace; c010af26 <do_IRQ+e6/f0>
>> Trace; c010d5c8 <call_do_IRQ+5/d>
>> Trace; c0180309 <leaf_delete_items_entirely+d9/210>
>> Trace; c016a422 <balance_leaf_when_delete+82/470>
>> Trace; c016d800 <balance_leaf+2ff0/3010>
>> Trace; c0116ac1 <schedule+2c1/550>
>> Trace; c0116ac1 <schedule+2c1/550>
>> Trace; c0177702 <get_parents+d2/190>
>> Trace; c0176d3e <is_leaf_removable+fe/140>
>> Trace; c0178f1d <clear_all_dirty_bits+1d/30>
>> Trace; c01790dd <wait_tb_buffers_until_unlocked+1ad/350>
>> Trace; c016dbf8 <do_balance+98/110>
>> Trace; c0179453 <fix_nodes+1d3/3f0>
>> Trace; c0184e0f <reiserfs_cut_from_item+19f/4a0>
>> Trace; c018541e <reiserfs_do_truncate+29e/570>
>> Trace; c0173fc1 <reiserfs_truncate_file+e1/290>
>> Trace; c018ba95 <journal_end+25/30>
>> Trace; c0175482 <reiserfs_file_release+272/490>
>> Trace; c018bd5d <journal_end_sync+3d/90>
>> Trace; c018c5ee <__commit_trans_index+8e/90>
>> Trace; c0140f0e <fsync_buffers_list+ce/1b0>
>> Trace; c013fe12 <fput+112/140>
>> Trace; c013e6bf <filp_close+8f/d0>
>> Trace; c013e766 <sys_close+66/80>
>> Trace; c0108efb <system_call+33/38>
>>
>> Code;  c024b03f <tcp_synack_timer+ff/1f0>
>> 00000000 <_EIP>:
>> Code;  c024b03f <tcp_synack_timer+ff/1f0>   <=====
>>    0:   ff 50 04                  call   *0x4(%eax)   <=====
>> Code;  c024b042 <tcp_synack_timer+102/1f0>
>>    3:   85 c0                     test   %eax,%eax
>> Code;  c024b044 <tcp_synack_timer+104/1f0>
>>    5:   0f 85 8b 00 00 00         jne    96 <_EIP+0x96>
>> Code;  c024b04a <tcp_synack_timer+10a/1f0>
>>    b:   0f b6 43 10               movzbl 0x10(%ebx),%eax
>> Code;  c024b04e <tcp_synack_timer+10e/1f0>
>>    f:   fe c0                     inc    %al
>> Code;  c024b050 <tcp_synack_timer+110/1f0>
>>   11:   88 43 10                  mov    %al,0x10(%ebx)
>>
>>  <0>Kernel panic: Aiee, killing interrupt handler!
>>
>>
>> [6.] A small shell script or example program which triggers the
>>       problem (if possible)
>>
>> N/A
>>
>> [7.] Environment
>> [7.1.] Software (add the output of the ver_linux script here)
>>
>> # sh ./scripts/ver_linux
>> If some fields are empty or look unusual you may have an old version.
>> Compare to the current minimal requirements in Documentation/Changes.
>>
>> Linux neo-u2.ops-netman.net 2.4.31 #2 SMP Tue Jun 27 00:59:16 GMT 2006 i686
>> GNU/Linux
>>
>> Gnu C                  3.3.5
>> Gnu make               3.80
>> binutils               2.15
>> util-linux             2.12p
>> mount                  2.12p
>> modutils               2.4.26
>> e2fsprogs              1.37
>> PPP                    2.4.3
>> Linux C Library        2.3.2
>> Dynamic linker (ldd)   2.3.2
>> Procps                 3.2.1
>> Net-tools              1.60
>> Console-tools          0.2.3
>> Sh-utils               5.2.1
>> Modules Loaded         sd_mod scsi_mod ipt_LOG ipt_REJECT ipt_state
>> ip_conntrack iptable_filter ip_tables ip6t_LOG ip6table_filter ip6_tables
>>
>>
>> [7.2.] Processor information (from /proc/cpuinfo):
>>
>> # cat /proc/cpuinfo
>> processor       : 0
>> vendor_id       : GenuineIntel
>> cpu family      : 6
>> model           : 8
>> model name      : Pentium III (Coppermine)
>> stepping        : 3
>> cpu MHz         : 596.007
>> cache size      : 256 KB
>> fdiv_bug        : no
>> hlt_bug         : no
>> f00f_bug        : no
>> coma_bug        : no
>> fpu             : yes
>> fpu_exception   : yes
>> cpuid level     : 2
>> wp              : yes
>> flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
>> cmov pat pse36 mmx fxsr sse
>> bogomips        : 1189.47
>>
>> processor       : 1
>> vendor_id       : GenuineIntel
>> cpu family      : 6
>> model           : 8
>> model name      : Pentium III (Coppermine)
>> stepping        : 3
>> cpu MHz         : 596.007
>> cache size      : 256 KB
>> fdiv_bug        : no
>> hlt_bug         : no
>> f00f_bug        : no
>> coma_bug        : no
>> fpu             : yes
>> fpu_exception   : yes
>> cpuid level     : 2
>> wp              : yes
>> flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
>> cmov pat pse36 mmx fxsr sse
>> bogomips        : 1189.47
>>
>>
>>
>> [7.3.] Module information (from /proc/modules):
>> # cat /proc/modules
>> sd_mod                 10892   0 (autoclean) (unused)
>> scsi_mod               91636   1 (autoclean) [sd_mod]
>> ipt_LOG                 3544   1 (autoclean)
>> ipt_REJECT              3384   1 (autoclean)
>> ipt_state                536   2 (autoclean)
>> ip_conntrack           22432   0 (autoclean) [ipt_state]
>> iptable_filter          1740   1 (autoclean)
>> ip_tables              12960   4 [ipt_LOG ipt_REJECT ipt_state
>> iptable_filter]
>> ip6t_LOG                4312   1 (autoclean)
>> ip6table_filter         1836   1 (autoclean)
>> ip6_tables             13600   2 [ip6t_LOG ip6table_filter]
>>
>>
>> [7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
>>
>> # cat /proc/ioports
>> 0000-001f : dma1
>> 0020-003f : pic1
>> 0040-0043 : timer0
>> 0050-0053 : timer1
>> 0060-006f : keyboard
>> 0080-008f : dma page reg
>> 00a0-00bf : pic2
>> 00c0-00df : dma2
>> 00f0-00ff : fpu
>> 0170-0177 : ide1
>> 01f0-01f7 : ide0
>> 02f8-02ff : serial(set)
>> 0376-0376 : ide1
>> 03c0-03df : vga+
>> 03f6-03f6 : ide0
>> 03f8-03ff : serial(set)
>> 0400-043f : Intel Corp. 82371AB/EB/MB PIIX4 ACPI
>> 0440-045f : Intel Corp. 82371AB/EB/MB PIIX4 ACPI
>> 0cf8-0cff : PCI conf1
>> c000-cfff : PCI Bus #01
>> d000-dfff : PCI Bus #02
>>   df00-df3f : Intel Corp. 82557/8/9 [Ethernet Pro 100] (#3)
>>     df00-df3f : eepro100
>> ee80-eebf : Intel Corp. 82557/8/9 [Ethernet Pro 100] (#2)
>>   ee80-eebf : eepro100
>> ef00-ef3f : Intel Corp. 82557/8/9 [Ethernet Pro 100]
>>   ef00-ef3f : eepro100
>> ef80-ef9f : Intel Corp. 82371AB/EB/MB PIIX4 USB
>> ffa0-ffaf : Intel Corp. 82371AB/EB/MB PIIX4 IDE
>>   ffa0-ffa7 : ide0
>>   ffa8-ffaf : ide1
>>
>> # cat /proc/iomem
>> 00000000-0009fbff : System RAM
>> 0009fc00-0009ffff : reserved
>> 000a0000-000bffff : Video RAM area
>> 000c0000-000c7fff : Video ROM
>> 000c9800-000ca7ff : Extension ROM
>> 000f0000-000fffff : System ROM
>> 00100000-2fffffff : System RAM
>>   00100000-0026e798 : Kernel code
>>   0026e799-002bf19f : Kernel data
>> fbd00000-fddfffff : PCI Bus #01
>>   fc000000-fcffffff : Chips and Technologies F69000 HiQVideo
>> fde00000-fe2fffff : PCI Bus #02
>>   fe100000-fe1fffff : Intel Corp. 82557/8/9 [Ethernet Pro 100] (#3)
>>   fe2ff000-fe2fffff : Intel Corp. 82557/8/9 [Ethernet Pro 100] (#3)
>>     fe2ff000-fe2fffff : eepro100
>> fe800000-fe8fffff : Intel Corp. 82557/8/9 [Ethernet Pro 100] (#2)
>> fea00000-feafffff : Intel Corp. 82557/8/9 [Ethernet Pro 100]
>> febfe000-febfefff : Intel Corp. 82557/8/9 [Ethernet Pro 100] (#2)
>>   febfe000-febfefff : eepro100
>> febff000-febfffff : Intel Corp. 82557/8/9 [Ethernet Pro 100]
>>   febff000-febfffff : eepro100
>> fec00000-fec00fff : reserved
>> fee00000-fee00fff : reserved
>> ff000000-ff0fffff : PCI Bus #01
>> ff100000-ff1fffff : PCI Bus #02
>> ff400000-ff7fffff : Intel Corp. 440GX - 82443GX Host bridge
>> fffc0000-ffffffff : reserved
>>
>>
>>
>> [7.5.] PCI information ('lspci -vvv' as root)
>> # lspci -vvv
>> 0000:00:00.0 Host bridge: Intel Corp. 440GX - 82443GX Host bridge
>>         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+
>>         Stepping- SERR+ FastB2B-
>>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
>>         <TAbort- <MAbort+ >SERR- <PERR-
>>         Latency: 64
>>         Region 0: Memory at ff400000 (32-bit, prefetchable) [size=4M]
>>         Capabilities: [a0] AGP version 1.0
>>                 Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64-
>>                 HTrans- 64bit- FW- AGP3- Rate=x1,x2
>>                 Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW-
>>                 Rate=<none>
>>
>> 0000:00:01.0 PCI bridge: Intel Corp. 440GX - 82443GX AGP bridge (prog-if 00
>> [Normal decode])
>>         Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV+ VGASnoop- ParErr-
>>         Stepping- SERR- FastB2B-
>>         Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
>>         <TAbort- <MAbort- >SERR- <PERR-
>>         Latency: 64
>>         Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
>>         I/O behind bridge: 0000c000-0000cfff
>>         Memory behind bridge: fbd00000-fddfffff
>>         Prefetchable memory behind bridge: ff000000-ff0fffff
>>         BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B+
>>
>> 0000:00:07.0 ISA bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 02)
>>         Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr-
>>         Stepping- SERR- FastB2B-
>>         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
>>         <TAbort- <MAbort- >SERR- <PERR-
>>         Latency: 0
>>
>> 0000:00:07.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01)
>> (prog-if 80 [Master])
>>         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
>>         Stepping- SERR- FastB2B-
>>         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
>>         <TAbort- <MAbort- >SERR- <PERR-
>>         Latency: 64
>>         Region 4: I/O ports at ffa0 [size=16]
>>
>> 0000:00:07.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01)
>> (prog-if 00 [UHCI])
>>         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
>>         Stepping- SERR- FastB2B-
>>         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
>>         <TAbort- <MAbort- >SERR- <PERR-
>>         Latency: 64
>>         Interrupt: pin D routed to IRQ 0
>>         Region 4: I/O ports at ef80 [size=32]
>>
>> 0000:00:07.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 02)
>>         Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
>>         Stepping- SERR- FastB2B-
>>         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
>>         <TAbort- <MAbort- >SERR- <PERR-
>>         Interrupt: pin ? routed to IRQ 9
>>
>> 0000:00:11.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100]
>> (rev 08)
>>         Subsystem: Intel Corp. 82559 Fast Ethernet LAN on Motherboard
>>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
>>         Stepping- SERR+ FastB2B-
>>         Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
>>         <TAbort- <MAbort- >SERR- <PERR-
>>         Latency: 64 (2000ns min, 14000ns max), Cache Line Size: 0x08 (32
>>         bytes)
>>         Interrupt: pin A routed to IRQ 11
>>         Region 0: Memory at febff000 (32-bit, non-prefetchable) [size=4K]
>>         Region 1: I/O ports at ef00 [size=64]
>>         Region 2: Memory at fea00000 (32-bit, non-prefetchable) [size=1M]
>>         Expansion ROM at fe900000 [disabled] [size=1M]
>>         Capabilities: [dc] Power Management version 2
>>                 Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
>>                 PME(D0+,D1+,D2+,D3hot+,D3cold-)
>>                 Status: D0 PME-Enable- DSel=0 DScale=2 PME-
>>
>> 0000:00:12.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100]
>> (rev 08)
>>         Subsystem: Intel Corp. 82559 Fast Ethernet LAN on Motherboard
>>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
>>         Stepping- SERR+ FastB2B-
>>         Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
>>         <TAbort- <MAbort- >SERR- <PERR-
>>         Latency: 64 (2000ns min, 14000ns max), Cache Line Size: 0x08 (32
>>         bytes)
>>         Interrupt: pin A routed to IRQ 10
>>         Region 0: Memory at febfe000 (32-bit, non-prefetchable) [size=4K]
>>         Region 1: I/O ports at ee80 [size=64]
>>         Region 2: Memory at fe800000 (32-bit, non-prefetchable) [size=1M]
>>         Expansion ROM at fe700000 [disabled] [size=1M]
>>         Capabilities: [dc] Power Management version 2
>>                 Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
>>                 PME(D0+,D1+,D2+,D3hot+,D3cold-)
>>                 Status: D0 PME-Enable- DSel=0 DScale=2 PME-
>>
>> 0000:00:14.0 PCI bridge: Digital Equipment Corporation DECchip 21152 (rev
>> 03) (prog-if 00 [Normal decode])
>>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
>>         Stepping- SERR+ FastB2B-
>>         Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
>>         <TAbort- <MAbort- >SERR- <PERR-
>>         Latency: 64, Cache Line Size: 0x08 (32 bytes)
>>         Bus: primary=00, secondary=02, subordinate=02, sec-latency=64
>>         I/O behind bridge: 0000d000-0000dfff
>>         Memory behind bridge: fde00000-fe2fffff
>>         Prefetchable memory behind bridge: 00000000ff100000-00000000ff100000
>>         BridgeCtl: Parity+ SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
>>         Capabilities: [dc] Power Management version 1
>>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=220mA
>>                 PME(D0-,D1-,D2-,D3hot-,D3cold-)
>>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>>                 Bridge: PM- B3+
>>
>> 0000:01:00.0 VGA compatible controller: Chips and Technologies F69000
>> HiQVideo (rev 64) (prog-if 00 [VGA])
>>         Subsystem: Chips and Technologies F69000 HiQVideo
>>         Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
>>         Stepping+ SERR+ FastB2B-
>>         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
>>         <TAbort- <MAbort- >SERR- <PERR-
>>         Interrupt: pin A routed to IRQ 0
>>         Region 0: Memory at fc000000 (32-bit, non-prefetchable) [size=16M]
>>         Expansion ROM at fddc0000 [disabled] [size=256K]
>>
>> 0000:02:0e.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100]
>> (rev 08)
>>         Subsystem: Intel Corp. EtherExpress PRO/100+ Management Adapter
>>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
>>         Stepping- SERR+ FastB2B-
>>         Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
>>         <TAbort- <MAbort- >SERR- <PERR-
>>         Latency: 64 (2000ns min, 14000ns max), Cache Line Size: 0x08 (32
>>         bytes)
>>         Interrupt: pin A routed to IRQ 10
>>         Region 0: Memory at fe2ff000 (32-bit, non-prefetchable) [size=4K]
>>         Region 1: I/O ports at df00 [size=64]
>>         Region 2: Memory at fe100000 (32-bit, non-prefetchable) [size=1M]
>>         Expansion ROM at fe000000 [disabled] [size=1M]
>>         Capabilities: [dc] Power Management version 2
>>                 Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
>>                 PME(D0+,D1+,D2+,D3hot+,D3cold-)
>>                 Status: D0 PME-Enable- DSel=0 DScale=2 PME-
>>
>>
>>
>> [7.6.] SCSI information (from /proc/scsi/scsi)
>>
>> # cat /proc/scsi/scsi
>> Attached devices: none
>>
>>
>> [7.7.] Other information that might be relevant to the problem
>>         (please look in /proc and include all information that you
>>         think to be relevant):
>> [X.] Other notes, patches, fixes, workarounds:
>>
>>
>> If more info is required I believe I can provide it if requested. Thanks!
>
> Regards,
> Willy
>
