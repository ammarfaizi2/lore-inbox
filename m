Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266256AbUGORzb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266256AbUGORzb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jul 2004 13:55:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266263AbUGORza
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jul 2004 13:55:30 -0400
Received: from larry.aptalaska.net ([64.186.96.3]:64684 "EHLO
	larry.aptalaska.net") by vger.kernel.org with ESMTP id S266256AbUGORzW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jul 2004 13:55:22 -0400
Message-ID: <40F6C504.9010403@aptalaska.net>
Date: Thu, 15 Jul 2004 09:55:16 -0800
From: Matthew Schumacher <matt.s@aptalaska.net>
User-Agent: Mozilla Thunderbird 0.7 (X11/20040615)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tim Bird <tim.bird@am.sony.com>
CC: linux-kernel@vger.kernel.org, syslinux@zytor.com
Subject: Re: Possible bug with kernel decompressor.
References: <40F490B6.6000106@schu.net> <40F5AE63.5010505@am.sony.com>
In-Reply-To: <40F5AE63.5010505@am.sony.com>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Schumacher wrote:
 > List,
 >
 > I think I found a bug here because I can repeatably get the same kernel
 > (checked with md5sum) to decompress and to fail with the error:
 >
 > invalid compressed format (err=2)
 >
 >   --System halted
 >
 >
 > Here is how I can reproduce the problem:
 >
 > Boot 2.6.8-rc1
 > Run md5sum on 2.6.8-rc1 kernel
 > Turn power off (this is an embedded system with only ramdisk mounted)
 > Turn power on
 > Kernel fails to boot with "invalid compressed format (err=2)"
 > Restart system
 > Boot 2.4.26
 > Run md5sum on 2.6.8-rc1 kernel (matches md5sum above)
 > Shutdown properly
 > boot 2.6.8-rc1 (works fine)
 > Run md5sum on 2.6.8-rc1 kernel (matches md5sum above)
 >
 > So you see if I don't shutdown properly (which shouldn't be required for
 > an embedded system using a ramdisk) my kernel won't decompress itself
 > until I run another kernel and shutdown properly.  I know that the
 > kernel didn't change so something else must be causing it to fail.
 >
 > I call this a bug simply because a power failure could cause someone to
 > loose the ability to boot their machine.
 >
 > Here is the hardware:
 > Whistle Interjet (486 SBC)
 > 64MB of memory
 > IDE disk.
 > Can reproduce with linux  2.6.5, 2.6.6, 2.6.7, and 2.6.8-rc1
 > Both kernel images and the initrd image both live on a fat16 partition
 > and are started with syslinux.  I can reproduce this problem with any
 > version of syslinux I have tried.
 >
 > Please CC me in any replies since I am not on the list.
 >
 > Thanks,
 >
 > schu
 >
 >
 >
Tim Bird wrote:
> If I recall correctly, a number of read errors during the
> initial kernel loading can result in this error message
> (which means it is somewhat misleading.)  You may have
> to add some printks to narrow this down more (in both the
> 2.4 and 2.6 kernels)
> 
> Obviously there's something in the 2.4 code that handles
> the ungracefully-shutdown machine state better than 2.6.8.
> Or there might be some other difference between the syslinux
> boot of the 2.4 kernel and that of the 2.6.8 kernel.
> 

Sorry, for the long post, I'm more doing this for the archive than 
anything else so others can google instead of ask.

I thought that this might be something with syslinux too, but didn't go 
down that road because something in the new 2.6 kernel doesn't handle 
this as gracefully as the 2.4 kernel.

That said, I thought I would try a different boot loader so I installed 
grub on the system and it seems to work fine.

I should note that this hardware requires the linux mem/memmap= params 
because of the buggy memory detection in the bios so I was required to 
use the uppermem command in grub to make it detect the memory and put 
the initrd image in the right place.

So in the end it looks like it is a syslinux issue loading the initrd 
image but for some reason the 2.4 kernel seems to be just fine with 
whatever isn't working right.

I can troubleshoot more if someone wants to track this down, but at this 
point I have a work around and now it's documented on both lists.

Thanks,

schu
