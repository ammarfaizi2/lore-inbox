Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932094AbWINWvt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932094AbWINWvt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 18:51:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932096AbWINWvt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 18:51:49 -0400
Received: from mail.kroah.org ([69.55.234.183]:10923 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932094AbWINWvs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 18:51:48 -0400
Date: Thu, 14 Sep 2006 15:36:38 -0700
From: Greg KH <gregkh@suse.de>
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: 2.6.18-rc6-mm2
Message-ID: <20060914223638.GA547@suse.de>
References: <20060912000618.a2e2afc0.akpm@osdl.org> <6bffcb0e0609140411j46c20757r6eced82b53266e0f@mail.gmail.com> <20060914214038.GA32352@suse.de> <6bffcb0e0609141517j4128dd41n1cd21599c51541a2@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6bffcb0e0609141517j4128dd41n1cd21599c51541a2@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2006 at 12:17:33AM +0200, Michal Piotrowski wrote:
> On 14/09/06, Greg KH <gregkh@suse.de> wrote:
> >On Thu, Sep 14, 2006 at 01:11:49PM +0200, Michal Piotrowski wrote:
> >> On 12/09/06, Andrew Morton <akpm@osdl.org> wrote:
> >> >
> >> 
> >>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc6/2.6.18-rc6-mm2/
> >> >
> >>
> >> Kernel 2.6.18-rc6-mm2 - xfs-rename-uio_read.patch
> >> Built with gcc 3.4
> >> Reading specs from 
> >/usr/local/bin/../lib/gcc/i686-pc-linux-gnu/3.4.6/specs
> >> Configured with: ./configure --prefix=/usr/local/ --disable-nls
> >> --enable-shared --enable-languages=c --program-suffix=-3.4
> >> Thread model: posix
> >> gcc version 3.4.6
> >>
> >> ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 17
> >> BUG: unable to handle kernel paging request at virtual address 5a5a5aaa
> >> usb usb2: configuration #1 chosen from 1 choice
> >> hub 2-0:1.0: USB hub found
> >> printing eip:
> >> c01f596a
> >> *pde = 00000000
> >> Oops: 0000 [#1]
> >> 4K_STACKS PREEMPT SMP
> >> last sysfs file:
> >> Modules linked in:
> >> CPU:    0
> >> EIP:    0060:[<c01f596a>]    Not tainted VLI
> >> EFLAGS: 00010202   (2.6.18-rc6-mm2 #122)
> >> EIP is at kref_get+0x7/0x55
> >> eax: 5a5a5aaa   ebx: 5a5a5aaa   ecx: c75cfe54   edx: c75cfe54
> >> esi: c033152f   edi: c75cfe5e   ebp: c755be20   esp: c755be18
> >> ds: 007b   es: 007b   ss: 0068
> >> Process usb-probe-<NULL (pid: 291, ti=c755b000 task=c759aab0
> >> task.ti=c755b000)
> >
> >You have the USB multi-threaded device probing config option
> >(CONFIG_USB_MULTITHREAD_PROBE) enabled, right?
> 
> Yes, I have.
> 
> >
> >Does disabling it fix this problem?
> 
> I'll disable it and try to reproduce the problem.

Great, please let us know.  Your device list looks simple, I don't see
why this would happen (no confusing devices).  In fact, this is getting
triggered by the root hub, which Alan's update specifically addresses by
not making that be multithreaded, as it's not needed.

I'll work on intergrating that patch update.

thanks,

greg k-h
