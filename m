Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275125AbTHMMet (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 08:34:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272520AbTHMMet
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 08:34:49 -0400
Received: from pop016pub.verizon.net ([206.46.170.173]:59111 "EHLO
	pop016.verizon.net") by vger.kernel.org with ESMTP id S275125AbTHMMdp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 08:33:45 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: None that appears to be detectable by casual observers
To: Andrew McGregor <andrew@indranet.co.nz>
Subject: Re: [PATCH] O13int for interactivity
Date: Wed, 13 Aug 2003 08:33:43 -0400
User-Agent: KMail/1.5.1
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <200308050207.18096.kernel@kolivas.org> <200308130124.31978.gene.heskett@verizon.net> <98750000.1060753418@ijir>
In-Reply-To: <98750000.1060753418@ijir>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308130833.43362.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at pop016.verizon.net from [151.205.61.27] at Wed, 13 Aug 2003 07:33:44 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 13 August 2003 01:43, Andrew McGregor wrote:
>--On Wednesday, August 13, 2003 01:24:31 AM -0400 Gene Heskett
>
><gene.heskett@verizon.net> wrote:
>> Unrelated question:  I've applied the 2.6 patches someone pointed
>> me at to the nvidia-linux-4496-pkg2 after figuring out how to get
>> it to unpack and leave itself behind, so x can be run on 2.6 now. 
>> But its a 100% total crash to exit x by any method when using it
>> that way.
>>
>> Has the patch been updated in the last couple of weeks to prevent
>> that now?  It takes nearly half an hour to e2fsck a hundred gigs
>> worth of drives, and its going to bite me if I don't let the
>> system settle before I crash it to reboot, finishing the reboot
>> with the hardware reset button.
>>
>> Better yet, a fresh pointer to that site.
>
>http://www.minion.de/
>
>Works fine for me, as of 2.6.0-test1 (which is when I downloaded the
>patch).  I don't get the crash on either of my systems (GeForce2Go
> P3 laptop and GeForce4 Athlon desktop).
>
>Andrew

I see some notes about patching X, which I haven't done.  That might 
be it.  I also doublechecked that I'm running the correct makefile, 
and get this:

[root@coyote NVIDIA-Linux-x86-1.0-4496-pkg2]# ls -lR * |grep Makefile
-rw-r--r--    1 root     root         3623 Jul 16 22:56 Makefile
-rw-r--r--    1 root     root         7629 Aug  5 22:24 Makefile
-rw-r--r--    1 root     root         7629 Aug  5 21:46 Makefile.kbuild
-rw-r--r--    1 root     root         4865 Aug  5 21:46 Makefile.nvidia
[root@coyote NVIDIA-Linux-x86-1.0-4496-pkg2]# cd ../NVIDIA-Linux-x86-1.0-4496-pkg2-4-2.4/
[root@coyote NVIDIA-Linux-x86-1.0-4496-pkg2-4-2.4]# ls -lR * |grep Makefile
-rw-r--r--    1 root     root         3623 Jul 16 22:56 Makefile
-rw-r--r--    1 root     root         5665 Jul 16 22:56 Makefile
[root@coyote NVIDIA-Linux-x86-1.0-4496-pkg2-4-2.4]#

My video card, from an lspci:
01:00.0 VGA compatible controller: nVidia Corporation NV11 [GeForce2 MX DDR] (rev b2)

And the XFree86 version is:
3.2.1-21

Interesting to note that the 'nv' driver that comes with X 
does not do this.  But it also has no openGL and such.
We are instructed to remove agp support from the kernel, and 
use that which is in the nvidia kit, and I just checked the
.config, and its off, so thats theoreticly correct.  A grep 
for FB stuff returns this:

CONFIG_FB=y
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
CONFIG_FB_VESA=y
# CONFIG_FB_HGA is not set
CONFIG_FB_RIVA=y
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_VIRTUAL is not set

I'd assume the 'RIVA' fb is the correct one, its working in
2.4, although I can induce a crash there by switching from X
to a virtual console, and then attempting to switch back to X.
That will generally bring the machine down.  It is perfectly ok
to do that, repeatedly, when running the nv driver from X.

-- 
Cheers, Gene
AMD K6-III@500mhz 320M
Athlon1600XP@1400mhz  512M
99.27% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.

