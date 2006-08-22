Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751418AbWHVRm7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751418AbWHVRm7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 13:42:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751420AbWHVRm7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 13:42:59 -0400
Received: from mail.fieldses.org ([66.93.2.214]:63419 "EHLO
	pickle.fieldses.org") by vger.kernel.org with ESMTP
	id S1751418AbWHVRm6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 13:42:58 -0400
Date: Tue, 22 Aug 2006 13:42:51 -0400
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, "Randy.Dunlap" <rdunlap@xenotime.net>,
       Jan Beulich <jbeulich@novell.com>, linux-kernel@vger.kernel.org
Subject: Re: boot failure, "DWARF2 unwinder stuck at 0xc0100199"
Message-ID: <20060822174251.GB16145@fieldses.org>
References: <20060820013121.GA18401@fieldses.org> <20060821094718.79c9a31a.rdunlap@xenotime.net> <20060821212043.332fdd0f.akpm@osdl.org> <200608221001.36124.ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608221001.36124.ak@suse.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
From: "J. Bruce Fields" <bfields@fieldses.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22, 2006 at 10:01:36AM +0200, Andi Kleen wrote:
> On Tuesday 22 August 2006 06:20, Andrew Morton wrote:
> > Has anyone even tried to reproduce Bruce's crash?
> 
> I looked at it a bit, but it puzzles me. The chaining for the interrupt stacks
> on i386 -- which is what seems to be corrupted here -- shouldn't have changed at all 
> by the unwinder changes.
> 
> I suspect it would crash without unwinder too. Bruce, do you get the 
> same crash when you boot with "call_trace=old" ? 

After appending "call_trace=old" to the boot commandline, and it booted
succesfully.  It had the following warning at what I suspect was the
same place the boot stopped before:

ide-scsi is deprecated for cd burning! Use ide-cd and give dev=/dev/hdX as device
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
BUG: warning at kernel/lockdep.c:1803/trace_hardirqs_on()
 [<c0103df6>] show_trace+0x16/0x20
 [<c0103ecb>] dump_stack+0x1b/0x20
 [<c012e997>] trace_hardirqs_on+0xf7/0x130
 [<c0445e63>] idescsi_pc_intr+0x63/0x450
 [<c042fe5c>] ide_intr+0x7c/0x1d0
 [<c013a727>] handle_IRQ_event+0x27/0x60
 [<c013a7f4>] __do_IRQ+0x94/0x110
 [<c0104cba>] do_IRQ+0xaa/0xf0
 [<c0103105>] common_interrupt+0x25/0x30
 [<c010d6c9>] apm_cpu_idle+0x1e9/0x270
 [<c010163c>] cpu_idle+0x2c/0x80
 [<c0100507>] rest_init+0x37/0x40
 [<c0823756>] start_kernel+0x266/0x2b0
 [<c0100199>] 0xc0100199
  Vendor: PIONEER   Model: DVD-ROM DVD-116   Rev: 1.22
  Type:   CD-ROM                             ANSI SCSI revision: 00
sr0: scsi-1 drive
Uniform CD-ROM driver Revision: 3.20
sr 0:0:0:0: Attached scsi CD-ROM sr0
sr 0:0:0:0: Attached scsi generic sg0 type 5
...

--b.
