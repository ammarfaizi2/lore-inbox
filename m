Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311609AbSCTGay>; Wed, 20 Mar 2002 01:30:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311611AbSCTGao>; Wed, 20 Mar 2002 01:30:44 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:46052 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S311609AbSCTGa1>; Wed, 20 Mar 2002 01:30:27 -0500
Date: Tue, 19 Mar 2002 23:30:23 -0700
Message-Id: <200203200630.g2K6UNw24115@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Felix Braun <Felix.Braun@mail.McGill.ca>
Cc: viro@math.psu.edu, linux-kernel@vger.kernel.org
Subject: Re: devfs mounted twice in linux 2.4.19-pre3
In-Reply-To: <20020317121954.390bc242.Felix.Braun@mail.McGill.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Felix Braun writes:
> Hi Richard,
> 
> I just noticed that devfs is listed twice in /proc/mounts in linux
> 2.4.19-pre3, which confuses my shutdown script. Under 2.4.19-pre my
> /proc/mounts looks like this:
> 
> devfs /dev devfs rw 0 0
> /dev/ide/host0/bus0/target0/lun0/part5 / reiserfs rw 0 0
> none /dev devfs rw 0 0
> /proc /proc proc rw 0 0
> /dev/discs/disc0/part1 /dos vfat rw 0 0
> /dev/discs/disc0/part9 /opt reiserfs rw,noatime 0 0
> none /dev/pts devpts rw 0 0
> /dev/discs/disc0/part7 /usr reiserfs rw 0 0
> none /dev/shm tmpfs rw 0 0
> 
> whereas under 2.4.18 the first line didn't show up. Is that a
> misconfiguration on my part?

No, this is due to a change in the kernel (presumably done by Al).
What seems to be happening is that the kernel temporarily mounts devfs
and then detaches it again using MNT_DETACH (actually, you need
2.4.19-pre3-ac2 to get the fix that adds MNT_DETACH). However,
detached filesystems still appear to be listed in /proc/mounts.
Arguably, this is incorrect.

If you were to reboot single-user, and with devfs=nomount, inspection
of /proc/mounts would show the line:
devfs /dev devfs rw 0 0

However, if you listed /dev, you would see that it doesn't actually
contain a devfs. Thus, /proc/mounts is deceiving you.

Al: what is the intended behaviour of MNT_DETACH wrt. /proc/mounts?

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
