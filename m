Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263658AbREYIrT>; Fri, 25 May 2001 04:47:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263659AbREYIrJ>; Fri, 25 May 2001 04:47:09 -0400
Received: from libra.cus.cam.ac.uk ([131.111.8.19]:51610 "EHLO
	libra.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S263658AbREYIqw>; Fri, 25 May 2001 04:46:52 -0400
Message-Id: <5.1.0.14.2.20010525093809.048337e0@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Fri, 25 May 2001 09:47:24 +0100
To: Blesson Paul <blessonpaul@usa.net>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: [Re: How to add NTFS support]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010525044008.14212.qmail@nwcst284.netaddress.usa.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

At 05:40 25/05/2001, Blesson Paul wrote:
>So you are constructing a improved NTFS file driver. So when you have to 
>check your written codes of file driver, will u recompile the whole kernel 
>? . That is what I am asking. I am in a way to build a new file system.
>I took NTFS as a sample one. I thought , I will first try to compile and make
>it run.

NTFS is not a good example for a 2.4.x file system at the moment IMHO. It 
doesn't even use the page cache at all...

But anyway, I recompile the whole kernel the first time round, i.e. say I 
install the latest kernel, apply my latest NTFS patch, copy my old .config 
to linux/.config, make oldconfig. Then I set off: make dep && make bzImage 
&& make modules && sudo make modules_install [switch to different VT and do 
other stuff, go out, have dinner, whatever...], then install kernel, lilo, 
reboot.

Once I am running the new kernel, it becomes much easier: modify some code 
in linux/fs/ntfs, then from linux/ I just do: make modules && make 
modules_install && rmmod ntfs && modprobe ntfs and the new driver is loaded...

If I change any code outside of fs/ntfs then a new make bzImage, etc is 
required, as I build everything static (only ntfs as a module).

If I install a new kernel as I do quite frequently to keep up on what's 
going on, a new kernel compile is required from scratch...

Hope this helps.

Anton


-- 
   "Nothing succeeds like success." - Alexandre Dumas
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://sf.net/projects/linux-ntfs/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

