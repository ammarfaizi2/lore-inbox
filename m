Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316395AbSEWHrz>; Thu, 23 May 2002 03:47:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316402AbSEWHrz>; Thu, 23 May 2002 03:47:55 -0400
Received: from [195.63.194.11] ([195.63.194.11]:54791 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S316395AbSEWHrx>; Thu, 23 May 2002 03:47:53 -0400
Message-ID: <3CEC8FB2.8090900@evision-ventures.com>
Date: Thu, 23 May 2002 08:44:02 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
CC: Alexander Viro <viro@math.psu.edu>, alan@lxorguk.ukuu.org.uk,
        davem@redhat.com, paulus@samba.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.17 /dev/ports
In-Reply-To: <E17AXfM-0001xc-00@the-village.bc.nu>	<Pine.GSO.4.21.0205221053330.2737-100000@weyl.math.psu.edu> <20020523173033.6635611a.rusty@rustcorp.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Rusty Russell napisa?:
> On Wed, 22 May 2002 10:54:25 -0400 (EDT)
> Alexander Viro <viro@math.psu.edu> wrote:
> 
>>On Wed, 22 May 2002, Alan Cox wrote:
>>
>>>XFree86 uses /proc/cpuinfo, /proc/bus/pci, /proc/mtrr, /proc/fb, /proc/dri
>>>and even such goodies as /proc/sys/dev/mac_hid/keyboard_sends_linux_keycodes
>>
>>... and while we are at flamewar-mongering, none of these files have any
>>business being in procfs.
> 
> 
> Let it never be said that you lack courage 8)
> 
> Let's sort this out at the kernel summit:
>  dev vs. driverfs. vs proc vs sysctl vs boot params vs. module params vs netlink

There isn't that much to be discussed there.

1. /proc is for process data becouse this has inherently a tree structure and
the FS abstractis is fitting this nicely. (We can share code with the VFS layer
therefore.)

2. /proc/sys is justifyed by the fact that sysctl can share a significant
amount of code with the procfs implementation. Note this *could* be changed
by abstracting the common code out of *both* procfs and sysctl instead
of stacking sysctl on to of procfs.

3. /proc/bus is superceeded by driverfs but has a tree struct and one can life
with it.

The rest is utter crap and legacy. Technically at least.

In particular the stuff listed above is looking like things which are in
reality device access abstractions and which belongs therefore to /dev/.

The only problem here is - people without taste for the implementation,
apparently love to look at files in /proc becouse this is giving them some
feelings I can't share...

PS. Did I mention that uniformity of interfaces is quite common in good
design practice? And something beeing ASCII simple doesn't imply that
it is an uniform interface.

