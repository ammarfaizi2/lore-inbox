Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267513AbTA3Ovm>; Thu, 30 Jan 2003 09:51:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267515AbTA3Ovm>; Thu, 30 Jan 2003 09:51:42 -0500
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:54542 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S267513AbTA3Ovl>; Thu, 30 Jan 2003 09:51:41 -0500
Date: Thu, 30 Jan 2003 16:00:47 +0100
From: Jurriaan <thunder7@xs4all.nl>
To: Dave Jones <davej@codemonkey.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: [SOLVED!] Re: raid-0/reiserfs problem; file system not recognized after reboot
Message-ID: <20030130150047.GA1017@middle.of.nowhere>
Reply-To: thunder7@xs4all.nl
References: <20030130124224.GA8844@middle.of.nowhere> <20030130130041.GA21637@codemonkey.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030130130041.GA21637@codemonkey.org.uk>
X-Message-Flag: Still using Outlook? Please Upgrade to real software!
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Jones <davej@codemonkey.org.uk>
Date: Thu, Jan 30, 2003 at 01:00:41PM +0000
> On Thu, Jan 30, 2003 at 01:42:24PM +0100, Jurriaan wrote:
> 
>  > umount /dev/md0
>  > umount /dev/md1
>  > raidstop /dev/md0
>  > raidstop /dev/md1
>  > dd if=/dev/zero of=/dev/hdi bs=512 count=1
>  > dd if=/dev/zero of=/dev/hdk bs=512 count=1
>  > fdisk /dev/hdi < /root/fdisk.in
>  > fdisk /dev/hdk < /root/fdisk.in
>  > mkraid --really-force /dev/md0
>  > mkraid --really-force /dev/md1
> 
It turned out the kernel I did this with was compiled like this:


#
# Multi-device support (RAID and LVM)
#
CONFIG_MD=y
CONFIG_BLK_DEV_MD=m
# CONFIG_MD_LINEAR is not set
CONFIG_MD_RAID0=m
# CONFIG_MD_RAID1 is not set
CONFIG_MD_RAID5=m
# CONFIG_MD_MULTIPATH is not set
# CONFIG_BLK_DEV_LVM is not set
# CONFIG_BLK_DEV_DM is not set

and those modules weren't loaded. After recompiling the kernel with all
raid-options on and in the kernel, it works.

It's strange, however, that you can create a raid partition without raid
support until you reboot.

You'd expect to have 'mkraid' say:

'no RAID support in kernel - aborting'

or something like that.

Kind regards,
Jurriaan
-- 
"Witness the strategy of silence - while the intended victims unravel each
other in pointless, divisive discourse. Oh yes, I have learned much from
Tremorlor."
        Steven Erikson - Deadhouse Gates
GNU/Linux 2.4.21-pre3-ac5 SMP/ReiserFS 1x2824 bogomips load av: 0.09 0.13 0.07
