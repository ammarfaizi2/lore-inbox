Return-Path: <linux-kernel-owner+w=401wt.eu-S932548AbXAGO0r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932548AbXAGO0r (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 09:26:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932550AbXAGO0r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 09:26:47 -0500
Received: from mtaout02-winn.ispmail.ntl.com ([81.103.221.48]:29169 "EHLO
	mtaout02-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932548AbXAGO0q convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 09:26:46 -0500
Date: Sun, 7 Jan 2007 14:26:41 +0000
From: Ken Moffat <zarniwhoop@ntlworld.com>
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: x86 instability with 2.6.1{8,9}
Message-ID: <20070107142641.GA30379@deepthought>
References: <20070101160158.GA26547@deepthought> <200701021225.57708.lenb@kernel.org> <20070102180425.GA18680@deepthought> <200701021342.32195.lenb@kernel.org> <20070102193459.GA19894@deepthought> <20070106140459.a6b72039.randy.dunlap@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20070106140459.a6b72039.randy.dunlap@oracle.com>
User-Agent: Mutt/1.5.12-2006-07-14
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 06, 2007 at 02:04:59PM -0800, Randy Dunlap wrote:
> On Tue, 2 Jan 2007 19:34:59 +0000 Ken Moffat wrote:
> 
> > On Tue, Jan 02, 2007 at 01:42:32PM -0500, Len Brown wrote:
> > > 
> > > You might remove and re-insert the DIMMS.
> > > Sometimes there are poor contacts if the DIMMS are not fully seated and clicked in.
> > > 
> > > The real mystery is the 32 vs 64-bit thing.
> > > Are the devices configured the same way -- ie are they both in IOAPIC mode
> > > and /proc/interrupts looks the same for both modes?
> > > 
> > > -Len
> > 
> >  Too late, I've started memtest-86+.  If it seems ok after an
> > overnight run, I'll take a look at /proc/interrupts.  How can I tell
> > it is in IOAPIC mode, please ?  Google was not helpful for this, but
> > if it's an override, the only things on my command lines are root=
> > and video= settings.
> 
> (did anyone ever answer this?)
> 
> In IO-APIC mode, /proc/interrupts contains entries like these:
> 
>            CPU0       CPU1       
>   0:  121218123          0    IO-APIC-edge  timer
>   1:     715259          0    IO-APIC-edge  i8042
>   6:          5          0    IO-APIC-edge  floppy
>   7:          0          0    IO-APIC-edge  parport0
>   9:          0          0   IO-APIC-level  acpi
>  12:   10011272          0    IO-APIC-edge  i8042
>  14:   11561548          0    IO-APIC-edge  ide0
>  66:    4525183          0         PCI-MSI  libata
>  74:       1711          0   IO-APIC-level  ehci_hcd:usb1, uhci_hcd:usb6
>  82:          4          0   IO-APIC-level  ohci_hcd:usb2, ohci_hcd:usb3, ohci_hcd:usb4, ohci_hcd:usb5
>  98:     101326          0         PCI-MSI  HDA Intel
> 106:   17747181          0         PCI-MSI  eth0
> 169:          0          0   IO-APIC-level  uhci_hcd:usb9
> 177:          3          0   IO-APIC-level  ohci1394
> 185:         15          0   IO-APIC-level  uhci_hcd:usb8, aic79xx
> 193:     427962          0   IO-APIC-level  uhci_hcd:usb7, aic79xx
> 
> If not in IO-APIC mode, lots of those will say "XT-PIC" instead
> of IO-APIC.
> 
> >  Certainly, it seems likely that the configs could be fairly
> > different in their detail.
> 
> 
 I eventually found it ("Local APIC support on uniprocessors") in
menuconfig.  In the meantime, I'd moved my 32-bit activity to a
different box (also athlon64, but a bit faster) and I had one oops
on that.  At least, I assume it was an oops - the caps and scroll
LEDs flashed, but I couldn't do anything with MagicSysrq, not even
force a reboot.  Ran diff on the various configs, changed to IO-APIC
plus an unrelated change to use libata for the cdrom.  The faster box
_seems_ stable (used for a couple of hours, and then for a whole day)
so I'm back on the original problem machine.

 Last night I reconfigured the kernel (select X86_UP_APIC, deselect
ACPI_VIDEO [ had been a module ], select ACPI_DEBUG, select PCI_MSI
(had been on in my 64-bit configs), removed some ATA/ATAPI drivers I
didn't need).  I was running on the 'old' 2.6.19.1 while I built it,
and again got the flashing LEDs after the build, but nothing logged
although I was able to force a reboot with SysRq b.

 I guess that when it does have problems, it is mostly within 30
minutes of booting - otherwise, it can be up all day.  So, for the
moment I'm hopeful that changing the config will help, but it will
be several days before I feel at all confident.

Ken
-- 
das eine Mal als Tragödie, das andere Mal als Farce
