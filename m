Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131708AbRCORUr>; Thu, 15 Mar 2001 12:20:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131712AbRCORU1>; Thu, 15 Mar 2001 12:20:27 -0500
Received: from lightning.hereintown.net ([207.196.96.3]:24503 "EHLO
	lightning.hereintown.net") by vger.kernel.org with ESMTP
	id <S131708AbRCORUV>; Thu, 15 Mar 2001 12:20:21 -0500
Date: Thu, 15 Mar 2001 12:32:27 -0500 (EST)
From: Chris Meadors <clubneon@hereintown.net>
To: Nathan Black <NBlack@md.aacisd.com>
cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Hardware problem detection? Linux 2.4.3-pre4 lockups.
In-Reply-To: <8FED3D71D1D2D411992A009027711D6718A8@md>
Message-ID: <Pine.LNX.4.31.0103151217070.30067-100000@rc.priv.hereintown.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Mar 2001, Nathan Black wrote:

> I am at a total loss, But I have found some interesting anomalies with my
> hardware.

That is about how I was feeling when I had similar problems.

> My Current Setup:
> Supermicro S370DE6 (Serverworks Chipset)
> Dual PIII 866
> 2 x 256 MB PC133 ECC SDRAM
> onboard AIC 7899 SCSI Controller.
> 36G,73GB Seagate Cheetah Drive.
> Voodoo4 4500 AGP video,
> Fore PCA 200e ATM

My setup was (is):
Tyan Thunder 2500 (Serverworks)
Dual PIII 667s
2 x 512 MB PC133 ECC SDRAM
Onboard dual SYM53C896 controller
5 18.2 GB Seagate Cheetahs
nVideo Vanta
Onboard Intel 10/100

> Problem, I have a program the can read a file(large, or small) it will then
> transmit the data over atm, ethernet, localhost,or write to a file.

I could move a lot of network traffic as long as I wasn't hitting the disk
too hard.

> I have noticed that the machine will consistently crash(hard lockup) when I
> do a read loop of the File. It never locks up at the same place, and I have
> changed it so that it never actually does anything with the data after it
> reads. Still, same result.

Any time I pushed the disk subsystem hard I would get a lockup.  Sometimes
the kernel would oops, the program writing to the disk would segfault, but
always the machine locked hard.

> Things that have "fixed" the problem. Setting the FSB to 100(jumpered) will
> allow me to run forever.
> Also, Setting the L1 Cache to Write-through instead of write back will allow
> me to run forever at 133, but the performance hit is worse than setting the
> FSB to 100.

If I forced things to run slower I could run longer, like changing the
cache setting, never tried the FSB setting.  But even with the machine
slowed down I could eventually lock it up if I pushed the disks hard
enough (12 bonnies at the same time would always do it).

> Another note. When I have attempted to compile the kernel for Uni processor.
> I started getting segmentation faults with gcc.
> Now this tells me it might be the processor. But I have nothing overclocked,
> so I would think that it might be some kind of timing issue in the kernel.

I saw so much strange stuff I couldn't pin it down to one thing, except
perhaps the processor.

> I have two machines set up this way. One is much more stable. But I do
> observe the occasional crash.(hard lockup)

I too had two identical machines.  I was doing all my work on one, and was
planning on copying the finished product over to the second when I was
done.  After I started suspecting the hardware, I started up the other
machine.  It ran perfectly.  I could push it as hard as I wanted with no
trouble at all.

> I have also seen fsck crash as well. when the system was not shut down
> correctly. ( as a hard lockup happens very frequently.)
>
> Here are some things that I have tried, but Have not fixed it.
> 1) SMP Kernel with "noapic" at lilo prompt ( and without the noapic)
> 2) Uni Kernel w/ & w/out apic
>
> I am at a total loss.
> Is there anything I can do(other than run at 100 FSB)?
>
> Nathan
>
> P.S. I have enclosed the dmesg output for my Uniprocessor kernel
>  <<dmesg.out.uni>>

In the end I started swapping processors between the two machines.  I
found the problem followed 1 of my processors.  I called Intel and after 2
days of convincing they RMAed my old processor and sent me a replacement.
Both machines have been running perfectly since then.  If you have any
more processors I'd try swapping them around.  But since you are seeing
problems with 2 similar machines, I wouldn't get my hopes up as to this
being the solution.

-Chris
-- 
Two penguins were walking on an iceberg.  The first penguin said to the
second, "you look like you are wearing a tuxedo."  The second penguin
said, "I might be..."                         --David Lynch, Twin Peaks


