Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276044AbRI1NMI>; Fri, 28 Sep 2001 09:12:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276045AbRI1NL6>; Fri, 28 Sep 2001 09:11:58 -0400
Received: from smtp.alcove.fr ([212.155.209.139]:13829 "EHLO smtp.alcove.fr")
	by vger.kernel.org with ESMTP id <S276044AbRI1NLs>;
	Fri, 28 Sep 2001 09:11:48 -0400
Date: Fri, 28 Sep 2001 15:12:08 +0200
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Thomas Hood <jdthood@mail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PnP BIOS + 2.4.9-ac16 = no boot
Message-ID: <20010928151208.J21524@come.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
In-Reply-To: <3BB46DCD.91576F70@mail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3BB46DCD.91576F70@mail.com>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2001 at 08:32:13AM -0400, Thomas Hood wrote:

> Please try this patch to drivers/pnp/pnp_bios.c (attached) and get
> back to me.

It doesn't change much: without the patch it hangs after:
	PnP: PNP BIOS installation structure at 0xc00f8120
	PnP: PNP BIOS version 1.0, entry ay f0000:b25f, dseg at 400
With the patch a third line is printed before the oops:
	PnP: PNP BIOS 13 devices detected (or something like that).

The oops symptoms seems to be identical in both cases.

> It would be helpful too if you could track down (using printks)
> where the fault occurs.

What about this manually copied oops decode (not sure why the
warnings are present...) (NOTE: this oops is without your patch):

ksymoops 2.4.1 on i586 2.4.9-ac16.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.9-ac16/ (default)
     -m /boot/System.map-2.4.9-ac16 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Warning (compare_maps): mismatch on symbol us_list  , usb-storage says c80729b0, /lib/modules/2.4.9-ac16/kernel/drivers/usb/storage/usb-storage.o says c8071c80.  Ignoring /lib/modules/2.4.9-ac16/kernel/drivers/usb/storage/usb-storage.o entry
Warning (compare_maps): mismatch on symbol us_list_semaphore  , usb-storage says c80729b4, /lib/modules/2.4.9-ac16/kernel/drivers/usb/storage/usb-storage.o says c8071c84.  Ignoring /lib/modules/2.4.9-ac16/kernel/drivers/usb/storage/usb-storage.o entry
Warning (compare_maps): mismatch on symbol proc_scsi  , scsi_mod says c806c778, /lib/modules/2.4.9-ac16/kernel/drivers/scsi/scsi_mod.o says c806afd0.  Ignoring /lib/modules/2.4.9-ac16/kernel/drivers/scsi/scsi_mod.o entry
Warning (compare_maps): mismatch on symbol scsi_devicelist  , scsi_mod says c806c7a4, /lib/modules/2.4.9-ac16/kernel/drivers/scsi/scsi_mod.o says c806affc.  Ignoring /lib/modules/2.4.9-ac16/kernel/drivers/scsi/scsi_mod.o entry
Warning (compare_maps): mismatch on symbol scsi_hostlist  , scsi_mod says c806c7a0, /lib/modules/2.4.9-ac16/kernel/drivers/scsi/scsi_mod.o says c806aff8.  Ignoring /lib/modules/2.4.9-ac16/kernel/drivers/scsi/scsi_mod.o entry
Warning (compare_maps): mismatch on symbol scsi_hosts  , scsi_mod says c806c7a8, /lib/modules/2.4.9-ac16/kernel/drivers/scsi/scsi_mod.o says c806b000.  Ignoring /lib/modules/2.4.9-ac16/kernel/drivers/scsi/scsi_mod.o entry
Warning (compare_maps): mismatch on symbol scsi_logging_level  , scsi_mod says c806c774, /lib/modules/2.4.9-ac16/kernel/drivers/scsi/scsi_mod.o says c806afcc.  Ignoring /lib/modules/2.4.9-ac16/kernel/drivers/scsi/scsi_mod.o entry
Warning (compare_maps): mismatch on symbol usb_devfs_handle  , usbcore says c8050580, /lib/modules/2.4.9-ac16/kernel/drivers/usb/usbcore.o says c80500a0.  Ignoring /lib/modules/2.4.9-ac16/kernel/drivers/usb/usbcore.o entry
CPU:    0
EIP:    0068:[<0000a67e>]  Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010046
eax: 00000001 ebx: 0000a8ce ecx: 00150000 edx: 00000005
esi: 0000c569 edi: 00000000 ebp: c11ede80 esp: c11ede28
ds: 0040 es:0080 ss: 0018
Process swapper (pid: 1, stackpage=c11ed000)
Stack: c5ae0070 a8ce0005 c5883032 c54c0003 0a110011 0018c50f c4fca8c8 0000c4e8
       c4d3a8c7 0000c4c1 00030000 de800000 de6ec11e a8afc11e 00000000 00180000
       00010015 ca5d0000 02f8c039 c1cac0b4 c17f0000 cac2c1a7 20000000 00000000
Call trace: [<c011a3cc>] [<c018bf28>] [<c0105000>] [<c018c4bb>] [<c01051fd>] 
   [<c0105000>] [<c010562f>] [<c01051f4>]
Code: Bad EIP value

>>EIP; 0000a67e Before first symbol   <=====
Trace; c011a3cc <update_process_times+20/7f>
Trace; c018bf28 <pnp_bios_get_dev_node+de/123>
Trace; c0105000 <_stext+0/0>
Trace; c018c4bb <pnp_bios_init+169/1b6>
Trace; c01051fd <init+9/134>
Trace; c0105000 <_stext+0/0>
Trace; c010562f <kernel_thread+26/30>
Trace; c01051f4 <init+0/134>

  Kernel panic: Attempted to kill init!

9 warnings issued.  Results may not be reliable.

-- 
Stelian Pop <stelian.pop@fr.alcove.com>
|---------------- Free Software Engineer -----------------|
| Alcôve - http://www.alcove.com - Tel: +33 1 49 22 68 00 |
|------------- Alcôve, liberating software ---------------|
