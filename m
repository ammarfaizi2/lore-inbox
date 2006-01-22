Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751154AbWAVH4M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751154AbWAVH4M (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 02:56:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751207AbWAVH4M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 02:56:12 -0500
Received: from smtp.osdl.org ([65.172.181.4]:15597 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751154AbWAVH4L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 02:56:11 -0500
Date: Sat, 21 Jan 2006 23:55:46 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Carlo E. Prelz" <fluido@fluido.as>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: ATI RS480-based motherboard: stuck while booting with kernel >=
 2.6.15 rc1
Message-Id: <20060121235546.68f50bd5.akpm@osdl.org>
In-Reply-To: <20060122074034.GA1315@epio.fluido.as>
References: <20060120123202.GA1138@epio.fluido.as>
	<20060121010932.5d731f90.akpm@osdl.org>
	<20060121125741.GA13470@epio.fluido.as>
	<20060121125822.570b0d99.akpm@osdl.org>
	<20060122074034.GA1315@epio.fluido.as>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Carlo E. Prelz" <fluido@fluido.as> wrote:
>
> 	Subject: Re: ATI RS480-based motherboard: stuck while booting with kernel >= 2.6.15 rc1
> 	Date: sab 21 gen 06 12:58:22 -0800
> 
> Quoting Andrew Morton (akpm@osdl.org):
> 
> > If you have a web server somewhere, just upload the .jpg file.  Or send it
> > to me and I can do that.
> 
> The latest screenshot can be found at
> http://www.fluido.as/files/images/screenshot.jpg
> 
> > > Calling initcall 0xffffffff8026836c: pci_init+0x0/0x2b()
> > > 
> > > 
> > > And then the machine freezes. I may add that, with 2.6.14.6, I am
> > > getting errors like:
> > 
> > OK, it looks like a PCI initcall went South.  Can you please add this, then
> > when it hangs, record the last few lines then send us those, as well as the
> > output of `lspci -vx'?
> 
> These lines appear at the end of the logfile:
> 
> pci_init: 10025950
> pci_init: 10025a3f
> pci_init: 1002437a
> pci_init: 10024379
> pci_init: 10024374
> pci_init: 10024375
> pci_init: 10024373
> 
> and 1002:4373 is the USB2 (EHCI) controller. I attach the output of
> lspci -vx. Even with 2.6.14.6, I have problems with USB. It did not
> work at all, then I downloaded the latest bios, and now, right after
> boot, usb works OK.

OK, so it sounds like quirk_usb_disable_ehci() caused your machine to hang
with the old BIOS.  That's fairly bad behaviour from the kernel, even
though the BIOS presumably had some problems.

> But after some time (possibly after the first APIC
> error message), newly inserted USB disks are not detected anymore, and
> I had one case in which a mounted disk was not accessible anymore. 

Can you please gather some more details on this and prepare a new report? 
The full demsg output, machine description, etc.  It might be best to do
this via a new bugzilla.kernel.org record so we know where to find it.

Thanks.

> I just bought the motherboard - I did not make too many tests.
> 
> > Is this new behaviour?  If so, are you able to pinpoint the latest kernel
> > which didn't have such problems?
> 
> The motherboard is new. With the previous motherboard (via k8t88
> based), using the same processor and most of the same boards, I did
> not have any of these problems.

