Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317298AbSILUVS>; Thu, 12 Sep 2002 16:21:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317305AbSILUVS>; Thu, 12 Sep 2002 16:21:18 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:58576 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S317298AbSILUVP>;
	Thu, 12 Sep 2002 16:21:15 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15744.63576.479593.109825@napali.hpl.hp.com>
Date: Thu, 12 Sep 2002 13:26:00 -0700
To: Galen Arnold <arnoldg@ncsa.uiuc.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: ia64 kernel hangs
In-Reply-To: <Pine.LNX.4.44.0209121438390.10127-100000@osage.ncsa.uiuc.edu>
References: <Pine.LNX.4.44.0209121438390.10127-100000@osage.ncsa.uiuc.edu>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I cannot reproduce this on 2.4.19 (the program runs to completion
without starting a subprocess, because the memory limit is so low).
2.4.16 is ancient and I don't have it on any machine at the moment.

	--david

>>>>> On Thu, 12 Sep 2002 15:06:45 -0500 (CDT), Galen Arnold <arnoldg@ncsa.uiuc.edu> said:

  Galen> [1.] ia64 linux 2.4.16 , 2.4.19 kernels hang with user code
  Galen> calling setrlimit() and system()

  Galen> [2.] A short user code can hang ia64 systems, but not ia32
  Galen> linux.

  Galen> [3.] setrlimit() system() hang

  Galen> [4.] 2.4.16 ia64 & 2.4.19 ia64

  Galen> [5.] kernel hangs, no output, system goes unresponsive for
  Galen> about an hour

  Galen> [6.]

  Galen> #include <sys/time.h> #include <sys/resource.h> #include
  Galen> <unistd.h>

  Galen> #define MAX_MEM 1000 int main(void) { struct rlimit
  Galen> my_rlimit;

  Galen>         my_rlimit.rlim_cur= 1024 * MAX_MEM;
  Galen> my_rlimit.rlim_max= my_rlimit.rlim_cur;

  Galen>         setrlimit(RLIMIT_AS, &my_rlimit); system("/bin/sh -c
  Galen> 'ulimit -a'"); }

  Galen> [7.]

  Galen> LANG=en_US ARCH=ia64 SHELL=/bin/bash HOSTTYPE=ia64
  Galen> OSTYPE=linux-gnu
  Galen> PATH=/usr/kerberos/bin:/usr/local/bin:/bin:/usr/bin:/usr/X11R6/bin

  Galen> [7.1] Linux user01 2.4.16 #1 SMP Mon Dec 10 11:03:09 CST 2001
  Galen> ia64 unknown

  Galen> Gnu C 2.96 Gnu make 3.79.1 binutils 2.10.91.0.2 util-linux
  Galen> 2.11f mount 2.11b modutils 2.4.6 e2fsprogs 1.26 reiserfsprogs
  Galen> 3.x.0f PPP 2.4.0 Linux C Library 2.2.4 Dynamic linker (ldd)
  Galen> 2.2.4 Procps 2.0.7 Net-tools 1.60 Console-tools 0.3.3
  Galen> Sh-utils 2.0 Modules Loaded sk98lin e100

  Galen> Linux mantis 2.4.19 #2 SMP Wed Sep 11 16:53:31 CDT 2002 ia64
  Galen> unknown

  Galen> Gnu C 2.96 Gnu make 3.79.1 binutils 2.11.90.0.8 util-linux
  Galen> 2.11f mount 2.11g modutils 2.4.13 e2fsprogs 1.23
  Galen> reiserfsprogs 3.x.0j PPP 2.4.1 isdn4k-utils 3.1pre1 Linux C
  Galen> Library 2.2.4 Dynamic linker (ldd) 2.2.4 Procps 2.0.7
  Galen> Net-tools 1.60 Console-tools 0.3.3 Sh-utils 2.0.11 Modules
  Galen> Loaded e1000 nls_iso8859-1 nls_cp437 vfat fat keybdev hid
  Galen> usbkbd input usb-uhci usbcore mptscsih mptbase

  Galen> [7.2] processor : 0 vendor : GenuineIntel arch : IA-64 family
  Galen> : Itanium 2 model : 0 revision : 5 archrev : 0 features :
  Galen> branchlong cpu number : 41600 cpu regs : 4 cpu MHz :
  Galen> 995.901000 itc MHz : 995.901000 BogoMIPS : 1488.97

  Galen> [7.2] e1000 133632 1 nls_iso8859-1 4624 1 (autoclean)
  Galen> nls_cp437 6128 1 (autoclean) vfat 26440 1 (autoclean) fat
  Galen> 77752 0 (autoclean) [vfat] keybdev 4496 0 (unused) hid 48200
  Galen> 0 (unused) usbkbd 7360 0 (unused) input 9832 0 [keybdev hid
  Galen> usbkbd] usb-uhci 64184 0 (unused) usbcore 163544 1 [hid
  Galen> usbkbd usb-uhci] mptscsih 79568 3 mptbase 78152 3 [mptscsih]

  Galen> [7.4] 000001f0-000001f7 : ide0 000002f8-000002ff :
  Galen> serial(auto) 000003c0-000003df : vga+ 000003f6-000003f6 :
  Galen> ide0 000003f8-000003ff : serial(auto) 00005cc0-00005cdf :
  Galen> usb-uhci 00005ce0-00005cff : usb-uhci

  Galen> fbfe0000-fbffffff : e1000

  Galen> [7.5] 00:1d.0 USB Controller: Intel Corporation: Unknown
  Galen> device 24c2 (rev 01) 00:1d.1 USB Controller: Intel
  Galen> Corporation: Unknown device 24c4 (rev 01) 00:1e.0 PCI bridge:
  Galen> Intel Corporation 82820 820 (Camino 2) Chipset PCI (rev 81)
  Galen> 00:1f.0 ISA bridge: Intel Corporation: Unknown device 24c0
  Galen> (rev 01) 00:1f.1 IDE interface: Intel Corporation: Unknown
  Galen> device 24cb (rev 01) 01:00.0 Ethernet controller: Intel
  Galen> Corporation: Unknown device 100e (rev 02) 01:01.0 VGA
  Galen> compatible controller: ATI Technologies Inc Rage XL (rev 27)
  Galen> 02:1c.0 PIC: Intel Corporation: Unknown device 1461 (rev 03)
  Galen> 02:1d.0 PCI bridge: Intel Corporation: Unknown device 1460
  Galen> (rev 03) 02:1e.0 PIC: Intel Corporation: Unknown device 1461
  Galen> (rev 03) 02:1f.0 PCI bridge: Intel Corporation: Unknown
  Galen> device 1460 (rev 03) 03:1f.0 PCI Hot-plug controller: Intel
  Galen> Corporation: Unknown device 1462 (rev 03)06:01.0 Ethernet
  Galen> controller: Intel Corporation 82557 [Ethernet Pro 100] (rev
  Galen> 0c)06:02.0 SCSI storage controller: LSI Logic / Symbios Logic
  Galen> (formerly NCR) 53c1030 (rev 03) 06:02.1 SCSI storage
  Galen> controller: LSI Logic / Symbios Logic (formerly NCR) 53c1030
  Galen> (rev 03) 06:1f.0 PCI Hot-plug controller: Intel Corporation:
  Galen> Unknown device 1462 (rev 03)08:1c.0 PIC: Intel Corporation:
  Galen> Unknown device 1461 (rev 03) 08:1d.0 PCI bridge: Intel
  Galen> Corporation: Unknown device 1460 (rev 03) 08:1e.0 PIC: Intel
  Galen> Corporation: Unknown device 1461 (rev 03) 08:1f.0 PCI bridge:
  Galen> Intel Corporation: Unknown device 1460 (rev 03) 09:1f.0 PCI
  Galen> Hot-plug controller: Intel Corporation: Unknown device 1462
  Galen> (rev 03)0b:1f.0 PCI Hot-plug controller: Intel Corporation:
  Galen> Unknown device 1462 (rev 03)0e:1c.0 PIC: Intel Corporation:
  Galen> Unknown device 1461 (rev 03) 0e:1d.0 PCI bridge: Intel
  Galen> Corporation: Unknown device 1460 (rev 03) 0e:1e.0 PIC: Intel
  Galen> Corporation: Unknown device 1461 (rev 03) 0e:1f.0 PCI bridge:
  Galen> Intel Corporation: Unknown device 1460 (rev 03) 0f:1f.0 PCI
  Galen> Hot-plug controller: Intel Corporation: Unknown device 1462
  Galen> (rev 03) 11:1f.0 PCI Hot-plug controller: Intel Corporation:
  Galen> Unknown device 1462 (rev 03)

  Galen> [7.6] Attached devices: Host: scsi0 Channel: 00 Id: 00 Lun:
  Galen> 00 Vendor: MAXTOR Model: ATLAS10K3_18_SCA Rev: B000 Type:
  Galen> Direct-Access ANSI SCSI revision: 03 Host: scsi0 Channel: 00
  Galen> Id: 06 Lun: 00 Vendor: QLogic Model: GEM359 Rev: 0200 Type:
  Galen> Processor ANSI SCSI revision: 02

  Galen> [7.7]

  Galen> [X.]  2.4.18 and 2.4.9 on ia32 do not produce the hang from
  Galen> the c program above.  Changing the values handed to
  Galen> setrlimit() will workaround the hang on ia64 (a small limit
  Galen> will cause the system() call to silently fail, and a larger
  Galen> [10M] limit will run the system() call successfully).

  Galen> Please cc: me on responses as I'm not on the list.

  Galen> -Galen -- + Galen Arnold, consulting group--system engineer
  Galen> National Center for Supercomputing Applications 605
  Galen> E. Springfield Avenue (217) 244-3473 Champaign, IL 61820
  Galen> arnoldg@ncsa.uiuc.edu

  Galen> - To unsubscribe from this list: send the line "unsubscribe
  Galen> linux-kernel" in the body of a message to
  Galen> majordomo@vger.kernel.org More majordomo info at
  Galen> http://vger.kernel.org/majordomo-info.html Please read the
  Galen> FAQ at http://www.tux.org/lkml/
