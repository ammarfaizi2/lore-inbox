Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129251AbRBFNtG>; Tue, 6 Feb 2001 08:49:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129279AbRBFNs4>; Tue, 6 Feb 2001 08:48:56 -0500
Received: from chaos.analogic.com ([204.178.40.224]:59779 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S129251AbRBFNsu>; Tue, 6 Feb 2001 08:48:50 -0500
Date: Tue, 6 Feb 2001 08:48:08 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: "Udo A. Steinberg" <sorisor@Hell.WH8.TU-Dresden.De>
cc: Peter Horton <pdh@colonel-panic.com>, linux-kernel@vger.kernel.org
Subject: Re: VIA silent disk corruption - bad news
In-Reply-To: <3A7F230A.BB1CBA25@Hell.WH8.TU-Dresden.De>
Message-ID: <Pine.LNX.3.95.1010206083740.22101A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Feb 2001, Udo A. Steinberg wrote:

> Peter Horton wrote:
> > 
> > The patch doesn't work for me. Maybe I need to disable some more of
> > those North bridge features :-(
> > 
> > Oh bum. Back to testing with "normal" ...
> 
> FWIW, here's the output of my lspci for A7V with working 1003 BIOS
> and still no corruption (after 2 hours stresstest).
> 
> 00:00.0 Host bridge: VIA Technologies, Inc.: Unknown device 0305 (rev 02)
>         Subsystem: Asustek Computer, Inc.: Unknown device 8033
>         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR+
>         Latency: 0
>         Region 0: Memory at e0000000 (32-bit, prefetchable) [size=128M]
>         Capabilities: [a0] AGP version 2.0
>                 Status: RQ=31 SBA+ 64bit- FW+ Rate=x1,x2
>                 Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
>         Capabilities: [c0] Power Management version 2
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 00: 06 11 05 03 06 00 10 a2 02 00 00 06 00 00 00 00
> 10: 08 00 00 e0 00 00 00 00 00 00 00 00 00 00 00 00
> 20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 33 80
> 30: 00 00 00 00 a0 00 00 00 00 00 00 00 00 00 00 00
> 
> I'll leave the comparing work to you. If you need more info, just holler.
> 
> -Udo.

I have found a way to create the file-system problem!  Just build
the kernel and, from another terminal execute `sync`. The build will
fail with multiple errors caused by corrupted files. The files
are not actually corrupted, though. Just restart the build and it
will complete.

So there is something that `sync` triggers that results in apparent
file system corruption. Once files are re-read, they are fine.
This does not explain the permanent file-system corruption that
sometimes occurs --that may occur during the `umount`.

I don't use IDE. I use BusLogic SCSI, 250 Mb RAM, Pentium-III(2), SMP.
Linux 2.4.1 (no postfix).

PCI stuff.....

Device      Vendor                    Type
   0   Intel Corporation              440BX/ZX - 82443BX/ZX Host bridge  
       I/O memory : 0xe6000000->0xe7fffff7
   1   Intel Corporation              440BX/ZX - 82443BX/ZX AGP bridge   
       I/O memory : 0x40010100->0x470101ff
       I/O memory : 0x22a0d0e0->0x1fffdfef
       I/O memory : 0xe5c0e5d0->0xe5cfe5df
       I/O memory : 0xe5f0e600->0xe5ffe60f
   4   Intel Corporation              82371AB PIIX4 ISA                  
   9   S3 Inc.                        86c968 [Vision 968 VRAM] rev 0     
       IRQ 15 Pin 1
       I/O memory : 0x14000000->0x15ffffff
  10   Advanced Micro Devices [AMD]   79c970 [PCnet LANCE]               
       IRQ 12 Pin 1
       I/O  ports : 0xd000->0xd01e
       I/O memory : 0xe1800000->0xe180001f
  11   3Com Corporation               3c905B 100BaseTX [Cyclone]         
       IRQ 10 Pin 1
       I/O  ports : 0xb800->0xb87e
       I/O memory : 0xe1000000->0xe100007f
  12   BusLogic                       BT-946C (BA80C30), [MultiMaster 10]
       IRQ 11 Pin 1
       I/O  ports : 0xb400->0xb402
       I/O memory : 0xe0800000->0xe0800fff




Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
