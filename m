Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129520AbQJ3SNE>; Mon, 30 Oct 2000 13:13:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129519AbQJ3SMz>; Mon, 30 Oct 2000 13:12:55 -0500
Received: from z211-19-80-152.dialup.wakwak.ne.jp ([211.19.80.152]:18932 "EHLO
	220fx.luky.org") by vger.kernel.org with ESMTP id <S129026AbQJ3SMn>;
	Mon, 30 Oct 2000 13:12:43 -0500
To: axboe@suse.de
Cc: shibata@luky.org, linux-kernel@vger.kernel.org
Subject: Re: patch: atapi dvd-ram support
In-Reply-To: <20001029141214.B615@suse.de>
In-Reply-To: <20001028201047.A5879@suse.de>
	<20001029134145N.shibata@luky.org>
	<20001029141214.B615@suse.de>
X-Mailer: Mew version 1.94.2 on XEmacs 21.1 (Canyonlands)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20001031031455T.shibata@luky.org>
Date: Tue, 31 Oct 2000 03:14:55 +0900
From: Hisaaki Shibata <shibata@luky.org>
X-Dispatcher: imput version 20000228(IM140)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello again,

> > I tried the patch.
> > But kernel said Oops both fdisk /dev/hdc and
> > dd if=/dev/zero of=/dev/hdc bs=2048 count=1 .
> 
> > After showing above strace message in a few seconds, kernel panic happened.
> > 
> > I can not see some head line of Oops messages. Sorry.
> 
> Is there any way for you to grab those messages, maybe with a serial
> console? I'd really like to see them.

By using serial console, I get messages for you ;-)


In case of doing "dd if=/dev/zero of=/dev/hdc bs=2048 count=1".
----------------------------------------------------------------------------
hdc: ATAPI DVD-ROM DVD-RAM drive, 512kB Cache, UDMA(33)
hdc: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hdc: irq timeout: status=0x7f { DriveReady DeviceFault SeekComplete DataRequest CorrectedError Index Error }                        
hdc: irq timeout: error=0x7f
hdc: DMA disabled
hdc: ATAPI reset complete
Unable to handle kernel NULL pointer dereference at virtual address 00000014
current->tss.cr3 = 00101000, %cr3 = 00101000
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<d8ab07a1>]
EFLAGS: 00010292
eax: 00000000   ebx: c0240318   ecx: 00000003   edx: d8ab0788
esi: d58a2600   edi: 00000080   ebp: 00000001   esp: c020dd74
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, process nr: 0, stackpage=c020d000)
Stack: 00000080 00000001 c0240318 d58a2600 00008000 00000001 c0229c20 00000286
       00feaac0 0080a3a4 c022d900 d2f157a0 c0229c20 d8aaf81c c020dde8 c0240318
       00000000 d8aaf917 c0240318 00000000 00000188 c019961a 00000000 d58a2600
Call Trace: [<d8aaf81c>] [<d8aaf917>] [<c019961a>] [<c01c5d49>] [<d8ab0832>] [<d8ab0788>] [<d8ab094d>]
       [<c019aa66>] [<c019adc0>] [<c019adc6>] [<c019b19e>] [<c019af74>] [<c011123b>] [<c0115775>] [<c0111994>]
       [<c0111946>] [<c011c99d>] [<c0106000>] [<c010ca89>] [<c010caa0>] [<c010b4f8>] [<c0106000>] [<c0108a11>]
       [<c0106000>] [<c010607c>] [<c0106000>] [<c01001ae>]
Code: 8b 50 14 8b 70 10 8d 44 24 34 89 44 24 18 c1 ee 02 31 c0 8b
Aiee, killing interrupt handler
Kernel panic: Attempted to kill the idle task!
In swapper task - not syncing   
----------------------------------------------------------------------------

In case of "/sbin/fdisk /dev/hdc" is a little bit different.


[root@celto shibata]# /sbin/fdisk /dev/hdc
Device contains neither a valid DOS partition table, nor Sun or SGI disklabel
Building a new DOS disklabel. Changes will remain in memory only,
until you decide to write them. After that, of course, the previous
content won't be recoverable.


Command (m for help): p

Disk /dev/hdc: 1 heads, 8946816 sectors, 1 cylinders
Units = cylinders of 8946816 * 512 bytes

   Device Boot    Start       End    Blocks   Id  System

Command (m for help): n
Command action
   e   extended
   p   primary partition (1-4)
p
Partition number (1-4): 1
First cylinder (1-1, default 1): 1

Command (m for help): p

Disk /dev/hdc: 1 heads, 8946816 sectors, 1 cylinders
Units = cylinders of 8946816 * 512 bytes

   Device Boot    Start       End    Blocks   Id  System
/dev/hdc1             1         1   4473407+  83  Linux
Partition 1 has different physical/logical endings:
     phys=(512, 0, 0) logical=(0, 0, 8946816)
Partition 1 does not end on cylinder boundary:
     phys=(512, 0, 0) should be (512, 0, 8946816)

Command (m for help): w
The partition table has been altered!

Calling ioctl() to re-read partition table.
----------------------------------------------------------------------------
hdc: ATAPI DVD-ROM DVD-RAM drive, 512kB Cache, UDMA(33)
Unable to handle kernel NULL pointer dereference at virtual address 0000002c
current->tss.cr3 = 13185000, %cr3 = 13185000
*pde = 00000000
Oops: 0000
CPU:    1
EIP:    0010:[<c01a7b0a>]
EFLAGS: 00010292
eax: 00000000   ebx: 0000f008   ecx: 128e395c   edx: c02402d8
esi: 00000001   edi: d7fda800   ebp: c0240318   esp: d3013bec
ds: 0018   es: 0018   ss: 0018
Process fdisk (pid: 704, process nr: 60, stackpage=d3013000)
Stack: c02402d8 c0240318 00000002 00000087 c017d6bc c01c5d49 000001c2 00000000
       c016afd4 c01a7fde c0240318 00000001 00000001 c019a771 c0240318 d5960e00
       00008000 00000001 c0240318 d5960e00 00000000 00000001 c02296f8 00000286
Call Trace: [<c017d6bc>] [<c01c5d49>] [<c016afd4>] [<c01a7fde>] [<c019a771>] [<c01a9f82>] [<d8aaf81c>]
       [<d8aaf85a>] [<c019961a>] [<c01c5d49>] [<d8ab0832>] [<d8ab0788>] [<c012c44f>] [<d8ab094d>] [<c019aa66>]
       [<c012c44f>] [<c019adc6>] [<c01989cf>] [<c019ae8b>] [<c0197bb0>] [<d880164c>] [<c012b631>] [<d880164c>]
       [<c0164430>] [<d8800000>] [<d8801674>] [<d8801680>] [<c0167623>] [<d880164c>] [<d8820e3c>] [<c0166933>]
       [<c01d99cf>] [<c0159d77>] [<c012e95c>] [<c012b8f7>] [<c012b8ee>] [<c01b8aa4>] [<c012b94d>] [<c010a47d>]
       [<c010a344>]
Code: 8b 58 2c c7 44 24 1c 00 00 00 00 85 db 75 13 8b 70 20 8b 48 
----------------------------------------------------------------------------

> > Please let me test more patches. I will keep up with you.

I hope it will be your help.

> Or you could try the 2.4 version, as I said originally the 2.2 patch
> hasn't been tested at all. It would be nice to know if that works
> for you, as I may have screwed up the backport a bit.

Before goto bed, I will get 2.4.x kernel and add your patch.
I will report again.

Best Regards,

-- 
 WWWWW  shibata@luky.org
 |O-O|  Hisaaki Shibata
0(mmm)0 P-mail: 070-5419-3233    IRC: #luky
   ~    http://his.luky.org/ last update:2000.3.12
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
