Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131348AbRDXVq1>; Tue, 24 Apr 2001 17:46:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131376AbRDXVqS>; Tue, 24 Apr 2001 17:46:18 -0400
Received: from supelec.supelec.fr ([160.228.120.192]:32260 "EHLO
	supelec.supelec.fr") by vger.kernel.org with ESMTP
	id <S131348AbRDXVqE>; Tue, 24 Apr 2001 17:46:04 -0400
Message-ID: <3AE5F3F6.1D588ACE@supelec.fr>
Date: Tue, 24 Apr 2001 23:45:26 +0200
From: Francois Cami <francois.cami@supelec.fr>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3 i686)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Ignacio Monge <ignaciomonge@navegalia.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: PIO disk writes using 100% system time and performing poorly with 
 VIA vt82c686b on kernels 2.2 & 2.4
In-Reply-To: <20010424191941.5e719746.ignaciomonge@navegalia.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ignacio Monge wrote:
> 
>         Hi.
>         I have  VIA686a too and a UDMA100 hard disk.

So do I.

>         This is my cat /proc/ide/via:
> 
> ----------VIA BusMastering IDE Configuration----------------
> Driver Version:                     3.23
> South Bridge:                       VIA vt82c686a
> Revision:                           ISA 0x22 IDE 0x10
> Highest DMA rate:                   UDMA66

> -------------------drive0----drive1----drive2----drive3-----
> Transfer Mode:        DMA      UDMA       PIO       PIO
> Address Setup:       30ns      30ns     120ns     120ns
> Cmd Active:          90ns      90ns     480ns     480ns
> Cmd Recovery:        30ns      30ns     480ns     480ns
> Data Active:         90ns      90ns     330ns     330ns
> Data Recovery:       30ns      30ns     270ns     270ns
> Cycle Time:         120ns      60ns     600ns     600ns
> Transfer Rate:   16.5MB/s  33.0MB/s   3.3MB/s   3.3MB/s

What is odd here is the 33MB/s on drive 1. If it was operating
at UDMA66, that would be more like 66MB/s (see my own /proc/ide/via).
I guess you should try putting a drive on IDEO as master and the
second on IDE1 (which seems empty) as master too. 

>         As you can see, l use UDMA66 instead UDMA100. I don't know why. Maybe VIA 
> vt82c686a doesn't support it? I have answering in this list a days ago about this 
> problem. but none seems to have a question. 

686a maxes out at UDMA66. 686b does UDMA100.

> Like you, my system goes down when I try to compile so
> mething (I have a 394 Mb of RAM and a 1 Ghz processor).

I'm clueless, my 686a with IBM DTLA works fine (board is
ASUS A7V, kernel 2.4.3, Duron700, 256MB PC133). The new VIA 
IDE fixes in the kernel _might_ be the cause, but I'm not sure.

>         Although, my hdparm output is this:
>         /dev/hde2:
>  Timing buffer-cache reads:   128 MB in  0.79 seconds =162.03 MB/sec
>  Timing buffered disk reads:  64 MB in  2.44 seconds = 26.23 MB/sec
>         and sometime looks better.
> 
>         I don't know is this is a problem with the VIA kernel driver or not. But the
> system doesn't seem to work fine since 2.4.2 or 2.4.1 kernel. I hope (plz!) this
> problem will be fixed in future.
>         Luck.
> 
>         PS: in cat /proc/ide/via I see "Cable Type:                   40w              >   40w"... Is it right? I have a 80w cable, not 40.
> 
> 

I see 80w in mine, maybe your cable is broken... Did you put the blue
end
of the cable on the motherboard ? Also detecting a 40w cable disables
UDMA66 I guess.


Here's my /proc/ide/via :

----------VIA BusMastering IDE Configuration----------------
Driver Version:                     3.20
South Bridge:                       VIA vt82c686a
Revision:                           ISA 0x22 IDE 0x10
BM-DMA base:                        0xd800
PCI clock:                          33MHz
Master Read  Cycle IRDY:            0ws
Master Write Cycle IRDY:            0ws
BM IDE Status Register Read Retry:  yes
Max DRDY Pulse Width:               No limit
-----------------------Primary IDE-------Secondary IDE------
Read DMA FIFO flush:          yes                 yes
End Sector FIFO flush:         no                  no
Prefetch Buffer:              yes                  no
Post Write Buffer:            yes                  no
Enabled:                      yes                 yes
Simplex only:                  no                  no
Cable Type:                   80w                 40w
-------------------drive0----drive1----drive2----drive3-----
Transfer Mode:       UDMA       PIO       DMA       PIO
Address Setup:       30ns     120ns      60ns     120ns
Cmd Active:          90ns      90ns      90ns      90ns
Cmd Recovery:        30ns      30ns      90ns      90ns
Data Active:         90ns     330ns      90ns     330ns
Data Recovery:       30ns     270ns      90ns     270ns
Cycle Time:          30ns     600ns     180ns     600ns
Transfer Rate:   66.0MB/s   3.3MB/s  11.0MB/s   3.3MB/s


François Cami

-- 

All that is gold does not glitter,
	Not all those who wander are lost,
The old that is strong does not wither,
	Deep roots are not touched by the frost.
>From the ashes a fire shall be woken,
	A light from the shadows shall spring,
Renewed shall the blade that was broken,
	The crownless again shall be king.

		The Riddle of Strider
		JRR Tolkien
