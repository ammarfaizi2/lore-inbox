Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132732AbRDDAsn>; Tue, 3 Apr 2001 20:48:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132729AbRDDAsY>; Tue, 3 Apr 2001 20:48:24 -0400
Received: from smtp9.xs4all.nl ([194.109.127.135]:56266 "EHLO smtp9.xs4all.nl")
	by vger.kernel.org with ESMTP id <S132727AbRDDAsS>;
	Tue, 3 Apr 2001 20:48:18 -0400
From: Stefan Linnemann <mazur@xs4all.nl>
Organization: Dis.
Date: Wed, 4 Apr 2001 02:48:03 +0200
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain; charset=US-ASCII
Cc: linux-kernel@vger.kernel.org
To: Tim Waugh <twaugh@redhat.com>
In-Reply-To: <01040302081301.00789@mazur.xs4all.nl> <20010403181619.J9355@redhat.com>
In-Reply-To: <20010403181619.J9355@redhat.com>
Subject: Re: Sandisk flashcard reader on 2.4.2. It works. Sort of.
MIME-Version: 1.0
Message-Id: <01040402480300.00799@mazur.xs4all.nl>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 03 April 2001 19:16, Tim Waugh wrote:

> > On Tue, Apr 03, 2001 at 02:08:13AM +0200, Stefan Linnemann wrote:
> > the necessary features.  I copied .config from the 2.2.17, superficially
> > checked the config, and remade and rebooted.

> > This was where I noted, that the parport, paride, epat and pd modules
> > didn't get installed as modules at all.  I haven't dug into the why of
> > that, let those familiar with the processes and Makefiles do that.

> It'll be because of the block device directory reorganisation I
> expect, or something similar.  Double-check your config.

Config is fine, it's just make modules_install that's ignoring them.

> > So I reconfigured to get those into the kernel, and remade and
> > rebooted.  No dice, so I succesfully again applied the same patch,
> > configured it into the kernel and remade and rebooted.  No
> > SanDisk. For some reason or another I rebooted again, and lo and
> > behold, we have a SanDisk.

> So the kernel you run which can see the SanDisk is with, or without,
> the C7/8 patch?

With both 2.2.17 and 2.4.2, only with the patch, and it reports a c7 chip.
The only times it did get recognized the 16 Mb SanDisk CompactFlash card
(EC-16CF) was in the reader.  Though even that now doesn't seem to help 
anymore.  One clue only remains to be told: ever since installing the patch I 
get one error message lots of time: "invalid character 46 in exportstr for 
pd.drive0".  It's even printed at bootup from almost every init script.

> > I mount it ok, cd
> > /sandisk/dir/, mv * elsewhere, my system hangs.  Reset.

> Enable magic-sysrq and see if Alt-SysRq-B reboots the machine or not.
> Or, even better, jot down what Alt-SysRq-T says.

It is in, and was in, I only had completely forgotten about that, never 
having had a need for it yet.

> > So the message is: Yes, it could work, but with the patch from
> > http://www.electricgod.net/~moomonk/epat/ it's slightly better working
> > than without it.

> This patch is in the queue, but behind the bug-fixes.

That, I figured.  Which is why I bothered the mailing list in the first 
place, so you know there are some issues with the patch as it is.

> You might want to try fiddling with the BIOS options for the parallel
> port and see if that makes any difference.

The only options I get in BIOS for my parallel port are Output-Only, 
Bi-Directional,  EPP and ECP.  ECP was the setting, and changing that to EPP 
and Bi_Directional only removed some of the protocols reported by the OS, so 
I'm back to ECP now.

I'll include a dmesg diff between one time he did recognize the thing and the 
current one:

*** dmesg	Wed Apr  4 02:03:56 2001
--- dmesg.sandisk	Fri Mar 30 16:45:40 2001
***************
*** 9,17 ****
  zone(0): 4096 pages.
  zone(1): 36864 pages.
  zone(2): 0 pages.
! Kernel command line: BOOT_IMAGE=linux ro root=301 hisax=3,2,10,0x180,HiSax 
opl3sa2=0x370,5,0,3,0x530,0x330 pd.drive0=0x378
  Initializing CPU#0
! Detected 233.290 MHz processor.
  Console: colour VGA+ 80x25
  Calibrating delay loop... 465.30 BogoMIPS
  Memory: 158892k/163840k available (1118k kernel code, 4560k reserved, 374k 
data, 84k init, 0k highmem)
--- 9,17 ----
  zone(0): 4096 pages.
  zone(1): 36864 pages.
  zone(2): 0 pages.
! Kernel command line: auto BOOT_IMAGE=linux ro root=301 
hisax=3,2,10,0x180,HiSax opl3sa2=0x370,5,0,3,0x530,0x330 pd.drive0=0x378
  Initializing CPU#0
! Detected 233.294 MHz processor.
  Console: colour VGA+ 80x25
  Calibrating delay loop... 465.30 BogoMIPS
  Memory: 158892k/163840k available (1118k kernel code, 4560k reserved, 374k 
data, 84k init, 0k highmem)
***************
*** 72,79 ****
   hdc: hdc1 hdc2
  paride: epat registered as protocol 0
  pd: pd version 1.05, major 45, cluster 64, nice 0
! epat_init_protopda: Autoprobe failed
! pd: no valid drive found
  Floppy drive(s): fd0 is 1.44M
  FDC 0 is a National Semiconductor PC87306
  Serial driver version 5.02 (2000-08-09) with MANY_PORTS MULTIPORT SHARE_IRQ 
ISAPNP enabled
--- 72,81 ----
   hdc: hdc1 hdc2
  paride: epat registered as protocol 0
  pd: pd version 1.05, major 45, cluster 64, nice 0
! epat_init_protopda: Sharing parport0 at 0x378
! pda: epat 1.02, Shuttle EPAT chip c7 at 0x378, mode 2 (8-bit), delay 1
! pda: SanDisk SDCFB-, master, 31360 blocks [15M], (490/2/32), removable media
!  pda: pda1
  Floppy drive(s): fd0 is 1.44M
  FDC 0 is a National Semiconductor PC87306
  Serial driver version 5.02 (2000-08-09) with MANY_PORTS MULTIPORT SHARE_IRQ 
ISAPNP enabled

Thanks for the reply, anyway,
Stefan.
-- 
Stefan Linnemann                        http://www.xs4all.nl/~mazur/
Systeem programmeur Unix      ICQ: 25314387
