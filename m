Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030412AbWJKBIt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030412AbWJKBIt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 21:08:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932291AbWJKBIs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 21:08:48 -0400
Received: from smtp.osdl.org ([65.172.181.4]:35299 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932140AbWJKBIs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 21:08:48 -0400
Date: Tue, 10 Oct 2006 18:08:26 -0700
From: Bryce Harrington <bryce@osdl.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Andrew Morton <akpm@osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: [BUG] 2.6.19-rc1-mm1:  fs/file.c138 on ia64
Message-ID: <20061011010826.GA15741@osdl.org>
References: <20060316170814.02fa55a1.akpm@osdl.org> <20060317084653.GA4515@in.ibm.com> <20060317010412.3243364c.akpm@osdl.org> <20061006231012.GH22139@osdl.org> <20061006162924.344090f8.akpm@osdl.org> <20061007000031.GI22139@osdl.org> <20061007103559.GC30034@elf.ucw.cz> <20061007204220.GB24743@osdl.org> <20061008182941.GA8308@osiris.ibm.com> <20061008191447.GD3788@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061008191447.GD3788@elf.ucw.cz>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 08, 2006 at 09:14:47PM +0200, Pavel Machek wrote:
> On Sun 2006-10-08 20:29:41, Heiko Carstens wrote:
> > > > > We've been running this testsuite fairly continuously for several
> > > > > months, and irregularly for about a year before that.  We find that on
> > > > > some platforms like PPC64 it's quite robust, and on others there are
> > > > > issues, but the developers tend to be quick to provide fixes as the
> > > > > issues are found.  I'm glad to see that the results are finally showing
> > > > > green for ia64.

Spoke too soon.  ;-)

We've noticed a new ia64 issue on the 2.6.19-rc1-mm1 kernel.  It has not
occurred on other 2.6.19 kernels we've tested.  We aslo encountered this
BUG only on ia64; the x86 and x86_64 systems booted without issue.
Apologies if this is already known; I didn't spot it in the list
archives.

I have hotplug-cpu configured for this machine, however I don't know if
it has anything to do with this BUG.  I can test with it turned of if
it'd help.

The line referred to in the output is in copy_fdtable():
        BUG_ON(nfdt->max_fds < ofdt->max_fds);


http://crucible.osdl.org/runs/2511/sysinfo/ita01.console.log

Freeing unused kernel memory: 1840kB freed
kernel BUG at fs/file.c:138!
hotplug[956]: bugcheck! 0 [1]
Modules linked in:

Pid: 956, CPU 1, comm:              hotplug
psr : 0000101008026018 ifs : 800000000000050d ip  : [<a00000010017c990>]    Not tainted
ip is at copy_fdtable+0x70/0x180
unat: 0000000000000000 pfs : 000000000000050d rsc : 0000000000000003
rnat: 0000000000000000 bsps: 0000000000000000 pr  : 0000000000019659
ldrs: 0000000000000000 ccv : 0000000000000000 fpsr: 0009804c8a70033f
csd : 0000000000000000 ssd : 0000000000000000
b0  : a00000010017c990 b6  : a000000100002d70 b7  : a0000001000373a0
f6  : 1003e0000000cc6c97af8 f7  : 0ffd9a200000000000000
f8  : 1003e00000000000005dc f9  : 1003e0000000cc6c980d4
f10 : 1003e0000000000000001 f11 : 1003e0000000000000000
r1  : a000000100e8f210 r2  : 0000000000004000 r3  : 0000000000004000
r8  : 0000000000000020 r9  : 0000000000000000 r10 : a000000100b600b0
r11 : 0000000000003e97 r12 : e0000040fc30fe30 r13 : e0000040fc308000
r14 : a000000100b3fc20 r15 : 0000000000003e97 r16 : ffffffffffffc169
r17 : a000000100ca89d0 r18 : 0000000000000000 r19 : a000000100ca89c8
r20 : a000000100ca89d8 r21 : 0000000000004000 r22 : 0000000000000000
r23 : a000000100ca89c0 r24 : a000000100ca44a0 r25 : 0000000000000000
r26 : a000000100ca89b4 r27 : a000000100b3fc20 r28 : a000000100c8f4e8
r29 : 0000000000800000 r30 : 0000000000000000 r31 : a000000100ca8990

Call Trace:
 [<a000000100012760>] show_stack+0x40/0xa0
                                sp=e0000040fc30f9a0 bsp=e0000040fc308e40
 [<a000000100012ff0>] show_regs+0x7d0/0x800
                                sp=e0000040fc30fb70 bsp=e0000040fc308df0
 [<a000000100037940>] die+0x1c0/0x2c0
                                sp=e0000040fc30fb70 bsp=e0000040fc308da8
 [<a000000100037a80>] die_if_kernel+0x40/0x60
                                sp=e0000040fc30fb90 bsp=e0000040fc308d78
 [<a000000100037cc0>] ia64_bad_break+0x220/0x460
                                sp=e0000040fc30fb90 bsp=e0000040fc308d50
 [<a00000010000c8a0>] ia64_leave_kernel+0x0/0x280
                                sp=e0000040fc30fc60 bsp=e0000040fc308d50
 [<a00000010017c990>] copy_fdtable+0x70/0x180
                                sp=e0000040fc30fe30 bsp=e0000040fc308ce8
 [<a00000010017cef0>] expand_fdtable+0x90/0x1e0
                                sp=e0000040fc30fe30 bsp=e0000040fc308cb0
 [<a00000010017d0a0>] expand_files+0x60/0x80
                                sp=e0000040fc30fe30 bsp=e0000040fc308c88
 [<a000000100167210>] sys_dup2+0x130/0x360
                                sp=e0000040fc30fe30 bsp=e0000040fc308c00
 [<a00000010000c700>] ia64_ret_from_syscall+0x0/0x20
                                sp=e0000040fc30fe30 bsp=e0000040fc308c00


Config used:
   http://crucible.osdl.org/runs/2511/sysinfo/ita01.config

More info about system:
   http://crucible.osdl.org/runs/2511/sysinfo/

For comparison, here is a run against patch-2.6.19-rc1-git6:
   http://crucible.osdl.org/runs/2505/

Bryce
