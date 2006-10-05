Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751394AbWJEVUc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751394AbWJEVUc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 17:20:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751398AbWJEVUc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 17:20:32 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:16140 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751394AbWJEVUb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 17:20:31 -0400
Date: Thu, 5 Oct 2006 23:20:29 +0200
From: Adrian Bunk <bunk@stusta.de>
To: art@usfltd.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc1 SMP x86_64 boot hungs up
Message-ID: <20061005212029.GL16812@stusta.de>
References: <20061005143237.xr08e3ew5b2ocgc8@69.222.0.225>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061005143237.xr08e3ew5b2ocgc8@69.222.0.225>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 05, 2006 at 02:32:37PM -0500, art@usfltd.com wrote:

> 2.6.19-rc1 SMP x86_64 boot hungs up
> 
> boot hungs up !!!
> last lines from screen at boot time:
> 
> ...
> Uniform CD-ROM driver Revision: 3.20
> ide-floppy driver 0.99.newide
> usbcore: registered new driver libusual
> usbcore: registered new driver hiddev
> usbcore: registered new driver usbhid
> drivers/usb/input/hid-core.c: v2.6:USB HID core driver
> PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
> PNP: PS/2 controller doesn't have AUX irq; using default 12
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ hungs up here
> next lines are from working 2.6.18-git6 looks like i8042 problem
> 
> PM: Adding info for platform:i8042
> serio: i8042 AUX port at 0x60,0x64 irq 12
> PM: Adding info for serio:serio0
> serio: i8042 KBD port at 0x60,0x64 irq 1
> PM: Adding info for serio:serio1
> mice: PS/2 mouse device common for all mice
> md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
> md: bitmap version 4.39
> TCP cubic registered
> ...
> 
> last good is 2.6.18-git6
> 2.6.18-git7 to 2.6.19-rc1 hungs up


Thanks for the confirmation.

Can you try to find the guilty commit through git bisecting?

IOW, please do:


# install git and cogito on your computer

# clone Linus' tree:
cg-clone \ 
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git

# start bisecting:
cd linux-2.6
git bisect start
git bisect bad b278240839e20fa9384ea430df463b367b90e04e
git bisect good dd77a4ee0f3981693d4229aa1d57cea9e526ff47

# start round
cp /path/to/.config .
make oldconfig
make
# install kernel, check whether it's good or bad, then:
git bisect [bad|good]
# start next round


After at about 8 reboots, you'll have found the guilty commit
("...  is first bad commit").


More information on git bisecting:
  man git-bisect


TIA
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

