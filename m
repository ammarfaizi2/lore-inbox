Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129084AbRBAV3E>; Thu, 1 Feb 2001 16:29:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129355AbRBAV2q>; Thu, 1 Feb 2001 16:28:46 -0500
Received: from faui02.informatik.uni-erlangen.de ([131.188.30.102]:56830 "EHLO
	faui02.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id <S129154AbRBAV2j>; Thu, 1 Feb 2001 16:28:39 -0500
Date: Thu, 1 Feb 2001 22:28:33 +0100 (MET)
From: "Andreas Ackermann (Acki)" <asackerm@stud.informatik.uni-erlangen.de>
To: <viro@math.psu.edu>, <linux-kernel@vger.kernel.org>
Subject: Oops in 2.4.0: [prune_dcache+24/328]
In-Reply-To: <1426EBBD3C90@vcnet.vc.cvut.cz>
Message-ID: <Pine.GSO.4.30.0102012221530.26836-100000@faui02d.informatik.uni-erlangen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

after experiencing several oops since installing Kernel 2.4.0 I thought
I'd better let someone know there still might be some trouble in the
kernel ... Find my very first question at the very bottom of this mail and
the answer I got from Petr Vandrovec right below ...

I'll try to give you any information you need to find out the cause ...
BTW CPU is AMD K6-2+

Thanks.

-Andreas
-------------------------------------------------------------------
        http://www.acki-netz.de  email: acki@acki-netz.de
   //   (+49)[0]9131/409500 or (+49)[0]9286/6399
 \X/    acki or acki2 on #rommelwood

   No trees were killed in the sending of this message. However
     a large number of electrons were terribly inconvenienced.

On Wed, 31 Jan 2001, Petr Vandrovec wrote:

> On 31 Jan 01 at 13:04, Andreas Ackermann (Acki) wrote:
> > > Is it always in prune_dcache? Which filesystems you have mounted
> > > at oops, or just before oops? ncpfs? smbfs? vfat?
> >
> > It happens after bootup, and only after bootup. After the first crash, the
> > system would run the whole day without trouble ... Here's my fstab:
> >
> > # /etc/fstab: static file system information.
> > #
> > # <file system> <mount point>   <type>  <options>
> > <dump>
> > /dev/hdc7       /               ext2    defaults,errors=remount-ro      0
> > /dev/hdc6       none            swap    sw                      0       0
> > proc            /proc           proc    defaults                        0
> > /dev/fd0        /a              auto    defaults,user,noauto            0
> > /dev/cdrom      /cd0            iso9660 defaults,ro,user,noauto         0
> >
> >
> > /dev/scd0       /cd1                      iso9660         ro,noauto,user 0
> > 0
> > /dev/hda1       /c                        vfat
> > defaults,gid=1000,umask=2 0
> > /dev/hda5       /d                        vfat
> > defaults,gid=1000,umask=2 0
> > /dev/hda7       /f                        vfat
> > defaults,gid=1000,umask=2
> > /dev/hda6       /e                        ntfs
> > defaults,gid=1000,umask=2 0
> > /dev/hdc8      /g                      ext2      defaults 0 0
> > /dev/hda9      /suse                      ext2      defaults 0 0
> >
> > And yes, any oops I get is with prune_dcache. Hope this helps
>
> You should send this to linux-kernel@vger.kernel.org and to
> viro@math.psu.edu - Al Viro is main Linux filesystem guru. There
> was discussion about oops in prune_dcache at the end of December,
> but I'm under impression that Al said that all these problems were
> solved before 2.4.0. Maybe they were not?
>
> And if you could test it without ntfs... (add ',noauto' to fstab
> entry for /dev/hda6...)
>                                                   Petr Vandrovec
>                                                   vandrove@vc.cvut.cz
>
>



Hi folks,

using the new Kernel it now occured for the 4th time that I get an Oops
some minutes after bootup, with X-Windows running. However, if I get
past this 'critical period' the system seems to run ok (it never crashed
a second time although running all day), even when heavily loaded
(avifile, mtvp, transfers using samba etc.).

Here's the log:
...
Jan 29 08:08:25 ane kernel: <Sound Blaster 16> at 0x300 irq 10 dma 0,0
Jan 29 08:08:25 ane kernel: sb: 1 Soundblaster PnP card(s) found.
Jan 29 08:08:25 ane kernel: lirc_serial: compile the serial port driver
as module and
Jan 29 08:08:25 ane kernel: lirc_serial: make sure this module is loaded
first
Jan 29 08:08:26 ane kernel: lirc_serial: auto-detected active low
receiver
Jan 29 08:08:27 ane lpd[212]: restarted
Jan 29 08:17:39 ane kernel:  printing eip:
Jan 29 08:17:39 ane kernel: c013d838
Jan 29 08:17:39 ane kernel: Oops: 0002
Jan 29 08:17:39 ane kernel: CPU:    0
Jan 29 08:17:39 ane kernel: EIP:    0010:[prune_dcache+24/328]
Jan 29 08:17:39 ane kernel: EFLAGS: 00010216
Jan 29 08:17:39 ane kernel: eax: c021903c   ebx: c8b929c0   ecx:
c8b12000   edx: ffffff20
Jan 29 08:17:39 ane kernel: esi: c8b12920   edi: c8aff800   ebp:
00000d8d   esp: cbfe7fa8
Jan 29 08:17:39 ane kernel: ds: 0018   es: 0018   ss: 0018
Jan 29 08:17:39 ane kernel: Process kswapd (pid: 3, stackpage=cbfe7000)
Jan 29 08:17:39 ane kernel: Stack: 00010f00 00000004 00000002 00000000
c013dbd1 00000f8f c01278eb 00000006
Jan 29 08:17:39 ane kernel:        00000004 00010f00 c01dae77 cbfe6239
0008e000 c012798c 00000004 00000000
Jan 29 08:17:39 ane kernel:        c133ffb8 00000000 c0107418 00000000
00000078 c0229fd8
Jan 29 08:17:39 ane kernel: Call Trace: [shrink_dcache_memory+33/48]
[do_try_to_free_pages+83/128] [kswapd+116/272] [kernel_thread+40/56]
Jan 29 08:17:39 ane kernel:
Jan 29 08:17:39 ane kernel: Code: 89 02 89 1b 89 5b 04 8d 73 e0 8b 43 e4
a8 08 74 27 24 f7 89
Jan 29 08:20:58 ane syslogd 1.3-3#33.1: restart.
Jan 29 08:20:58 ane kernel: klogd 1.3-3#33.1, log source = /proc/kmsg
started.
Jan 29 08:20:58 ane kernel: Inspecting /boot/System.map-2.4.0
Jan 29 08:20:59 ane kernel: Loaded 13095 symbols from
/boot/System.map-2.4.0.
Jan 29 08:20:59 ane kernel: Symbols match kernel version 2.4.0.
Jan 29 08:20:59 ane kernel: Loaded 219 symbols from 13 modules.


If this tells somebody what it's all about I can provide further
information about system etc. I also can provide three similar excerpts
form my logfile ;-)

Yours


-Andreas

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
