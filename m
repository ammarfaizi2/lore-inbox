Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271502AbRIBBdx>; Sat, 1 Sep 2001 21:33:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271507AbRIBBdn>; Sat, 1 Sep 2001 21:33:43 -0400
Received: from mail.spylog.com ([194.67.35.220]:27854 "HELO mail.spylog.com")
	by vger.kernel.org with SMTP id <S271502AbRIBBdZ>;
	Sat, 1 Sep 2001 21:33:25 -0400
Date: Sun, 2 Sep 2001 05:33:38 +0400
From: Andrey Nekrasov <andy@spylog.ru>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.10-pre3 - bug report
Message-ID: <20010902053338.A26119@spylog.ru>
Mail-Followup-To: Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0109011212380.922-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0109011212380.922-100000@penguin.transmeta.com>
User-Agent: Mutt/1.3.20i
Organization: SpyLOG ltd.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus Torvalds,

> pre3:
>  - Johannes Erdfelt, Oliver Neukum: USB printer driver race fix
>  - John Byrne: fix stupid i386-SMP irq stack layout bug
>  - Andreas Bombe, me: yenta IO window fix
>  - Neil Brown: raid1 buffer state fix
>  - David Miller, Paul Mackerras: fix up sparc and ppc respectively for kmap/kbd_rate
>  - Matija Nalis: umsdos fixes, and make it possible to boot up with umsdos
>  - Francois Romieu: fix bugs in dscc4 driver
>  - Andy Grover: new PCI config space access functions (eventually for ACPI)
>  - Albert Cranford: fix incorrect e2fsprog data from ver_linux script
>  - Dave Jones: re-sync x86 setup code, fix macsonic kmalloc use
>  - Johannes Erdfelt: remove obsolete plusb USB driver
>  - Andries Brouwer: fix USB compact flash version info, add blksize ioctls

1.  hardware configuration:
		 - Intel Server ISP1100 + Promise Ultra100 controller
		 - 1Gb RAM

2.  ...
		CONFIG_HIGHMEM4G=y
    CONFIG_HIGHMEM=y
		...
		# CONFIG_SMP is not set
		# CONFIG_X86_UP_IOAPIC is not set
	  ...

3.  Test:

		run
		test:/spylog/test/tiobench-0.3.1 # ./tiobench.pl 
		No size specified, using 1792 MB
	
    syslog level "kern.*":
	
ep  2 05:20:18 test kernel: Inspecting /boot/System.map
Sep  2 05:20:18 test kernel: Loaded 12509 symbols from /boot/System.map.
Sep  2 05:20:18 test kernel: Symbols match kernel version 2.4.10.
Sep  2 05:20:18 test kernel: No module symbols loaded - kernel modules not enabled. 
Sep  2 05:24:52 test kernel: __alloc_pages: 0-order allocation failed (gfp=0x70/1).
Sep  2 05:24:54 test last message repeated 77 times
Sep  2 05:24:54 test kernel: __alloc_pages: 0-order allocation failed (gfp=0x30/1).
Sep  2 05:24:54 test kernel: __alloc_pages: 0-order allocation failed (gfp=0x70/1).
Sep  2 05:24:59 test last message repeated 133 times
Sep  2 05:24:59 test kernel: __alloc_pages: 0-order allocation failed (gfp=0x20/0).
Sep  2 05:24:59 test kernel: __alloc_pages: 0-order allocation failed (gfp=0x70/1).
Sep  2 05:25:15 test last message repeated 505 times
Sep  2 05:25:15 test kernel: __alloc_pages: 0-order allocation failed (gfp=0x30/1).
Sep  2 05:25:15 test kernel: __alloc_pages: 0-order allocation failed (gfp=0x70/1).
Sep  2 05:25:31 test last message repeated 482 times
Sep  2 05:28:00 test kernel: __alloc_pages: 0-order allocation failed (gfp=0x70/1).
Sep  2 05:28:04 test last message repeated 140 times
Sep  2 05:28:04 test kernel: __alloc_pages: 0-order allocation failed (gfp=0x20/0).
Sep  2 05:28:04 test kernel: __alloc_pages: 0-order allocation failed (gfp=0x70/1).
Sep  2 05:28:07 test last message repeated 97 times
Sep  2 05:28:07 test kernel: __alloc_pages: 0-order allocation failed (gfp=0x20/0).
Sep  2 05:28:07 test kernel: __alloc_pages: 0-order allocation failed (gfp=0x70/1).

Need other test, that search this bug?
(MySQL server version: 3.23.40 also work wrong)

-- 
bye.
Andrey Nekrasov, SpyLOG.
