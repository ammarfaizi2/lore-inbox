Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262504AbTCMRzB>; Thu, 13 Mar 2003 12:55:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262502AbTCMRzB>; Thu, 13 Mar 2003 12:55:01 -0500
Received: from fed1mtao07.cox.net ([68.6.19.124]:34008 "EHLO
	fed1mtao07.cox.net") by vger.kernel.org with ESMTP
	id <S262504AbTCMRy5>; Thu, 13 Mar 2003 12:54:57 -0500
Message-ID: <3E70C877.7040804@cox.net>
Date: Thu, 13 Mar 2003 11:05:43 -0700
From: "Kevin P. Fleming" <kpfleming@cox.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.3b) Gecko/20030215
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
CC: Oliver Tennert <tennert@science-computing.de>,
       linux-kernel@vger.kernel.org
Subject: Re: Kernel setup() and initrd problems
References: <Pine.LNX.4.44.0303131051160.7342-100000@chaos.physics.uiowa.edu>
In-Reply-To: <Pine.LNX.4.44.0303131051160.7342-100000@chaos.physics.uiowa.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kai Germaschewski wrote:
> I think whoever came up with that just got the idea of pivot_root wrong. 
> The idea was to get rid of the initrd special case. It should be possible 
> to do the following, though I didn't work out the details: 
> 
> Tell the kernel that our root dev is /dev/ram and give it an initrd which 
> isn't really a classical initrd (with /linuxrc on it), but instead has a 
> /sbin/init which is similar to the linuxrc above.
> 
> Then, the kernel will load the image into /dev/ram, mount that as root and 
> exec /sbin/init, skipping the special initrd code.
> 
> Now, we have to take care of all the remaining business in /sbin/init 
> ourselves, i.e.
> 
> - load modules
> - mount real root
> - pivot root to real root
> - execve /sbin/init on real root, pointing stdin/out/err to /dev/console 
>   on the new root
> - umount and free our first (ramdisk) root

I have used exactly this process, and it works as you expect. In this 
situation you're not really using the initrd as a "classic" initrd, it's 
just a temporary root filesystem. The kernel has no idea what the real 
root is going to be, and that determination isn't made until the 
initrd's scripts decide what to mount and then pivot_root to it.

Much cleaner than the old way.

