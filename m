Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281304AbRKTUEg>; Tue, 20 Nov 2001 15:04:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281306AbRKTUE1>; Tue, 20 Nov 2001 15:04:27 -0500
Received: from chaos.analogic.com ([204.178.40.224]:31619 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S281304AbRKTUEL>; Tue, 20 Nov 2001 15:04:11 -0500
Date: Tue, 20 Nov 2001 15:03:23 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Dale Amon <amon@vnl.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: A return to PCI ordering problems...
In-Reply-To: <20011120190316.H19738@vnl.com>
Message-ID: <Pine.LNX.3.95.1011120144925.14138A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Nov 2001, Dale Amon wrote:

> I looked back on the thread from last year and thought
> that this would be well in hand by now. Either that or
> I've missed something obvious or I've got an overly
> unfriendly BIOS.
> 
> In any case, here is the problem:
> 
> 	NIC on motherboard, Realtek
> 	NIC on PCI card, Realtek
> 	Monolithic (no-module) kernel
> 	Motherboard must be set to eth0
> 
> The PCI search order always makes the PCI card 
> eth0.

The PCI devices are read in the order that they are found. The
first bridge is device 0, etc. These are not usually configurable
since they are hard-wired, a particular slot has a certain device
number.

Device      Vendor                    Type
   0   Intel Corporation              440BX/ZX - 82443BX/ZX Host bridge  
       I/O memory : 0xe4000000->0xe7fffff7
   1   Intel Corporation              440BX/ZX - 82443BX/ZX AGP bridge   
       I/O memory : 0x40010100->0x470101ff
       I/O memory : 0x22a0d0e0->0x1fffdfef
       I/O memory : 0xe3c0e3d0->0xe3cfe3df
       I/O memory : 0xe3f0e400->0xe3ffe40f
   4   Intel Corporation              82371AB PIIX4 ISA                  
   9   S3 Inc.                        86c968 [Vision 968 VRAM] rev 0     
       IRQ 5 Pin 1
       I/O memory : 0x14000000->0x15ffffff
  10   Advanced Micro Devices [AMD]   79c970 [PCnet LANCE]               
       IRQ 12 Pin 1
       I/O  ports : 0xd000->0xd01e
       I/O memory : 0xdf800000->0xdf80001f
  11   3Com Corporation               3c905B 100BaseTX [Cyclone]         
       IRQ 10 Pin 1
       I/O  ports : 0xb800->0xb87e
       I/O memory : 0xdf000000->0xdf00007f
  12   BusLogic                       BT-946C (BA80C30), [MultiMaster 10]
       IRQ 11 Pin 1
       I/O  ports : 0xb400->0xb402
       I/O memory : 0xde800000->0xde800fff

The first ethermet board installed will be eth0, the second eth1, etc.
Therefore, if you want to make a particular board eth0, use modules
and `insmod` the one that you want to be first, first.

FYI, if you care about the name of your ethernet device, your
configuration is probably broken. The IEEE station address can
be used to identify a device and it's accessible from `ifconfig`
without setting any network parameters. So, given this, you
can set any number of boards found, to anything you need to
configure, including complicated servers and routers, with a
simple shell-script.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


