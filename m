Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262220AbTEPV3w (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 17:29:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264434AbTEPV3w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 17:29:52 -0400
Received: from 205-158-62-136.outblaze.com ([205.158.62.136]:33690 "HELO
	fs5-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id S262220AbTEPV3p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 17:29:45 -0400
Subject: Re: 2.5.69-mm6: pccard oops while booting
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Andrew Morton <akpm@digeo.com>
Cc: rmk@arm.linux.org.uk, LKML <linux-kernel@vger.kernel.org>, davej@suse.de
In-Reply-To: <20030516132908.62e54266.akpm@digeo.com>
References: <1052964213.586.3.camel@teapot.felipe-alfaro.com>
	 <20030514191735.6fe0998c.akpm@digeo.com>
	 <1052998601.726.1.camel@teapot.felipe-alfaro.com>
	 <20030515130019.B30619@flint.arm.linux.org.uk>
	 <1053004615.586.2.camel@teapot.felipe-alfaro.com>
	 <20030515144439.A31491@flint.arm.linux.org.uk>
	 <1053037915.569.2.camel@teapot.felipe-alfaro.com>
	 <20030515160015.5dfea63f.akpm@digeo.com>
	 <1053090184.653.0.camel@teapot.felipe-alfaro.com>
	 <1053110098.648.1.camel@teapot.felipe-alfaro.com>
	 <20030516132908.62e54266.akpm@digeo.com>
Content-Type: multipart/mixed; boundary="=-+hCtXFy4zSDxEJwo33ul"
Message-Id: <1053121346.569.1.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.3 (Preview Release)
Date: 16 May 2003 23:42:26 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-+hCtXFy4zSDxEJwo33ul
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, 2003-05-16 at 22:29, Andrew Morton wrote:
> Felipe Alfaro Solana <felipe_alfaro@linuxmail.org> wrote:
> >
> > Unable to handle kernel paging request at virtual address 50464d59
> 
> hm, that address is "YMFP".   Please try generating the oops
> again with the below patch applied:
> 
>  ./sound/pci/ymfpci/ymfpci.c      |    8 ++++----
>  ./sound/pci/ymfpci/ymfpci_main.c |   22 +++++++++++-----------
>  2 files changed, 15 insertions(+), 15 deletions(-)
> 
> diff -puN ./sound/pci/ymfpci/ymfpci_main.c~a ./sound/pci/ymfpci/ymfpci_main.c
> --- 25/./sound/pci/ymfpci/ymfpci_main.c~a	2003-05-16 13:26:26.000000000 -0700
> +++ 25-akpm/./sound/pci/ymfpci/ymfpci_main.c	2003-05-16 13:27:27.000000000 -0700
> @@ -1093,7 +1093,7 @@ int __devinit snd_ymfpci_pcm(ymfpci_t *c
>  
>  	if (rpcm)
>  		*rpcm = NULL;
> -	if ((err = snd_pcm_new(chip->card, "YMFPCI", device, 32, 1, &pcm)) < 0)
> +	if ((err = snd_pcm_new(chip->card, "1YMFPCI", device, 32, 1, &pcm)) < 0)
>  		return err;
>  	pcm->private_data = chip;
>  	pcm->private_free = snd_ymfpci_pcm_free;
> @@ -1103,7 +1103,7 @@ int __devinit snd_ymfpci_pcm(ymfpci_t *c
>  
>  	/* global setup */
>  	pcm->info_flags = 0;
> -	strcpy(pcm->name, "YMFPCI");
> +	strcpy(pcm->name, "2YMFPCI");
>  	chip->pcm = pcm;
>  
>  	snd_pcm_lib_preallocate_pci_pages_for_all(chip->pci, pcm, 64*1024, 256*1024);
> @@ -1138,7 +1138,7 @@ int __devinit snd_ymfpci_pcm2(ymfpci_t *
>  
>  	if (rpcm)
>  		*rpcm = NULL;
> -	if ((err = snd_pcm_new(chip->card, "YMFPCI - AC'97", device, 0, 1, &pcm)) < 0)
> +	if ((err = snd_pcm_new(chip->card, "3YMFPCI - AC'97", device, 0, 1, &pcm)) < 0)
>  		return err;
>  	pcm->private_data = chip;
>  	pcm->private_free = snd_ymfpci_pcm2_free;
> @@ -1147,7 +1147,7 @@ int __devinit snd_ymfpci_pcm2(ymfpci_t *
>  
>  	/* global setup */
>  	pcm->info_flags = 0;
> -	strcpy(pcm->name, "YMFPCI - AC'97");
> +	strcpy(pcm->name, "4YMFPCI - AC'97");
>  	chip->pcm2 = pcm;
>  
>  	snd_pcm_lib_preallocate_pci_pages_for_all(chip->pci, pcm, 64*1024, 256*1024);
> @@ -1182,7 +1182,7 @@ int __devinit snd_ymfpci_pcm_spdif(ymfpc
>  
>  	if (rpcm)
>  		*rpcm = NULL;
> -	if ((err = snd_pcm_new(chip->card, "YMFPCI - IEC958", device, 1, 0, &pcm)) < 0)
> +	if ((err = snd_pcm_new(chip->card, "5YMFPCI - IEC958", device, 1, 0, &pcm)) < 0)
>  		return err;
>  	pcm->private_data = chip;
>  	pcm->private_free = snd_ymfpci_pcm_spdif_free;
> @@ -1191,7 +1191,7 @@ int __devinit snd_ymfpci_pcm_spdif(ymfpc
>  
>  	/* global setup */
>  	pcm->info_flags = 0;
> -	strcpy(pcm->name, "YMFPCI - IEC958");
> +	strcpy(pcm->name, "6YMFPCI - IEC958");
>  	chip->pcm_spdif = pcm;
>  
>  	snd_pcm_lib_preallocate_pci_pages_for_all(chip->pci, pcm, 64*1024, 256*1024);
> @@ -1226,7 +1226,7 @@ int __devinit snd_ymfpci_pcm_4ch(ymfpci_
>  
>  	if (rpcm)
>  		*rpcm = NULL;
> -	if ((err = snd_pcm_new(chip->card, "YMFPCI - Rear", device, 1, 0, &pcm)) < 0)
> +	if ((err = snd_pcm_new(chip->card, "7YMFPCI - Rear", device, 1, 0, &pcm)) < 0)
>  		return err;
>  	pcm->private_data = chip;
>  	pcm->private_free = snd_ymfpci_pcm_4ch_free;
> @@ -1235,7 +1235,7 @@ int __devinit snd_ymfpci_pcm_4ch(ymfpci_
>  
>  	/* global setup */
>  	pcm->info_flags = 0;
> -	strcpy(pcm->name, "YMFPCI - Rear PCM");
> +	strcpy(pcm->name, "8YMFPCI - Rear PCM");
>  	chip->pcm_4ch = pcm;
>  
>  	snd_pcm_lib_preallocate_pci_pages_for_all(chip->pci, pcm, 64*1024, 256*1024);
> @@ -1831,7 +1831,7 @@ static void snd_ymfpci_proc_read(snd_inf
>  {
>  	// ymfpci_t *chip = snd_magic_cast(ymfpci_t, private_data, return);
>  	
> -	snd_iprintf(buffer, "YMFPCI\n\n");
> +	snd_iprintf(buffer, "9YMFPCI\n\n");
>  }
>  
>  static int __devinit snd_ymfpci_proc_init(snd_card_t * card, ymfpci_t *chip)
> @@ -2226,12 +2226,12 @@ int __devinit snd_ymfpci_create(snd_card
>  	chip->reg_area_virt = (unsigned long)ioremap_nocache(chip->reg_area_phys, 0x8000);
>  	pci_set_master(pci);
>  
> -	if ((chip->res_reg_area = request_mem_region(chip->reg_area_phys, 0x8000, "YMFPCI")) == NULL) {
> +	if ((chip->res_reg_area = request_mem_region(chip->reg_area_phys, 0x8000, "AYMFPCI")) == NULL) {
>  		snd_ymfpci_free(chip);
>  		snd_printk("unable to grab memory region 0x%lx-0x%lx\n", chip->reg_area_phys, chip->reg_area_phys + 0x8000 - 1);
>  		return -EBUSY;
>  	}
> -	if (request_irq(pci->irq, snd_ymfpci_interrupt, SA_INTERRUPT|SA_SHIRQ, "YMFPCI", (void *) chip)) {
> +	if (request_irq(pci->irq, snd_ymfpci_interrupt, SA_INTERRUPT|SA_SHIRQ, "BYMFPCI", (void *) chip)) {
>  		snd_ymfpci_free(chip);
>  		snd_printk("unable to grab IRQ %d\n", pci->irq);
>  		return -EBUSY;
> diff -puN ./sound/pci/ymfpci/ymfpci.c~a ./sound/pci/ymfpci/ymfpci.c
> --- 25/./sound/pci/ymfpci/ymfpci.c~a	2003-05-16 13:26:26.000000000 -0700
> +++ 25-akpm/./sound/pci/ymfpci/ymfpci.c	2003-05-16 13:27:49.000000000 -0700
> @@ -122,7 +122,7 @@ static int __devinit snd_card_ymfpci_pro
>  			fm_port[dev] = addr;
>  		}
>  		if (fm_port[dev] >= 0 &&
> -		    (chip->fm_res = request_region(fm_port[dev], 4, "YMFPCI OPL3")) != NULL) {
> +		    (chip->fm_res = request_region(fm_port[dev], 4, "CYMFPCI OPL3")) != NULL) {
>  			legacy_ctrl |= YMFPCI_LEGACY_FMEN;
>  			pci_write_config_word(pci, PCIR_DSXG_FMBASE, fm_port[dev]);
>  		}
> @@ -133,7 +133,7 @@ static int __devinit snd_card_ymfpci_pro
>  			mpu_port[dev] = addr;
>  		}
>  		if (mpu_port[dev] >= 0 &&
> -		    (chip->mpu_res = request_region(mpu_port[dev], 2, "YMFPCI MPU401")) != NULL) {
> +		    (chip->mpu_res = request_region(mpu_port[dev], 2, "DYMFPCI MPU401")) != NULL) {
>  			legacy_ctrl |= YMFPCI_LEGACY_MEN;
>  			pci_write_config_word(pci, PCIR_DSXG_MPU401BASE, mpu_port[dev]);
>  		}
> @@ -146,7 +146,7 @@ static int __devinit snd_card_ymfpci_pro
>  		default: fm_port[dev] = -1; break;
>  		}
>  		if (fm_port[dev] > 0 &&
> -		    (chip->fm_res = request_region(fm_port[dev], 4, "YMFPCI OPL3")) != NULL) {
> +		    (chip->fm_res = request_region(fm_port[dev], 4, "EYMFPCI OPL3")) != NULL) {
>  			legacy_ctrl |= YMFPCI_LEGACY_FMEN;
>  		} else {
>  			legacy_ctrl2 &= ~YMFPCI_LEGACY2_FMIO;
> @@ -160,7 +160,7 @@ static int __devinit snd_card_ymfpci_pro
>  		default: mpu_port[dev] = -1; break;
>  		}
>  		if (mpu_port[dev] > 0 &&
> -		    (chip->mpu_res = request_region(mpu_port[dev], 2, "YMFPCI MPU401")) != NULL) {
> +		    (chip->mpu_res = request_region(mpu_port[dev], 2, "FYMFPCI MPU401")) != NULL) {
>  			legacy_ctrl |= YMFPCI_LEGACY_MEN;
>  		} else {
>  			legacy_ctrl2 &= ~YMFPCI_LEGACY2_MPUIO;
> 

I've applied the patch above to a pristine 2.5.69-mm6. Curiously, if I
build snd-ymfpci as a module, I can't reproduce the oops anymore.
However, if I build snd-ymfpci into the kernel, I can *still* reproduce
the oops.

Attached is the dmesg of a 2.5.69-mm6 plus the above patch with ymfpci
integrated into the kernel.

Thanks!


--=-+hCtXFy4zSDxEJwo33ul
Content-Disposition: attachment; filename=dmesg-kernel
Content-Type: application/octet-stream; name=dmesg-kernel
Content-Transfer-Encoding: 8bit

Linux version 2.5.69-mm6-test (root@glass.felipe-alfaro.com) (gcc version 3.2.3 20030422 (Red Hat Linux 3.2.3-4)) #1 Fri May 16 23:34:22 CEST 2003
Video mode to be used for restore is f00
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000fff0000 (usable)
 BIOS-e820: 000000000fff0000 - 000000000fff8000 (ACPI data)
 BIOS-e820: 000000000fff8000 - 0000000010000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
255MB LOWMEM available.
On node 0 totalpages: 65520
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 61424 pages, LIFO batch:14
  HighMem zone: 0 pages, LIFO batch:1
ACPI: RSDP (v000 NEC                        ) @ 0x000fb550
ACPI: RSDT (v001    NEC ND000020 00000.00001) @ 0x0fff0000
ACPI: FADT (v001    NEC ND000020 00000.00001) @ 0x0fff0030
ACPI: BOOT (v001    NEC ND000020 00000.00001) @ 0x0fff00b0
ACPI: DSDT (v001    NEC ND000020 00000.00001) @ 0x00000000
ACPI: BIOS passes blacklist
Building zonelist for node : 0
Kernel command line: ro root=/dev/hda3 1
Initializing CPU#0
PID hash table entries: 1024 (order 10: 8192 bytes)
Detected 696.996 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1376.25 BogoMIPS
Memory: 256048k/262080k available (1739k kernel code, 5304k reserved, 682k data, 104k init, 0k highmem)
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
-> /dev
-> /dev/console
-> /root
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU:     After generic, caps: 0383f9ff 00000000 00000000 00000040
CPU: Intel Pentium III (Coppermine) stepping 06
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v2.0 (20020519)
Initializing RT netlink socket
PCI: PCI BIOS revision 2.10 entry at 0xfdb81, last bus=1
PCI: Using configuration type 1
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
ACPI: Subsystem revision 20030418
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [NRTH] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.NRTH._PRT]
ACPI: Embedded Controller [EC0] (gpe 9)
ACPI: Power Resource [PUSB] (off)
ACPI: PCI Interrupt Link [LNKA] (IRQs 10, disabled)
ACPI: PCI Interrupt Link [LNKB] (IRQs 5, disabled)
ACPI: PCI Interrupt Link [LNKC] (IRQs 5 7 10, disabled)
ACPI: PCI Interrupt Link [LNKD] (IRQs 9, disabled)
block request queues:
 4/128 requests per read queue
 4/128 requests per write queue
 enter congestion at 15
 exit congestion at 17
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 9
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
SBF: Simple Boot Flag extension found and enabled.
SBF: Setting boot flags 0x1
Enabling SEP on CPU 0
Limiting direct PCI/PCI transfers.
ACPI: AC Adapter [AC] (on-line)
ACPI: Battery Slot [BAT0] (battery absent)
ACPI: Power Button (CM) [PRB1]
ACPI: Lid Switch [LID0]
ACPI: Fan [FANC] (on)
ACPI: Processor [CPU0] (supports C1)
ACPI: Thermal Zone [THRM] (64 C)
pty: 256 Unix98 ptys configured
Real Time Clock Driver v1.11
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected an Intel 440BX Chipset.
agpgart: Maximum main memory to use for agp memory: 203M
agpgart: AGP aperture is 256M @ 0xe0000000
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller at PCI slot 00:07.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio
hda: HITACHI_DK23BA-20, ATA DISK drive
anticipatory scheduling elevator
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: MATSHITADVD-ROM SR-8185, ATAPI CD/DVD-ROM drive
anticipatory scheduling elevator
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: host protected area => 1
hda: 39070080 sectors (20004 MB) w/2048KiB Cache, CHS=38760/16/63, UDMA(33)
 hda: hda1 hda2 hda3 hda4
hdc: ATAPI 24X DVD-ROM drive, 512kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
yenta 00:0c.0: Preassigned resource 3 busy, reconfiguring...
Yenta IRQ list 08d8, PCI irq10
Socket status: 30000068
yenta 00:0c.1: Preassigned resource 2 busy, reconfiguring...
yenta 00:0c.1: Preassigned resource 3 busy, reconfiguring...
Yenta IRQ list 08d8, PCI irq5
Socket status: 30000006
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver v2.0
uhci-hcd 00:07.2: Intel Corp. 82371AB/EB/MB PIIX4 
uhci-hcd 00:07.2: irq 9, io base 0000ef80
Please use the 'usbfs' filetype instead, the 'usbdevfs' name is deprecated.
uhci-hcd 00:07.2: new USB bus registered, assigned bus number 1
hub 1-0:0: USB hub found
hub 1-0:0: 2 ports detected
drivers/usb/core/usb.c: registered new driver hiddev
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
Advanced Linux Sound Architecture Driver Version 0.9.2 (Thu Mar 20 13:31:57 2003 UTC).
ALSA device list:
  #0: Yamaha DS-XG PCI (YMF754) at 0xd0851000, irq 5
NET4: Linux TCP/IP 1.0 for NET4.0
Unable to handle kernel paging request at virtual address 25007367
 printing eip:
c0192598
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c0192598>]    Not tainted VLI
EFLAGS: 00010202
EIP is at pci_bus_match+0x18/0xb0
eax: 00000000   ebx: c13c1000   ecx: 25007367   edx: 00000000
esi: c13c104c   edi: ffffffed   ebp: cff3844c   esp: cfde7ed0
ds: 007b   es: 007b   ss: 0068
Process pccardd (pid: 10, threadinfo=cfde6000 task=c1390060)
Stack: c02ddc7c c01d065f c13c104c c02ddc7c c02ddcac c13c104c c03209fc c01d06ff 
       c13c104c c02ddc7c c13c104c c03209a0 c13c1084 c01d08b4 c13c104c c02c36c3 
       c03272c0 c13c104c 00000000 c13c1084 c01cfa84 c13c104c cffc3a40 c13c1000 
Call Trace:
 [<c01d065f>] bus_match+0x2f/0x80
 [<c01d06ff>] device_attach+0x4f/0x90
 [<c01d08b4>] bus_add_device+0x64/0xb0
 [<c01cfa84>] device_add+0xd4/0x110
 [<c018ec5e>] pci_bus_add_devices+0xae/0xe0
 [<c02038cb>] cb_alloc+0xab/0xf0
 [<c0200709>] socket_insert+0x69/0x80
 [<c01ffcba>] get_socket_status+0x1a/0x20
 [<c020094d>] pccardd+0x13d/0x1f0
 [<c0115ed0>] default_wake_function+0x0/0x20
 [<c0109272>] ret_from_fork+0x6/0x14
 [<c0115ed0>] default_wake_function+0x0/0x20
 [<c0200810>] pccardd+0x0/0x1f0
 [<c010722d>] kernel_thread_helper+0x5/0x18

Code: 83 fa 06 7e f1 31 c0 c3 b8 00 09 32 c0 c3 90 8d 74 26 00 53 8b 44 24 0c 8b 5c 24 08 83 e8 28 8b 48 0c 83 eb 4c 31 c0 85 c9 74 30 <8b> 11 85 d2 74 7a 89 f6 83 fa ff 74 2b 0f b7 43 24 39 c2 74 23 
 <6>hub 1-0:0: debounce: port 1: delay 100ms stable 4 status 0x301
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 104k freed
hub 1-0:0: new USB device on port 1, assigned address 2
input: USB HID v1.00 Mouse [Microsoft Microsoft IntelliMouse® Explorer] on usb-00:07.2-1
hub 1-0:0: debounce: port 2: delay 100ms stable 4 status 0x101
hub 1-0:0: new USB device on port 2, assigned address 3
hub 1-2:0: USB hub found
hub 1-2:0: 2 ports detected
Adding 257032k swap on /dev/hda2.  Priority:-1 extents:1
blk: queue c038d3dc, I/O limit 4095Mb (mask 0xffffffff)
hdc: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
hdc: drive_cmd: error=0x04Aborted Command 

--=-+hCtXFy4zSDxEJwo33ul--

