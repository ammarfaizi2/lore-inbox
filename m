Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262454AbVBXTUz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262454AbVBXTUz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 14:20:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262453AbVBXTUz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 14:20:55 -0500
Received: from heisenberg.zen.co.uk ([212.23.3.141]:60597 "EHLO
	heisenberg.zen.co.uk") by vger.kernel.org with ESMTP
	id S262454AbVBXTUD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 14:20:03 -0500
Message-Id: <200502241920.j1OJJxj0016253@StraightRunning.com>
From: "Colin Harrison" <colin.harrison@virgin.net>
To: <linux-kernel@vger.kernel.org>
Subject: RE: Kernel oops in mm/rmap.c in 2.6.11rc4-bk9
Date: Thu, 24 Feb 2005 19:20:20 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
In-Reply-To: 
X-Copyright: Copyright (c) 2005 Colin Harrison
X-Domain: StraightRunning.com
X-Admin: colin@straightrunning.com
X-Originating-Heisenberg-IP: [62.3.107.196]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Fresher trace of my oops captured over a serial tty link (kernel now
2.6.11rc4-bk11) 

Kernel 2.6.11colin on an i686 / ttyS0
verbier.straightrunning.com login: ------------[ cut here ]------------
kernel BUG at mm/rmap.c:482!
invalid operand: 0000 [#1]
Modules linked in: parport_pc lp parport ipt_LOG ipt_REJECT ipt_state
ipt_limite
CPU:    0
EIP:    0060:[<c013cc28>]    Not tainted VLI
EFLAGS: 00010296   (2.6.11colin)
EIP is at page_remove_rmap+0x38/0x50
eax: fffff000   ebx: 00064000   ecx: c039878c   edx: c123ca00
esi: d2389f30   edi: 00098000   ebp: d10e0e4c   esp: d10e0e4c
ds: 007b   es: 007b   ss: 0068
Process cc1 (pid: 10543, threadinfo=d10e0000 task=ced11a80)
Stack: d10e0e80 c013661b c12335c0 cef90904 00000001 00000000 11e50067
c123ca00
       b7b68000 c039878c b7f68000 d1f10b7c b7c00000 d10e0ea8 c01367a1
00098000
       00000000 c039878c b8241000 c039878c b7b68000 d1f10b7c b7c00000
d10e0ed0
Call Trace:
 [<c0102736>] show_stack+0xa6/0xb0
 [<c01028a9>] show_registers+0x149/0x1c0
 [<c0102a8b>] die+0xbb/0x150
 [<c0102b9e>] do_trap+0x7e/0xc0
 [<c0102e15>] do_invalid_op+0xa5/0xb0
 [<c01023af>] error_code+0x2b/0x30
 [<c013661b>] zap_pte_range+0x13b/0x270
 [<c01367a1>] zap_pmd_range+0x51/0x70
 [<c01367fd>] zap_pud_range+0x3d/0x70
 [<c0136897>] unmap_page_range+0x67/0x80
 [<c01369a4>] unmap_vmas+0xf4/0x1e0
 [<c013afe8>] exit_mmap+0x68/0x130
 [<c01100d1>] mmput+0x21/0x70
 [<c011343e>] exit_mm+0xbe/0xe0
 [<c0113d9d>] do_exit+0x9d/0x2c0
 [<c0114032>] do_group_exit+0x32/0x70
 [<c011407f>] sys_exit_group+0xf/0x20
 [<c0102145>] sysenter_past_esp+0x52/0x75
Code: 42 08 ff 0f 98 c0 84 c0 74 15 8b 42 08 40 78 1b ba ff ff ff ff b8 10
00 0

Entering kdb (current=0xced11a80, pid 10543) Oops: invalid operand
due to oops @ 0xc013cc28
eax = 0xfffff000 ebx = 0x00064000 ecx = 0xc039878c edx = 0xc123ca00
esi = 0xd2389f30 edi = 0x00098000 esp = 0xd10e0e4c eip = 0xc013cc28
ebp = 0xd10e0e4c xss = 0xc0210068 xcs = 0x00000060 eflags = 0x00010296
xds = 0xc122007b xes = 0x0000007b origeax = 0xffffffff &regs = 0xd10e0e18
kdb>

Thanks

Colin Harrison

> -----Original Message-----
> From: Colin Harrison [mailto:colin.harrison@virgin.net] 
> Sent: 21 February 2005 18:45
> To: 'linux-kernel@vger.kernel.org'
> Subject: Kernel oops in mm/rmap.c in 2.6.11rc4-bk9
> 
> Hi
> 
> I've been getting a hang on my firewall machine for some 
> weeks when pushed.
> 
> Kernel freezes when heavily loaded either compiling or under 
> lots of web traffic.
> Machine is a Pentium III 450MHz i440BX Intel Mobo with 384MHz 
> memory running a firewall (iptables-1.3.0-200050220) via two 
> natsemi network cards.
> (old machine but should be good as firewall only...been solid 
> for years!) Kernel 2.6.11rc4-bk9 + supermount patch.
> 
> I have another machine which I am going to connect via serial 
> cable to help debug.
> (this has also been known to freeze on 2.6.11...a common 
> denominator is that I use Netgear natsemi net cards in 
> both...probably not significant?)
> 
> I've today built in KDB and get the following trace:-
> 
> In this case while compiling a kernel (make bzImage...running cc1)
> 
> Typed by hand:-
> 
> kernel BUG at mm/rmap.c:482!
> invalid operand: 0000 [#1]
> Modules linked in: parport_pc lp parport ipt_LOG ipt_REJECT 
> ipt_state ipt_limit iptable_mangle iptable_filter ip_nat_ftp 
> iptable_nat ip_conntrack_ftp floppy natsemi supermount 
> intel_agp agpgart cs4243 ad1848 uart401 sound soundcore
> CPU:    0
> EIP:    0060:[<c013cc28>]   Not tainted VLI
> EFLAGS: 00010296   (2.6.11colin)
> EIP is at page_remove_rmap+0x38/0x50
> eax: fffff000   ebx: 0002f000   ecx: c038d78c   edx: c123sd20
> esi: d0e7e44c   edi: 00090000   ebp: d2a6ae4c   esp: d2a6ae4c
> ds: 007b   es: 007b   ss: 0068
> Process cc1 (pid: 10835, threadinfo=d2a6a000 task=cf57aaa0)
> Stack: d2a6ae80
> etc......
> 
> 
> 
> Entered kdb (current=0xcf57aaa0, pid 10835) Oops: invalid 
> operand due to oops @ 0xc013cc28 etc...
> 
> More info can be supplied if required and patches compiled in 
> to trace etc.
> Note that I have run a memory checker (memtest-86 v3.2 boot 
> CD) for ~ 3hours with no errors.
> I can usually repeat the crash while compiling a 
> kernel..which after a reboot recovers and allows 'make 
> bzImage' 'make modules' to finish!
> 
> Thanks
> Colin Harrison
> 

