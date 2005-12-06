Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750737AbVLFLQc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750737AbVLFLQc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 06:16:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750798AbVLFLQc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 06:16:32 -0500
Received: from ext-gw.newtoncomputing.co.uk ([81.2.122.18]:40454 "EHLO
	mail.newtoncomputing.co.uk") by vger.kernel.org with ESMTP
	id S1750737AbVLFLQb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 06:16:31 -0500
Date: Tue, 6 Dec 2005 11:16:25 +0000
From: matthew-lkml@newtoncomputing.co.uk
To: linux-kernel@vger.kernel.org
Subject: 2.4.27 crashed: any ideas?
Message-ID: <20051206111625.GA6542@newtoncomputing.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
X-NC-Fw-Sig: 579b9f15cc6d6ef038f7c9571346d6bf matthew-lkml@newtoncomputing.co.uk
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Our main user-facing Linux machine at work crashed a couple of times over the
last few days, both with the same error. It's been up and stable for the last
80ish days (from when it was upgraded to Debian sarge), and had no problems
before that with the same kernel.

Machine is an HP DL740 with four Xeon 2Ghz CPUs and 4Gb RAM (5Gb RAID 5).

I've put both outputs that our console logger saved, and the result from running
them through ksymoops, at http://www.le.ac.uk/cc/mcn4/problem/

I realise the kernel is tainted. It's a locally compiled Debian kernel. I think
the non-free module is the qla SAN card driver, but I'm not sure (is there a way
of finding out what exactly tainted the kernel?)

The strange thing is that both times it seemed to crash in cfi_probe, which
looks like something to do with Compact Flash / MTDs. Something we don't use.

Unfortunately the machine is in constant use, so it's probably going to be
difficult to do things to investigate this, unless it crashes again. I'll try
and get output from different sysrq-type things next time, too.

However, any ideas where I can look further to work out what caused this?

Thanks!

Matthew


uname -a:

Linux falcon 2.4.27-686-smp-uol1 #1 SMP Thu Apr 21 12:45:26 BST 2005 i686
GNU/Linux

The first oops was:

Dec  4 07:33:45 falcon kernel: Unable to handle kernel NULL pointer dereference
at virtual address 00000004 
Dec  4 07:33:45 falcon kernel:  printing eip: 
Dec  4 07:33:45 falcon kernel: f8934bc4 
Dec  4 07:33:45 falcon kernel: *pde = 18d3e001 
Dec  4 07:33:45 falcon kernel: *pte = 00000000 
Dec  4 07:33:45 falcon kernel: Oops: 0002 
Dec  4 07:33:45 falcon kernel: CPU:    1 
Dec  4 07:33:45 falcon kernel: EIP:
0010:[cfi_probe:__insmod_cfi_probe_O/lib/modules/2.4.27-686-smp-uol1/kernel+-3015740/96]
Tainted: P  
Dec  4 07:33:45 falcon kernel: EFLAGS: 00010202 
Dec  4 07:33:45 falcon kernel: eax: 00000000   ebx: f8bb0068   ecx: f8b81c90
edx: 00000000 
Dec  4 07:33:45 falcon kernel: esi: 00150400   edi: c63db200   ebp: 00000805
esp: dfc31d40 
Dec  4 07:33:45 falcon kernel: ds: 0018   es: 0018   ss: 0018 
Dec  4 07:33:45 falcon kernel: Process cortex.3.5.4 (pid: 18691,
stackpage=dfc31000) 
Dec  4 07:33:45 falcon kernel: Stack: c63db200 c63db370 f6bd5970 00400000
00000080 00000007 00000060 00000000  
Dec  4 07:33:45 falcon kernel:        f89316d1 dfc31d9e dfc31da0 00150180
c63db200 00003a02 dccbc1a0 001402e0  
Dec  4 07:33:45 falcon kernel:        00400000 ed16ee60 001002e0 f6bd5800
f6bd4000 00150180 00000140 08050000  
Dec  4 07:33:45 falcon kernel: Call Trace:
[cfi_probe:__insmod_cfi_probe_O/lib/modules/2.4.27-686-smp-uol1/kernel+-3029295/96]
[cfi_probe:__insmod_cfi_probe_O/lib/modules/2.4.27-686-smp-uol1/kernel+-3029065/96]
[generic_make_request+288/304] [submit_bh+86/224] [sync_page_buffers+148/172] 
Dec  4 07:33:45 falcon kernel:   [try_to_free_buffers+294/332]
[try_to_release_page+68/72] [shrink_cache+557/1060] [shrink_caches+60/72]
[try_to_free_pages_zone+100/240] [balance_classzone+72/456] 
Dec  4 07:33:45 falcon kernel:   [__alloc_pages+396/652] [_alloc_pages+22/24]
[__get_free_pages+10/24] [__pollwait+51/144] [tcp_poll+46/348] [sock_poll+35/40] 
Dec  4 07:33:45 falcon kernel:   [do_select+272/516] [sys_select+810/1132]
[system_call+51/56] 
Dec  4 07:33:45 falcon kernel:  
Dec  4 07:33:45 falcon kernel: Code: 89 42 04 89 10 c7 01 00 00 00 00 c7 41 04
00 00 00 00 8b 03  

modules:

Module                  Size  Used by    Tainted: P  
lp                      6048   0 (unused)
parport                24320   0 [lp]
ipt_REJECT              3584   1 (autoclean)
ipt_state                672  18 (autoclean)
iptable_filter          1824   1 (autoclean)
ip_tables              11904   3 [ipt_REJECT ipt_state iptable_filter]
fan                     1612   0 (unused)
ac                      1868   0
battery                 6060   0 (unused)
ext2                   46592   8 (autoclean)
cfi_probe               4896   0 (autoclean)
gen_probe               1824   0 (autoclean) [cfi_probe]
chipreg                  972   0 [cfi_probe]
usb-ohci               19424   0 (unused)
usbcore                58944   1 [usb-ohci]
cpqphp                 66884   0 (unused)
pci_hotplug            16024   1 [cpqphp]
md                     57248   0 (autoclean) (unused)
loop                    8976   0 (autoclean)
dm-mod                 44268   0 (unused)
quota_v2                6392   2
thermal                 6896   0
processor               9088   0 [thermal]
button                  2744   0 (unused)
ip_conntrack_ftp        3936   0 (unused)
ip_conntrack_amanda     1504   0 (unused)
ip_conntrack           21460   2 [ipt_state ip_conntrack_ftp ip_conntrack_amanda]
bcm5700               102532   1
rtc                     6620   0 (autoclean)
ext3                   76864  16 (autoclean)
jbd                    40696  16 (autoclean) [ext3]
lvm-mod                59872  49 (autoclean)
sd_mod                 11004  48 (autoclean)
qla2300_conf          300832   0 (autoclean)
qla2300               567296  24
unix                   16164 867 (autoclean)
cciss                  56224   6 (autoclean)
scsi_mod               96060   2 (autoclean) [sd_mod qla2300 cciss]


-- 
Matthew
