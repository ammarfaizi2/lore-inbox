Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129491AbRCADkh>; Wed, 28 Feb 2001 22:40:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129493AbRCADk1>; Wed, 28 Feb 2001 22:40:27 -0500
Received: from tomts5.bellnexxia.net ([209.226.175.25]:7584 "EHLO
	tomts5-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S129491AbRCADkL>; Wed, 28 Feb 2001 22:40:11 -0500
Message-ID: <3A9DC385.130F9ACE@coplanar.net>
Date: Wed, 28 Feb 2001 22:35:33 -0500
From: Jeremy Jackson <jerj@coplanar.net>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Eduard Hasenleithner <eduardh@aon.at>, linux-kernel@vger.kernel.org
Subject: Re: How to set hdparms for ide-scsi devices on devfs?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Eduard Hasenleithner wrote:

> Sorry, if this issue was already discussed in lkml. I didn't find
> a reference to this at www.geocrawler.com
>
> My Problem:
> I want to set the unmaskirq and dma -flag for my ide cd-recorder.
> The Problem is, that devfs creates no ide device, but only
> the /dev/scsi/../{cd,general} devices are created. And hdparm
> don't accepts this devices for setting the ide-parameters.
>
> My current workaround is to create a /dev/hd? device "by hand"
> at system startup. This is not very beautiful. Furthermore, if
> the device numbers in devfs are deactivated, this won't work
> anymore.
>
> I can live with my current solution. But i would be very happy
> if someone can present a clean solution.
>
> I posted this message intentionally not on the devfs mailing list
> as i think this problem is related to accessing the same device
> through different /dev entries. Under devfs, the /dev/ide/...
> device node gets allocated after the corresponding ide-xx.o has
> been loaded. But this is not possible with ide-scsi claiming
> the device :(
>
> Thanks in advance

workaround - before ide-scsi is loaded in boot sequence
(finding is left as an exercise to the reader :) do:

modprobe ide-cd
hdparm -u 1 -d 1 /dev/xxx
rmmod ide-cd

might have to do near top of /etc/rc.d/rc.sysinit under redhat,
but this is good since problems will happen before root filesystem
is remounted read-write, so any problems with hdparm settings
won't mess up disk.



