Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750827AbWCATVH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750827AbWCATVH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 14:21:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750862AbWCATVH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 14:21:07 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:28140
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1751059AbWCATVF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 14:21:05 -0500
Date: Wed, 1 Mar 2006 11:21:03 -0800
From: Greg KH <greg@kroah.com>
To: Paul Jackson <pj@sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, ebiederm@xmission.com,
       linux-kernel@vger.kernel.org
Subject: Re: + proc-dont-lock-task_structs-indefinitely-cpuset-fix-2.patch added to -mm tree
Message-ID: <20060301192103.GA14320@kroah.com>
References: <200603010120.k211KqVP009559@shell0.pdx.osdl.net> <20060228181849.faaf234e.pj@sgi.com> <20060228183610.5253feb9.akpm@osdl.org> <20060228194525.0faebaaa.pj@sgi.com> <20060228201040.34a1e8f5.pj@sgi.com> <m1irqypxf5.fsf@ebiederm.dsl.xmission.com> <20060228212501.25464659.pj@sgi.com> <20060228234807.55f1b25f.pj@sgi.com> <20060301002631.48e3800e.akpm@osdl.org> <20060301015338.b296b7ad.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060301015338.b296b7ad.pj@sgi.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 01, 2006 at 01:53:38AM -0800, Paul Jackson wrote:
> Ok - down to the patch:
> 
> 1) gregkh-driver-empty_release_functions_are_broken.patch         - good
> 2) gregkh-driver-allow-sysfs-attribute-files-to-be-pollable.patch - special case
> 3) gregkh-driver-fix-up-the-sysfs-pollable-patch.patch            - bad
> 
> Up through and including (1), it all seems fine.
> 
> With (3) or more loaded, it fails to boot, with the crash
> given before (and appended below for completeness).
> 
> With patchs up through (2) loaded, it boots, but complains 27
> times during the boot
> 
> One of the 27 complaints for special case (2):
> ================================= begin =================================
> Debug: sleeping function called from invalid context at drivers/base/core.c:343^M
> in_atomic():1, irqs_disabled():0^M
> ^M
> Call Trace:^M
>  [<a0000001000132c0>] show_stack+0x40/0xa0^M
>                                 sp=e00002bc3a49f9b0 bsp=e00002bc3a499558^M

<snip>

As reported this is expected, and can be ignored safely.  It's just scsi
being bad :)

> The boottime crash seen in case (3) and beyond:
> ================================= begin =================================
> pci_hotplug: PCI Hot Plug PCI Core version: 0.5
> SGI Altix RTC Timer: v2.1, 20 MHz
> EFI Time Services Driver v0.4
> Linux agpgart interface v0.101 (c) Dave Jones
> sn_console: Console driver init
> ttySG0 at I/O 0x0 (irq = 0) is a SGI SN L1
> Unable to handle kernel NULL pointer dereference (address 0000000000000058)
> swapper[1]: Oops 8813272891392 [1]
> Modules linked in:
> 
> Pid: 1, CPU 0, comm:              swapper
> psr : 0000101008026018 ifs : 800000000000040b ip  : [<a0000001001eac90>]    Not tainted
> ip is at sysfs_create_group+0x30/0x2a0
> unat: 0000000000000000 pfs : 0000000000000308 rsc : 0000000000000003
> rnat: 0000000002000027 bsps: 0000000000000002 pr  : 0000000000005649
> ldrs: 0000000000000000 ccv : 0000000000000000 fpsr: 0009804c8a70433f
> csd : 0000000000000000 ssd : 0000000000000000
> b0  : a000000100809190 b6  : e000023002310080 b7  : a0000001008091e0
> f6  : 1003e0000000000000000 f7  : 1003e20c49ba5e353f7cf
> f8  : 1003e0000000000003398 f9  : 1003e000000000000007f
> f10 : 1003e0000000000000000 f11 : 1003e0000000000000000
> r1  : a000000100c70cc0 r2  : 0000000000000058 r3  : a000000100a80ef8
> r8  : 0000000000000000 r9  : a000000100c95820 r10 : ffffffffffffffff
> r11 : 0000000000000400 r12 : e00002343bd97d50 r13 : e00002343bd90000
> r14 : a000000100a83360 r15 : a000000100c95820 r16 : a000000100a80f00
> r17 : 00000000000003c0 r18 : 0000000000000001 r19 : 0000000000000002
> r20 : ffffffffffffffff r21 : 0000000000000000 r22 : 000000000000000e
> r23 : a000000100a720a8 r24 : a000000100812c40 r25 : a000000100a77698
> r26 : a000000100a88b60 r27 : a0000001008f3b88 r28 : e00002bc3a0432f0
> r29 : 0000000000000001 r30 : a0000001007d0db8 r31 : a0000001008091e0
> 
> Call Trace:
>  [<a0000001000132c0>] show_stack+0x40/0xa0
>                                 sp=e00002343bd978e0 bsp=e00002343bd91278
>  [<a000000100013af0>] show_regs+0x7d0/0x800
>                                 sp=e00002343bd97ab0 bsp=e00002343bd91228
>  [<a000000100036df0>] die+0x210/0x320
>                                 sp=e00002343bd97ab0 bsp=e00002343bd911d8
>  [<a00000010005a840>] ia64_do_page_fault+0x900/0xa80
>                                 sp=e00002343bd97ad0 bsp=e00002343bd91178
>  [<a00000010000bd00>] ia64_leave_kernel+0x0/0x290
>                                 sp=e00002343bd97b80 bsp=e00002343bd91178
>  [<a0000001001eac90>] sysfs_create_group+0x30/0x2a0
>                                 sp=e00002343bd97d50 bsp=e00002343bd91120
>  [<a000000100809190>] topology_cpu_callback+0x70/0xc0
>                                 sp=e00002343bd97d60 bsp=e00002343bd910f0
>  [<a000000100809260>] topology_sysfs_init+0x80/0x120
>                                 sp=e00002343bd97d60 bsp=e00002343bd910d0

This points at the sysfs cpu patches that are in -mm, which are not in
my tree...

thanks,

greg k-h
