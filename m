Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312526AbSEHJQn>; Wed, 8 May 2002 05:16:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312529AbSEHJQn>; Wed, 8 May 2002 05:16:43 -0400
Received: from [195.63.194.11] ([195.63.194.11]:34822 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S312526AbSEHJQl>; Wed, 8 May 2002 05:16:41 -0400
Message-ID: <3CD8DE35.9090207@evision-ventures.com>
Date: Wed, 08 May 2002 10:13:41 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Jauder Ho <jauderho@carumba.com>
CC: benh@kernel.crashing.org, Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Padraig Brady <padraig@antefacto.com>,
        Anton Altaparmakov <aia21@cantab.net>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.14 IDE 56
In-Reply-To: <Pine.LNX.4.44.0205071025060.24481-100000@twinlark.arctic.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Jauder Ho napisa?:
> Ben, what you are proposing is fairly similar to what Solaris does today.
> There is a /devices directory that contains the real path while /dev
> contains the legacy stuff. Seems to work fine and given the proper docs,
> you can decipher what the /devices path points to fairly easily. So I
> certainly wouldnt mind seeing this happen for Linux eventually.

Amen, We would only have to add a device special file
to some of the /devices Stuff and /dev/ could be a symlink tree
pointing there...

I have *intentionally* named the standard mounting point
of the devicefs /devices the time I added the description
how to mount it to the driver-model.txt. The following words
are from *me*:

This can be done permanently by providing the following entry into the
/dev/fstab (under the provision that the mount point does exist, of course):

none            /devices        driverfs    defaults            0       0

Or by hand on the command line:

~: mount -t driverfs none /devices



> 
> --Jauder
> 
> On Tue, 7 May 2002 benh@kernel.crashing.org wrote:
> 
> 
>>>	/driverfs/root/pci0/00:1f.4/usb_bus/000/
>>>
>>>and it wouldn't be impossible (or even necessarily very hard) to make an
>>>IDE controller export the "IDE device tree" the same way a USB controller
>>>now exports the "USB device tree".
>>>
>>>For things like hotplug etc, I think driverfs is eventually the only way
>>>to go, simply because it gives you the full (and unambiguous) path to
>>>_any_ device, and is completely bus-agnostic.
>>>
>>>But there is definitely a potential backwards-compatibility-issue.
>>
>>One interesting thing here would be to have some optional link between
>>the bus-oriented device tree and the function-oriented tree (ie. devfs
>>or simply /dev). For example, an IDE node in driverfs could eventually
>>hold symlinks to the entries it provides in /dev when using devfs (or
>>just provide major/minor when not using devfs).
>>
>>What do you think ?
>>
>>One problem I've been faced with on ppc is to be able to match
>>a linux device with what the firmware (Open Firmware) thinks that
>>device is. The firmware view is bus-centered and it would be pretty
>>easy to provide some additional entries in driverfs that give the
>>OF fullpath of a given device. But then, the link between the actual
>>driver in driverfs and the "device" as used by, for example, the
>>filesystem isn't trivial.
>>
>>Ben.
>>
>>
>>
>>-
>>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>>the body of a message to majordomo@vger.kernel.org
>>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>Please read the FAQ at  http://www.tux.org/lkml/
>>
>>
> 
> 
> 



-- 
- phone: +49 214 8656 283
- job:   eVision-Ventures AG, LEV .de (MY OPINIONS ARE MY OWN!)
- langs: de_DE.ISO8859-1, en_US, pl_PL.ISO8859-2, last ressort: ru_RU.KOI8-R

