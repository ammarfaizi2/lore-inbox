Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265470AbTLHRCI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 12:02:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265504AbTLHRA3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 12:00:29 -0500
Received: from k-kdom.nishanet.com ([65.125.12.2]:14095 "EHLO
	mail2k.k-kdom.nishanet.com") by vger.kernel.org with ESMTP
	id S265483AbTLHQ7m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 11:59:42 -0500
Message-ID: <3FD4B250.8010402@nishanet.com>
Date: Mon, 08 Dec 2003 12:18:08 -0500
From: Bob <recbo@nishanet.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031014 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Kernel 2.6.0-testX show stoppers
References: <3FD498A0.9080802@yahoo.es> <1070898030.2098.146.camel@athlonxp.bradney.info>
In-Reply-To: <1070898030.2098.146.camel@athlonxp.bradney.info>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Craig Bradney wrote:

>For the Athlon, keep in touch with the nforce thread on here.. There are
>patches due to timing issues with the nforce chipset. 
>
>For me, so far, just using this one works:
>http://www.kernel.org/pub/linux/kernel/people/bart/2.6.0-test11-bart1/broken-out/nforce2-apic.patch
>
>There is a program called athcool to turn off CPU Disconnect if you dont
>have that in your BIOS. I havent used this patch as I have found
>reliability using the first one I mentioned.
>
>Craig
>  
>
The patch works for a lot of people. I've seen those drive
errors, irq7 disabled, spurious 8259a messages with a
bios and acpi and apic and lapic and linux acpi handling
conflict usually related to nforce2 and amd cpu's are
usually involved.

My nforce2 amd system got to working with apic and lapic
and acpi when I did a bios flash update.

On a via chip system, amd cpu, savage pro vid onboard,
it would run stable but there were some no-no's with
regard to acpi-apic-lapic until a bios flash helped.

Things I tried and saw some improvement from were
leaving acpi on and apic on in linux, turn lapic off in
linux. 2) Turn apic off in bios and on in linux. 3) Use
anticipatory scheduling and turn deadline scheduling
off really helped with driver errors on the via box.
4) hdparm off unmask irq feature on drive controllers
by siig sis.

My pcmcia controller doesn't show a sign of life. In
the documentation mine says it's very touchy about
sharing irq's even though it's a pci card. These nforce2
acpi conflicts cause just that sort of problem. On the
bright side, they can go away, it's only a hardware
problem causing juxtaposed by software that can
be changed either in kernel or bios update.

-Bob

>On Mon, 2003-12-08 at 16:28, Roberto Sanchez wrote:
>  
>
>>I am having some problems getting 2.6.0-test11 working on my 2 boxes.
>>I am hoping that someone here can provide me some insight so that I
>>can provide some useful info to help get these solved.
>>
>>Any help would be appreciated.
>>
>>-Roberto
>>
>>Here goes:
>>
>>Box 1:
>>
>>Athlon XP 2500+, 1 GB RAM, 120 GB HDD
>>nVidia nForce2 chipset
>>ATI Radeon 9000 Pro w/ 128 MB
>>
>>This machine just randomly and frequently locks up under any 2.6.x
>>kernel.  I can't find a particular pattern, but it happens every few
>>minutes (enough to make the machine unusable).  It is now running a
>>2.4.23 kernel.
>>
>>
>>Box 2:
>>
>>Toshiba Satellite 2805-S401 (laptop)
>>P-III 700 MHz, 256 MB RAM, 40 GB HDD
>>Intel 440BX chipset
>>S3 Savage IX/MV 8 MB video
>>
>>Problem: Every kernel after 2.6.0-test4 gives me a hard lock-up during
>>the boot sequence when PCMCIA services start.  No 2.4.x kernel ever did
>>this, and 2.6.0-test1 thru -test4 work fine.  I have narrowed the 
>>problem to the point where the yenta_socket socket module is inserted.
>>However, if I pass acpi=off as a kernel boot parameter, it does not lock
>>up.  Also, if I build PCMCIA support directly into the kernel,
>>everything works.  I am currently running 2.6.0-test11 with PCMCIA
>>built in (but I would like it to be modular).
>>
>>I am also receiving the following errors on boot when my scripts
>>set up the parameters on my HDD and CD/DVD (this is also particular
>>to the post -test4 kernels):
>>
>>hda: dma_intr: status=0x58 { DriveReady SeekComplete DataRequest }
>>
>>hda: status error: status=0x58 { DriveReady SeekComplete DataRequest }
>>
>>hda: drive not ready for command
>>hda: status error: status=0x58 { DriveReady SeekComplete DataRequest }
>>
>>hda: drive not ready for command
>>hda: status error: status=0x58 { DriveReady SeekComplete DataRequest }
>>
>>hda: DMA disabled
>>hda: drive not ready for command
>>hda: set_drive_speed_status: status=0x58 { DriveReady SeekComplete 
>>DataRequest }
>>
>>But, eventhough it says DMA is disabled, it is still enabled.
>>
>># hdparm /dev/hda
>>
>>/dev/hda:
>>  multcount    = 16 (on)
>>  IO_support   =  1 (32-bit)
>>  unmaskirq    =  1 (on)
>>  using_dma    =  1 (on)
>>  keepsettings =  0 (off)
>>  readonly     =  0 (off)
>>  readahead    = 256 (on)
>>  geometry     = 38760/16/63, sectors = 39070080, start = 0
>>
>
>  
>


