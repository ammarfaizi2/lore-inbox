Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316610AbSGVKHb>; Mon, 22 Jul 2002 06:07:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316615AbSGVKHb>; Mon, 22 Jul 2002 06:07:31 -0400
Received: from sproxy.gmx.de ([213.165.64.20]:20248 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S316610AbSGVKHa>;
	Mon, 22 Jul 2002 06:07:30 -0400
Message-ID: <3D3BDA18.4070902@gmx.at>
Date: Mon, 22 Jul 2002 12:10:32 +0200
From: Wilfried Weissmann <Wilfried.Weissmann@gmx.at>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: en
MIME-Version: 1.0
To: Ville Herva <vherva@niksula.hut.fi>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: File Corruption in Kernel 2.4.18
References: <3D362125.3A324489@atr.co.jp> <20020718072155.GB1548@niksula.cs.hut.fi> <3D367295.2010109@gmx.at> <20020718081630.GX1465@niksula.cs.hut.fi>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ville Herva wrote:
> On Thu, Jul 18, 2002 at 09:47:33AM +0200, you [Wilfried Weissmann] wrote:
> 
>>[snip]
>>
>>>I repoduced the problem with wrchk utility I wrote
>>>(http://iki.fi/v/tmp/wrchk.c) but it seems you can do it with you directory
>>>tree copying.
>>
>>I got to check this out!
> 
> 
> I had the problem to appear almost certainly when doing wrchk to raw disks
> (you should be able to use large files just as well), two writes in parallel
> (eg. /dev/hde, /dev/hdg). Occasionally it took ~50GB of writing before it
> happened (multiple rounds), but it always did.

I did a simultaneous:
wrck /dev/hd[fh] 0 64 2
The two disks were connected to the HPT-370 controller and both were 
configured as slave (the masters are configured into an ataraid-0 and 
contain my root partition). The test disk were IBM DLTA 307030 (30GB) 
with updated firmware. These disks are locked down to ata-44 by the 
kernel and I only got a maximum I/O speed of 21.7 MB/s. During the read 
phase one of the disks always slowed down, while the other disk 
proceeded at normal speed. In the first run I got 7.2 MB/s and at the 
second run the other disk slowed down to crawling 5.3 MB/s, but the test 
was completed without any errors. *joy* However I am not that the test 
did stress the chipset enough to trigger the error because of the 
throughput is so low.
My mainboard is a abit kt7-raid (VIA KT133 chipset), BIOS version 3R. 
Memory bus was reduced to 100 MHz (SDR). Linux kernel 2.4.18 tainted by 
NVidia(TM). ;)
DivX 5.0 seems to be a good stability test for VIA chipset based 
motherboards. It finds errors that not even memtest could detect.

greetings,
Wilfried

PS: I will do another run on my raid-0 root partition. The 2 disks that 
are part of the raid run at ata-100 (Maxtor 40GB).

