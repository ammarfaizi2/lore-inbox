Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312486AbSEHJBl>; Wed, 8 May 2002 05:01:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312505AbSEHJBk>; Wed, 8 May 2002 05:01:40 -0400
Received: from [195.63.194.11] ([195.63.194.11]:16646 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S312486AbSEHJBj>; Wed, 8 May 2002 05:01:39 -0400
Message-ID: <3CD8DAA2.6080907@evision-ventures.com>
Date: Wed, 08 May 2002 09:58:26 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Padraig Brady <padraig@antefacto.com>,
        Anton Altaparmakov <aia21@cantab.net>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.14 IDE 56
In-Reply-To: <Pine.LNX.4.44.0205070953420.2509-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Linus Torvalds napisa?:
> 
> On Tue, 7 May 2002, Alan Cox wrote:
> 
>>/proc/ide has useful information in it that you can't get easily by
>>other means at the moment - which controller is driving the disks, what
>>devices are present etc.
> 
> 
> I'd love for somebody to add the devices to the real device tree, at which
> point this kind of information would be very much visible..
> 
> Right now devicefs isn't even mounted by default, but it's the only
> _really_ generic way of showing things like this that we have. For people
> who haven't seen it before, do a
> 
> 	mount -t driverfs /devfs /devfs
> 
> and go look in there.. In particular, if you have a PCI system with a USB
> device tree (or _multiple_ such trees), notice how you can look at things
> like
> 
> 	/driverfs/root/pci0/00:1f.4/usb_bus/000/
> 
> and it wouldn't be impossible (or even necessarily very hard) to make an
> IDE controller export the "IDE device tree" the same way a USB controller
> now exports the "USB device tree".
> 
> For things like hotplug etc, I think driverfs is eventually the only way
> to go, simply because it gives you the full (and unambiguous) path to
> _any_ device, and is completely bus-agnostic.
> 
> But there is definitely a potential backwards-compatibility-issue.

Linus - there are no backward compatibility issues here.
No single application from my system does mess with /proc/ide.
They showed you a list of programs which use /proc and not a list
of programs which use anything out of /proc/ide...
RedHat even disables all this chip set specific reporting in theyr
public kernels. OK kudzu is using it, but it does not *rely on it*.
Heck kudzu is running all the time I rebooted my system during
developement and nothing ugly did happen.

for fdisk on my notebook, well it runs just fine:

[root@kozaczek root]# fdisk /dev/hda

The number of cylinders for this disk is set to 2584.
There is nothing wrong with that, but this is larger than 1024,
and could in certain setups cause problems with:
1) software that runs at boot time (e.g., old versions of LILO)
2) booting and partitioning software from other OSs
    (e.g., DOS FDISK, OS/2 FDISK)

Command (m for help): p

Disk /dev/hda: 240 heads, 63 sectors, 2584 cylinders
Units = cylinders of 15120 * 512 bytes

    Device Boot    Start       End    Blocks   Id  System
/dev/hda1   *         1         7     52888+  83  Linux
/dev/hda2             8      2556  19270440    5  Extended
/dev/hda4          2557      2584    211680   a0  IBM Thinkpad hibernation
/dev/hda5             8      2166  16322008+  83  Linux
/dev/hda6          2167      2219    400648+  82  Linux swap

Neither the programmer who wrote fdisk or cdrecord or anything else
was stiupid enough to use anything out there, since using a
simple ioctl is easier anyway. I *did* check them.
(Admittedly I don't care about kudzu, but fdisk an friends I was
fully aware of.)

BTW. If one needs the size of the disk well we could
attach it as a file size to the device file in /dev IMHO. Why not?


