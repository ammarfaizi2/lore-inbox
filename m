Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964812AbWHCPml@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964812AbWHCPml (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 11:42:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964802AbWHCPmk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 11:42:40 -0400
Received: from web51002.mail.yahoo.com ([206.190.38.133]:12408 "HELO
	web51002.mail.yahoo.com") by vger.kernel.org with SMTP
	id S964814AbWHCPmi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 11:42:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=jcBm75S71B3SfWkQqAGZYwS8xsTdutafUWvkVZC8ueF7D0sqWi2myPZxJdWtWphPiSRKi7yTdBdwpjDMkONDjvSeibspdCEp4DYo+KDrh/UPAeEvk/j2OmXK9VAbN12EcTgAfmhOSmcHToN/KRL8ZuzBBmp3hQSQB36UFIDQB5Y=  ;
Message-ID: <20060803154237.12936.qmail@web51002.mail.yahoo.com>
Date: Thu, 3 Aug 2006 08:42:37 -0700 (PDT)
From: Richard Mollel <unixtipz@yahoo.com>
Subject: Kernel Hangs, EIP is at scsi_decide_disposition
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1608146152-1154619757=:12163"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0-1608146152-1154619757=:12163
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

Our mandriva boxes are randomly crushing after
migration to 2006.0 download version. The same
hardware has had mandriva 10.0 withuptimes of over 230
days....but nowadays it is hardly a week before a
crash for over 6 nodes with latest kernels.

I captured one of our lockups and am attaching the
output of ksymoops for further interpretation by mroe
experienced eyes when it comes to kernel internals.

Here is the actual error, and attached, the ksymoops
interpretation of it.

Unable to handle kernel NULL pointer dereference at
virtual address 000002a9
 printing eip:
f88642bd
*pde = 3702b001
Oops: 0000 [#1]
SMP
Modules linked in: sg nfsd exportfs raw md5 ipv6 nfs
lockd nfs_acl sunrpc parport_pc lp parport e1000
af_packet floppy video thermal tc1100_wmi processor
fan container button battery ac ipt_LOG ipt_REJECT
ipt_state ip_conntrack iptable_filter ip_tables ide_cd
loop hw_random 3w_9xxx tsdev sr_mod ehci_hcd uhci_hcd
usbcore evdev reiserfs sd_mod ahci ata_piix libata
scsi_mod
CPU:    0
EIP:    0060:[<f88642bd>]    Tainted: G   M  VLI
EFLAGS: 00010282   (2.6.12-22mdksmp)
EIP is at scsi_decide_disposition+0xd/0x160 [scsi_mod]
eax: c0437f2c   ebx: f7c3902c   ecx: 00000001   edx:
f7db6e18
esi: f7c3902c   edi: c0437f2c   ebp: c0437f1c   esp:
c0437f04
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, threadinfo=c0436000
task=c03d6bc0)
Stack: 00000001 00000000 00000000 00002002 f7da6680
00002002 c0437f40 f885fc71
       f7c3902c 00002002 f7db6e18 f7db6818 00000001
c04331e0 c047ef00 c0437f6c
       c0181ab2 c04331e0 0000000a 00000000 c047c380
c0436000 c047c380 00000046
Call Trace:
 [<c010426b>] show_stack+0xab/0xf0
 [<c010444f>] show_registers+0x17f/0x220
 [<c0104694>] die+0xf4/0x180
 [<c011bf71>] do_page_fault+0x261/0x793
 [<c0103e6f>] error_code+0x4f/0x54
 [<f885fc71>] scsi_softirq+0x71/0xf0 [scsi_mod]
 [<c0181ab2>] __do_softirq+0x82/0xf0
 [<c0181b57>] do_softirq+0x37/0x40
 [<c0105b11>] do_IRQ+0x21/0x30
 [<c0103d16>] common_interrupt+0x1a/0x20
 [<c010112f>] cpu_idle+0x6f/0xc0
 [<c0438a7a>] start_kernel+0x17a/0x1e0
 [<c010020f>] 0xc010020f
Code: 24 89 44 24 04 e8 f4 f2 ff ff 39 fe 8b 16 89 f0
75 a2 83 c4 14 5b 5e 5f 5d c3 8d 74 26 00 55 89 e5 53
83 ec 14 8b 5d 08 8b 4b 04 <83> b9 a8 02 00 00 06 74
2a 8b 93 4c 01 00 00 89 d0 c1 f8 10 25
 <0>Kernel panic - not syncing: Fatal exception in
interrupt


# lspci
00:00.0 Host bridge: Intel Corporation E7520 Memory
Controller Hub (rev 0c)
00:00.1 Class ff00: Intel Corporation E7525/E7520
Error Reporting Registers (rev 0c)
00:02.0 PCI bridge: Intel Corporation
E7525/E7520/E7320 PCI Express Port A (rev 0c)
00:03.0 PCI bridge: Intel Corporation
E7525/E7520/E7320 PCI Express Port A1 (rev 0c)
00:04.0 PCI bridge: Intel Corporation E7525/E7520 PCI
Express Port B (rev 0c)
00:06.0 PCI bridge: Intel Corporation E7520 PCI
Express Port C (rev 0c)
00:1d.0 USB Controller: Intel Corporation 82801EB/ER
(ICH5/ICH5R) USB UHCI Controller #1 (rev 02)
00:1d.1 USB Controller: Intel Corporation 82801EB/ER
(ICH5/ICH5R) USB UHCI Controller #2 (rev 02)
00:1d.2 USB Controller: Intel Corporation 82801EB/ER
(ICH5/ICH5R) USB UHCI Controller #3 (rev 02)
00:1d.3 USB Controller: Intel Corporation 82801EB/ER
(ICH5/ICH5R) USB UHCI Controller #4 (rev 02)
00:1d.7 USB Controller: Intel Corporation 82801EB/ER
(ICH5/ICH5R) USB2 EHCI Controller (rev 02)
00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge
(rev c2)
00:1f.0 ISA bridge: Intel Corporation 82801EB/ER
(ICH5/ICH5R) LPC Interface Bridge (rev 02)
00:1f.2 IDE interface: Intel Corporation 82801EB
(ICH5) SATA Controller (rev 02)
00:1f.3 SMBus: Intel Corporation 82801EB/ER
(ICH5/ICH5R) SMBus Controller (rev 02)
02:00.0 PCI bridge: Intel Corporation 6700PXH PCI
Express-to-PCI Bridge A (rev 09)
02:00.1 PIC: Intel Corporation 6700/6702PXH I/OxAPIC
Interrupt Controller A (rev 09)
02:00.2 PCI bridge: Intel Corporation 6700PXH PCI
Express-to-PCI Bridge B (rev 09)
02:00.3 PIC: Intel Corporation 6700PXH I/OxAPIC
Interrupt Controller B (rev 09)
03:03.0 RAID bus controller: 3ware Inc: Unknown device
1003
04:01.0 SCSI storage controller: LSI Logic / Symbios
Logic 53c1030 PCI-X Fusion-MPT Dual Ultra320 SCSI (rev
08)
04:02.0 Ethernet controller: Intel Corporation 82546GB
Gigabit Ethernet Controller (rev 03)
04:02.1 Ethernet controller: Intel Corporation 82546GB
Gigabit Ethernet Controller (rev 03)
07:01.0 VGA compatible controller: ATI Technologies
Inc Rage XL (rev 27)


#cat /etc/redhat-release
Mandriva Linux release 2006.0 (Official) for i586

Kernel::
2.6.12-22mdksmp #1 SMP Tue May 23 15:13:55 MDT 2006
i686 Intel(R) Xeon(TM) CPU 3.40GHz




DEBUG (parse): 'v'
'/usr/src/linux-2.6.12-22mdk/vmlinux'
DEBUG (parse): 'm'
'/usr/src/linux-2.6.12-22mdk/System.map'
DEBUG (convert_uname): /lib/modules/*r/ in
DEBUG (convert_uname): /lib/modules/2.6.12-22mdksmp/
out
ksymoops 2.4.9 on i686 2.6.12-22mdksmp.  Options used
     -v /usr/src/linux-2.6.12-22mdk/vmlinux
(specified)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.6.12-22mdksmp/ (default)
     -m /usr/src/linux-2.6.12-22mdk/System.map
(specified)

DEBUG (main): level 3
DEBUG (read_env): override
KSYMOOPS_NM=/usr/bin/ksymoops-gznm
DEBUG (read_env): default KSYMOOPS_FIND=/usr/bin/find
DEBUG (read_env): default
KSYMOOPS_OBJDUMP=/usr/bin/objdump
DEBUG (re_compile): '^([0-9a-fA-F]{4,}) +([^ ]) +([^
]+)( +\[([^ ]+)\])?$' 5 sub expression(s)
DEBUG (re_compile): '^ *\[*<([0-9a-fA-F]{4,})>\]* *' 1
sub expression(s)
DEBUG (re_compile): '^ *<\[([0-9a-fA-F]{4,})\]> *' 1
sub expression(s)
DEBUG (re_compile): '^ *([0-9a-fA-F]{4,}) *' 1 sub
expression(s)
DEBUG (read_nm_symbols): command
'/usr/bin/ksymoops-gznm
/usr/src/linux-2.6.12-22mdk/vmlinux'
DEBUG (re_compile): '^(.*)_R.*[0-9a-fA-F]{8,}$' 1 sub
expression(s)
DEBUG (read_nm_symbols): vmlinux used 20829 out of
23952 entries
DEBUG (ss_sort_na): vmlinux
DEBUG (ss_compress): table vmlinux, before 20829
DEBUG (ss_compress): table vmlinux, after 20829
DEBUG (ss_compress): table vmlinux, before 20829
DEBUG (ss_compress): table vmlinux, after 20829
DEBUG (add_Version): vmlinux 132620 2.6.12
DEBUG (read_ksyms): /proc/ksyms
Error (regular_file): read_ksyms stat /proc/ksyms
failed
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
DEBUG (read_system_map):
/usr/src/linux-2.6.12-22mdk/System.map
DEBUG (ss_sort_na): System.map
DEBUG (ss_compress): table System.map, before 20829
DEBUG (ss_compress): table System.map, after 20829
DEBUG (ss_compress): table System.map, before 20829
DEBUG (ss_compress): table System.map, after 20829
DEBUG (add_Version): System.map 132620 2.6.12
DEBUG (read_system_map): System.map used 20829 out of
23952 entries
DEBUG (merge_maps): 
DEBUG (ss_sort_na): Version_
DEBUG (ss_compress): table Version_, before 2
DEBUG (ss_compress): table Version_, after 2
DEBUG (ss_compress): table Version_, before 2
DEBUG (ss_compress): table Version_, after 2
DEBUG (compare_Version): Version 2.6.12
DEBUG (compare_maps): System.map vs vmlinux, vmlinux
takes precedence
DEBUG (compare_maps): vmlinux vs System.map, vmlinux
takes precedence
DEBUG (append_map): vmlinux to merged
DEBUG (append_map): System.map to merged
DEBUG (ss_sort_atn): merged
DEBUG (ss_compress): table merged, before 41658
DEBUG (ss_compress): table merged, after 41658
DEBUG (ss_sort_atn): merged
DEBUG (ss_compress): table merged, before 41658
DEBUG (ss_compress): table merged, after 20829
DEBUG (find_fullpath): /usr/bin/ksymoops.real
DEBUG (Oops_read): Unable to handle kernel NULL
pointer dereference at virtual address 000002a9
DEBUG (re_compile): '^( +|[^ ]{3} [ 0-9][0-9]
[0-9]{2}:[0-9]{2}:[0-9]{2} [^ ]+ kernel:
+|<[0-9]+>|[0-9]+\|[^|]+\|[^|]+\|[^|]+\||[0-9][AC]
[0-9]{3} [0-9]{3}[cir][0-9]{2}:\+)' 1 sub
expression(s)
DEBUG (re_compile): '^((Stack: )|(Stack from
)|([0-9a-fA-F]{4,})|(Call Trace:
*)|(\[*<([0-9a-fA-F]{4,})>\]*
*)|(Version_[0-9]+)|(Trace:)|(Call
backtrace:)|(bh:)|<\[([0-9a-fA-F]{4,})\]> *|(\([^ ]+\)
*\[*<([0-9a-fA-F]{4,})>\]* *)|([0-9]+ +base=)|(Kernel
BackChain)|EBP *EIP|0x([0-9a-fA-F]{4,})
*0x([0-9a-fA-F]{4,}) *|Process .*stackpage=|Code *:
|Kernel panic|In swapper
task|kmem_free|swapper|Pid:|r[0-9]{1,2}
*[:=]|Corrupted stack page|invalid operand: |Oops:
|Cpu:* +[0-9]|current->tss|\*pde +=|EIP: |EFLAGS:
|eax: |esi: |ds: |CR0: |wait_on_|irq: |Stack
dumps:|RAX: |RSP: |RIP: |RDX: |RBP: |FS: |CS: |CR2:
|PML4|pc[:=]|68060 access|Exception at |d[04]: |Frame
format=|wb [0-9] stat|push data: |baddr=|Arithmetic
fault|Instruction fault|Bad unaligned
kernel|Forwarding unaligned exception|: unhandled
unaligned exception|pc *=|[rvtsa][0-9]+ *=|gp
*=|spinlock stuck|tsk->|PSR: |[goli]0: |Instruction
DUMP: |spin_lock|TSTATE: |[goli]4:
|Caller\[|CPU\[|MSR: |TASK = |last math |GPR[0-9]+:
|.* in .*\.[ch]:.*, line [0-9]+:|\$[0-9 ]+:|Hi *:|Lo
*:|epc *:|badvaddr *:|Status *:|Cause
*:|Backtrace:|Function entered at|\*pgd =|Internal
error|pc :|sp
:|Flags:|Control:|WARNING:|this_stack:|i:|PSW|cr[0-9]+:|machine
check|Exception in |Program Check |System restart
|IUCV |unexpected external |Kernel stack |User process
fault:|failing address|User PSW|User GPRS|User
ACRS|Kernel PSW|Kernel GPRS|Kernel ACRS|illegal
operation|task:|Entering kdb|eax *=|esi *=|ebp *=|ds
*=|psr |unat  |rnat |ldrs |xip |iip |ipsr |ifa |pr
|itc |ifs |bsp |[bfr][0-9]+ |irr[0-9] |General
Exception|MCA|SAL|Processor State|Bank [0-9]+|Register
Stack|Processor Error Info|proc err map|proc state
param|proc lid|processor structure|check info|target
identifier|IRP *: )' 18 sub expression(s)
DEBUG (re_compile): 'Unable to handle
kernel|Aiee|die_if_kernel|NMI |BUG
|\(L-TLB\)|\(NOTLB\)|\([0-9]\): Oops |: memory
violation|: Exception at|: Arithmetic fault|:
Instruction fault|: arithmetic trap|: unaligned
trap|\([0-9]+\):
(Whee|Oops|Kernel|.*Penguin|BOGUS)|kernel pc |trap at
PC: |bad area pc |NIP: | ra *==' 1 sub expression(s)
DEBUG (re_compile): '^(i[04]: |Instruction DUMP:
|Caller\[)' 1 sub expression(s)
Unable to handle kernel NULL pointer dereference at
virtual address 000002a9
DEBUG (re_compile): '^PSR: [0-9a-fA-F]+ PC:
([0-9a-fA-F]{4,}) *' 1 sub expression(s)
DEBUG (re_compile): '^TSTATE: [0-9a-fA-F]{16} TPC:
([0-9a-fA-F]{4,}) *' 1 sub expression(s)
DEBUG (re_compile): '(kernel pc |trap at PC: |bad area
pc |NIP: )([0-9a-fA-F]{4,}) *' 2 sub expression(s)
DEBUG (re_compile): '^epc *:+ *([0-9a-fA-F]{4,}) *' 1
sub expression(s)
DEBUG (re_compile): ' ip *:+
*\[*<([0-9a-fA-F]{4,})>\]* *' 1 sub expression(s)
DEBUG (re_compile): '[xi]ip *\([^)]*\) *:
*0x([0-9a-fA-F]{4,}) *' 1 sub expression(s)
DEBUG (re_compile): '(^0x([0-9a-fA-F]{4,})
*0x([0-9a-fA-F]{4,}) *.*+0x)|(^Entering kdb on
processor.*0x([0-9a-fA-F]{4,}) *)' 5 sub expression(s)
DEBUG (re_compile): '^ *IRP *: *([0-9a-fA-F]{4,}) *' 1
sub expression(s)
DEBUG (re_compile): '^(EIP: +.*|RIP: +.*|PC *= *|pc *:
*)\[*<([0-9a-fA-F]{4,})>\]* *' 2 sub expression(s)
DEBUG (re_compile): '^spinlock stuck at
([0-9a-fA-F]{4,}) *.*owner.*at ([0-9a-fA-F]{4,}) *' 2
sub expression(s)
DEBUG (re_compile): '^spin_lock[^
]*\(([0-9a-fA-F]{4,}) *.*stuck at *([0-9a-fA-F]{4,})
*.*PC\(([0-9a-fA-F]{4,}) *' 3 sub expression(s)
DEBUG (re_compile): 'ra *=+ *([0-9a-fA-F]{4,}) *' 1
sub expression(s)
DEBUG (re_compile): '^(\$[0-9]{1,2}) *:
*([0-9a-fA-F]{4,}) *' 2 sub expression(s)
DEBUG (re_compile): '^(GPR[0-9]{1,2}) *:
*([0-9a-fA-F]{4,}) *' 2 sub expression(s)
DEBUG (re_compile): '^PSW *flags: *([0-9a-fA-F]{4,}) *
*PSW addr: *([0-9a-fA-F]{4,}) *' 2 sub expression(s)
DEBUG (re_compile): '^Kernel PSW: *([0-9a-fA-F]{4,})
*([0-9a-fA-F]{4,}) *' 2 sub expression(s)
DEBUG (re_compile): '^((Call Trace:
*)|(Trace:)|(\[*<([0-9a-fA-F]{4,})>\]* *)|(Call
backtrace:)|([0-9a-fA-F]{4,}) *|Function entered at
(\[*<([0-9a-fA-F]{4,})>\]*
*)|Caller\[([0-9a-fA-F]{4,})
*\]|(<\[([0-9a-fA-F]{4,})\]> *)|(\([0-9]+\)
*(\[*<([0-9a-fA-F]{4,})>\]* *))|([0-9]+
+base=0x([0-9a-fA-F]{4,}) *)|(Kernel BackChain.*))' 18
sub expression(s)
DEBUG (re_compile):
'^((GP|o)?r[0-9]{1,2}|[goli][0-9]{1,2}|[eR][ABCD]X|[eR][DS]I|RBP|e[bs]p|[fsi]p|IRP|SRP|D?CCR|USP|MOF|ret_pc)
*[:=] *([0-9a-fA-F]{4,}) * *' 3 sub expression(s)
DEBUG (re_compile): '^(Kernel GPRS.*)' 1 sub
expression(s)
DEBUG (re_compile): '^(IRP|SRP|D?CCR|USP|MOF):
*([0-9a-fA-F]{4,}) *' 2 sub expression(s)
DEBUG (re_compile): '^b[0-7] *(\([^)]*\) *)?:
*(0x)?([0-9a-fA-F]{4,}) *' 3 sub expression(s)
DEBUG (re_compile): '^([^ ]+) +[^ ] *([^
]+).*\((L-TLB|NOTLB)\)' 3 sub expression(s)
DEBUG (re_compile): '^((Instruction DUMP)|(Code:? *)):
+((general protection.*)|(Bad E?IP
value.*)|(<[0-9]+>)|(([<(]?[0-9a-fA-F]+[>)]?
+)+[<(]?[0-9a-fA-F]+[>)]?))(.*)$' 10 sub expression(s)
DEBUG (Oops_read):  printing eip:
DEBUG (Oops_read): f88642bd
f88642bd
DEBUG (Oops_read): *pde = 3702b001
*pde = 3702b001
DEBUG (Oops_read): Oops: 0000 [#1]
Oops: 0000 [#1]
DEBUG (Oops_read): SMP
DEBUG (Oops_read): Modules linked in: sg nfsd exportfs
raw md5 ipv6 nfs lockd nfs_acl sunrpc parport_pc lp
parport e1000 af_packet floppy video thermal
tc1100_wmi processor fan container button battery ac
ipt_LOG ipt_REJECT ipt_state ip_conntrack
iptable_filter ip_tables ide_cd loop hw_random arcmsr
tsdev sr_mod ehci_hcd uhci_hcd usbcore evdev reiserfs
sd_mod ahci ata_piix libata scsi_mod
DEBUG (Oops_read): CPU:    0
CPU:    0
DEBUG (Oops_read): EIP:    0060:[<f88642bd>]   
Tainted: G   M  VLI
EIP:    0060:[<f88642bd>]    Tainted: G   M  VLI
DEBUG (re_compile): 'pc *: *\[*<([0-9a-fA-F]{4,})>\]*
* *lr *: *\[*<([0-9a-fA-F]{4,})>\]* *' 2 sub
expression(s)
DEBUG (re_compile): 'pc *= *\[*<([0-9a-fA-F]{4,})>\]*
* *ra *= *\[*<([0-9a-fA-F]{4,})>\]* *' 2 sub
expression(s)
Using defaults from ksymoops -t elf32-i386 -a i386
DEBUG (Oops_read): EFLAGS: 00010282  
(2.6.12-22mdksmp)
EFLAGS: 00010282   (2.6.12-22mdksmp)
DEBUG (Oops_read): EIP is at
scsi_decide_disposition+0xd/0x160 [scsi_mod]
DEBUG (Oops_read): eax: c0437f2c   ebx: f7c3902c  
ecx: 00000001   edx: f7db6e18
eax: c0437f2c   ebx: f7c3902c   ecx: 00000001   edx:
f7db6e18
DEBUG (Oops_read): esi: f7c3902c   edi: c0437f2c  
ebp: c0437f1c   esp: c0437f04
esi: f7c3902c   edi: c0437f2c   ebp: c0437f1c   esp:
c0437f04
DEBUG (Oops_read): ds: 007b   es: 007b   ss: 0068
ds: 007b   es: 007b   ss: 0068
DEBUG (Oops_read): Process swapper (pid: 0,
threadinfo=c0436000 task=c03d6bc0)
DEBUG (Oops_read): Stack: 00000001 00000000 00000000
00002002 f7da6680 00002002 c0437f40 f885fc71
Stack: 00000001 00000000 00000000 00002002 f7da6680
00002002 c0437f40 f885fc71
DEBUG (Oops_read):        f7c3902c 00002002 f7db6e18
f7db6818 00000001 c04331e0 c047ef00 c0437f6c
       f7c3902c 00002002 f7db6e18 f7db6818 00000001
c04331e0 c047ef00 c0437f6c
DEBUG (Oops_read):        c0181ab2 c04331e0 0000000a
00000000 c047c380 c0436000 c047c380 00000046
       c0181ab2 c04331e0 0000000a 00000000 c047c380
c0436000 c047c380 00000046
DEBUG (Oops_read): Call Trace:
Call Trace:
DEBUG (re_compile): '^(\([0-9]+\) *)' 1 sub
expression(s)
DEBUG (Oops_read):  [<c010426b>] show_stack+0xab/0xf0
 [<c010426b>] show_stack+0xab/0xf0
DEBUG (Oops_read):  [<c010444f>]
show_registers+0x17f/0x220
 [<c010444f>] show_registers+0x17f/0x220
DEBUG (Oops_read):  [<c0104694>] die+0xf4/0x180
 [<c0104694>] die+0xf4/0x180
DEBUG (Oops_read):  [<c011bf71>]
do_page_fault+0x261/0x793
 [<c011bf71>] do_page_fault+0x261/0x793
DEBUG (Oops_read):  [<c0103e6f>] error_code+0x4f/0x54
 [<c0103e6f>] error_code+0x4f/0x54
DEBUG (Oops_read):  [<f885fc71>]
scsi_softirq+0x71/0xf0 [scsi_mod]
 [<f885fc71>] scsi_softirq+0x71/0xf0 [scsi_mod]
DEBUG (Oops_read):  [<c0181ab2>]
__do_softirq+0x82/0xf0
 [<c0181ab2>] __do_softirq+0x82/0xf0
DEBUG (Oops_read):  [<c0181b57>] do_softirq+0x37/0x40
 [<c0181b57>] do_softirq+0x37/0x40
DEBUG (Oops_read):  [<c0105b11>] do_IRQ+0x21/0x30
 [<c0105b11>] do_IRQ+0x21/0x30
DEBUG (Oops_read):  [<c0103d16>]
common_interrupt+0x1a/0x20
 [<c0103d16>] common_interrupt+0x1a/0x20
DEBUG (Oops_read):  [<c010112f>] cpu_idle+0x6f/0xc0
 [<c010112f>] cpu_idle+0x6f/0xc0
DEBUG (Oops_read):  [<c0438a7a>]
start_kernel+0x17a/0x1e0
 [<c0438a7a>] start_kernel+0x17a/0x1e0
DEBUG (Oops_read):  [<c010020f>] 0xc010020f
 [<c010020f>] 0xc010020f
DEBUG (Oops_read): Code: 24 89 44 24 04 e8 f4 f2 ff ff
39 fe 8b 16 89 f0 75 a2 83 c4 14 5b 5e 5f 5d c3 8d 74
26 00 55 89 e5 53 83 ec 14 8b 5d 08 8b 4b 04 <83> b9
a8 02 00 00 06 74 2a 8b 93 4c 01 00 00 89 d0 c1 f8 10
25
Code: 24 89 44 24 04 e8 f4 f2 ff ff 39 fe 8b 16 89 f0
75 a2 83 c4 14 5b 5e 5f 5d c3 8d 74 26 00 55 89 e5 53
83 ec 14 8b 5d 08 8b 4b 04 <83> b9 a8 02 00 00 06 74
2a 8b 93 4c 01 00 00 89 d0 c1 f8 10 25
DEBUG (Oops_decode): 
DEBUG (re_compile): '^(([<(]?)([0-9a-fA-F]+)[)>]?
*)|(Bad .*)' 4 sub expression(s)
DEBUG (Oops_decode_part): 
DEBUG (Oops_objdump): command '/usr/bin/objdump -dhf
/root/tmp/ksymoops.eowtTC'
DEBUG (Oops_decode_part): 
DEBUG (re_compile): '^ *([0-9a-fA-F]+)(
<_XXX[^>]*>)?:(.* +<_XXX\+0?x?([0-9a-fA-F]+)> *$)?.*'
4 sub expression(s)
DEBUG (Oops_decode_part): /root/tmp/ksymoops.eowtTC:  
  file format elf32-i386
DEBUG (Oops_decode_part): architecture: i386, flags
0x00000010:
DEBUG (Oops_decode_part): HAS_SYMS
DEBUG (Oops_decode_part): start address 0x00000000
DEBUG (Oops_decode_part): 
DEBUG (Oops_decode_part): Sections:
DEBUG (Oops_decode_part): Idx Name          Size     
VMA       LMA       File off  Algn
DEBUG (Oops_decode_part):   0 .text         0000002b 
00000000  00000000  00000040  2**4
DEBUG (Oops_decode_part):                   CONTENTS,
ALLOC, LOAD, READONLY, CODE
DEBUG (Oops_decode_part): Disassembly of section
.text:
DEBUG (Oops_decode_part): 
DEBUG (Oops_decode_part): 00000000 <_XXX>:
DEBUG (Oops_decode_part):    0:   24 89               
     and    $0x89,%al
DEBUG (Oops_decode_part):    2:   44                  
     inc    %esp
DEBUG (Oops_decode_part):    3:   24 04               
     and    $0x4,%al
DEBUG (Oops_decode_part):    5:   e8 f4 f2 ff ff      
     call   fffff2fe <_XXX+0xfffff2fe>
DEBUG (Oops_decode_part):    a:   39 fe               
     cmp    %edi,%esi
DEBUG (Oops_decode_part):    c:   8b 16               
     mov    (%esi),%edx
DEBUG (Oops_decode_part):    e:   89 f0               
     mov    %esi,%eax
DEBUG (Oops_decode_part):   10:   75 a2               
     jne    ffffffb4 <_XXX+0xffffffb4>
DEBUG (Oops_decode_part):   12:   83 c4 14            
     add    $0x14,%esp
DEBUG (Oops_decode_part):   15:   5b                  
     pop    %ebx
DEBUG (Oops_decode_part):   16:   5e                  
     pop    %esi
DEBUG (Oops_decode_part):   17:   5f                  
     pop    %edi
DEBUG (Oops_decode_part):   18:   5d                  
     pop    %ebp
DEBUG (Oops_decode_part):   19:   c3                  
     ret    
DEBUG (Oops_decode_part):   1a:   8d 74 26 00         
     lea    0x0(%esi),%esi
DEBUG (Oops_decode_part):   1e:   55                  
     push   %ebp
DEBUG (Oops_decode_part):   1f:   89 e5               
     mov    %esp,%ebp
DEBUG (Oops_decode_part):   21:   53                  
     push   %ebx
DEBUG (Oops_decode_part):   22:   83 ec 14            
     sub    $0x14,%esp
DEBUG (Oops_decode_part):   25:   8b 5d 08            
     mov    0x8(%ebp),%ebx
DEBUG (Oops_decode_part):   28:   8b 4b 04            
     mov    0x4(%ebx),%ecx
DEBUG (Oops_decode_part): 
DEBUG (Oops_objdump): command '/usr/bin/objdump -dhf
/root/tmp/ksymoops.xIweUA'
DEBUG (Oops_decode_part): 
DEBUG (Oops_decode_part): /root/tmp/ksymoops.xIweUA:  
  file format elf32-i386
DEBUG (Oops_decode_part): architecture: i386, flags
0x00000010:
DEBUG (Oops_decode_part): HAS_SYMS
DEBUG (Oops_decode_part): start address 0x00000000
DEBUG (Oops_decode_part): 
DEBUG (Oops_decode_part): Sections:
DEBUG (Oops_decode_part): Idx Name          Size     
VMA       LMA       File off  Algn
DEBUG (Oops_decode_part):   0 .text         00000015 
00000000  00000000  00000040  2**4
DEBUG (Oops_decode_part):                   CONTENTS,
ALLOC, LOAD, READONLY, CODE
DEBUG (Oops_decode_part): Disassembly of section
.text:
DEBUG (Oops_decode_part): 
DEBUG (Oops_decode_part): 00000000 <_XXX>:
DEBUG (Oops_decode_part):    0:   83 b9 a8 02 00 00 06
     cmpl   $0x6,0x2a8(%ecx)
DEBUG (Oops_decode_part):    7:   74 2a               
     je     33 <_XXX+0x33>
DEBUG (Oops_decode_part):    9:   8b 93 4c 01 00 00   
     mov    0x14c(%ebx),%edx
DEBUG (Oops_decode_part):    f:   89 d0               
     mov    %edx,%eax
DEBUG (Oops_decode_part):   11:   c1 f8 10            
     sar    $0x10,%eax
DEBUG (Oops_decode_part):   14:   25                  
     .byte 0x25
DEBUG (Oops_format): 

DEBUG (map_address): merged f88642bd

>> >>EIP; f88642bd <pg0+3839f2bd/3fb39400>   <=====
DEBUG (map_address): merged c0437f2c

>> >>eax; c0437f2c <setup_IO_APIC+dc/5f0>
DEBUG (map_address): merged f7c3902c
>> >>ebx; f7c3902c <pg0+3777402c/3fb39400>
DEBUG (map_address): merged 00000001
DEBUG (map_address): merged f7db6e18
>> >>edx; f7db6e18 <pg0+378f1e18/3fb39400>
DEBUG (map_address): merged f7c3902c
>> >>esi; f7c3902c <pg0+3777402c/3fb39400>
DEBUG (map_address): merged c0437f2c
>> >>edi; c0437f2c <setup_IO_APIC+dc/5f0>
DEBUG (map_address): merged c0437f1c
>> >>ebp; c0437f1c <setup_IO_APIC+cc/5f0>
DEBUG (map_address): merged c0437f04
>> >>esp; c0437f04 <setup_IO_APIC+b4/5f0>
DEBUG (map_address): merged c010426b

Trace; c010426b <die+7b/150>
DEBUG (map_address): merged c010444f
Trace; c010444f <do_divide_error+1f/c0>
DEBUG (map_address): merged c0104694
Trace; c0104694 <do_invalid_op+84/c0>
DEBUG (map_address): merged c011bf71
Trace; c011bf71 <sys_rsbac_mac_get_p_trulist+c1/f0>
DEBUG (map_address): merged c0103e6f
Trace; c0103e6f <show_stack+3f/f0>
DEBUG (map_address): merged f885fc71
Trace; f885fc71 <pg0+3839ac71/3fb39400>
DEBUG (map_address): merged c0181ab2
Trace; c0181ab2 <sys_setresuid+52/350>
DEBUG (map_address): merged c0181b57
Trace; c0181b57 <sys_setresuid+f7/350>
DEBUG (map_address): merged c0105b11
Trace; c0105b11 <sys_vm86old+c1/d0>
DEBUG (map_address): merged c0103d16
Trace; c0103d16 <page_fault+a/c>
DEBUG (map_address): merged c010112f
Trace; c010112f <cpu_idle_wait+1f/80>
DEBUG (map_address): merged c0438a7a
Trace; c0438a7a <hpet_enable+fa/1a0>
DEBUG (map_address): merged c010020f
Trace; c010020f <ignore_int+23/34>

This architecture has variable length instructions,
decoding before eip
is unreliable, take these instructions with a pinch of
salt.

DEBUG (map_address): merged f8864292
Code;  f8864292 <pg0+3839f292/3fb39400>
00000000 <_EIP>:
DEBUG (map_address): merged f8864292
Code;  f8864292 <pg0+3839f292/3fb39400>
   0:   24 89                     and    $0x89,%al
DEBUG (map_address): merged f8864294
Code;  f8864294 <pg0+3839f294/3fb39400>
   2:   44                        inc    %esp
DEBUG (map_address): merged f8864295
Code;  f8864295 <pg0+3839f295/3fb39400>
   3:   24 04                     and    $0x4,%al
DEBUG (map_address): merged f8864297
Code;  f8864297 <pg0+3839f297/3fb39400>
   5:   e8 f4 f2 ff ff            call   fffff2fe
<_EIP+0xfffff2fe>
DEBUG (map_address): merged f886429c
Code;  f886429c <pg0+3839f29c/3fb39400>
   a:   39 fe                     cmp    %edi,%esi
DEBUG (map_address): merged f886429e
Code;  f886429e <pg0+3839f29e/3fb39400>
   c:   8b 16                     mov    (%esi),%edx
DEBUG (map_address): merged f88642a0
Code;  f88642a0 <pg0+3839f2a0/3fb39400>
   e:   89 f0                     mov    %esi,%eax
DEBUG (map_address): merged f88642a2
Code;  f88642a2 <pg0+3839f2a2/3fb39400>
  10:   75 a2                     jne    ffffffb4
<_EIP+0xffffffb4>
DEBUG (map_address): merged f88642a4
Code;  f88642a4 <pg0+3839f2a4/3fb39400>
  12:   83 c4 14                  add    $0x14,%esp
DEBUG (map_address): merged f88642a7
Code;  f88642a7 <pg0+3839f2a7/3fb39400>
  15:   5b                        pop    %ebx
DEBUG (map_address): merged f88642a8
Code;  f88642a8 <pg0+3839f2a8/3fb39400>
  16:   5e                        pop    %esi
DEBUG (map_address): merged f88642a9
Code;  f88642a9 <pg0+3839f2a9/3fb39400>
  17:   5f                        pop    %edi
DEBUG (map_address): merged f88642aa
Code;  f88642aa <pg0+3839f2aa/3fb39400>
  18:   5d                        pop    %ebp
DEBUG (map_address): merged f88642ab
Code;  f88642ab <pg0+3839f2ab/3fb39400>
  19:   c3                        ret    
DEBUG (map_address): merged f88642ac
Code;  f88642ac <pg0+3839f2ac/3fb39400>
  1a:   8d 74 26 00               lea   
0x0(%esi),%esi
DEBUG (map_address): merged f88642b0
Code;  f88642b0 <pg0+3839f2b0/3fb39400>
  1e:   55                        push   %ebp
DEBUG (map_address): merged f88642b1
Code;  f88642b1 <pg0+3839f2b1/3fb39400>
  1f:   89 e5                     mov    %esp,%ebp
DEBUG (map_address): merged f88642b3
Code;  f88642b3 <pg0+3839f2b3/3fb39400>
  21:   53                        push   %ebx
DEBUG (map_address): merged f88642b4
Code;  f88642b4 <pg0+3839f2b4/3fb39400>
  22:   83 ec 14                  sub    $0x14,%esp
DEBUG (map_address): merged f88642b7
Code;  f88642b7 <pg0+3839f2b7/3fb39400>
  25:   8b 5d 08                  mov   
0x8(%ebp),%ebx
DEBUG (map_address): merged f88642ba
Code;  f88642ba <pg0+3839f2ba/3fb39400>
  28:   8b 4b 04                  mov   
0x4(%ebx),%ecx

This decode from eip onwards should be reliable

DEBUG (map_address): merged f88642bd
Code;  f88642bd <pg0+3839f2bd/3fb39400>
00000000 <_EIP>:
DEBUG (map_address): merged f88642bd
Code;  f88642bd <pg0+3839f2bd/3fb39400>   <=====
   0:   83 b9 a8 02 00 00 06      cmpl  
$0x6,0x2a8(%ecx)   <=====
DEBUG (map_address): merged f88642c4
Code;  f88642c4 <pg0+3839f2c4/3fb39400>
   7:   74 2a                     je     33
<_EIP+0x33>
DEBUG (map_address): merged f88642c6
Code;  f88642c6 <pg0+3839f2c6/3fb39400>
   9:   8b 93 4c 01 00 00         mov   
0x14c(%ebx),%edx
DEBUG (map_address): merged f88642cc
Code;  f88642cc <pg0+3839f2cc/3fb39400>
   f:   89 d0                     mov    %edx,%eax
DEBUG (map_address): merged f88642ce
Code;  f88642ce <pg0+3839f2ce/3fb39400>
  11:   c1 f8 10                  sar    $0x10,%eax
DEBUG (map_address): merged f88642d1
Code;  f88642d1 <pg0+3839f2d1/3fb39400>
  14:   25                        .byte 0x25

DEBUG (Oops_read):  <0>Kernel panic - not syncing:
Fatal exception in interrupt
 <0>Kernel panic - not syncing: Fatal exception in
interrupt
DEBUG (Oops_read): 

1 error issued.  Results may not be reliable.


_Thanks....
Richard

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
--0-1608146152-1154619757=:12163
Content-Type: application/octet-stream; name="ksymoops.out3"
Content-Transfer-Encoding: base64
Content-Description: 1297169995-ksymoops.out3
Content-Disposition: attachment; filename="ksymoops.out3"

REVCVUcgKHBhcnNlKTogJ3YnICcvdXNyL3NyYy9saW51eC0yLjYuMTItMjJt
ZGsvdm1saW51eCcKREVCVUcgKHBhcnNlKTogJ20nICcvdXNyL3NyYy9saW51
eC0yLjYuMTItMjJtZGsvU3lzdGVtLm1hcCcKREVCVUcgKGNvbnZlcnRfdW5h
bWUpOiAvbGliL21vZHVsZXMvKnIvIGluCkRFQlVHIChjb252ZXJ0X3VuYW1l
KTogL2xpYi9tb2R1bGVzLzIuNi4xMi0yMm1ka3NtcC8gb3V0CmtzeW1vb3Bz
IDIuNC45IG9uIGk2ODYgMi42LjEyLTIybWRrc21wLiAgT3B0aW9ucyB1c2Vk
CiAgICAgLXYgL3Vzci9zcmMvbGludXgtMi42LjEyLTIybWRrL3ZtbGludXgg
KHNwZWNpZmllZCkKICAgICAtayAvcHJvYy9rc3ltcyAoZGVmYXVsdCkKICAg
ICAtbCAvcHJvYy9tb2R1bGVzIChkZWZhdWx0KQogICAgIC1vIC9saWIvbW9k
dWxlcy8yLjYuMTItMjJtZGtzbXAvIChkZWZhdWx0KQogICAgIC1tIC91c3Iv
c3JjL2xpbnV4LTIuNi4xMi0yMm1kay9TeXN0ZW0ubWFwIChzcGVjaWZpZWQp
CgpERUJVRyAobWFpbik6IGxldmVsIDMKREVCVUcgKHJlYWRfZW52KTogb3Zl
cnJpZGUgS1NZTU9PUFNfTk09L3Vzci9iaW4va3N5bW9vcHMtZ3pubQpERUJV
RyAocmVhZF9lbnYpOiBkZWZhdWx0IEtTWU1PT1BTX0ZJTkQ9L3Vzci9iaW4v
ZmluZApERUJVRyAocmVhZF9lbnYpOiBkZWZhdWx0IEtTWU1PT1BTX09CSkRV
TVA9L3Vzci9iaW4vb2JqZHVtcApERUJVRyAocmVfY29tcGlsZSk6ICdeKFsw
LTlhLWZBLUZdezQsfSkgKyhbXiBdKSArKFteIF0rKSggK1xbKFteIF0rKVxd
KT8kJyA1IHN1YiBleHByZXNzaW9uKHMpCkRFQlVHIChyZV9jb21waWxlKTog
J14gKlxbKjwoWzAtOWEtZkEtRl17NCx9KT5cXSogKicgMSBzdWIgZXhwcmVz
c2lvbihzKQpERUJVRyAocmVfY29tcGlsZSk6ICdeICo8XFsoWzAtOWEtZkEt
Rl17NCx9KVxdPiAqJyAxIHN1YiBleHByZXNzaW9uKHMpCkRFQlVHIChyZV9j
b21waWxlKTogJ14gKihbMC05YS1mQS1GXXs0LH0pIConIDEgc3ViIGV4cHJl
c3Npb24ocykKREVCVUcgKHJlYWRfbm1fc3ltYm9scyk6IGNvbW1hbmQgJy91
c3IvYmluL2tzeW1vb3BzLWd6bm0gL3Vzci9zcmMvbGludXgtMi42LjEyLTIy
bWRrL3ZtbGludXgnCkRFQlVHIChyZV9jb21waWxlKTogJ14oLiopX1IuKlsw
LTlhLWZBLUZdezgsfSQnIDEgc3ViIGV4cHJlc3Npb24ocykKREVCVUcgKHJl
YWRfbm1fc3ltYm9scyk6IHZtbGludXggdXNlZCAyMDgyOSBvdXQgb2YgMjM5
NTIgZW50cmllcwpERUJVRyAoc3Nfc29ydF9uYSk6IHZtbGludXgKREVCVUcg
KHNzX2NvbXByZXNzKTogdGFibGUgdm1saW51eCwgYmVmb3JlIDIwODI5CkRF
QlVHIChzc19jb21wcmVzcyk6IHRhYmxlIHZtbGludXgsIGFmdGVyIDIwODI5
CkRFQlVHIChzc19jb21wcmVzcyk6IHRhYmxlIHZtbGludXgsIGJlZm9yZSAy
MDgyOQpERUJVRyAoc3NfY29tcHJlc3MpOiB0YWJsZSB2bWxpbnV4LCBhZnRl
ciAyMDgyOQpERUJVRyAoYWRkX1ZlcnNpb24pOiB2bWxpbnV4IDEzMjYyMCAy
LjYuMTIKREVCVUcgKHJlYWRfa3N5bXMpOiAvcHJvYy9rc3ltcwpFcnJvciAo
cmVndWxhcl9maWxlKTogcmVhZF9rc3ltcyBzdGF0IC9wcm9jL2tzeW1zIGZh
aWxlZApObyBtb2R1bGVzIGluIGtzeW1zLCBza2lwcGluZyBvYmplY3RzCk5v
IGtzeW1zLCBza2lwcGluZyBsc21vZApERUJVRyAocmVhZF9zeXN0ZW1fbWFw
KTogL3Vzci9zcmMvbGludXgtMi42LjEyLTIybWRrL1N5c3RlbS5tYXAKREVC
VUcgKHNzX3NvcnRfbmEpOiBTeXN0ZW0ubWFwCkRFQlVHIChzc19jb21wcmVz
cyk6IHRhYmxlIFN5c3RlbS5tYXAsIGJlZm9yZSAyMDgyOQpERUJVRyAoc3Nf
Y29tcHJlc3MpOiB0YWJsZSBTeXN0ZW0ubWFwLCBhZnRlciAyMDgyOQpERUJV
RyAoc3NfY29tcHJlc3MpOiB0YWJsZSBTeXN0ZW0ubWFwLCBiZWZvcmUgMjA4
MjkKREVCVUcgKHNzX2NvbXByZXNzKTogdGFibGUgU3lzdGVtLm1hcCwgYWZ0
ZXIgMjA4MjkKREVCVUcgKGFkZF9WZXJzaW9uKTogU3lzdGVtLm1hcCAxMzI2
MjAgMi42LjEyCkRFQlVHIChyZWFkX3N5c3RlbV9tYXApOiBTeXN0ZW0ubWFw
IHVzZWQgMjA4Mjkgb3V0IG9mIDIzOTUyIGVudHJpZXMKREVCVUcgKG1lcmdl
X21hcHMpOiAKREVCVUcgKHNzX3NvcnRfbmEpOiBWZXJzaW9uXwpERUJVRyAo
c3NfY29tcHJlc3MpOiB0YWJsZSBWZXJzaW9uXywgYmVmb3JlIDIKREVCVUcg
KHNzX2NvbXByZXNzKTogdGFibGUgVmVyc2lvbl8sIGFmdGVyIDIKREVCVUcg
KHNzX2NvbXByZXNzKTogdGFibGUgVmVyc2lvbl8sIGJlZm9yZSAyCkRFQlVH
IChzc19jb21wcmVzcyk6IHRhYmxlIFZlcnNpb25fLCBhZnRlciAyCkRFQlVH
IChjb21wYXJlX1ZlcnNpb24pOiBWZXJzaW9uIDIuNi4xMgpERUJVRyAoY29t
cGFyZV9tYXBzKTogU3lzdGVtLm1hcCB2cyB2bWxpbnV4LCB2bWxpbnV4IHRh
a2VzIHByZWNlZGVuY2UKREVCVUcgKGNvbXBhcmVfbWFwcyk6IHZtbGludXgg
dnMgU3lzdGVtLm1hcCwgdm1saW51eCB0YWtlcyBwcmVjZWRlbmNlCkRFQlVH
IChhcHBlbmRfbWFwKTogdm1saW51eCB0byBtZXJnZWQKREVCVUcgKGFwcGVu
ZF9tYXApOiBTeXN0ZW0ubWFwIHRvIG1lcmdlZApERUJVRyAoc3Nfc29ydF9h
dG4pOiBtZXJnZWQKREVCVUcgKHNzX2NvbXByZXNzKTogdGFibGUgbWVyZ2Vk
LCBiZWZvcmUgNDE2NTgKREVCVUcgKHNzX2NvbXByZXNzKTogdGFibGUgbWVy
Z2VkLCBhZnRlciA0MTY1OApERUJVRyAoc3Nfc29ydF9hdG4pOiBtZXJnZWQK
REVCVUcgKHNzX2NvbXByZXNzKTogdGFibGUgbWVyZ2VkLCBiZWZvcmUgNDE2
NTgKREVCVUcgKHNzX2NvbXByZXNzKTogdGFibGUgbWVyZ2VkLCBhZnRlciAy
MDgyOQpERUJVRyAoZmluZF9mdWxscGF0aCk6IC91c3IvYmluL2tzeW1vb3Bz
LnJlYWwKREVCVUcgKE9vcHNfcmVhZCk6IFVuYWJsZSB0byBoYW5kbGUga2Vy
bmVsIE5VTEwgcG9pbnRlciBkZXJlZmVyZW5jZSBhdCB2aXJ0dWFsIGFkZHJl
c3MgMDAwMDAyYTkKREVCVUcgKHJlX2NvbXBpbGUpOiAnXiggK3xbXiBdezN9
IFsgMC05XVswLTldIFswLTldezJ9OlswLTldezJ9OlswLTldezJ9IFteIF0r
IGtlcm5lbDogK3w8WzAtOV0rPnxbMC05XStcfFtefF0rXHxbXnxdK1x8W158
XStcfHxbMC05XVtBQ10gWzAtOV17M30gWzAtOV17M31bY2lyXVswLTldezJ9
OlwrKScgMSBzdWIgZXhwcmVzc2lvbihzKQpERUJVRyAocmVfY29tcGlsZSk6
ICdeKChTdGFjazogKXwoU3RhY2sgZnJvbSApfChbMC05YS1mQS1GXXs0LH0p
fChDYWxsIFRyYWNlOiAqKXwoXFsqPChbMC05YS1mQS1GXXs0LH0pPlxdKiAq
KXwoVmVyc2lvbl9bMC05XSspfChUcmFjZTopfChDYWxsIGJhY2t0cmFjZTop
fChiaDopfDxcWyhbMC05YS1mQS1GXXs0LH0pXF0+ICp8KFwoW14gXStcKSAq
XFsqPChbMC05YS1mQS1GXXs0LH0pPlxdKiAqKXwoWzAtOV0rICtiYXNlPSl8
KEtlcm5lbCBCYWNrQ2hhaW4pfEVCUCAqRUlQfDB4KFswLTlhLWZBLUZdezQs
fSkgKjB4KFswLTlhLWZBLUZdezQsfSkgKnxQcm9jZXNzIC4qc3RhY2twYWdl
PXxDb2RlICo6IHxLZXJuZWwgcGFuaWN8SW4gc3dhcHBlciB0YXNrfGttZW1f
ZnJlZXxzd2FwcGVyfFBpZDp8clswLTldezEsMn0gKls6PV18Q29ycnVwdGVk
IHN0YWNrIHBhZ2V8aW52YWxpZCBvcGVyYW5kOiB8T29wczogfENwdToqICtb
MC05XXxjdXJyZW50LT50c3N8XCpwZGUgKz18RUlQOiB8RUZMQUdTOiB8ZWF4
OiB8ZXNpOiB8ZHM6IHxDUjA6IHx3YWl0X29uX3xpcnE6IHxTdGFjayBkdW1w
czp8UkFYOiB8UlNQOiB8UklQOiB8UkRYOiB8UkJQOiB8RlM6IHxDUzogfENS
MjogfFBNTDR8cGNbOj1dfDY4MDYwIGFjY2Vzc3xFeGNlcHRpb24gYXQgfGRb
MDRdOiB8RnJhbWUgZm9ybWF0PXx3YiBbMC05XSBzdGF0fHB1c2ggZGF0YTog
fGJhZGRyPXxBcml0aG1ldGljIGZhdWx0fEluc3RydWN0aW9uIGZhdWx0fEJh
ZCB1bmFsaWduZWQga2VybmVsfEZvcndhcmRpbmcgdW5hbGlnbmVkIGV4Y2Vw
dGlvbnw6IHVuaGFuZGxlZCB1bmFsaWduZWQgZXhjZXB0aW9ufHBjICo9fFty
dnRzYV1bMC05XSsgKj18Z3AgKj18c3BpbmxvY2sgc3R1Y2t8dHNrLT58UFNS
OiB8W2dvbGldMDogfEluc3RydWN0aW9uIERVTVA6IHxzcGluX2xvY2t8VFNU
QVRFOiB8W2dvbGldNDogfENhbGxlclxbfENQVVxbfE1TUjogfFRBU0sgPSB8
bGFzdCBtYXRoIHxHUFJbMC05XSs6IHwuKiBpbiAuKlwuW2NoXTouKiwgbGlu
ZSBbMC05XSs6fFwkWzAtOSBdKzp8SGkgKjp8TG8gKjp8ZXBjICo6fGJhZHZh
ZGRyICo6fFN0YXR1cyAqOnxDYXVzZSAqOnxCYWNrdHJhY2U6fEZ1bmN0aW9u
IGVudGVyZWQgYXR8XCpwZ2QgPXxJbnRlcm5hbCBlcnJvcnxwYyA6fHNwIDp8
RmxhZ3M6fENvbnRyb2w6fFdBUk5JTkc6fHRoaXNfc3RhY2s6fGk6fFBTV3xj
clswLTldKzp8bWFjaGluZSBjaGVja3xFeGNlcHRpb24gaW4gfFByb2dyYW0g
Q2hlY2sgfFN5c3RlbSByZXN0YXJ0IHxJVUNWIHx1bmV4cGVjdGVkIGV4dGVy
bmFsIHxLZXJuZWwgc3RhY2sgfFVzZXIgcHJvY2VzcyBmYXVsdDp8ZmFpbGlu
ZyBhZGRyZXNzfFVzZXIgUFNXfFVzZXIgR1BSU3xVc2VyIEFDUlN8S2VybmVs
IFBTV3xLZXJuZWwgR1BSU3xLZXJuZWwgQUNSU3xpbGxlZ2FsIG9wZXJhdGlv
bnx0YXNrOnxFbnRlcmluZyBrZGJ8ZWF4ICo9fGVzaSAqPXxlYnAgKj18ZHMg
Kj18cHNyIHx1bmF0ICB8cm5hdCB8bGRycyB8eGlwIHxpaXAgfGlwc3IgfGlm
YSB8cHIgfGl0YyB8aWZzIHxic3AgfFtiZnJdWzAtOV0rIHxpcnJbMC05XSB8
R2VuZXJhbCBFeGNlcHRpb258TUNBfFNBTHxQcm9jZXNzb3IgU3RhdGV8QmFu
ayBbMC05XSt8UmVnaXN0ZXIgU3RhY2t8UHJvY2Vzc29yIEVycm9yIEluZm98
cHJvYyBlcnIgbWFwfHByb2Mgc3RhdGUgcGFyYW18cHJvYyBsaWR8cHJvY2Vz
c29yIHN0cnVjdHVyZXxjaGVjayBpbmZvfHRhcmdldCBpZGVudGlmaWVyfElS
UCAqOiApJyAxOCBzdWIgZXhwcmVzc2lvbihzKQpERUJVRyAocmVfY29tcGls
ZSk6ICdVbmFibGUgdG8gaGFuZGxlIGtlcm5lbHxBaWVlfGRpZV9pZl9rZXJu
ZWx8Tk1JIHxCVUcgfFwoTC1UTEJcKXxcKE5PVExCXCl8XChbMC05XVwpOiBP
b3BzIHw6IG1lbW9yeSB2aW9sYXRpb258OiBFeGNlcHRpb24gYXR8OiBBcml0
aG1ldGljIGZhdWx0fDogSW5zdHJ1Y3Rpb24gZmF1bHR8OiBhcml0aG1ldGlj
IHRyYXB8OiB1bmFsaWduZWQgdHJhcHxcKFswLTldK1wpOiAoV2hlZXxPb3Bz
fEtlcm5lbHwuKlBlbmd1aW58Qk9HVVMpfGtlcm5lbCBwYyB8dHJhcCBhdCBQ
QzogfGJhZCBhcmVhIHBjIHxOSVA6IHwgcmEgKj09JyAxIHN1YiBleHByZXNz
aW9uKHMpCkRFQlVHIChyZV9jb21waWxlKTogJ14oaVswNF06IHxJbnN0cnVj
dGlvbiBEVU1QOiB8Q2FsbGVyXFspJyAxIHN1YiBleHByZXNzaW9uKHMpClVu
YWJsZSB0byBoYW5kbGUga2VybmVsIE5VTEwgcG9pbnRlciBkZXJlZmVyZW5j
ZSBhdCB2aXJ0dWFsIGFkZHJlc3MgMDAwMDAyYTkKREVCVUcgKHJlX2NvbXBp
bGUpOiAnXlBTUjogWzAtOWEtZkEtRl0rIFBDOiAoWzAtOWEtZkEtRl17NCx9
KSAqJyAxIHN1YiBleHByZXNzaW9uKHMpCkRFQlVHIChyZV9jb21waWxlKTog
J15UU1RBVEU6IFswLTlhLWZBLUZdezE2fSBUUEM6IChbMC05YS1mQS1GXXs0
LH0pIConIDEgc3ViIGV4cHJlc3Npb24ocykKREVCVUcgKHJlX2NvbXBpbGUp
OiAnKGtlcm5lbCBwYyB8dHJhcCBhdCBQQzogfGJhZCBhcmVhIHBjIHxOSVA6
ICkoWzAtOWEtZkEtRl17NCx9KSAqJyAyIHN1YiBleHByZXNzaW9uKHMpCkRF
QlVHIChyZV9jb21waWxlKTogJ15lcGMgKjorICooWzAtOWEtZkEtRl17NCx9
KSAqJyAxIHN1YiBleHByZXNzaW9uKHMpCkRFQlVHIChyZV9jb21waWxlKTog
JyBpcCAqOisgKlxbKjwoWzAtOWEtZkEtRl17NCx9KT5cXSogKicgMSBzdWIg
ZXhwcmVzc2lvbihzKQpERUJVRyAocmVfY29tcGlsZSk6ICdbeGldaXAgKlwo
W14pXSpcKSAqOiAqMHgoWzAtOWEtZkEtRl17NCx9KSAqJyAxIHN1YiBleHBy
ZXNzaW9uKHMpCkRFQlVHIChyZV9jb21waWxlKTogJyheMHgoWzAtOWEtZkEt
Rl17NCx9KSAqMHgoWzAtOWEtZkEtRl17NCx9KSAqLiorMHgpfCheRW50ZXJp
bmcga2RiIG9uIHByb2Nlc3Nvci4qMHgoWzAtOWEtZkEtRl17NCx9KSAqKScg
NSBzdWIgZXhwcmVzc2lvbihzKQpERUJVRyAocmVfY29tcGlsZSk6ICdeICpJ
UlAgKjogKihbMC05YS1mQS1GXXs0LH0pIConIDEgc3ViIGV4cHJlc3Npb24o
cykKREVCVUcgKHJlX2NvbXBpbGUpOiAnXihFSVA6ICsuKnxSSVA6ICsuKnxQ
QyAqPSAqfHBjICo6ICopXFsqPChbMC05YS1mQS1GXXs0LH0pPlxdKiAqJyAy
IHN1YiBleHByZXNzaW9uKHMpCkRFQlVHIChyZV9jb21waWxlKTogJ15zcGlu
bG9jayBzdHVjayBhdCAoWzAtOWEtZkEtRl17NCx9KSAqLipvd25lci4qYXQg
KFswLTlhLWZBLUZdezQsfSkgKicgMiBzdWIgZXhwcmVzc2lvbihzKQpERUJV
RyAocmVfY29tcGlsZSk6ICdec3Bpbl9sb2NrW14gXSpcKChbMC05YS1mQS1G
XXs0LH0pICouKnN0dWNrIGF0ICooWzAtOWEtZkEtRl17NCx9KSAqLipQQ1wo
KFswLTlhLWZBLUZdezQsfSkgKicgMyBzdWIgZXhwcmVzc2lvbihzKQpERUJV
RyAocmVfY29tcGlsZSk6ICdyYSAqPSsgKihbMC05YS1mQS1GXXs0LH0pICon
IDEgc3ViIGV4cHJlc3Npb24ocykKREVCVUcgKHJlX2NvbXBpbGUpOiAnXihc
JFswLTldezEsMn0pICo6ICooWzAtOWEtZkEtRl17NCx9KSAqJyAyIHN1YiBl
eHByZXNzaW9uKHMpCkRFQlVHIChyZV9jb21waWxlKTogJ14oR1BSWzAtOV17
MSwyfSkgKjogKihbMC05YS1mQS1GXXs0LH0pIConIDIgc3ViIGV4cHJlc3Np
b24ocykKREVCVUcgKHJlX2NvbXBpbGUpOiAnXlBTVyAqZmxhZ3M6ICooWzAt
OWEtZkEtRl17NCx9KSAqICpQU1cgYWRkcjogKihbMC05YS1mQS1GXXs0LH0p
IConIDIgc3ViIGV4cHJlc3Npb24ocykKREVCVUcgKHJlX2NvbXBpbGUpOiAn
Xktlcm5lbCBQU1c6ICooWzAtOWEtZkEtRl17NCx9KSAqKFswLTlhLWZBLUZd
ezQsfSkgKicgMiBzdWIgZXhwcmVzc2lvbihzKQpERUJVRyAocmVfY29tcGls
ZSk6ICdeKChDYWxsIFRyYWNlOiAqKXwoVHJhY2U6KXwoXFsqPChbMC05YS1m
QS1GXXs0LH0pPlxdKiAqKXwoQ2FsbCBiYWNrdHJhY2U6KXwoWzAtOWEtZkEt
Rl17NCx9KSAqfEZ1bmN0aW9uIGVudGVyZWQgYXQgKFxbKjwoWzAtOWEtZkEt
Rl17NCx9KT5cXSogKil8Q2FsbGVyXFsoWzAtOWEtZkEtRl17NCx9KSAqXF18
KDxcWyhbMC05YS1mQS1GXXs0LH0pXF0+ICopfChcKFswLTldK1wpICooXFsq
PChbMC05YS1mQS1GXXs0LH0pPlxdKiAqKSl8KFswLTldKyArYmFzZT0weChb
MC05YS1mQS1GXXs0LH0pICopfChLZXJuZWwgQmFja0NoYWluLiopKScgMTgg
c3ViIGV4cHJlc3Npb24ocykKREVCVUcgKHJlX2NvbXBpbGUpOiAnXigoR1B8
byk/clswLTldezEsMn18W2dvbGldWzAtOV17MSwyfXxbZVJdW0FCQ0RdWHxb
ZVJdW0RTXUl8UkJQfGVbYnNdcHxbZnNpXXB8SVJQfFNSUHxEP0NDUnxVU1B8
TU9GfHJldF9wYykgKls6PV0gKihbMC05YS1mQS1GXXs0LH0pICogKicgMyBz
dWIgZXhwcmVzc2lvbihzKQpERUJVRyAocmVfY29tcGlsZSk6ICdeKEtlcm5l
bCBHUFJTLiopJyAxIHN1YiBleHByZXNzaW9uKHMpCkRFQlVHIChyZV9jb21w
aWxlKTogJ14oSVJQfFNSUHxEP0NDUnxVU1B8TU9GKTogKihbMC05YS1mQS1G
XXs0LH0pIConIDIgc3ViIGV4cHJlc3Npb24ocykKREVCVUcgKHJlX2NvbXBp
bGUpOiAnXmJbMC03XSAqKFwoW14pXSpcKSAqKT86ICooMHgpPyhbMC05YS1m
QS1GXXs0LH0pIConIDMgc3ViIGV4cHJlc3Npb24ocykKREVCVUcgKHJlX2Nv
bXBpbGUpOiAnXihbXiBdKykgK1teIF0gKihbXiBdKykuKlwoKEwtVExCfE5P
VExCKVwpJyAzIHN1YiBleHByZXNzaW9uKHMpCkRFQlVHIChyZV9jb21waWxl
KTogJ14oKEluc3RydWN0aW9uIERVTVApfChDb2RlOj8gKikpOiArKChnZW5l
cmFsIHByb3RlY3Rpb24uKil8KEJhZCBFP0lQIHZhbHVlLiopfCg8WzAtOV0r
Pil8KChbPChdP1swLTlhLWZBLUZdK1s+KV0/ICspK1s8KF0/WzAtOWEtZkEt
Rl0rWz4pXT8pKSguKikkJyAxMCBzdWIgZXhwcmVzc2lvbihzKQpERUJVRyAo
T29wc19yZWFkKTogIHByaW50aW5nIGVpcDoKREVCVUcgKE9vcHNfcmVhZCk6
IGY4ODY0MmJkCmY4ODY0MmJkCkRFQlVHIChPb3BzX3JlYWQpOiAqcGRlID0g
MzcwMmIwMDEKKnBkZSA9IDM3MDJiMDAxCkRFQlVHIChPb3BzX3JlYWQpOiBP
b3BzOiAwMDAwIFsjMV0KT29wczogMDAwMCBbIzFdCkRFQlVHIChPb3BzX3Jl
YWQpOiBTTVAKREVCVUcgKE9vcHNfcmVhZCk6IE1vZHVsZXMgbGlua2VkIGlu
OiBzZyBuZnNkIGV4cG9ydGZzIHJhdyBtZDUgaXB2NiBuZnMgbG9ja2QgbmZz
X2FjbCBzdW5ycGMgcGFycG9ydF9wYyBscCBwYXJwb3J0IGUxMDAwIGFmX3Bh
Y2tldCBmbG9wcHkgdmlkZW8gdGhlcm1hbCB0YzExMDBfd21pIHByb2Nlc3Nv
ciBmYW4gY29udGFpbmVyIGJ1dHRvbiBiYXR0ZXJ5IGFjIGlwdF9MT0cgaXB0
X1JFSkVDVCBpcHRfc3RhdGUgaXBfY29ubnRyYWNrIGlwdGFibGVfZmlsdGVy
IGlwX3RhYmxlcyBpZGVfY2QgbG9vcCBod19yYW5kb20gYXJjbXNyIHRzZGV2
IHNyX21vZCBlaGNpX2hjZCB1aGNpX2hjZCB1c2Jjb3JlIGV2ZGV2IHJlaXNl
cmZzIHNkX21vZCBhaGNpIGF0YV9waWl4IGxpYmF0YSBzY3NpX21vZApERUJV
RyAoT29wc19yZWFkKTogQ1BVOiAgICAwCkNQVTogICAgMApERUJVRyAoT29w
c19yZWFkKTogRUlQOiAgICAwMDYwOls8Zjg4NjQyYmQ+XSAgICBUYWludGVk
OiBHICAgTSAgVkxJCkVJUDogICAgMDA2MDpbPGY4ODY0MmJkPl0gICAgVGFp
bnRlZDogRyAgIE0gIFZMSQpERUJVRyAocmVfY29tcGlsZSk6ICdwYyAqOiAq
XFsqPChbMC05YS1mQS1GXXs0LH0pPlxdKiAqICpsciAqOiAqXFsqPChbMC05
YS1mQS1GXXs0LH0pPlxdKiAqJyAyIHN1YiBleHByZXNzaW9uKHMpCkRFQlVH
IChyZV9jb21waWxlKTogJ3BjICo9ICpcWyo8KFswLTlhLWZBLUZdezQsfSk+
XF0qICogKnJhICo9ICpcWyo8KFswLTlhLWZBLUZdezQsfSk+XF0qIConIDIg
c3ViIGV4cHJlc3Npb24ocykKVXNpbmcgZGVmYXVsdHMgZnJvbSBrc3ltb29w
cyAtdCBlbGYzMi1pMzg2IC1hIGkzODYKREVCVUcgKE9vcHNfcmVhZCk6IEVG
TEFHUzogMDAwMTAyODIgICAoMi42LjEyLTIybWRrc21wKQpFRkxBR1M6IDAw
MDEwMjgyICAgKDIuNi4xMi0yMm1ka3NtcCkKREVCVUcgKE9vcHNfcmVhZCk6
IEVJUCBpcyBhdCBzY3NpX2RlY2lkZV9kaXNwb3NpdGlvbisweGQvMHgxNjAg
W3Njc2lfbW9kXQpERUJVRyAoT29wc19yZWFkKTogZWF4OiBjMDQzN2YyYyAg
IGVieDogZjdjMzkwMmMgICBlY3g6IDAwMDAwMDAxICAgZWR4OiBmN2RiNmUx
OAplYXg6IGMwNDM3ZjJjICAgZWJ4OiBmN2MzOTAyYyAgIGVjeDogMDAwMDAw
MDEgICBlZHg6IGY3ZGI2ZTE4CkRFQlVHIChPb3BzX3JlYWQpOiBlc2k6IGY3
YzM5MDJjICAgZWRpOiBjMDQzN2YyYyAgIGVicDogYzA0MzdmMWMgICBlc3A6
IGMwNDM3ZjA0CmVzaTogZjdjMzkwMmMgICBlZGk6IGMwNDM3ZjJjICAgZWJw
OiBjMDQzN2YxYyAgIGVzcDogYzA0MzdmMDQKREVCVUcgKE9vcHNfcmVhZCk6
IGRzOiAwMDdiICAgZXM6IDAwN2IgICBzczogMDA2OApkczogMDA3YiAgIGVz
OiAwMDdiICAgc3M6IDAwNjgKREVCVUcgKE9vcHNfcmVhZCk6IFByb2Nlc3Mg
c3dhcHBlciAocGlkOiAwLCB0aHJlYWRpbmZvPWMwNDM2MDAwIHRhc2s9YzAz
ZDZiYzApCkRFQlVHIChPb3BzX3JlYWQpOiBTdGFjazogMDAwMDAwMDEgMDAw
MDAwMDAgMDAwMDAwMDAgMDAwMDIwMDIgZjdkYTY2ODAgMDAwMDIwMDIgYzA0
MzdmNDAgZjg4NWZjNzEKU3RhY2s6IDAwMDAwMDAxIDAwMDAwMDAwIDAwMDAw
MDAwIDAwMDAyMDAyIGY3ZGE2NjgwIDAwMDAyMDAyIGMwNDM3ZjQwIGY4ODVm
YzcxCkRFQlVHIChPb3BzX3JlYWQpOiAgICAgICAgZjdjMzkwMmMgMDAwMDIw
MDIgZjdkYjZlMTggZjdkYjY4MTggMDAwMDAwMDEgYzA0MzMxZTAgYzA0N2Vm
MDAgYzA0MzdmNmMKICAgICAgIGY3YzM5MDJjIDAwMDAyMDAyIGY3ZGI2ZTE4
IGY3ZGI2ODE4IDAwMDAwMDAxIGMwNDMzMWUwIGMwNDdlZjAwIGMwNDM3ZjZj
CkRFQlVHIChPb3BzX3JlYWQpOiAgICAgICAgYzAxODFhYjIgYzA0MzMxZTAg
MDAwMDAwMGEgMDAwMDAwMDAgYzA0N2MzODAgYzA0MzYwMDAgYzA0N2MzODAg
MDAwMDAwNDYKICAgICAgIGMwMTgxYWIyIGMwNDMzMWUwIDAwMDAwMDBhIDAw
MDAwMDAwIGMwNDdjMzgwIGMwNDM2MDAwIGMwNDdjMzgwIDAwMDAwMDQ2CkRF
QlVHIChPb3BzX3JlYWQpOiBDYWxsIFRyYWNlOgpDYWxsIFRyYWNlOgpERUJV
RyAocmVfY29tcGlsZSk6ICdeKFwoWzAtOV0rXCkgKiknIDEgc3ViIGV4cHJl
c3Npb24ocykKREVCVUcgKE9vcHNfcmVhZCk6ICBbPGMwMTA0MjZiPl0gc2hv
d19zdGFjaysweGFiLzB4ZjAKIFs8YzAxMDQyNmI+XSBzaG93X3N0YWNrKzB4
YWIvMHhmMApERUJVRyAoT29wc19yZWFkKTogIFs8YzAxMDQ0NGY+XSBzaG93
X3JlZ2lzdGVycysweDE3Zi8weDIyMAogWzxjMDEwNDQ0Zj5dIHNob3dfcmVn
aXN0ZXJzKzB4MTdmLzB4MjIwCkRFQlVHIChPb3BzX3JlYWQpOiAgWzxjMDEw
NDY5ND5dIGRpZSsweGY0LzB4MTgwCiBbPGMwMTA0Njk0Pl0gZGllKzB4ZjQv
MHgxODAKREVCVUcgKE9vcHNfcmVhZCk6ICBbPGMwMTFiZjcxPl0gZG9fcGFn
ZV9mYXVsdCsweDI2MS8weDc5MwogWzxjMDExYmY3MT5dIGRvX3BhZ2VfZmF1
bHQrMHgyNjEvMHg3OTMKREVCVUcgKE9vcHNfcmVhZCk6ICBbPGMwMTAzZTZm
Pl0gZXJyb3JfY29kZSsweDRmLzB4NTQKIFs8YzAxMDNlNmY+XSBlcnJvcl9j
b2RlKzB4NGYvMHg1NApERUJVRyAoT29wc19yZWFkKTogIFs8Zjg4NWZjNzE+
XSBzY3NpX3NvZnRpcnErMHg3MS8weGYwIFtzY3NpX21vZF0KIFs8Zjg4NWZj
NzE+XSBzY3NpX3NvZnRpcnErMHg3MS8weGYwIFtzY3NpX21vZF0KREVCVUcg
KE9vcHNfcmVhZCk6ICBbPGMwMTgxYWIyPl0gX19kb19zb2Z0aXJxKzB4ODIv
MHhmMAogWzxjMDE4MWFiMj5dIF9fZG9fc29mdGlycSsweDgyLzB4ZjAKREVC
VUcgKE9vcHNfcmVhZCk6ICBbPGMwMTgxYjU3Pl0gZG9fc29mdGlycSsweDM3
LzB4NDAKIFs8YzAxODFiNTc+XSBkb19zb2Z0aXJxKzB4MzcvMHg0MApERUJV
RyAoT29wc19yZWFkKTogIFs8YzAxMDViMTE+XSBkb19JUlErMHgyMS8weDMw
CiBbPGMwMTA1YjExPl0gZG9fSVJRKzB4MjEvMHgzMApERUJVRyAoT29wc19y
ZWFkKTogIFs8YzAxMDNkMTY+XSBjb21tb25faW50ZXJydXB0KzB4MWEvMHgy
MAogWzxjMDEwM2QxNj5dIGNvbW1vbl9pbnRlcnJ1cHQrMHgxYS8weDIwCkRF
QlVHIChPb3BzX3JlYWQpOiAgWzxjMDEwMTEyZj5dIGNwdV9pZGxlKzB4NmYv
MHhjMAogWzxjMDEwMTEyZj5dIGNwdV9pZGxlKzB4NmYvMHhjMApERUJVRyAo
T29wc19yZWFkKTogIFs8YzA0MzhhN2E+XSBzdGFydF9rZXJuZWwrMHgxN2Ev
MHgxZTAKIFs8YzA0MzhhN2E+XSBzdGFydF9rZXJuZWwrMHgxN2EvMHgxZTAK
REVCVUcgKE9vcHNfcmVhZCk6ICBbPGMwMTAwMjBmPl0gMHhjMDEwMDIwZgog
WzxjMDEwMDIwZj5dIDB4YzAxMDAyMGYKREVCVUcgKE9vcHNfcmVhZCk6IENv
ZGU6IDI0IDg5IDQ0IDI0IDA0IGU4IGY0IGYyIGZmIGZmIDM5IGZlIDhiIDE2
IDg5IGYwIDc1IGEyIDgzIGM0IDE0IDViIDVlIDVmIDVkIGMzIDhkIDc0IDI2
IDAwIDU1IDg5IGU1IDUzIDgzIGVjIDE0IDhiIDVkIDA4IDhiIDRiIDA0IDw4
Mz4gYjkgYTggMDIgMDAgMDAgMDYgNzQgMmEgOGIgOTMgNGMgMDEgMDAgMDAg
ODkgZDAgYzEgZjggMTAgMjUKQ29kZTogMjQgODkgNDQgMjQgMDQgZTggZjQg
ZjIgZmYgZmYgMzkgZmUgOGIgMTYgODkgZjAgNzUgYTIgODMgYzQgMTQgNWIg
NWUgNWYgNWQgYzMgOGQgNzQgMjYgMDAgNTUgODkgZTUgNTMgODMgZWMgMTQg
OGIgNWQgMDggOGIgNGIgMDQgPDgzPiBiOSBhOCAwMiAwMCAwMCAwNiA3NCAy
YSA4YiA5MyA0YyAwMSAwMCAwMCA4OSBkMCBjMSBmOCAxMCAyNQpERUJVRyAo
T29wc19kZWNvZGUpOiAKREVCVUcgKHJlX2NvbXBpbGUpOiAnXigoWzwoXT8p
KFswLTlhLWZBLUZdKylbKT5dPyAqKXwoQmFkIC4qKScgNCBzdWIgZXhwcmVz
c2lvbihzKQpERUJVRyAoT29wc19kZWNvZGVfcGFydCk6IApERUJVRyAoT29w
c19vYmpkdW1wKTogY29tbWFuZCAnL3Vzci9iaW4vb2JqZHVtcCAtZGhmIC9y
b290L3RtcC9rc3ltb29wcy5lb3d0VEMnCkRFQlVHIChPb3BzX2RlY29kZV9w
YXJ0KTogCkRFQlVHIChyZV9jb21waWxlKTogJ14gKihbMC05YS1mQS1GXSsp
KCA8X1hYWFtePl0qPik/OiguKiArPF9YWFhcKzA/eD8oWzAtOWEtZkEtRl0r
KT4gKiQpPy4qJyA0IHN1YiBleHByZXNzaW9uKHMpCkRFQlVHIChPb3BzX2Rl
Y29kZV9wYXJ0KTogL3Jvb3QvdG1wL2tzeW1vb3BzLmVvd3RUQzogICAgIGZp
bGUgZm9ybWF0IGVsZjMyLWkzODYKREVCVUcgKE9vcHNfZGVjb2RlX3BhcnQp
OiBhcmNoaXRlY3R1cmU6IGkzODYsIGZsYWdzIDB4MDAwMDAwMTA6CkRFQlVH
IChPb3BzX2RlY29kZV9wYXJ0KTogSEFTX1NZTVMKREVCVUcgKE9vcHNfZGVj
b2RlX3BhcnQpOiBzdGFydCBhZGRyZXNzIDB4MDAwMDAwMDAKREVCVUcgKE9v
cHNfZGVjb2RlX3BhcnQpOiAKREVCVUcgKE9vcHNfZGVjb2RlX3BhcnQpOiBT
ZWN0aW9uczoKREVCVUcgKE9vcHNfZGVjb2RlX3BhcnQpOiBJZHggTmFtZSAg
ICAgICAgICBTaXplICAgICAgVk1BICAgICAgIExNQSAgICAgICBGaWxlIG9m
ZiAgQWxnbgpERUJVRyAoT29wc19kZWNvZGVfcGFydCk6ICAgMCAudGV4dCAg
ICAgICAgIDAwMDAwMDJiICAwMDAwMDAwMCAgMDAwMDAwMDAgIDAwMDAwMDQw
ICAyKio0CkRFQlVHIChPb3BzX2RlY29kZV9wYXJ0KTogICAgICAgICAgICAg
ICAgICAgQ09OVEVOVFMsIEFMTE9DLCBMT0FELCBSRUFET05MWSwgQ09ERQpE
RUJVRyAoT29wc19kZWNvZGVfcGFydCk6IERpc2Fzc2VtYmx5IG9mIHNlY3Rp
b24gLnRleHQ6CkRFQlVHIChPb3BzX2RlY29kZV9wYXJ0KTogCkRFQlVHIChP
b3BzX2RlY29kZV9wYXJ0KTogMDAwMDAwMDAgPF9YWFg+OgpERUJVRyAoT29w
c19kZWNvZGVfcGFydCk6ICAgIDA6ICAgMjQgODkgICAgICAgICAgICAgICAg
ICAgICBhbmQgICAgJDB4ODksJWFsCkRFQlVHIChPb3BzX2RlY29kZV9wYXJ0
KTogICAgMjogICA0NCAgICAgICAgICAgICAgICAgICAgICAgIGluYyAgICAl
ZXNwCkRFQlVHIChPb3BzX2RlY29kZV9wYXJ0KTogICAgMzogICAyNCAwNCAg
ICAgICAgICAgICAgICAgICAgIGFuZCAgICAkMHg0LCVhbApERUJVRyAoT29w
c19kZWNvZGVfcGFydCk6ICAgIDU6ICAgZTggZjQgZjIgZmYgZmYgICAgICAg
ICAgICBjYWxsICAgZmZmZmYyZmUgPF9YWFgrMHhmZmZmZjJmZT4KREVCVUcg
KE9vcHNfZGVjb2RlX3BhcnQpOiAgICBhOiAgIDM5IGZlICAgICAgICAgICAg
ICAgICAgICAgY21wICAgICVlZGksJWVzaQpERUJVRyAoT29wc19kZWNvZGVf
cGFydCk6ICAgIGM6ICAgOGIgMTYgICAgICAgICAgICAgICAgICAgICBtb3Yg
ICAgKCVlc2kpLCVlZHgKREVCVUcgKE9vcHNfZGVjb2RlX3BhcnQpOiAgICBl
OiAgIDg5IGYwICAgICAgICAgICAgICAgICAgICAgbW92ICAgICVlc2ksJWVh
eApERUJVRyAoT29wc19kZWNvZGVfcGFydCk6ICAgMTA6ICAgNzUgYTIgICAg
ICAgICAgICAgICAgICAgICBqbmUgICAgZmZmZmZmYjQgPF9YWFgrMHhmZmZm
ZmZiND4KREVCVUcgKE9vcHNfZGVjb2RlX3BhcnQpOiAgIDEyOiAgIDgzIGM0
IDE0ICAgICAgICAgICAgICAgICAgYWRkICAgICQweDE0LCVlc3AKREVCVUcg
KE9vcHNfZGVjb2RlX3BhcnQpOiAgIDE1OiAgIDViICAgICAgICAgICAgICAg
ICAgICAgICAgcG9wICAgICVlYngKREVCVUcgKE9vcHNfZGVjb2RlX3BhcnQp
OiAgIDE2OiAgIDVlICAgICAgICAgICAgICAgICAgICAgICAgcG9wICAgICVl
c2kKREVCVUcgKE9vcHNfZGVjb2RlX3BhcnQpOiAgIDE3OiAgIDVmICAgICAg
ICAgICAgICAgICAgICAgICAgcG9wICAgICVlZGkKREVCVUcgKE9vcHNfZGVj
b2RlX3BhcnQpOiAgIDE4OiAgIDVkICAgICAgICAgICAgICAgICAgICAgICAg
cG9wICAgICVlYnAKREVCVUcgKE9vcHNfZGVjb2RlX3BhcnQpOiAgIDE5OiAg
IGMzICAgICAgICAgICAgICAgICAgICAgICAgcmV0ICAgIApERUJVRyAoT29w
c19kZWNvZGVfcGFydCk6ICAgMWE6ICAgOGQgNzQgMjYgMDAgICAgICAgICAg
ICAgICBsZWEgICAgMHgwKCVlc2kpLCVlc2kKREVCVUcgKE9vcHNfZGVjb2Rl
X3BhcnQpOiAgIDFlOiAgIDU1ICAgICAgICAgICAgICAgICAgICAgICAgcHVz
aCAgICVlYnAKREVCVUcgKE9vcHNfZGVjb2RlX3BhcnQpOiAgIDFmOiAgIDg5
IGU1ICAgICAgICAgICAgICAgICAgICAgbW92ICAgICVlc3AsJWVicApERUJV
RyAoT29wc19kZWNvZGVfcGFydCk6ICAgMjE6ICAgNTMgICAgICAgICAgICAg
ICAgICAgICAgICBwdXNoICAgJWVieApERUJVRyAoT29wc19kZWNvZGVfcGFy
dCk6ICAgMjI6ICAgODMgZWMgMTQgICAgICAgICAgICAgICAgICBzdWIgICAg
JDB4MTQsJWVzcApERUJVRyAoT29wc19kZWNvZGVfcGFydCk6ICAgMjU6ICAg
OGIgNWQgMDggICAgICAgICAgICAgICAgICBtb3YgICAgMHg4KCVlYnApLCVl
YngKREVCVUcgKE9vcHNfZGVjb2RlX3BhcnQpOiAgIDI4OiAgIDhiIDRiIDA0
ICAgICAgICAgICAgICAgICAgbW92ICAgIDB4NCglZWJ4KSwlZWN4CkRFQlVH
IChPb3BzX2RlY29kZV9wYXJ0KTogCkRFQlVHIChPb3BzX29iamR1bXApOiBj
b21tYW5kICcvdXNyL2Jpbi9vYmpkdW1wIC1kaGYgL3Jvb3QvdG1wL2tzeW1v
b3BzLnhJd2VVQScKREVCVUcgKE9vcHNfZGVjb2RlX3BhcnQpOiAKREVCVUcg
KE9vcHNfZGVjb2RlX3BhcnQpOiAvcm9vdC90bXAva3N5bW9vcHMueEl3ZVVB
OiAgICAgZmlsZSBmb3JtYXQgZWxmMzItaTM4NgpERUJVRyAoT29wc19kZWNv
ZGVfcGFydCk6IGFyY2hpdGVjdHVyZTogaTM4NiwgZmxhZ3MgMHgwMDAwMDAx
MDoKREVCVUcgKE9vcHNfZGVjb2RlX3BhcnQpOiBIQVNfU1lNUwpERUJVRyAo
T29wc19kZWNvZGVfcGFydCk6IHN0YXJ0IGFkZHJlc3MgMHgwMDAwMDAwMApE
RUJVRyAoT29wc19kZWNvZGVfcGFydCk6IApERUJVRyAoT29wc19kZWNvZGVf
cGFydCk6IFNlY3Rpb25zOgpERUJVRyAoT29wc19kZWNvZGVfcGFydCk6IElk
eCBOYW1lICAgICAgICAgIFNpemUgICAgICBWTUEgICAgICAgTE1BICAgICAg
IEZpbGUgb2ZmICBBbGduCkRFQlVHIChPb3BzX2RlY29kZV9wYXJ0KTogICAw
IC50ZXh0ICAgICAgICAgMDAwMDAwMTUgIDAwMDAwMDAwICAwMDAwMDAwMCAg
MDAwMDAwNDAgIDIqKjQKREVCVUcgKE9vcHNfZGVjb2RlX3BhcnQpOiAgICAg
ICAgICAgICAgICAgICBDT05URU5UUywgQUxMT0MsIExPQUQsIFJFQURPTkxZ
LCBDT0RFCkRFQlVHIChPb3BzX2RlY29kZV9wYXJ0KTogRGlzYXNzZW1ibHkg
b2Ygc2VjdGlvbiAudGV4dDoKREVCVUcgKE9vcHNfZGVjb2RlX3BhcnQpOiAK
REVCVUcgKE9vcHNfZGVjb2RlX3BhcnQpOiAwMDAwMDAwMCA8X1hYWD46CkRF
QlVHIChPb3BzX2RlY29kZV9wYXJ0KTogICAgMDogICA4MyBiOSBhOCAwMiAw
MCAwMCAwNiAgICAgIGNtcGwgICAkMHg2LDB4MmE4KCVlY3gpCkRFQlVHIChP
b3BzX2RlY29kZV9wYXJ0KTogICAgNzogICA3NCAyYSAgICAgICAgICAgICAg
ICAgICAgIGplICAgICAzMyA8X1hYWCsweDMzPgpERUJVRyAoT29wc19kZWNv
ZGVfcGFydCk6ICAgIDk6ICAgOGIgOTMgNGMgMDEgMDAgMDAgICAgICAgICBt
b3YgICAgMHgxNGMoJWVieCksJWVkeApERUJVRyAoT29wc19kZWNvZGVfcGFy
dCk6ICAgIGY6ICAgODkgZDAgICAgICAgICAgICAgICAgICAgICBtb3YgICAg
JWVkeCwlZWF4CkRFQlVHIChPb3BzX2RlY29kZV9wYXJ0KTogICAxMTogICBj
MSBmOCAxMCAgICAgICAgICAgICAgICAgIHNhciAgICAkMHgxMCwlZWF4CkRF
QlVHIChPb3BzX2RlY29kZV9wYXJ0KTogICAxNDogICAyNSAgICAgICAgICAg
ICAgICAgICAgICAgIC5ieXRlIDB4MjUKREVCVUcgKE9vcHNfZm9ybWF0KTog
CgpERUJVRyAobWFwX2FkZHJlc3MpOiBtZXJnZWQgZjg4NjQyYmQKCj4+RUlQ
OyBmODg2NDJiZCA8cGcwKzM4MzlmMmJkLzNmYjM5NDAwPiAgIDw9PT09PQpE
RUJVRyAobWFwX2FkZHJlc3MpOiBtZXJnZWQgYzA0MzdmMmMKCj4+ZWF4OyBj
MDQzN2YyYyA8c2V0dXBfSU9fQVBJQytkYy81ZjA+CkRFQlVHIChtYXBfYWRk
cmVzcyk6IG1lcmdlZCBmN2MzOTAyYwo+PmVieDsgZjdjMzkwMmMgPHBnMCsz
Nzc3NDAyYy8zZmIzOTQwMD4KREVCVUcgKG1hcF9hZGRyZXNzKTogbWVyZ2Vk
IDAwMDAwMDAxCkRFQlVHIChtYXBfYWRkcmVzcyk6IG1lcmdlZCBmN2RiNmUx
OAo+PmVkeDsgZjdkYjZlMTggPHBnMCszNzhmMWUxOC8zZmIzOTQwMD4KREVC
VUcgKG1hcF9hZGRyZXNzKTogbWVyZ2VkIGY3YzM5MDJjCj4+ZXNpOyBmN2Mz
OTAyYyA8cGcwKzM3Nzc0MDJjLzNmYjM5NDAwPgpERUJVRyAobWFwX2FkZHJl
c3MpOiBtZXJnZWQgYzA0MzdmMmMKPj5lZGk7IGMwNDM3ZjJjIDxzZXR1cF9J
T19BUElDK2RjLzVmMD4KREVCVUcgKG1hcF9hZGRyZXNzKTogbWVyZ2VkIGMw
NDM3ZjFjCj4+ZWJwOyBjMDQzN2YxYyA8c2V0dXBfSU9fQVBJQytjYy81ZjA+
CkRFQlVHIChtYXBfYWRkcmVzcyk6IG1lcmdlZCBjMDQzN2YwNAo+PmVzcDsg
YzA0MzdmMDQgPHNldHVwX0lPX0FQSUMrYjQvNWYwPgpERUJVRyAobWFwX2Fk
ZHJlc3MpOiBtZXJnZWQgYzAxMDQyNmIKClRyYWNlOyBjMDEwNDI2YiA8ZGll
KzdiLzE1MD4KREVCVUcgKG1hcF9hZGRyZXNzKTogbWVyZ2VkIGMwMTA0NDRm
ClRyYWNlOyBjMDEwNDQ0ZiA8ZG9fZGl2aWRlX2Vycm9yKzFmL2MwPgpERUJV
RyAobWFwX2FkZHJlc3MpOiBtZXJnZWQgYzAxMDQ2OTQKVHJhY2U7IGMwMTA0
Njk0IDxkb19pbnZhbGlkX29wKzg0L2MwPgpERUJVRyAobWFwX2FkZHJlc3Mp
OiBtZXJnZWQgYzAxMWJmNzEKVHJhY2U7IGMwMTFiZjcxIDxzeXNfcnNiYWNf
bWFjX2dldF9wX3RydWxpc3QrYzEvZjA+CkRFQlVHIChtYXBfYWRkcmVzcyk6
IG1lcmdlZCBjMDEwM2U2ZgpUcmFjZTsgYzAxMDNlNmYgPHNob3dfc3RhY2sr
M2YvZjA+CkRFQlVHIChtYXBfYWRkcmVzcyk6IG1lcmdlZCBmODg1ZmM3MQpU
cmFjZTsgZjg4NWZjNzEgPHBnMCszODM5YWM3MS8zZmIzOTQwMD4KREVCVUcg
KG1hcF9hZGRyZXNzKTogbWVyZ2VkIGMwMTgxYWIyClRyYWNlOyBjMDE4MWFi
MiA8c3lzX3NldHJlc3VpZCs1Mi8zNTA+CkRFQlVHIChtYXBfYWRkcmVzcyk6
IG1lcmdlZCBjMDE4MWI1NwpUcmFjZTsgYzAxODFiNTcgPHN5c19zZXRyZXN1
aWQrZjcvMzUwPgpERUJVRyAobWFwX2FkZHJlc3MpOiBtZXJnZWQgYzAxMDVi
MTEKVHJhY2U7IGMwMTA1YjExIDxzeXNfdm04Nm9sZCtjMS9kMD4KREVCVUcg
KG1hcF9hZGRyZXNzKTogbWVyZ2VkIGMwMTAzZDE2ClRyYWNlOyBjMDEwM2Qx
NiA8cGFnZV9mYXVsdCthL2M+CkRFQlVHIChtYXBfYWRkcmVzcyk6IG1lcmdl
ZCBjMDEwMTEyZgpUcmFjZTsgYzAxMDExMmYgPGNwdV9pZGxlX3dhaXQrMWYv
ODA+CkRFQlVHIChtYXBfYWRkcmVzcyk6IG1lcmdlZCBjMDQzOGE3YQpUcmFj
ZTsgYzA0MzhhN2EgPGhwZXRfZW5hYmxlK2ZhLzFhMD4KREVCVUcgKG1hcF9h
ZGRyZXNzKTogbWVyZ2VkIGMwMTAwMjBmClRyYWNlOyBjMDEwMDIwZiA8aWdu
b3JlX2ludCsyMy8zND4KClRoaXMgYXJjaGl0ZWN0dXJlIGhhcyB2YXJpYWJs
ZSBsZW5ndGggaW5zdHJ1Y3Rpb25zLCBkZWNvZGluZyBiZWZvcmUgZWlwCmlz
IHVucmVsaWFibGUsIHRha2UgdGhlc2UgaW5zdHJ1Y3Rpb25zIHdpdGggYSBw
aW5jaCBvZiBzYWx0LgoKREVCVUcgKG1hcF9hZGRyZXNzKTogbWVyZ2VkIGY4
ODY0MjkyCkNvZGU7ICBmODg2NDI5MiA8cGcwKzM4MzlmMjkyLzNmYjM5NDAw
PgowMDAwMDAwMCA8X0VJUD46CkRFQlVHIChtYXBfYWRkcmVzcyk6IG1lcmdl
ZCBmODg2NDI5MgpDb2RlOyAgZjg4NjQyOTIgPHBnMCszODM5ZjI5Mi8zZmIz
OTQwMD4KICAgMDogICAyNCA4OSAgICAgICAgICAgICAgICAgICAgIGFuZCAg
ICAkMHg4OSwlYWwKREVCVUcgKG1hcF9hZGRyZXNzKTogbWVyZ2VkIGY4ODY0
Mjk0CkNvZGU7ICBmODg2NDI5NCA8cGcwKzM4MzlmMjk0LzNmYjM5NDAwPgog
ICAyOiAgIDQ0ICAgICAgICAgICAgICAgICAgICAgICAgaW5jICAgICVlc3AK
REVCVUcgKG1hcF9hZGRyZXNzKTogbWVyZ2VkIGY4ODY0Mjk1CkNvZGU7ICBm
ODg2NDI5NSA8cGcwKzM4MzlmMjk1LzNmYjM5NDAwPgogICAzOiAgIDI0IDA0
ICAgICAgICAgICAgICAgICAgICAgYW5kICAgICQweDQsJWFsCkRFQlVHICht
YXBfYWRkcmVzcyk6IG1lcmdlZCBmODg2NDI5NwpDb2RlOyAgZjg4NjQyOTcg
PHBnMCszODM5ZjI5Ny8zZmIzOTQwMD4KICAgNTogICBlOCBmNCBmMiBmZiBm
ZiAgICAgICAgICAgIGNhbGwgICBmZmZmZjJmZSA8X0VJUCsweGZmZmZmMmZl
PgpERUJVRyAobWFwX2FkZHJlc3MpOiBtZXJnZWQgZjg4NjQyOWMKQ29kZTsg
IGY4ODY0MjljIDxwZzArMzgzOWYyOWMvM2ZiMzk0MDA+CiAgIGE6ICAgMzkg
ZmUgICAgICAgICAgICAgICAgICAgICBjbXAgICAgJWVkaSwlZXNpCkRFQlVH
IChtYXBfYWRkcmVzcyk6IG1lcmdlZCBmODg2NDI5ZQpDb2RlOyAgZjg4NjQy
OWUgPHBnMCszODM5ZjI5ZS8zZmIzOTQwMD4KICAgYzogICA4YiAxNiAgICAg
ICAgICAgICAgICAgICAgIG1vdiAgICAoJWVzaSksJWVkeApERUJVRyAobWFw
X2FkZHJlc3MpOiBtZXJnZWQgZjg4NjQyYTAKQ29kZTsgIGY4ODY0MmEwIDxw
ZzArMzgzOWYyYTAvM2ZiMzk0MDA+CiAgIGU6ICAgODkgZjAgICAgICAgICAg
ICAgICAgICAgICBtb3YgICAgJWVzaSwlZWF4CkRFQlVHIChtYXBfYWRkcmVz
cyk6IG1lcmdlZCBmODg2NDJhMgpDb2RlOyAgZjg4NjQyYTIgPHBnMCszODM5
ZjJhMi8zZmIzOTQwMD4KICAxMDogICA3NSBhMiAgICAgICAgICAgICAgICAg
ICAgIGpuZSAgICBmZmZmZmZiNCA8X0VJUCsweGZmZmZmZmI0PgpERUJVRyAo
bWFwX2FkZHJlc3MpOiBtZXJnZWQgZjg4NjQyYTQKQ29kZTsgIGY4ODY0MmE0
IDxwZzArMzgzOWYyYTQvM2ZiMzk0MDA+CiAgMTI6ICAgODMgYzQgMTQgICAg
ICAgICAgICAgICAgICBhZGQgICAgJDB4MTQsJWVzcApERUJVRyAobWFwX2Fk
ZHJlc3MpOiBtZXJnZWQgZjg4NjQyYTcKQ29kZTsgIGY4ODY0MmE3IDxwZzAr
MzgzOWYyYTcvM2ZiMzk0MDA+CiAgMTU6ICAgNWIgICAgICAgICAgICAgICAg
ICAgICAgICBwb3AgICAgJWVieApERUJVRyAobWFwX2FkZHJlc3MpOiBtZXJn
ZWQgZjg4NjQyYTgKQ29kZTsgIGY4ODY0MmE4IDxwZzArMzgzOWYyYTgvM2Zi
Mzk0MDA+CiAgMTY6ICAgNWUgICAgICAgICAgICAgICAgICAgICAgICBwb3Ag
ICAgJWVzaQpERUJVRyAobWFwX2FkZHJlc3MpOiBtZXJnZWQgZjg4NjQyYTkK
Q29kZTsgIGY4ODY0MmE5IDxwZzArMzgzOWYyYTkvM2ZiMzk0MDA+CiAgMTc6
ICAgNWYgICAgICAgICAgICAgICAgICAgICAgICBwb3AgICAgJWVkaQpERUJV
RyAobWFwX2FkZHJlc3MpOiBtZXJnZWQgZjg4NjQyYWEKQ29kZTsgIGY4ODY0
MmFhIDxwZzArMzgzOWYyYWEvM2ZiMzk0MDA+CiAgMTg6ICAgNWQgICAgICAg
ICAgICAgICAgICAgICAgICBwb3AgICAgJWVicApERUJVRyAobWFwX2FkZHJl
c3MpOiBtZXJnZWQgZjg4NjQyYWIKQ29kZTsgIGY4ODY0MmFiIDxwZzArMzgz
OWYyYWIvM2ZiMzk0MDA+CiAgMTk6ICAgYzMgICAgICAgICAgICAgICAgICAg
ICAgICByZXQgICAgCkRFQlVHIChtYXBfYWRkcmVzcyk6IG1lcmdlZCBmODg2
NDJhYwpDb2RlOyAgZjg4NjQyYWMgPHBnMCszODM5ZjJhYy8zZmIzOTQwMD4K
ICAxYTogICA4ZCA3NCAyNiAwMCAgICAgICAgICAgICAgIGxlYSAgICAweDAo
JWVzaSksJWVzaQpERUJVRyAobWFwX2FkZHJlc3MpOiBtZXJnZWQgZjg4NjQy
YjAKQ29kZTsgIGY4ODY0MmIwIDxwZzArMzgzOWYyYjAvM2ZiMzk0MDA+CiAg
MWU6ICAgNTUgICAgICAgICAgICAgICAgICAgICAgICBwdXNoICAgJWVicApE
RUJVRyAobWFwX2FkZHJlc3MpOiBtZXJnZWQgZjg4NjQyYjEKQ29kZTsgIGY4
ODY0MmIxIDxwZzArMzgzOWYyYjEvM2ZiMzk0MDA+CiAgMWY6ICAgODkgZTUg
ICAgICAgICAgICAgICAgICAgICBtb3YgICAgJWVzcCwlZWJwCkRFQlVHICht
YXBfYWRkcmVzcyk6IG1lcmdlZCBmODg2NDJiMwpDb2RlOyAgZjg4NjQyYjMg
PHBnMCszODM5ZjJiMy8zZmIzOTQwMD4KICAyMTogICA1MyAgICAgICAgICAg
ICAgICAgICAgICAgIHB1c2ggICAlZWJ4CkRFQlVHIChtYXBfYWRkcmVzcyk6
IG1lcmdlZCBmODg2NDJiNApDb2RlOyAgZjg4NjQyYjQgPHBnMCszODM5ZjJi
NC8zZmIzOTQwMD4KICAyMjogICA4MyBlYyAxNCAgICAgICAgICAgICAgICAg
IHN1YiAgICAkMHgxNCwlZXNwCkRFQlVHIChtYXBfYWRkcmVzcyk6IG1lcmdl
ZCBmODg2NDJiNwpDb2RlOyAgZjg4NjQyYjcgPHBnMCszODM5ZjJiNy8zZmIz
OTQwMD4KICAyNTogICA4YiA1ZCAwOCAgICAgICAgICAgICAgICAgIG1vdiAg
ICAweDgoJWVicCksJWVieApERUJVRyAobWFwX2FkZHJlc3MpOiBtZXJnZWQg
Zjg4NjQyYmEKQ29kZTsgIGY4ODY0MmJhIDxwZzArMzgzOWYyYmEvM2ZiMzk0
MDA+CiAgMjg6ICAgOGIgNGIgMDQgICAgICAgICAgICAgICAgICBtb3YgICAg
MHg0KCVlYngpLCVlY3gKClRoaXMgZGVjb2RlIGZyb20gZWlwIG9ud2FyZHMg
c2hvdWxkIGJlIHJlbGlhYmxlCgpERUJVRyAobWFwX2FkZHJlc3MpOiBtZXJn
ZWQgZjg4NjQyYmQKQ29kZTsgIGY4ODY0MmJkIDxwZzArMzgzOWYyYmQvM2Zi
Mzk0MDA+CjAwMDAwMDAwIDxfRUlQPjoKREVCVUcgKG1hcF9hZGRyZXNzKTog
bWVyZ2VkIGY4ODY0MmJkCkNvZGU7ICBmODg2NDJiZCA8cGcwKzM4MzlmMmJk
LzNmYjM5NDAwPiAgIDw9PT09PQogICAwOiAgIDgzIGI5IGE4IDAyIDAwIDAw
IDA2ICAgICAgY21wbCAgICQweDYsMHgyYTgoJWVjeCkgICA8PT09PT0KREVC
VUcgKG1hcF9hZGRyZXNzKTogbWVyZ2VkIGY4ODY0MmM0CkNvZGU7ICBmODg2
NDJjNCA8cGcwKzM4MzlmMmM0LzNmYjM5NDAwPgogICA3OiAgIDc0IDJhICAg
ICAgICAgICAgICAgICAgICAgamUgICAgIDMzIDxfRUlQKzB4MzM+CkRFQlVH
IChtYXBfYWRkcmVzcyk6IG1lcmdlZCBmODg2NDJjNgpDb2RlOyAgZjg4NjQy
YzYgPHBnMCszODM5ZjJjNi8zZmIzOTQwMD4KICAgOTogICA4YiA5MyA0YyAw
MSAwMCAwMCAgICAgICAgIG1vdiAgICAweDE0YyglZWJ4KSwlZWR4CkRFQlVH
IChtYXBfYWRkcmVzcyk6IG1lcmdlZCBmODg2NDJjYwpDb2RlOyAgZjg4NjQy
Y2MgPHBnMCszODM5ZjJjYy8zZmIzOTQwMD4KICAgZjogICA4OSBkMCAgICAg
ICAgICAgICAgICAgICAgIG1vdiAgICAlZWR4LCVlYXgKREVCVUcgKG1hcF9h
ZGRyZXNzKTogbWVyZ2VkIGY4ODY0MmNlCkNvZGU7ICBmODg2NDJjZSA8cGcw
KzM4MzlmMmNlLzNmYjM5NDAwPgogIDExOiAgIGMxIGY4IDEwICAgICAgICAg
ICAgICAgICAgc2FyICAgICQweDEwLCVlYXgKREVCVUcgKG1hcF9hZGRyZXNz
KTogbWVyZ2VkIGY4ODY0MmQxCkNvZGU7ICBmODg2NDJkMSA8cGcwKzM4Mzlm
MmQxLzNmYjM5NDAwPgogIDE0OiAgIDI1ICAgICAgICAgICAgICAgICAgICAg
ICAgLmJ5dGUgMHgyNQoKREVCVUcgKE9vcHNfcmVhZCk6ICA8MD5LZXJuZWwg
cGFuaWMgLSBub3Qgc3luY2luZzogRmF0YWwgZXhjZXB0aW9uIGluIGludGVy
cnVwdAogPDA+S2VybmVsIHBhbmljIC0gbm90IHN5bmNpbmc6IEZhdGFsIGV4
Y2VwdGlvbiBpbiBpbnRlcnJ1cHQKREVCVUcgKE9vcHNfcmVhZCk6IAoKMSBl
cnJvciBpc3N1ZWQuICBSZXN1bHRzIG1heSBub3QgYmUgcmVsaWFibGUuCg==


--0-1608146152-1154619757=:12163--
