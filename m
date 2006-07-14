Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161180AbWGNGUF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161180AbWGNGUF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 02:20:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161243AbWGNGUF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 02:20:05 -0400
Received: from 83-64-96-243.bad-voeslau.xdsl-line.inode.at ([83.64.96.243]:43179
	"EHLO mognix.dark-green.com") by vger.kernel.org with ESMTP
	id S1161180AbWGNGUD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 02:20:03 -0400
Message-ID: <44B73791.9080601@ed-soft.at>
Date: Fri, 14 Jul 2006 08:20:01 +0200
From: Edgar Hucek <hostmaster@ed-soft.at>
User-Agent: Thunderbird 1.5.0.4 (X11/20060615)
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: "Eric W. Biederman" <ebiederm@xmission.com>,
       "H. Peter Anvin" <hpa@zytor.com>, LKML <linux-kernel@vger.kernel.org>,
       akpm@osdl.org
Subject: Re: [PATCH 1/1] Fix boot on efi 32 bit Machines [try #4]
References: <44A04F5F.8030405@ed-soft.at> <Pine.LNX.4.64.0606261430430.3927@g5.osdl.org> <44A0CCEA.7030309@ed-soft.at> <Pine.LNX.4.64.0606262318341.3927@g5.osdl.org> <44A304C1.2050304@zytor.com> <m1ac7r9a9n.fsf@ebiederm.dsl.xmission.com> <44A8058D.3030905@zytor.com> <m11wt3983j.fsf@ebiederm.dsl.xmission.com> <44AB8878.7010203@ed-soft.at> <m1lkr83v73.fsf@ebiederm.dsl.xmission.com> <44B6BF2F.6030401@ed-soft.at> <Pine.LNX.4.64.0607131507220.5623@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0607131507220.5623@g5.osdl.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the memory map from the efi shell :

available  0000000000000000-000000000008EFFF  000000000000008F 000000000000000F
ACPI_NVS   000000000008F000-000000000008FFFF  0000000000000001 000000000000000F
available  0000000000090000-000000000009FFFF  0000000000000010 000000000000000F
available  0000000000100000-000000007C64FFFF  000000000007C550 000000000000000F
BS_data    000000007C650000-000000007C697FFF  0000000000000048 000000000000000F
available  000000007C698000-000000007CEA9FFF  0000000000000812 000000000000000F
LoaderData 000000007CEAA000-000000007CEC2FFF  0000000000000019 000000000000000F
LoaderCode 000000007CEC3000-000000007CFD5FFF  0000000000000113 000000000000000F
LoaderData 000000007CFD6000-000000007D08DFFF  00000000000000B8 000000000000000F
LoaderCode 000000007D08E000-000000007D09EFFF  0000000000000011 000000000000000F
available  000000007D09F000-000000007D37DFFF  00000000000002DF 000000000000000F
BS_data    000000007D37E000-000000007DCF0FFF  0000000000000973 000000000000000F
available  000000007DCF1000-000000007DD2EFFF  000000000000003E 000000000000000F
BS_data    000000007DD2F000-000000007DDD7FFF  00000000000000A9 000000000000000F
available  000000007DDD8000-000000007DE10FFF  0000000000000039 000000000000000F
BS_data    000000007DE11000-000000007E0D0FFF  00000000000002C0 000000000000000F
ACPI_NVS   000000007E0D1000-000000007E2D1FFF  0000000000000201 000000000000000F
BS_data    000000007E2D2000-000000007ECEDFFF  0000000000000A1C 000000000000000F
available  000000007ECEE000-000000007ED30FFF  0000000000000043 000000000000000F
BS_code    000000007ED31000-000000007EE3FFFF  000000000000010F 000000000000000F
available  000000007EE40000-000000007EE48FFF  0000000000000009 000000000000000F
RT_code    000000007EE49000-000000007EE6EFFF  0000000000000026 800000000000000F
available  000000007EE6F000-000000007EE7EFFF  0000000000000010 000000000000000F
RT_data    000000007EE7F000-000000007EEAAFFF  000000000000002C 800000000000000F
available  000000007EEAB000-000000007EEBAFFF  0000000000000010 000000000000000F
ACPI_recl  000000007EEBB000-000000007EEBFFFF  0000000000000005 000000000000000F
available  000000007EEC0000-000000007EEC1FFF  0000000000000002 000000000000000F
ACPI_NVS   000000007EEC2000-000000007EEEEFFF  000000000000002D 000000000000000F
ACPI_recl  000000007EEEF000-000000007EEFEFFF  0000000000000010 000000000000000F
RT_data    000000007EEFF000-000000007EEFFFFF  0000000000000001 800000000000000F
MemMapIO   00000000E00F8000-00000000E00F8FFF  0000000000000001 8000000000000000
MemMapIO   00000000FED1C000-00000000FED1FFFF  0000000000000004 8000000000000000
MemMapIO   00000000FFFB0000-00000000FFFDFFFF  0000000000000030 8000000000000000

This is the Memory what the kernel efi funktions get :

mem00: type=7, attr=0xf, range=[0x0000000000000000-0x000000000008f000) (0MB)
mem01: type=10, attr=0xf, range=[0x000000000008f000-0x0000000000090000) (0MB)
mem02: type=7, attr=0xf, range=[0x0000000000090000-0x00000000000a0000) (0MB)
mem03: type=2, attr=0xf, range=[0x0000000000100000-0x0000000003300000) (50MB)
mem04: type=7, attr=0xf, range=[0x0000000003300000-0x000000007c650000) (1939MB)
mem05: type=4, attr=0xf, range=[0x000000007c650000-0x000000007c698000) (0MB)
mem06: type=7, attr=0xf, range=[0x000000007c698000-0x000000007cf9a000) (9MB)
mem07: type=2, attr=0xf, range=[0x000000007cf9a000-0x000000007cfa5000) (0MB)
mem08: type=1, attr=0xf, range=[0x000000007cfa5000-0x000000007cfd6000) (0MB)
mem09: type=2, attr=0xf, range=[0x000000007cfd6000-0x000000007d032000) (0MB)
mem10: type=1, attr=0xf, range=[0x000000007d032000-0x000000007d033000) (0MB)
mem11: type=7, attr=0xf, range=[0x000000007d033000-0x000000007d034000) (0MB)
mem12: type=2, attr=0xf, range=[0x000000007d034000-0x000000007d08e000) (0MB)
mem13: type=1, attr=0xf, range=[0x000000007d08e000-0x000000007d09f000) (0MB)
mem14: type=7, attr=0xf, range=[0x000000007d09f000-0x000000007d3bf000) (3MB)
mem15: type=4, attr=0xf, range=[0x000000007d3bf000-0x000000007dcf1000) (9MB)
mem16: type=7, attr=0xf, range=[0x000000007dcf1000-0x000000007ddc1000) (0MB)
mem17: type=4, attr=0xf, range=[0x000000007ddc1000-0x000000007e0d1000) (3MB)
mem18: type=10, attr=0xf, range=[0x000000007e0d1000-0x000000007e2d2000) (2MB)
mem19: type=4, attr=0xf, range=[0x000000007e2d2000-0x000000007ecee000) (10MB)
mem20: type=7, attr=0xf, range=[0x000000007ecee000-0x000000007ed31000) (0MB)
mem21: type=3, attr=0xf, range=[0x000000007ed31000-0x000000007ee40000) (1MB)
mem22: type=7, attr=0xf, range=[0x000000007ee40000-0x000000007ee49000) (0MB)
mem23: type=5, attr=0x800000000000000f, range=[0x000000007ee49000-0x000000007ee6f000) (0MB)
mem24: type=7, attr=0xf, range=[0x000000007ee6f000-0x000000007ee7f000) (0MB)
mem25: type=6, attr=0x800000000000000f, range=[0x000000007ee7f000-0x000000007eeab000) (0MB)
mem26: type=7, attr=0xf, range=[0x000000007eeab000-0x000000007eebb000) (0MB)
mem27: type=9, attr=0xf, range=[0x000000007eebb000-0x000000007eec0000) (0MB)
mem28: type=7, attr=0xf, range=[0x000000007eec0000-0x000000007eec2000) (0MB)
mem29: type=10, attr=0xf, range=[0x000000007eec2000-0x000000007eeef000) (0MB)
mem30: type=9, attr=0xf, range=[0x000000007eeef000-0x000000007eeff000) (0MB)
mem31: type=6, attr=0x800000000000000f, range=[0x000000007eeff000-0x000000007ef00000) (0MB)
mem32: type=11, attr=0x8000000000000000, range=[0x00000000e00f8000-0x00000000e00f9000) (0MB)
mem33: type=11, attr=0x8000000000000000, range=[0x00000000fed1c000-0x00000000fed20000) (0MB)
mem34: type=11, attr=0x8000000000000000, range=[0x00000000fffb0000-0x00000000fffe0000) (0MB)

This is the converted memory map :


 BIOS-EFI: 0000000000000000 - 000000000008f000 (usable)
 BIOS-EFI: 000000000008f000 - 0000000000090000 (ACPI NVS)
 BIOS-EFI: 0000000000090000 - 00000000000a0000 (usable)
 BIOS-EFI: 0000000003300000 - 000000007c650000 (usable)
 BIOS-EFI: 000000007c698000 - 000000007cf9a000 (usable)
 BIOS-EFI: 000000007d033000 - 000000007d034000 (usable)
 BIOS-EFI: 000000007d09f000 - 000000007d3bf000 (usable)
 BIOS-EFI: 000000007dcf1000 - 000000007ddc1000 (usable)
 BIOS-EFI: 000000007e0d1000 - 000000007e2d2000 (ACPI NVS)
 BIOS-EFI: 000000007ecee000 - 000000007ed31000 (usable)
 BIOS-EFI: 000000007ee40000 - 000000007ee49000 (usable)
 BIOS-EFI: 000000007ee6f000 - 000000007ee7f000 (usable)
 BIOS-EFI: 000000007eeab000 - 000000007eebb000 (usable)
 BIOS-EFI: 000000007eebb000 - 000000007eec0000 (ACPI data)
 BIOS-EFI: 000000007eec0000 - 000000007eec2000 (usable)
 BIOS-EFI: 000000007eec2000 - 000000007eeef000 (ACPI NVS)
 BIOS-EFI: 000000007eeef000 - 000000007eeff000 (ACPI data)
 BIOS-EFI: 00000000e00f8000 - 00000000e00f9000 (reserved)
 BIOS-EFI: 00000000fed1c000 - 00000000fed20000 (reserved)
 BIOS-EFI: 00000000fffb0000 - 00000000fffe0000 (reserved)

This is the funktion i used for converting :

void __init efi_init_e820_map(void)
{
        efi_memory_desc_t *md;
        unsigned long long start = 0;
        unsigned long long end = 0;
        unsigned long long size = 0;
        void *p;

        e820.nr_map = 0;

        for (p = memmap.map; p < memmap.map_end;
                p += memmap.desc_size) {
                md = p;
                switch (md->type) {
                case EFI_ACPI_RECLAIM_MEMORY:
                        add_memory_region(md->phys_addr, md->num_pages << EFI_PAGE_SHIFT, E820_ACPI);
                        break;
                case EFI_RESERVED_TYPE:
                case EFI_MEMORY_MAPPED_IO:
                case EFI_MEMORY_MAPPED_IO_PORT_SPACE:
                case EFI_UNUSABLE_MEMORY:
                        add_memory_region(md->phys_addr, md->num_pages << EFI_PAGE_SHIFT, E820_RESERVED);
                        break;
                case EFI_CONVENTIONAL_MEMORY:
                        start = md->phys_addr;
                        size = md->num_pages << EFI_PAGE_SHIFT;
                        end = start + size;
                        if (start < 0x100000ULL && end > 0xA0000ULL) {
                                if (start < 0xA0000ULL)
                                        add_memory_region(start, 0xA0000ULL-start, E820_RAM);
                                if (end <= 0x100000ULL)
                                        continue;
                                start = 0x100000ULL;
                                size = end - start;
                        }
                        add_memory_region(start, size, E820_RAM);
                        break;
                case EFI_ACPI_MEMORY_NVS:
                        add_memory_region(md->phys_addr, md->num_pages << EFI_PAGE_SHIFT, E820_NVS);
                        break;
                }
        }
}


cu

Edgar Hucek


Linus Torvalds schrieb:
> 
> On Thu, 13 Jul 2006, Edgar Hucek wrote:
>> I converted the efi memory map to use the e820 table.
>> While converting i discovered why the kernel would allways
>> fail to boot through efi on Intel Macs without a proper fix.
> 
> Ok, can you show what the converted and the original map looks like?
> 
>> From kernel 2.6.16 to kernel 2.6.17 a new check is made.
>> File arch/i386/pci/mmconfig.c -> funktion pci_mmcfg_init -> check e820_all_mapped
>> The courios thing is that this check will always fail on the
>> Intel Macs booted through efi. Parsing of the ACPI_MCFG table
>> returns e0000000 for the start. But this location is
>> not in the memory map which the efi firmware have :
>> BIOS-EFI: 00000000e00f8000 - 00000000e00f9000 (reserved)
> 
> It _sounds_ like you may not have converted all the EFI types 
> (EFI_UNUSABLE_MEMORY?), but regardless, I think it would be fine to have 
> perhaps a "PCI_FORCE_MMCONF" flag that avoided that sanity check, and then 
> you could have some code (either the EFI code _or_ some DMI code) that 
> sets it for the Intel Macs.
> 
> Note that the check in pci_mmcfg_init() shouldn't be some EFI hack itself, 
> it would be a real flag for the PCI subsystem, independently of EFI (I can 
> see it being useful for a kernel command line option, even), and the only 
> EFI connection would be that perhaps the EFI code ends up setting that 
> flag (especially if there is some EFI command for doing this).
> 
> Btw, if you do do this, I think we should make sure that the MMCONFIG base 
> address is reserved in the PCI MMIO resource structures (which we don't do 
> now, I think - part of the whole point of verifying that it's marked as 
> E820_RESERVED is exactly the fact that otherwise we migth have problems 
> with PCI MMIO resource allocations allocating a regular PCI resource over 
> the MMCONFIG space..)
> 
> 			Linus
> 

