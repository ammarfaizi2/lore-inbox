Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315891AbSEGQb1>; Tue, 7 May 2002 12:31:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315895AbSEGQb0>; Tue, 7 May 2002 12:31:26 -0400
Received: from eventhorizon.antefacto.net ([193.120.245.3]:36019 "EHLO
	eventhorizon.antefacto.net") by vger.kernel.org with ESMTP
	id <S315891AbSEGQbY>; Tue, 7 May 2002 12:31:24 -0400
Message-ID: <3CD800FE.4050004@antefacto.com>
Date: Tue, 07 May 2002 17:29:50 +0100
From: Padraig Brady <padraig@antefacto.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc1) Gecko/20020417
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Anton Altaparmakov <aia21@cantab.net>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.14 IDE 56
In-Reply-To: <Pine.LNX.4.44.0205070827050.1343-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
>  [ First off: any IDE-only thing that doesn't work for SCSI or other disks
>    doesn't solve a generic problem, so the complaint that some generic
>    tools might use it is totally invalid. ]
> 
> On Tue, 7 May 2002, Anton Altaparmakov wrote:
> 
>>Linux's power is exactly that it can be used on anything from a wristwatch
>>to a huge server and that it is flexible about everything. You are breaking
>>this flexibility for no apparent reason. (I don't accept "I can't cope with
>>this so I remove it." as a reason, sorry).
> 
> 
> Run the 57 patch, and complain if something doesn't work.
> 
> Linux's power is that we FIX stuff. That we make it the best system
> possible, and that we don't just whine and argue about things.
> 
> 
>>As the new IDE maintainer so far we have only seen you removing one
>>feature after the other in the name of cleanup, without adequate or even
>>any at all(!) replacements,
> 
> 
> Who cares? Have you found _anything_ that Martin removed that was at all
> worthwhile? I sure haven't.
> 
> Guys, you have to realize that the IDE layer has eight YEARS of absolute
> crap in it. Seriously. It's _never_ been cleaned up before. It has stuff
> so distasteful that t's scary.
> 
> Take it from me: it's a _lot_ easier to add cruft and crap on top of clean
> code. You can do it yourself if you want to. You don't need a maintainer
> to add barnacles.
> 
> All the information that /proc/ide gave you is basically available in
> hdparm, and for your dear embedded system it apparently takes up less
> space by being in user space. So what is the problem?

Well my "dear" embedded system doesn't have libc :-(
So 35664 saved in kernel (less on disk), requires 25212
extra for hdparm + more for static linked uclibc (hope
it works ;-)). As a side note if this happens hdparm would
be a requirement for busybox IMHO, anyway getting back on topic...

All the info I've ever needed is /proc/ide/hdx/capacity
which I could get from /proc/partitions with more a bit
more effort, so I vote for removing /proc/ide.

I think everyone realises Martin is doing great and much needed work
on IDE (btw I'll have those flash support patches soon Martin ;-)),
but I did think this change needed debate. In general I know it's a
hard decision what to export in proc, especially if there are
existing dependencies, a few already mentioned possibles in RH7.1:

/sbin/mkinitrd
/sbin/fdisk
/sbin/sfdisk
/sbin/sndconfig
/usr/sbin/mouseconfig
/usr/sbin/kudzu
/usr/sbin/module_upgrade
/usr/sbin/updfstab
/usr/sbin/glidelink
/usr/sbin/sndconfig
/usr/lib/python1.5/site-packages/_kudzumodule.so
/usr/bin/X11/Xconfigurator

For e.g. could the same arguments could be made for lspci only
interface to pci info rather than /proc/bus/pci? The following
references are made to /proc/bus/pci on my system:

/sbin/lspci
/sbin/setpci
/sbin/sndconfig
/usr/sbin/mouseconfig
/usr/sbin/kudzu
/usr/sbin/module_upgrade
/usr/sbin/updfstab
/usr/sbin/glidelink
/usr/sbin/sndconfig
/usr/sbin/adsl-config
/usr/sbin/internet-config
/usr/sbin/isdn-config
/usr/lib/python1.5/site-packages/_kudzumodule.so
/usr/bin/X11/XFree86
/usr/bin/X11/pcitweak
/usr/bin/X11/scanpci
/usr/bin/X11/Xconfigurator

cheers,
Padraig.

