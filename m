Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264655AbSJ3LAy>; Wed, 30 Oct 2002 06:00:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264660AbSJ3LAy>; Wed, 30 Oct 2002 06:00:54 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:44299 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S264655AbSJ3LAx>;
	Wed, 30 Oct 2002 06:00:53 -0500
Message-ID: <3DBFBD46.5000307@pobox.com>
Date: Wed, 30 Oct 2002 06:06:46 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: dcinege@psychosis.com
CC: linux-kernel@vger.kernel.org
Subject: Re: Abbott and Costello meet Crunch Time -- Penultimate 2.5 merge
 candidate list.
References: <200210272017.56147.landley@trommello.org> <200210300514.57193.dcinege@psychosis.com> <3DBFB362.2070506@pobox.com> <200210300542.47207.dcinege@psychosis.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Cinege wrote:

>On Wednesday 30 October 2002 5:24, Jeff Garzik wrote:
>
>  
>
>>You appear to be unaware of early userspace. Moving code out of the
>>kernel does _not_ mean eliminating that code completely. 
>>    
>>
>
>My appologies, I thought you meant do_mounts.c was being yanked
>entirly if initramfs goes in.
>  
>

Apology accepted -- and note my apology further down below ;-)

>>do_mounts.c performs -- otherwise a Linux system would never have a root
>>filesystem mounted.
>>    
>>
>
>Actually it's very possible to eliminate it....require an initramfs image
>to have scripts and tools (mount and pivotroot) to do it all and mount that
>as the root. (An interesting but pretty bad idea IMO) This is what I thought
>you meant.
>

That's what is going to happen.  The initramfs image is completely 
removed from RAM after all this occurs, combined with moving code out of 
the kernel to early userspace, is how the overall kernel size shrinks.

Looking at a kernel cleanliness perspective, mounting root, unpacking 
initrd images, etc. get more and more complex -- with one simply copying 
userspace code into the kernel to get the job done.  In order to do NFS 
root for example, the kernel has an internal BOOTP and DHCP client, to 
snag an IP.  This mess simply does not belong in the kernel.  Never did.


>>Being unaware of early userspace implies that you are not familiar with
>>initramfs.
>>    
>>
>
>I'll accept your apology after you see how nicely I cleaned up do_mounts.c
>(It's 11K now) However I did not know the 'rootfs' was called 'early 
>userspace'. (Or was my above assumption correct?)
>
The absolutely smallest possible code is - unpack a cpio archive onto a 
ramfs.

If you want to support initrd --in kernel-- you must add in much more 
code:  ram disk device, and filesystem of your choice 
(minix/ext2/whatever).  _Any_ initrd code in the kernel is quite simply 
too much.  It doesn't matter how much you clean up the do_mounts.c code, 
"zero bytes" will always be smaller :)


>>Which implies you wish you merge your own code in place of something you
>>do not understand.
>>    
>>
>
>Jeff, be nice. I'm trying very hard myself...and if you knew me, you'd know
>it's a difficult task. : >
>  
>

lol

As promised above, I do apologize for jumping all over you.  :)  I 
should have much more tact and approach posts with a more educational 
perspective.

Further, if you are patient with _me_, I think I can explain how 
initramfs can (a) keep your existing initrd images working just fine or 
(b) help you shrink your startup images even more.

    Jeff




