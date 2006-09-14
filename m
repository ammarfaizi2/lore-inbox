Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750797AbWINPrP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750797AbWINPrP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 11:47:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750876AbWINPrP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 11:47:15 -0400
Received: from smtp.osdl.org ([65.172.181.4]:50645 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750797AbWINPrO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 11:47:14 -0400
Date: Thu, 14 Sep 2006 08:47:02 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
Cc: linux-kernel@vger.kernel.org, "Greg KH" <gregkh@suse.de>,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: 2.6.18-rc6-mm2
Message-Id: <20060914084702.963fcdf5.akpm@osdl.org>
In-Reply-To: <6bffcb0e0609140411j46c20757r6eced82b53266e0f@mail.gmail.com>
References: <20060912000618.a2e2afc0.akpm@osdl.org>
	<6bffcb0e0609140411j46c20757r6eced82b53266e0f@mail.gmail.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


(Added linux-usb-devel)

On Thu, 14 Sep 2006 13:11:49 +0200
"Michal Piotrowski" <michal.k.k.piotrowski@gmail.com> wrote:

> On 12/09/06, Andrew Morton <akpm@osdl.org> wrote:
> >
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc6/2.6.18-rc6-mm2/
> >
> 
> Kernel 2.6.18-rc6-mm2 - xfs-rename-uio_read.patch
> Built with gcc 3.4
> Reading specs from /usr/local/bin/../lib/gcc/i686-pc-linux-gnu/3.4.6/specs
> Configured with: ./configure --prefix=/usr/local/ --disable-nls
> --enable-shared --enable-languages=c --program-suffix=-3.4
> Thread model: posix
> gcc version 3.4.6
> 
> ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 17
> BUG: unable to handle kernel paging request at virtual address 5a5a5aaa
> usb usb2: configuration #1 chosen from 1 choice
> hub 2-0:1.0: USB hub found
>  printing eip:
> c01f596a
> *pde = 00000000
> Oops: 0000 [#1]
> 4K_STACKS PREEMPT SMP
> last sysfs file:
> Modules linked in:
> CPU:    0
> EIP:    0060:[<c01f596a>]    Not tainted VLI
> EFLAGS: 00010202   (2.6.18-rc6-mm2 #122)
> EIP is at kref_get+0x7/0x55
> eax: 5a5a5aaa   ebx: 5a5a5aaa   ecx: c75cfe54   edx: c75cfe54
> esi: c033152f   edi: c75cfe5e   ebp: c755be20   esp: c755be18
> ds: 007b   es: 007b   ss: 0068
> Process usb-probe-<NULL (pid: 291, ti=c755b000 task=c759aab0 task.ti=c755b000)

That's an interesting process name..

> Stack: 5a5a5a92 c033152f c755be2c c01f529b c75cfe80 c755be50 c01b1513 c755be50
>        fffffff4 c75bd51c 5a5a5a92 c75b8eec c0331525 5a5a5a92 c755be68 c01b15ca
>        ffffffef c75cfeac c752e044 c752e044 c755be80 c025d2ff c752e12c c75cfeac
> Call Trace:
>  [<c01f529b>] kobject_get+0x12/0x17
>  [<c01b1513>] sysfs_add_link+0x5f/0xa3
>  [<c01b15ca>] sysfs_create_link+0x73/0x8c
>  [<c025d2ff>] device_add_class_symlinks+0x2f/0x111
>  [<c025d5f4>] device_add+0x181/0x2ea
>  [<c025d76f>] device_register+0x12/0x15
>  [<c02936b2>] usb_create_ep_files+0xaf/0x146
>  [<c0293013>] usb_create_sysfs_dev_files+0x80/0xbb
>  [<c0296402>] generic_probe+0xc/0x55
>  [<c0290e54>] usb_probe_device+0x35/0x3b
>  [<c025f1eb>] really_probe+0x3a/0xbb
>  [<c025f31e>] driver_probe_device+0x99/0xa5
>  [<c025f332>] __device_attach+0x8/0xa
>  [<c025e828>] bus_for_each_drv+0x38/0x5d
>  [<c025f384>] device_attach+0x50/0x67
>  [<c025e9fe>] bus_attach_device+0x1a/0x35
>  [<c025d65e>] device_add+0x1eb/0x2ea
>  [<c028c182>] __usb_new_device+0x102/0x134
>  [<c0134b3d>] kthread+0x79/0xa1
>  [<c0103e53>] kernel_thread_helper+0x7/0x10
>  =======================
> Code: 40 89 06 3b 45 18 5e 7f 04 ff 07 31 db 8d 65 f4 89 d8 5b 5e 5f
> 5d c3 90 90 55 c7 00 01 00 00 00 89 e5 5d c3 55 89 e5 56 53 89 c3 <8b>
> 00 85 c0 0f 94 c0 0f b6 f0 b8 38 b9 38 c0 89 f2 e8 f4 0f 01
> Sep 14 12:58:09 euridica kernel: EIP: [<c01f596a>] kref_get+0x7/0x55
> SS:ESP 0068:c755be18
> Sep 14 12:58:09 euridica kernel:  <7>PCI: Setting latency timer of
> device 0000:00:1d.2 to 64
> 
> l *0xc01f596a
> 0xc01f596a is in kref_get (/usr/src/linux-mm/lib/kref.c:32).
> 27       * kref_get - increment refcount for object.
> 28       * @kref: object.
> 29       */
> 30      void kref_get(struct kref *kref)
> 31      {
> 32              WARN_ON(!atomic_read(&kref->refcount));
> 33              atomic_inc(&kref->refcount);
> 34      }
> 35
> 36      /**
> 
> http://www.stardust.webpages.pl/files/mm/2.6.18-rc6-mm2/mm-config1
> 
> Regards,
> Michal
> 
> -- 
> Michal K. K. Piotrowski
> LTG - Linux Testers Group
> (http://www.stardust.webpages.pl/ltg/)
