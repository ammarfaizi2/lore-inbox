Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932246AbWAFEuq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932246AbWAFEuq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 23:50:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932361AbWAFEuq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 23:50:46 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:50923 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932246AbWAFEup (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 23:50:45 -0500
Date: Fri, 6 Jan 2006 10:20:26 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Yinghai Lu <yinghai.lu@amd.com>, ak@muc.de, ebiederm@xmission.com,
       fastboot@lists.osdl.org, linux-kernel@vger.kernel.org,
       discuss@x86-64.org, linuxbios@openbios.org
Subject: Re: Inclusion of x86_64 memorize ioapic at bootup patch
Message-ID: <20060106045026.GA4928@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20060103044632.GA4969@in.ibm.com> <86802c440601051630i4d52aa2fj1a2990acf858cd63@mail.gmail.com> <20060105163848.3275a220.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060105163848.3275a220.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 05, 2006 at 04:38:48PM -0800, Andrew Morton wrote:
> Yinghai Lu <yinghai.lu@amd.com> wrote:
> >
> > the patch is good.
> > 
> > I tried LinuxBIOS with kexec.
> > 
> > without this patch: I need to disable acpi in kernel. otherwise the
> > kernel with acpi support can boot the second kernel, but the second
> > kernel will hang after
> > 
> > time.c: Using 14.318180 MHz HPET timer.
> > time.c: Detected 2197.663 MHz processor.
> > Console: colour VGA+ 80x25
> > Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
> > Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
> > Memory: 1009152k/1048576k available (2967k kernel code, 39036k reserved, 1186k )
> > 
> > 
> 
> Please don't top-post.
> 
> > 
> > On 1/2/06, Vivek Goyal <vgoyal@in.ibm.com> wrote:
> > > Hi Andi,
> > >
> > > Can you please include the following patch. This patch has already been pushed
> > > by Andrew.
> > >
> > > http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.15-rc5/2.6.15-rc5-mm3/broken-out/x86_64-io_apicc-memorize-at-bootup-where-the-i8259-is.patch
> 
> IIRC, I dropped this patch because of discouraging noises from Andi and
> because underlying x86_64 changes broke it in ugly ways.  It needs to be
> redone and Andi's objections (whatever they were) need to be addressed or
> argued about.
> 

Andrew, as per my information this patch has not broken anything. It was
other patch which tried to initialize ioapics early which had broken some
sysmtems and that patch has already been dropped.

Andi's main concern with this patch is that it has got special case
knowledge of 8259 and legacy stuff. He would rather prefer, saving all the
APIC states early during boot and restore it back during reboot.

This shall work well for kexec but will not work for kdump as we might
crash on a non-boot cpu and second kernel will come up on a non-boot cpu.
Just restoring the APIC states shall ensure that kernel can boot well on
BIOS designated boot cpu but it does not hold good for other cpus. One
example is that other cpus will not receive timer interrupts during early
boot.

Hence there does not seem to be any escape route except relocate
to boot cpu after crash and second kernel comes up on BIOS designated
boot cpu. But after crash relocating to boot cpu might not be a very
reliable thing to do.

Thanks
Vivek
