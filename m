Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262177AbTCVLll>; Sat, 22 Mar 2003 06:41:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262184AbTCVLll>; Sat, 22 Mar 2003 06:41:41 -0500
Received: from lucidpixels.com ([66.45.37.187]:11905 "HELO lucidpixels.com")
	by vger.kernel.org with SMTP id <S262177AbTCVLlk>;
	Sat, 22 Mar 2003 06:41:40 -0500
Message-ID: <3E7C4E8E.9030704@lucidpixels.com>
Date: Sat, 22 Mar 2003 06:52:46 -0500
From: Justin Piszcz <jpiszcz@lucidpixels.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Question about hdparm & dma.
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

root@war:~# hdparm -X69 /dev/hda
/dev/hda:
 setting xfermode to 69 (UltraDMA mode5)
root@war:~# dmesg | tail -n 1
ide0: Speed warnings UDMA 3/4/5 is not functional.
root@war:~#

war@war:~$ dmesg|grep -i ST[0-9]
hda: ST3120024A, ATA DISK drive
war@war:~$

This is a Segeate 120GB 7200RPM drive.
On a:

SIS5513: IDE controller on PCI bus 00 dev 15
SIS5513: chipset revision 0
SIS5513: not 100% native mode: will probe irqs later

When I put the drive on a Promise Ultra ATA/133 board, it runs UDMA MODE 
5 (ATA 100) just fine.

Next...

When I run hdparm -t /dev/hda on the SiS (with the settings I have shown):

root@war:~# hdparm -v /dev/hda

/dev/hda:
 multcount    = 16 (on)
 IO_support   =  0 (default 16-bit)
 unmaskirq    =  1 (on)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 14593/255/63, sectors = 234441648, start = 0
root@war:~#

root@war:~# hdparm -t /dev/hda
/dev/hda:
 Timing buffered disk reads:  64 MB in  1.60 seconds = 40.00 MB/sec

Now...

My question is, how is it possible to get > 33MB/s in only UDMA Mode 2 
(the linux driver only supports up to UDMA2).

I haven't been able to figure it out.

With the same settings for the promise, and the promise, ide2=ata100 
works on the command line, on the SiS/for the SiS, it does not, says it 
is an invalid option, doing that or setting the dma on manually, I get 
the same speed (MB/s), but is it really running at ATA/100?  I mean, if 
it is running in UDMA MODE 5 vs UDMA MODE 2, I would assume a little bit 
of a speed boost, I remember with an older box, going from ATA/66 -> 
ATA/100 increase about 2-3MB/s throughput with hdparm.

However, more importantly, when I am doing many things simultaenously, I 
notice a slowdown, I did *NOT* notice this slow down on my older p3/866 
+ ata/66 system, and I knew for a fact it was at ata/66, not only this, 
it was a via/133 chipset and the ide[0|1]=ata66 worked as well.

So basically I am wondering if udma mode 5 will be supported for SIS 
chipsets.
Secondly, I also have one of those Promise/Serial ATA raid on the 
motherboard (2 serial ata/1 ata133), but that is not supported at all.

So what should I do if I want to run at UDMA MODE 5?
Should I buy another promise controller (ATA/133 PCI) and run it off of 
that?

Anyone have any suggestions?  Please let me know, thank you.
Please cc me as I am not on the list.



