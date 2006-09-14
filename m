Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751372AbWINWRf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751372AbWINWRf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 18:17:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751373AbWINWRf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 18:17:35 -0400
Received: from wx-out-0506.google.com ([66.249.82.225]:3787 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751372AbWINWRe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 18:17:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IqFUOwXj80PjcTW5aSaxQ00LQ2AqJNMikfTaxFs/RGqmVtsSQfiXDg9Vz7o8K+rWGYCratuPAC1Ns6+kXAkQgF3T4496JHBIZSCp5VxqXqFbmsvYk2EPUJ3JbjE1+6o7KNToMMXB3gLVpVji1C87wh2WEbk9bpWjhtyQvomfPQ8=
Message-ID: <6bffcb0e0609141517j4128dd41n1cd21599c51541a2@mail.gmail.com>
Date: Fri, 15 Sep 2006 00:17:33 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Greg KH" <gregkh@suse.de>
Subject: Re: 2.6.18-rc6-mm2
Cc: "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
In-Reply-To: <20060914214038.GA32352@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060912000618.a2e2afc0.akpm@osdl.org>
	 <6bffcb0e0609140411j46c20757r6eced82b53266e0f@mail.gmail.com>
	 <20060914214038.GA32352@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/09/06, Greg KH <gregkh@suse.de> wrote:
> On Thu, Sep 14, 2006 at 01:11:49PM +0200, Michal Piotrowski wrote:
> > On 12/09/06, Andrew Morton <akpm@osdl.org> wrote:
> > >
> > >ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc6/2.6.18-rc6-mm2/
> > >
> >
> > Kernel 2.6.18-rc6-mm2 - xfs-rename-uio_read.patch
> > Built with gcc 3.4
> > Reading specs from /usr/local/bin/../lib/gcc/i686-pc-linux-gnu/3.4.6/specs
> > Configured with: ./configure --prefix=/usr/local/ --disable-nls
> > --enable-shared --enable-languages=c --program-suffix=-3.4
> > Thread model: posix
> > gcc version 3.4.6
> >
> > ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 17
> > BUG: unable to handle kernel paging request at virtual address 5a5a5aaa
> > usb usb2: configuration #1 chosen from 1 choice
> > hub 2-0:1.0: USB hub found
> > printing eip:
> > c01f596a
> > *pde = 00000000
> > Oops: 0000 [#1]
> > 4K_STACKS PREEMPT SMP
> > last sysfs file:
> > Modules linked in:
> > CPU:    0
> > EIP:    0060:[<c01f596a>]    Not tainted VLI
> > EFLAGS: 00010202   (2.6.18-rc6-mm2 #122)
> > EIP is at kref_get+0x7/0x55
> > eax: 5a5a5aaa   ebx: 5a5a5aaa   ecx: c75cfe54   edx: c75cfe54
> > esi: c033152f   edi: c75cfe5e   ebp: c755be20   esp: c755be18
> > ds: 007b   es: 007b   ss: 0068
> > Process usb-probe-<NULL (pid: 291, ti=c755b000 task=c759aab0
> > task.ti=c755b000)
>
> You have the USB multi-threaded device probing config option
> (CONFIG_USB_MULTITHREAD_PROBE) enabled, right?

Yes, I have.

>
> Does disabling it fix this problem?

I'll disable it and try to reproduce the problem.

> That option has been reworked by Alan Stern, and I need to intregate it
> into my tree soon.  This is the first report of a problem with the
> current stuff, I wonder why.
>
> Can you send the output of /sys/proc/bus/usb/devices with the same
> devices plugged in on a different, no oopsing kernel?

cat /proc/bus/usb/devices

T:  Bus=05 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 2.06
S:  Manufacturer=Linux 2.6.18-rc7-g63b98080 uhci_hcd
S:  Product=UHCI Host Controller
S:  SerialNumber=0000:00:1d.3
C:* #Ifs= 1 Cfg#= 1 Atr=e0 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms

T:  Bus=04 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 2.06
S:  Manufacturer=Linux 2.6.18-rc7-g63b98080 uhci_hcd
S:  Product=UHCI Host Controller
S:  SerialNumber=0000:00:1d.2
C:* #Ifs= 1 Cfg#= 1 Atr=e0 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms

T:  Bus=03 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc=118/900 us (13%), #Int=  1, #Iso=  0
D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 2.06
S:  Manufacturer=Linux 2.6.18-rc7-g63b98080 uhci_hcd
S:  Product=UHCI Host Controller
S:  SerialNumber=0000:00:1d.1
C:* #Ifs= 1 Cfg#= 1 Atr=e0 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms

T:  Bus=03 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=1.5 MxCh= 0
D:  Ver= 1.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=04d9 ProdID=0499 Rev= 2.90
C:* #Ifs= 1 Cfg#= 1 Atr=a0 MxPwr=100mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=01 Prot=02 Driver=usbhid
E:  Ad=81(I) Atr=03(Int.) MxPS=   8 Ivl=10ms

T:  Bus=02 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 2.06
S:  Manufacturer=Linux 2.6.18-rc7-g63b98080 uhci_hcd
S:  Product=UHCI Host Controller
S:  SerialNumber=0000:00:1d.0
C:* #Ifs= 1 Cfg#= 1 Atr=e0 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms

T:  Bus=01 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=480 MxCh= 8
B:  Alloc=  0/800 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 2.00 Cls=09(hub  ) Sub=00 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 2.06
S:  Manufacturer=Linux 2.6.18-rc7-g63b98080 ehci_hcd
S:  Product=EHCI Host Controller
S:  SerialNumber=0000:00:1d.7
C:* #Ifs= 1 Cfg#= 1 Atr=e0 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=256ms

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
