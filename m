Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313035AbSDDAyc>; Wed, 3 Apr 2002 19:54:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313048AbSDDAyX>; Wed, 3 Apr 2002 19:54:23 -0500
Received: from huitzilopochtli.presidencia.gob.mx ([200.57.34.35]:27059 "EHLO
	huitzilopochtli.presidencia.gob.mx") by vger.kernel.org with ESMTP
	id <S313035AbSDDAyM>; Wed, 3 Apr 2002 19:54:12 -0500
Message-ID: <3CABA3EB.E8ED7D04@sandino.net>
Date: Wed, 03 Apr 2002 18:52:59 -0600
From: Sandino Araico =?iso-8859-1?Q?S=E1nchez?= <sandino@sandino.net>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: es-MX, es, es-ES, en
MIME-Version: 1.0
To: Juan Quintela <quintela@mandrakesoft.com>
CC: Greg KH <greg@kroah.com>, Richard Gooch <rgooch@ras.ucalgary.ca>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4.17,2.4.18 ide-scsi+usb-storage+devfs Oops
In-Reply-To: <3C7EA7CB.C36D0211@sandino.net> <20020302075847.GE20536@kroah.com>
		<3C84294C.AE1E8CE9@sandino.net>
		<200203060528.g265Sh502430@vindaloo.ras.ucalgary.ca>
		<20020306053355.GA13072@kroah.com>
		<200203060545.g265jwL02756@vindaloo.ras.ucalgary.ca>
		<20020306181956.GC16003@kroah.com> <3C868302.31C7BBC4@sandino.net> <m2ofhsij2z.fsf@trasno.mitica>
Content-Type: multipart/mixed;
 boundary="------------9F0F8C3A2A08FFD46F088118"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------9F0F8C3A2A08FFD46F088118
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Juan Quintela wrote:

> >>>>> "sandino" == Sandino Araico Sánchez <sandino@sandino.net> writes:
>
> sandino> I had to copy the Oops trace by hand to a paper. Gpm is not working correctly
> sandino> on my machine. Is there another way to send the Oops trace to a file?
>
> dmesg > file
>

Sorry about being so late, but I have another ksymoops.

This time the Oops was reproduced as follows:

1. I ran this script
#!/bin/sh
killall -9 wmcdplay
rmmod sr_mod
rmmod ide-scsi
modprobe ide-cd
ls -la /dev/cdroms/cdrom0
/etc/rc.d/init.d/usbmgr start

2. I ran this script
#!/bin/sh
/etc/rc.d/init.d/usbmgr stop
killall -9 wmcdplay
rmmod ide-cd
modprobe ide-scsi
modprobe sr_mod
ls -la /dev/cdroms/cdrom0

lr-xr-xr-x    1 root     root           34 dic 31  1969 /dev/cdroms/cdrom0 ->
../scsi/host2/bus0/target0/lun0/cd

3. I mounted the cdrom
mount  /dev/scsi/host2/bus0/target0/lun0/cd /mnt/cdrom

4. I started the usbmgr

5. I inserted the zip drive in the usb port

6. I don't remember when the Oops happened, when I unmounted the CD or after unmounting
it when I ran eject.


This time I'm sure the ksymoops is correct because I did dmesg > file and after rebooting
ksymoops < file > file.ksymoops.

--
Sandino Araico Sánchez
>drop table internet;
OK, 135454265363565609860398636678346496 rows affected.
"oh fuck" --fluxrad



--------------9F0F8C3A2A08FFD46F088118
Content-Type: text/plain; charset=us-ascii;
 name="Oops-2002-04-03-cdrom.ksymoops"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Oops-2002-04-03-cdrom.ksymoops"

ksymoops 2.3.4 on i686 2.4.18.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.18/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Warning (compare_maps): ksyms_base symbol acpi_fadt_R__ver_acpi_fadt not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol acpi_gbl_FADT_R__ver_acpi_gbl_FADT not found in System.map.  Ignoring ksyms_base entry
Unable to handle kernel paging request at virtual address 0120000c
c01575bb
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c01575bb>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010206
eax: 0120000c   ebx: d40dd8e0   ecx: c1846d60   edx: 00000000
esi: d0820a14   edi: d9e5bbe0   ebp: bfffe4ec   esp: da36ff3c
ds: 0018   es: 0018   ss: 0018
Process rmmod (pid: 3239, stackpage=da36f000)
Stack: d0820a14 e08e4362 d40dd8e0 d0820a00 00000000 e08f13be d0820a14 00000b00 
       00000000 d9e5bbe0 df0ff720 e08f2a80 c01c544a d9e5bbe0 e08f0000 fffffff0 
       e08f0000 c01c555e e08f2a80 e08f1424 00000004 e08f2a80 c011980f e08f0000 
Call Trace: [<e08e4362>] [<e08f13be>] [<e08f2a80>] [<c01c544a>] [<c01c555e>] 
   [<e08f2a80>] [<e08f1424>] [<e08f2a80>] [<c011980f>] [<c0118b12>] [<c0106e23>] 
Code: f0 81 28 00 00 00 01 0f 85 72 22 00 00 53 8b 43 20 50 e8 46 

>>EIP; c01575bb <devfs_unregister+13/38>   <=====
Trace; e08e4362 <[cdrom]unregister_cdrom+8a/bc>
Trace; e08f13be <[ide-cd]cdrom_analyze_sense_data+2c2/31c>
Trace; e08f2a80 <[ide-cd]cdrom_lockdoor+1c/e0>
Trace; c01c544a <scsi_unregister_device+52/d4>
Trace; c01c555e <scsi_unregister_module+36/3c>
Trace; e08f2a80 <[ide-cd]cdrom_lockdoor+1c/e0>
Trace; e08f1424 <[ide-cd]cdrom_queue_request_sense+c/90>
Trace; e08f2a80 <[ide-cd]cdrom_lockdoor+1c/e0>
Trace; c011980f <free_module+17/b4>
Trace; c0118b12 <sys_delete_module+126/234>
Trace; c0106e23 <system_call+33/38>
Code;  c01575bb <devfs_unregister+13/38>
00000000 <_EIP>:
Code;  c01575bb <devfs_unregister+13/38>   <=====
   0:   f0 81 28 00 00 00 01      lock subl $0x1000000,(%eax)   <=====
Code;  c01575c2 <devfs_unregister+1a/38>
   7:   0f 85 72 22 00 00         jne    227f <_EIP+0x227f> c015983a <_text_lock_base+75/12f>
Code;  c01575c8 <devfs_unregister+20/38>
   d:   53                        push   %ebx
Code;  c01575c9 <devfs_unregister+21/38>
   e:   8b 43 20                  mov    0x20(%ebx),%eax
Code;  c01575cc <devfs_unregister+24/38>
  11:   50                        push   %eax
Code;  c01575cd <devfs_unregister+25/38>
  12:   e8 46 00 00 00            call   5d <_EIP+0x5d> c0157618 <devfs_do_symlink+38/17c>


3 warnings issued.  Results may not be reliable.

--------------9F0F8C3A2A08FFD46F088118--

