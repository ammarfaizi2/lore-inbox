Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316456AbSEaS3A>; Fri, 31 May 2002 14:29:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316538AbSEaS27>; Fri, 31 May 2002 14:28:59 -0400
Received: from [195.63.194.11] ([195.63.194.11]:38666 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S316456AbSEaS26>; Fri, 31 May 2002 14:28:58 -0400
Message-ID: <3CF7B339.3000406@evision-ventures.com>
Date: Fri, 31 May 2002 19:30:33 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
CC: Vojtech Pavlik <vojtech@suse.cz>, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org, Andries.Brouwer@cwi.nl
Subject: Re: [PATCH] Artop update
In-Reply-To: <200205311951.35809@enzo.bigblue.local>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Franz Sirl wrote:
> Hi,
> 
> finally I was able to test the new driver and except for the "return 0 instead 
> of dev-irq" typo all was fine. I added a few minor changes based on the 
> discussion with Vojtech though.

Hey cool!

> The hunk to main.c is needed to be able to boot with DEVFS enabled.

Better just don't do devfs :-). But anyway...

Well I'm planing to add kernel version tagging of fstab line enties
to util-linux. This seems to be the only way to make major/minor
transitions (and the more I think about it the more I'm convinced
that they will be unevitable at some not so distant point in time!)

Something along the lines of:

cat /etc/fstab:

/dev/hdc                /                       ext3    v2.4,defaults    1 1
/dev/sda1 
         /                       ext3    v2.5,defaults    1 1
LABEL=/boot             /boot                   ext3    defaults        1 2
/dev/fd0                /mnt/floppy             auto    noauto,owner    0 0
# /dev/loop1            /mnt/1                  auto    noauto,owner    0 0
# /dev/loop2            /mnt/2                  auto    noauto,owner    0 0
none                    /proc                   proc    defaults        0 0
none                    /tmp                    tmpfs   defaults        0 0
none                    /dev/pts                devpts  gid=5,mode=620  0 0
/dev/hda6               swap                    swap    defaults        0 0


Would be *very* convenient for this purpose and solve 99.9999% percent
of portability problems. Well the above syntax may be the esiest to
imeplement however the below syntax would be perhaps more palatable:

2.5:/dev/sda1 
		/		ext3 ....

Opinnions?

perhaps a similar adjustments would be required for the kernel root parameter of 
course.

With something along
root=2.5:/dev/sda1,2.4:/dev/hdc
one could be living with... The respecive kernel would just pick the entry
which is matching it's version and be fine.

