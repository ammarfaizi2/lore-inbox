Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130532AbREEJHx>; Sat, 5 May 2001 05:07:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131157AbREEJHo>; Sat, 5 May 2001 05:07:44 -0400
Received: from dyn7d0.dhcp.lancs.ac.uk ([148.88.247.208]:19972 "EHLO
	dyn7d0.dhcp.lancs.ac.uk") by vger.kernel.org with ESMTP
	id <S130532AbREEJHg>; Sat, 5 May 2001 05:07:36 -0400
Date: Sat, 5 May 2001 10:06:02 +0100 (BST)
From: Stephen Torri <s.torri@lancaster.ac.uk>
X-X-Sender: <torri@dyn7d0.dhcp.lancs.ac.uk>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: 2.4.4-ac4 OOPS: acpi_get_timer
Message-ID: <Pine.LNX.4.33.0105050924530.3268-100000@dyn7d0.dhcp.lancs.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I compiled 2.4.4-ac4 with gcc-2.95.3. No problems with previous versions
until today. Here is the output of the kenerl panic from ksymoops:

EIP: c0247cfa <acpi_get_timer+e/2c>
Trace: c025602e <bm_initialize+56/278>
Trace: c02567a5 <bm_osl_init+79/8c>
Trace: c0105058 <init+58/1d0>
Trace: c0105594 <kernel thread+28/38>
Code; c0247cfa <acpi_get_timer+e/2c>
00000000 <_EIP>:

Code: c0247cfa <acpi_get_timer+e/2c>
   0: 8b 80 d4 00 00 00		mov, 0xd4(%eax), %eax

Code: c0247d00 <acpi_get_timer+14/2c>
   6: 50			push %eax

Code: c0247d01 <acpi_get_timer+15/2c>
   7: e8 4a 77 ff ff		call ffff7756 <_EIP+0xffff7756>
				c023f450 <acpi_os_in_32+0/8>

Code: c0247d06 <acpi_get_timer+1a/2c>
   c: 89 03			mov %eax, (%ebx)

Code: c0247d08 <acpi_get_timer +1c/2c>
   e: 31 c0			xor %eax, %eax

Code: c0247d0a <acpi_get_timer+1e/2c>
  10: 83 c4 04			add $0x4, %esp

Code: c0247d0d <acpi_get_timer+21/2c>
  13: eb 00			jmp 15 <_EIP+0x15> c0247d0f
				<acpi_get_timer+23/2c>


acpi_get_timer is in drivers/acpi/hardware/hwtimer

It makes a call to acpi_os_in32

acpi_os_in32 is in drivers/acpi/os.c

This takes the argument of an ACPI_IO_ADDRESS for a port number. What is
given as arguments in acpi_get_timer is

acpi_os_in32((ACPI_IO_ADDRESS) ACPI_GET_ADDRESS
(acpi_gbl_FADT->Xpm_tmr_blk.address));

ACPI_IO_ADDRESS is a cast
ACPI_GET_ADDRESS is a converter from 32 or 64 bit addresses to 16 bit
addresses if necessary. On this system it should not do anything.
acpi_gbl+FADT is a FADT_DESCRIPTOR_REV2 (a struct).

Looking at FADT_DESCRIPTOR_REV2's definition I fail to see where the
pointer is referring to in the struct. There is no element named
Xpm_tmr_blk)

---------------
The message that I received at the top of the oops was:

unable to handle NULL pointer dereference at virutal address 0000 00d4

---------------
System:
Dual P3@450Mhz, 392 MB Ram
Supermicro P6DBE motherboard
ACPI Disabled during first boot - got oops
ACPI Enabled during second boot - got same oops

ACPI settings:
all except for battery.

Stephen

-----------------------------------------------
Buyer's Guide for a Operating System:
Don't care to know: Mac
Don't mind knowing but not too much: Windows
Hit me! I can take it!: Linux




