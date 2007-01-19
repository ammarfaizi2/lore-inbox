Return-Path: <linux-kernel-owner+w=401wt.eu-S964976AbXASIhn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964976AbXASIhn (ORCPT <rfc822;w@1wt.eu>);
	Fri, 19 Jan 2007 03:37:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964978AbXASIhn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Jan 2007 03:37:43 -0500
Received: from hera.kernel.org ([140.211.167.34]:41994 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964976AbXASIhm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Jan 2007 03:37:42 -0500
From: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
To: "Matheus Izvekov" <mizvekov@gmail.com>
Subject: Re: BUG: linux 2.6.19 unable to enable acpi
Date: Fri, 19 Jan 2007 03:36:20 -0500
User-Agent: KMail/1.9.5
Cc: "Arjan van de Ven" <arjan@infradead.org>,
       "Luming Yu" <luming.yu@gmail.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
References: <305c16960701162001j5ec23332hcd398cbe944916e1@mail.gmail.com> <200701170408.54220.lenb@kernel.org> <305c16960701171310v727963aevd4f29eba34316ed9@mail.gmail.com>
In-Reply-To: <305c16960701171310v727963aevd4f29eba34316ed9@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701190336.20236.lenb@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 17 January 2007 16:10, Matheus Izvekov wrote:
> On 1/17/07, Len Brown <lenb@kernel.org> wrote:
> > The code that enables ACPI mode hasn't really changed since before 2.6.12 --
> > unless udelay() has changed beneath us...
> > So if you are going to test an old version of Linux, you should start before then.
> >
> > Perhaps you can try this debug patch on top of 2.6.19 and send along the dmesg?
> > (also, please include CONFIG_ACPI_DEBUG=y)
> >
> > thanks,
> > -Len
> 
> Tried that, dmesg output below:
> 
> DMI 2.2 present.
> ACPI: RSDP (v000 AMI                                   ) @ 0x000fb080
> ACPI: RSDT (v001 AMIINT          0x00000000 MSFT 0x00000097) @ 0x0fdf0000
> ACPI: FADT (v001 AMIINT          0x00000000 MSFT 0x00000097) @ 0x0fdf0030
> ACPI: DSDT (v001    SiS      620 0x00001000 MSFT 0x0100000a) @ 0x00000000
> ACPI: PM-Timer IO Port: 0x408
> Allocating PCI resources starting at 10000000 (gap: 0fe00000:f00f0000)
> Detected 300.683 MHz processor.
> Built 1 zonelists.  Total pages: 64501
> Kernel command line: root=/dev/sda3
> Initializing CPU#0
> CPU 0 irqstacks, hard=c038f000 soft=c038e000
> PID hash table entries: 1024 (order: 10, 4096 bytes)
> Console: colour VGA+ 80x25
> Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
> Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
> Memory: 254268k/260032k available (1818k kernel code, 5268k reserved,
> 611k data, 160k init, 0k highmem)
> virtual kernel memory layout:
>     fixmap  : 0xffff8000 - 0xfffff000   (  28 kB)
>     vmalloc : 0xd0800000 - 0xffff6000   ( 759 MB)
>     lowmem  : 0xc0000000 - 0xcfdf0000   ( 253 MB)
>       .init : 0xc0361000 - 0xc0389000   ( 160 kB)
>       .data : 0xc02c6be6 - 0xc035fa28   ( 611 kB)
>       .text : 0xc0100000 - 0xc02c6be6   (1818 kB)
> Checking if this processor honours the WP bit even in supervisor mode... Ok.
> Calibrating delay using timer specific routine.. 602.00 BogoMIPS (lpj=3010033)
> Security Framework v1.0.0 initialized
> Mount-cache hash table entries: 512
> CPU: After generic identify, caps: 0080f9ff 00000000 00000000 00000000
> 00000000 00000000 00000000
> CPU: L1 I cache: 16K, L1 D cache: 16K
> CPU: L2 cache: 512K
> CPU: After all inits, caps: 0080f9ff 00000000 00000000 00000040
> 00000000 00000000 00000000
> Intel machine check architecture supported.
> Intel machine check reporting enabled on CPU#0.
> CPU: Intel Pentium II (Klamath) stepping 03
> Checking 'hlt' instruction... OK.
> ACPI: Core revision 20060707
>  tbxface-0107 [01] load_tables           : ACPI Tables successfully acquired
> Parsing all Control Methods:
> Table [DSDT](id 0005) - 259 Objects with 25 Devices 99 Methods 13 Regions
> ACPI Namespace successfully loaded at root c03a49f0
> ACPI: setting ELCR to 8000 (from 1c00)
> ACPI: FADT.acpi_enable 225
> ACPI: FADT.acpi_disable 30
> ACPI: smi_cmd 0x435, acpi_enable 0xe1
> ACPI: retry 142

I guess I'm losing my mind, because when I read this code,
there are only two ways out of the while(retry) loop.
Either return with success, or retry is 0.
So how the heck is retry printed as 142?!

did you notice any delay between the last two lines of printout above?

please boot with "acpi_dbg_layer=2" "acpi_dbg_level=0xffffffff"
so that we can see each read and write of the hardware look like.
Success is measured here by looking for SCI_EN being set
to indicate that we successfully entered ACPI mode.

I guess we should see about 142 reads looking for SCI_EN...

It would be interesting if you could boot a windows disk on this box
to see if they are able to get into ACPI mode.  You'd be able to
tell by dumping the interrupt list, looking at the device tree,
or observing if the power button gives immediate poweroff
or does an OS shutdown.

thanks,
-Len

> ACPI Error (hwacpi-0185): Hardware did not change modes [20060707]
> ACPI Error (evxfevnt-0084): Could not transition to ACPI mode [20060707]
> ACPI Warning (utxface-0154): AcpiEnable failed [20060707]
> ACPI: Unable to enable ACPI
