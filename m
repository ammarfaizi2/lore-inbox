Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316675AbSE3OxQ>; Thu, 30 May 2002 10:53:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316678AbSE3OxP>; Thu, 30 May 2002 10:53:15 -0400
Received: from [195.63.194.11] ([195.63.194.11]:33551 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S316675AbSE3OxO>; Thu, 30 May 2002 10:53:14 -0400
Message-ID: <3CF62F2A.6030009@evision-ventures.com>
Date: Thu, 30 May 2002 15:54:50 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
Subject: Re: [PATCH] 2.5.18 IDE 73
In-Reply-To: <UTC200205300019.g4U0JtH24034.aeb@smtp.cwi.nl> 	<3CF622F0.4050304@evision-ventures.com> <1022772774.12888.380.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Thu, 2002-05-30 at 14:02, Martin Dalecki wrote:
> 
>>1. util-linux doesn't cover half of the system utilities needed on
>>    a sanely actual Linux system.
>>2. The Linux vendors have to apply insane number of patches to it
>>    util it's moderately usable.
> 
> 
> So now you have nothing better to do than insult someone whose code
> works, is shipped in just about every distribution. Someone whose kernel
> patches are almost without fail perfect first time.
> 
> You should learn from Andries not mock him.

rpm -i util-linux-xxx.src.rpm

and count the patches yourself. Andries could be the Pope I would
still feel free to tell him what I think about this.
Ahh and just a remainder - poking at ports in kbdrate is bad and not
quite something I would learn from.

>>And after all it's rather trivial to iterate *all* disks present at boot
>>by hand and just going through /dev/sdaxxx chains. SCSI allocates
>>them consecutively anyway and there are typically not many ATA diskst around
>>there.
> 
> 
> You still need a way to talk all the disk devices. It might be that is
> devfs /dev/disk, but in case it hasn't permeated your skull yet, in such
> a situation then -devfs- would need such a list. We also have another

I don't use and don't care about devfs - it's a misconception in my opinnion.
What you are potining at is just another symptom of this simple fact.
After several years of beeing "official" it didn't develer up on
promises. There are some reasons why the Linux vendors out there get
well along without it. It is simple not necessary and even worser
introduces more problems that it promised to solve. No matter how
vigorous the propnents of it where before Linus give in. It's just another
try to work around the too narrow major/minor number spaces of Linux
and well see below:

> flaw here - we don't export the bit position of the partition/device
> split on each device which puts lots of horrible code into user space
> thats always going out of date
> 
> Oh and for /dev/disk/... to do labels and partitions it needs the
> partition data in the list too, remarkably like we have it now actually.

All what you are talking about here are afterthoughts to the a basic simple
flaw in the linux way af looking at devices:

Major numbers are sliced up to account for the fact that some drivers
abused slices of the major number space instead of minor numbers to
discriminate between different instances of the driver. Even worser
some drivers (most prominently ide-cd) hooked up completely
different devices on the same mojor number.
And last but not least: some devices which should be viewd as "same type"
are hooked up to different major numbers instead of sharing them.
Most prominent here are the differences between SCSI disks and ATA disks
for example. From a technical point of view they don't make *any* sense.

