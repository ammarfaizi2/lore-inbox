Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262882AbUJ2Evx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262882AbUJ2Evx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 00:51:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263093AbUJ2Evw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 00:51:52 -0400
Received: from out011pub.verizon.net ([206.46.170.135]:40950 "EHLO
	out011.verizon.net") by vger.kernel.org with ESMTP id S262882AbUJ2EuH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 00:50:07 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9bk6 msdos fs OOPS
Date: Fri, 29 Oct 2004 00:50:06 -0400
User-Agent: KMail/1.7
Cc: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
       Nigel Kukard <nkukard@lbsd.net>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
References: <41809921.10200@lbsd.net> <200410281905.20547.gene.heskett@verizon.net> <87k6ta1jf5.fsf@devron.myhome.or.jp>
In-Reply-To: <87k6ta1jf5.fsf@devron.myhome.or.jp>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410290050.06454.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out011.verizon.net from [141.153.91.102] at Thu, 28 Oct 2004 23:50:06 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 28 October 2004 20:01, OGAWA Hirofumi wrote:
>Gene Heskett <gene.heskett@verizon.net> writes:
>> Not at the time, which is why I came to the conclusion it may be a
>> bug in the camera software.  It checks in as version 1.0, and we
>> all know no one trusts anything at version 1.0. :-)
>>
>> I know now how to keep it from happening, so its not a showstopper
>> for me.
>
>Can you check the camera's entry of "cat /proc/mounts"?  Is it
>something like, "/dev/sda1 /mnt vfat ro,..."?

Unforch, I just rebooted to 2.6.10-rc1-bk7, and something is now broken.
It's always plugged in, but as it eats batteries pretty bad, turned off.

When I turned it on, I got this in the logs:
Oct 29 00:36:03 coyote kernel: usb 3-2.2: new full speed USB device using address 7
Oct 29 00:36:04 coyote kernel: scsi0 : SCSI emulation for USB Mass Storage devices
Oct 29 00:36:09 coyote scsi.agent[3339]: disk at /devices/pci0000:00/0000:00:02.1/usb3/3-2/3-2.2/3-2.2:1.0/host0/target0:0:0/0:0:0:0
Oct 29 00:36:09 coyote kernel:   Vendor: OLYMPUS   Model: C-3020ZOOM(U)     Rev: 1.00
Oct 29 00:36:09 coyote kernel:   Type:   Direct-Access                      ANSI SCSI revision: 02
Oct 29 00:36:09 coyote kernel: Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0
Oct 29 00:36:09 coyote kernel: SCSI device sda: 128000 512-byte hdwr sectors (66 MB)
Oct 29 00:36:09 coyote kernel: sda: assuming Write Enabled
Oct 29 00:36:09 coyote kernel: sda: assuming drive cache: write through
Oct 29 00:36:09 coyote kernel:  sda: sda1
Oct 29 00:36:09 coyote kernel: Attached scsi removable disk sda at scsi0, channel 0, id 0, lun 0

When I mounted it, the logs show:
Nothing.

The screen I mnounted it in gave this:
[root@coyote dlds-tgzs]# mount -t iso9660 /dev/camera /mnt/camera
mount: wrong fs type, bad option, bad superblock on /dev/camera,
       or too many mounted file systems

And:
[root@coyote dlds-tgzs]# ls -l /dev/camera
lrwxr-xr-x  1 root root 9 Nov 14  2003 /dev/camera -> /dev/sda1

So it appears that -bk7 is broken and I'll have to reboot back to
2.6.10-rc1-bk6 to get that info, and that will require the fscking
of about 200GB of drives, they will all check on the next reboot. :(

Att: Linus:  bk7 broke this, it worked fine at 2.6.10-rc1-bk6.  This
-bk7 kernel includes the patch that started this thread also, as did
the -bk6 test kernel under which it worked.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.28% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
