Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261682AbVFMQJO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261682AbVFMQJO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 12:09:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261325AbVFMQJN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 12:09:13 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:45008 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S261682AbVFMQGE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 12:06:04 -0400
Subject: Re: PROBLEM: 2.6.11.10 reiserfs panic with quota and soft raid1
From: Vladimir Saveliev <vs@namesys.com>
To: tchesmeli serge <tchesmeli.serge@wanadoo.fr>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <200506131329.18803.tchesmeli.serge@wanadoo.fr>
References: <200506131329.18803.tchesmeli.serge@wanadoo.fr>
Content-Type: multipart/mixed; boundary="=-CMV8Z5MwUI/cqi2YKFIY"
Message-Id: <1118678749.3604.125.camel@tribesman.namesys.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Mon, 13 Jun 2005 20:05:51 +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-CMV8Z5MwUI/cqi2YKFIY
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hello

On Mon, 2005-06-13 at 15:29, tchesmeli serge wrote:
> Hi all,
> 
> i got a reiserfs panic with kernel 2.6.11.10 , quota support on a raid1 soft 
> partiton. 
> 
> Here the panic trace log, system information, environement, ...
> If you need more info, please ask me.
> Excuse for my poor english, i'm a french user.
> 
> 
> Panic log:
> 
> Jun 11 12:26:28 sky kernel: ReiserFS: md4: warning: PAP-5660: 
> reiserfs_do_truncate: wrong result -1 of search for [1515870810 1515870810 
> 0xffffffff DIRECT]

Please try reiserfsck md4.

> Jun 11 12:26:28 sky kernel: ReiserFS: md4: warning: clm-2100: nesting info a 
> different FS

Please try the attached patch. It may help to get rid of this.

> Jun 11 12:26:28 sky last message repeated 2 times
> Jun 11 12:26:28 sky kernel: ReiserFS: md4: warning: BAD: refcount <= 1, but 
> journal_info != 0
> Jun 11 12:26:28 sky kernel: REISERFS: panic (device md4): journal-1577: handle 
> trans id 36 != current trans id 308616
> Jun 11 12:26:28 sky kernel:
> Jun 11 12:26:28 sky kernel: ------------[ cut here ]------------
> Jun 11 12:26:28 sky kernel: kernel BUG at fs/reiserfs/prints.c:362!
> Jun 11 12:26:28 sky kernel: invalid operand: 0000 [#1]
> Jun 11 12:26:28 sky kernel: Modules linked in: w83627hf i2c_sensor i2c_isa 
> i2c_core ipt_state ipt_REJECT ipt_LOG ipt_limit ip_nat_ftp ip_conntrack_ftp 
> iptable_mangle iptable_nat ip_conntrack ip
> table_filter ip_tables ide_scsi
> Jun 11 12:26:28 sky kernel: CPU:    0
> Jun 11 12:26:28 sky kernel: EIP:    0060:[<c01f33f2>]    Not tainted VLI
> Jun 11 12:26:28 sky kernel: EFLAGS: 00010282   (2.6.11.10)
> Jun 11 12:26:28 sky kernel: EIP is at reiserfs_panic+0x52/0x80
> Jun 11 12:26:28 sky kernel: eax: 0000005e   ebx: c05091c5   ecx: c065c480   
> edx: 00000000
> Jun 11 12:26:28 sky kernel: esi: f7a42d50   edi: f7a42f20   ebp: c051fe60   
> esp: f5c7bc50
> Jun 11 12:26:28 sky kernel: ds: 007b   es: 007b   ss: 0068
> Jun 11 12:26:28 sky kernel: Process vi (pid: 29212, threadinfo=f5c7a000 
> task=f7be18f0)
> Jun 11 12:26:28 sky kernel: Stack: c0517b80 f7a42f20 c066b5e0 00000000 
> f8c8e000 f5c7a000 c0209168 f7a42d50
> Jun 11 12:26:28 sky kernel:        c051fe60 00000024 0004b588 00000246 
> 00000000 00000000 f8c8e000 00000000
> Jun 11 12:26:28 sky kernel:        f5c7a000 00000000 c020987f f5c7bd38 
> f7a42d50 000000f2 00000000 c065c0a5
> Jun 11 12:26:28 sky kernel: Call Trace:
> Jun 11 12:26:28 sky kernel:  [<c0209168>] check_journal_end+0x258/0x270
> Jun 11 12:26:28 sky kernel:  [<c020987f>] do_journal_end+0x11f/0xa80
> Jun 11 12:26:28 sky kernel:  [<c012457a>] vprintk+0x1aa/0x310
> Jun 11 12:26:28 sky kernel:  [<c01243c7>] printk+0x17/0x20
> Jun 11 12:26:28 sky kernel:  [<c0208aaa>] journal_end+0xaa/0x100
> Jun 11 12:26:28 sky kernel:  [<c01f1ba7>] reiserfs_dquot_drop+0x57/0x70
> Jun 11 12:26:28 sky kernel:  [<c0208730>] journal_begin+0xd0/0x100
> Jun 11 12:26:28 sky kernel:  [<c01e33c0>] reiserfs_new_inode+0x160/0x770
> Jun 11 12:26:28 sky kernel:  [<c0209e25>] do_journal_end+0x6c5/0xa80
> Jun 11 12:26:28 sky kernel:  [<c0124190>] call_console_drivers+0x70/0x130
> Jun 11 12:26:28 sky kernel:  [<c030916b>] vscnprintf+0x2b/0x40
> Jun 11 12:26:28 sky kernel:  [<c02081ea>] do_journal_begin_r+0x6a/0x300
> Jun 11 12:26:28 sky kernel:  [<c01ddc4b>] reiserfs_create+0xab/0x250
> Jun 11 12:26:28 sky kernel:  [<c018feb9>] permission+0x89/0xa0
> Jun 11 12:26:28 sky kernel:  [<c01923b1>] vfs_create+0xa1/0x130
> Jun 11 12:26:28 sky kernel:  [<c0192ce6>] open_namei+0x616/0x670
> Jun 11 12:26:28 sky kernel:  [<c017b15e>] filp_open+0x3e/0x70
> Jun 11 12:26:28 sky kernel:  [<c017b819>] sys_open+0x49/0x90
> Jun 11 12:26:28 sky kernel:  [<c0103ac3>] syscall_call+0x7/0xb
> Jun 11 12:26:28 sky kernel: Code: 01 00 00 89 04 24 e8 ae fc ff ff c7 04 24 80 
> 7b 51 c0 85 f6 89 d8 0f 45 c7 ba e0 b5 66 c0 89 54 24 08 89 44 24 04 e8 be 0f 
> f3 ff <0f> 0b 6a 01 82 97 50 c0 c7 0
> 4 24 c0 7b 51 c0 85 f6 b9 e0 b5 66
> 
> 
> -------------------------------------------------------------------------------------------------------------------------
> 
> Environement:
> 
> Slackware Linux 10.1:
> 	- Kernel 2.6.11.10 (see config file atached in this mail)
> 	- reiserfsprogs-3.6.19
> 	- quota-3.12
> 
> -------------------------------------------------------------------------------------------------------------------------
> 
> /proc/cpuinfo:
> processor       : 0
> vendor_id       : GenuineIntel
> cpu family      : 15
> model           : 2
> model name      : Intel(R) Celeron(R) CPU 2.40GHz
> stepping        : 9
> cpu MHz         : 2390.335
> cache size      : 128 KB
> fdiv_bug        : no
> hlt_bug         : no
> f00f_bug        : no
> coma_bug        : no
> fpu             : yes
> fpu_exception   : yes
> cpuid level     : 2
> wp              : yes
> flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
> cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
> bogomips        : 4771.02
> 
> -------------------------------------------------------------------------------------------------------------------------
> 
> /sbin/lspci  -vvv
> 00:00.0 Host bridge: Silicon Integrated Systems [SiS] 650/M650 Host (rev 01)
>         Subsystem: Silicon Integrated Systems [SiS] 650/M650 Host
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
> Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
> <TAbort- <MAbort+ >SERR- <PERR-
>         Latency: 32
>         Region 0: Memory at e0000000 (32-bit, non-prefetchable) [size=4M]
>         Capabilities: [c0] AGP version 2.0
>                 Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 
> 64bit- FW+ AGP3- Rate=x1,x2,x4
>                 Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- 
> Rate=<none>
> 
> 00:01.0 PCI bridge: Silicon Integrated Systems [SiS] Virtual PCI-to-PCI bridge 
> (AGP) (prog-if 00 [Normal decode])
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
> Stepping- SERR+ FastB2B-
>         Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 64
>         Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
>         I/O behind bridge: 0000d000-0000dfff
>         Memory behind bridge: c8400000-c84fffff
>         Prefetchable memory behind bridge: c0000000-c7ffffff
>         BridgeCtl: Parity- SERR+ NoISA+ VGA+ MAbort- >Reset- FastB2B-
> 
> 00:02.0 ISA bridge: Silicon Integrated Systems [SiS] SiS85C503/5513 (LPC 
> Bridge)
>         Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- 
> Stepping- SERR- FastB2B-
>         Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 0
> 
> 00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (rev d0) 
> (prog-if 80 [Master])
>         Subsystem: Silicon Integrated Systems [SiS] SiS5513 EIDE Controller 
> (A,B step)
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
> Stepping- SERR- FastB2B-
>         Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 128
>         Region 4: I/O ports at 4000 [size=16]
> 
> 00:0f.0 Ethernet controller: Realtek Semiconductor Co., Ltd. 
> RTL-8139/8139C/8139C+ (rev 10)
>         Subsystem: Realtek Semiconductor Co., Ltd. RT8139
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
> Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
> <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 32 (8000ns min, 16000ns max)
>         Interrupt: pin A routed to IRQ 18
>         Region 0: I/O ports at e000 [size=256]
>         Region 1: Memory at c8502000 (32-bit, non-prefetchable) [size=256]
>         Capabilities: [50] Power Management version 2
>                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA 
> PME(D0-,D1+,D2+,D3hot+,D3cold+)
>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 
> 01:00.0 VGA compatible controller: Silicon Integrated Systems [SiS] 
> 65x/M650/740 PCI/AGP VGA Display Adapter (prog-if 00 [VGA])
>         Subsystem: Silicon Integrated Systems [SiS] 65x/M650/740 PCI/AGP VGA 
> Display Adapter
>         Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
> Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
> <TAbort- <MAbort- >SERR- <PERR-
>         Interrupt: pin A routed to IRQ 16
>         BIST result: 00
>         Region 0: Memory at c0000000 (32-bit, prefetchable) [size=128M]
>         Region 1: Memory at c8400000 (32-bit, non-prefetchable) [size=128K]
>         Region 2: I/O ports at d000 [size=128]
>         Capabilities: [40] Power Management version 1
>                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>         Capabilities: [50] AGP version 2.0
>                 Status: RQ=16 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 
> 64bit- FW- AGP3- Rate=x1,x2,x4
>                 Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- 
> Rate=<none>
> 
> 
> 

--=-CMV8Z5MwUI/cqi2YKFIY
Content-Disposition: attachment; filename=reiserfs-add-missing-jounal_end.patch
Content-Type: text/plain; name=reiserfs-add-missing-jounal_end.patch; charset=KOI8-R
Content-Transfer-Encoding: 7bit

 fs/reiserfs/inode.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletion(-)

diff -puN fs/reiserfs/inode.c~reiserfs-add-missing-jounal_end fs/reiserfs/inode.c
--- linux-2.6.12-rc5-mm2/fs/reiserfs/inode.c~reiserfs-add-missing-jounal_end	2005-06-13 19:59:48.380292142 +0400
+++ linux-2.6.12-rc5-mm2-vs/fs/reiserfs/inode.c	2005-06-13 20:01:29.477116249 +0400
@@ -46,6 +46,7 @@ void reiserfs_delete_inode (struct inode
 	reiserfs_update_inode_transaction(inode) ;
 
 	if (reiserfs_delete_object (&th, inode)) {
+	    journal_end(&th, inode->i_sb, jbegin_count);
 	    up (&inode->i_sem);
 	    goto out;
 	}
@@ -2017,8 +2018,10 @@ int reiserfs_truncate_file(struct inode 
 	       either appears truncated properly or not truncated at all */
 	add_save_link (&th, p_s_inode, 1);
     error = reiserfs_do_truncate (&th, p_s_inode, page, update_timestamps) ;
-    if (error)
+    if (error) {
+        journal_end (&th, p_s_inode->i_sb, JOURNAL_PER_BALANCE_CNT * 2 + 1);
         goto out;
+    }
     error = journal_end (&th, p_s_inode->i_sb, JOURNAL_PER_BALANCE_CNT * 2 + 1);
     if (error)
         goto out;

_

--=-CMV8Z5MwUI/cqi2YKFIY--

