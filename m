Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932194AbWIOUfj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932194AbWIOUfj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 16:35:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932203AbWIOUfj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 16:35:39 -0400
Received: from wx-out-0506.google.com ([66.249.82.224]:37076 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932194AbWIOUfi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 16:35:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dcsRfa3eEYujuUYJay+PZ74fpOkuXAuPlKgbTX9djpT9pe8M8IqI3DPQ0ncD7ZMb0Ntpa0Sv3WdFVVwdHQuv2jktaD+eUBOQqBjyrs9m7AkuEnAzSgsmRjGNIO8aO+dln5SbnsPq8fInvss6xi6At6559LOEKhjaWBR9vCajNYA=
Message-ID: <6bffcb0e0609151335wce499b0nb3e39bdc26b4b433@mail.gmail.com>
Date: Fri, 15 Sep 2006 22:35:37 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Greg KH" <gregkh@suse.de>
Subject: Re: 2.6.18-rc6-mm2
Cc: "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
In-Reply-To: <20060914223638.GA547@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060912000618.a2e2afc0.akpm@osdl.org>
	 <6bffcb0e0609140411j46c20757r6eced82b53266e0f@mail.gmail.com>
	 <20060914214038.GA32352@suse.de>
	 <6bffcb0e0609141517j4128dd41n1cd21599c51541a2@mail.gmail.com>
	 <20060914223638.GA547@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/09/06, Greg KH <gregkh@suse.de> wrote:
> On Fri, Sep 15, 2006 at 12:17:33AM +0200, Michal Piotrowski wrote:
> > On 14/09/06, Greg KH <gregkh@suse.de> wrote:
> > >On Thu, Sep 14, 2006 at 01:11:49PM +0200, Michal Piotrowski wrote:
> > >> On 12/09/06, Andrew Morton <akpm@osdl.org> wrote:
> > >> >
> > >>
> > >>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc6/2.6.18-rc6-mm2/
> > >> >
> > >>
> > >> Kernel 2.6.18-rc6-mm2 - xfs-rename-uio_read.patch
> > >> Built with gcc 3.4
> > >> Reading specs from
> > >/usr/local/bin/../lib/gcc/i686-pc-linux-gnu/3.4.6/specs
> > >> Configured with: ./configure --prefix=/usr/local/ --disable-nls
> > >> --enable-shared --enable-languages=c --program-suffix=-3.4
> > >> Thread model: posix
> > >> gcc version 3.4.6
> > >>
> > >> ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 17
> > >> BUG: unable to handle kernel paging request at virtual address 5a5a5aaa
> > >> usb usb2: configuration #1 chosen from 1 choice
> > >> hub 2-0:1.0: USB hub found
> > >> printing eip:
> > >> c01f596a
> > >> *pde = 00000000
> > >> Oops: 0000 [#1]
> > >> 4K_STACKS PREEMPT SMP
> > >> last sysfs file:
> > >> Modules linked in:
> > >> CPU:    0
> > >> EIP:    0060:[<c01f596a>]    Not tainted VLI
> > >> EFLAGS: 00010202   (2.6.18-rc6-mm2 #122)
> > >> EIP is at kref_get+0x7/0x55
> > >> eax: 5a5a5aaa   ebx: 5a5a5aaa   ecx: c75cfe54   edx: c75cfe54
> > >> esi: c033152f   edi: c75cfe5e   ebp: c755be20   esp: c755be18
> > >> ds: 007b   es: 007b   ss: 0068
> > >> Process usb-probe-<NULL (pid: 291, ti=c755b000 task=c759aab0
> > >> task.ti=c755b000)
> > >
> > >You have the USB multi-threaded device probing config option
> > >(CONFIG_USB_MULTITHREAD_PROBE) enabled, right?
> >
> > Yes, I have.
> >
> > >
> > >Does disabling it fix this problem?
> >
> > I'll disable it and try to reproduce the problem.
>
> Great, please let us know.

Good news, I can't reproduce this bug with CONFIG_USB_MULTITHREAD_PROBE=n.

BTW. This might be a problem with CONFIG_PCI_MULTITHREAD_PROBE=y
http://www.stardust.webpages.pl/files/mm/2.6.18-rc6-mm2/bug.jpg

>  Your device list looks simple, I don't see
> why this would happen (no confusing devices).  In fact, this is getting
> triggered by the root hub, which Alan's update specifically addresses by
> not making that be multithreaded, as it's not needed.
>
> I'll work on intergrating that patch update.
>
> thanks,
>
> greg k-h
>

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/)
