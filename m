Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262464AbUKRPDh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262464AbUKRPDh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 10:03:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262435AbUKRPB5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 10:01:57 -0500
Received: from chic01-104.240.digitalpath.net ([65.164.104.240]:39145 "EHLO
	opennms.digitalpath.net") by vger.kernel.org with ESMTP
	id S262405AbUKRPAH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 10:00:07 -0500
Date: Thu, 18 Nov 2004 07:00:06 -0800
From: Ray Van Dolson <rayvd@corp.digitalpath.net>
To: linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at kernel/exit.c:842! (2.6.9, PoPToP and ppp_mppe)
Message-ID: <20041118150006.GA6241@digitalpath.net>
References: <20041109054725.GA22764@digitalpath.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041109054725.GA22764@digitalpath.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey all--this same "bug" has happened again.  Seems to happen pretty regularly
every four days.  Perhaps this is a hardware issue(?) but it happens on all
of our HP DL140's... anyone have any thoughts or ideas on why this might
be happening?  Here is the latest:

EFLAGS: 00010246   (2.6.9-1.1_FC2custom)
EIP:    0060:[<02121d10>]    Tainted: P   VLI
CPU:    1
Modules linked in: sch_tbf(U) ppp_mppe(U) ppp_async(U) crc_ccitt(U) ppp_generic(U) slhc(U) ipt_limit(U) ipt_REJECT(U) ipt_mult iport(U) iptable_filter(U) iptable_nat(U) ip_conntrack(U) ip_tables(U) sunrpc(U) e100(U) mii(U) sg(U) scsi_mod(U) microcode(U) dm_mod(U) ohci_hcd(U) button(U) bat tery(U) ac(U) ext3(U) jbd(U)
SMP
invalid operand: 0000 [#1]
kernel BUG at kernel/exit.c:842!

For whatever reason, there was not as much output this time.

Again, the kernel is tainted with the ppp_mppe module.  If anyone has
suggestions on a different MPPE module that does not taint the kernel, I would
love to try it.

Appreciate any ideas--even knowing that this is *not* a kernel bug at all
would give me some ammunition when talking with HP tech support.

On Mon, Nov 08, 2004 at 09:47:25PM -0800, Ray Van Dolson wrote:

> Apologies for creating a new thread for this. This seems to be a different
> "oops" than my last thread...
>
> My current setup is a Fedora Core 2 box with Kernel 2.6.9-1.1_FC2 + the
> ppp_mppe patch by Frank Cusack from the pppd 2.4.3 sources. This module
> is what is taining the kernel. All the other modules are stock kernel
> modules.
>
> After about 72 hours or so of runtime on a very busy Poptop server (~750
> users or so), I begin seeing a few "Neighbour table overflow" error messages
> in my /var/log/messages file. Things seem to continue running OK however,
> but eventually the following oops shows up:
>
>  kernel BUG at kernel/exit.c:842!
>  invalid operand: 0000 [#1]
>  SMP
>  Modules linked in: sch_tbf(U) ppp_async(U) crc_ccitt(U) ppp_mppe(U)
>  ppp_generic(U) slhc(U) ipt_limit(U) ipt_REJECT(U) ipt_multiport(U)
>  iptable_filter(U) iptable_nat(U) ip_conntrack(U) ip_tables(U) sunrpc(U)
>  e100(U) mii(U) sg(U) scsi_mod(U) microcode(U) dm_mod(U) ohci_hcd(U)
>  button(U) battery(U) ac(U) ext3(U) jbd(U)
>  CPU: 2
>  EIP: 0060:[<02121d10>] Tainted: P VLI
>  EFLAGS: 00010246 (2.6.9-1.1_FC2custom)
>  EIP is at do_exit+0x3b3/0x3bd
>  eax: 00000000 ebx: 26506560 ecx: 26506000 edx: 0381dd60
>  esi: 41fec340 edi: 26506030 ebp: 00001000 esp: 23b82f98
>  ds: 007b es: 007b ss: 0068
>  Process pppd (pid: 27091, threadinfo=23b82000 task=26506030)
>  Stack: 0d611e00 00001000 23b82000 23b82000 02121e05 00001000 23b82fc4      
>  00000010 f6f32684 23b82000 fffec200 00000010 00000000 00000000 00000010    
>  f6f32684 fef87938 000000fc 0000007b 0000007b 000000fc f6fa37a2 00000073    
>  00000246                                                                   
>  Call Trace: [<02121e05>] sys_exit_group+0x0/0xd
>  Code: c1 e0 07 8d 04 10 ff 88 00 01 00 00 83 3a 02 75 0b 8b 82 08 11 00
>  00 e8 d8 95 ff ff 89 6f 7c 89 f8 e8 88 f5 ff ff e8 bc 74 19 00 <0f> 0b 4a
>  03 96 09 2d 02 eb fe 53 85 c0 89 d3 74 05 e8 35 ab ff <1>Unable to handle
>  kernel NULL pointer dereference at virtual address 00000024 printing eip:
>  0211ddb0
>  *pde = 00004001
>  Oops: 0000 [#2]
>  SMP
>  Modules linked in: sch_tbf(U) ppp_async(U) crc_ccitt(U) ppp_mppe(U)
>  ppp_generic(U) slhc(U) ipt_limit(U) ipt_REJECT(U) ipt_multiport(U)
>  iptable_filter(U) iptable_nat(U) ip_conntrack(U) ip_tables(U) sunrpc(U)
>  e100(U) mii(U) sg(U) scsi_mod(U) microcode(U) dm_mod(U) ohci_hcd(U)
>  button(U) battery(U) ac(U) ext3(U) jbd(U)
>  CPU: 2
>  EIP: 0060:[<0211ddb0>] Tainted: P VLI
>  EFLAGS: 00010286 (2.6.9-1.1_FC2custom)
>  EIP is at mm_release+0x33/0x70
>  eax: 00000000 ebx: 26506030 ecx: 00000000 edx: 00000000
>  esi: f6ff6828 edi: 00000000 ebp: 0000000b esp: 23b82e50
>  ds: 007b es: 007b ss: 0068
>  Process pppd (pid: 27091, threadinfo=23b82000 task=26506030)
>  Stack: 00000000 00000000 23b82f64 26506030 02121a20 23b82000 23b82f64      
>  00000000 022c9112 021064a2 0000000b 23b82f64 022c9112 00000000 000000ff    
>  0000000b 00000000 02106784 00001000 23b82f64 00000000 02106784 00001000    
>  02106850                                                                   
>  Call Trace: [<02121a20>] do_exit+0xc3/0x3bd [<021064a2>]
>  do_divide_error+0x0/0xea [<02106784>] do_invalid_op+0x0/0xd5 [<02106784>]
>  do_invalid_op+0x0/0xd5 [<02106850>] do_invalid_op+0xcc/0xd5 [<0211bff5>]
>  load_balance+0x27/0x135 [<02121d10>] do_exit+0x3b3/0x3bd [<022b9a4a>]
>  schedule+0x87e/0x8aa [<0217e45d>] proc_delete_inode+0x0/0x61 [<022b9a4a>]
>  schedule+0x87e/0x8aa [<02121d10>] do_exit+0x3b3/0x3bd [<02121e05>]
>  sys_exit_group+0x0/0xd
>  Code: 8b 90 14 01 00 00 31 c0 8e e0 8e e8 85 d2 74 11 c7 83 14 01 00 00
>  00 00 00 00 89 d0 e8 b5 ea ff ff 8b b3 1c 01 00 00 85 f6 74 38 <8b> 47 24
>  48 7e 32 c7 83 1c 01 00 00 00 00 00 00 89 e2 89 f1 c7 <1>Unable to handle
>  kernel NULL pointer dereference at virtual address 00000024 printing eip:
>  0211ddb0
>  *pde = 00004001
>  Oops: 0000 [#3]
>  SMP
>  Modules linked in: sch_tbf(U) ppp_async(U) crc_ccitt(U) ppp_mppe(U)
>  ppp_generic(U) slhc(U) ipt_limit(U) ipt_REJECT(U) ipt_multiport(U)
>  iptable_filter(U) iptable_nat(U) ip_conntrack(U) ip_tables(U) sunrpc(U)
>  e100(U) mii(U) sg(U) scsi_mod(U) microcode(U) dm_mod(U) ohci_hcd(U)
>  button(U) battery(U) ac(U) ext3(U) jbd(U)
>  CPU: 2
>  EIP: 0060:[<0211ddb0>] Tainted: P VLI
>  EFLAGS: 00010286 (2.6.9-1.1_FC2custom)
>  EIP is at mm_release+0x33/0x70
>  eax: 00000000 ebx: 26506030 ecx: 00000000 edx: 00000000
>  esi: f6ff6828 edi: 00000000 ebp: 0000000b esp: 23b82cc8
>  ds: 007b es: 007b ss: 0068
>
> The system does not die immediately, and in fact I can still access the web
> server, and establish a pptp tunnel but no traffic passes. Likewise I can
> get a password prompt from the console, switch to different terminals etc
> but stuff just seems to hang and generally act weird. Eventually I am forced
> to hard reset the box since I cannot log in to run /sbin/reboot.
>
> I am beginning to wonder if somehow the ppp_mppe module just simply does not
> like the Dual Xeon processors in this HP DL140 server or if this is actually
> a legitimate bug...
>
> Any suggestions or further information I can provide? It looks like the
> Fedora project has released a newer 2.6.9 based kernel, so I may give that
> a try, and also may try just building a kernel from the sources off of
> kernel.org.
>
> Thanks for any help.
