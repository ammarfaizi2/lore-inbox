Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262901AbTLWVuz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 16:50:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262902AbTLWVuz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 16:50:55 -0500
Received: from amber.ccs.neu.edu ([129.10.116.51]:18423 "EHLO
	amber.ccs.neu.edu") by vger.kernel.org with ESMTP id S262901AbTLWVut
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 16:50:49 -0500
Subject: Re: DEVFS is very good compared to UDEV
From: Stan Bubrouski <stan@ccs.neu.edu>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <sfe8cdc2.027@mail2.edu.stadia.fi>
References: <sfe8cdc2.027@mail2.edu.stadia.fi>
Content-Type: text/plain; charset=
Message-Id: <1072216246.2947.103.camel@duergar>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 23 Dec 2003 16:50:48 -0500
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-12-23 at 16:20, Jari Soderholm wrote:
> Hello !
> 
> I am quite advanced Linux user who has used DEVFS quite
> long time, and have also been a little suprised that it
> has been marked OBSOLETE in 2.6 kernel.
> 

If you were such an advanced Linux user you'd read this list or at least
search it to understand the problems.  DevFS may have seemed fine to
you, but the code is nasty and full of races.  It's overly complicated
and the problems it exhibits were determined to not be easily fixable
and not worth the time.  DevFS never really took off and it was under
development for a good part of 4 years.  Richard Gooch did an admirable
job trying to come up with a new solution to the old /dev situation, but
frankly a new approach was needed, and he himself recognized this and
abandoned devfs.

> I think that there are plenty good arguments why in many
> cases it is technically better solution than udev, and
> I like to give my view on that.
> 

How do you know this?  Have you looked at the code to both?  You can't
be telling me you've looked at the devfs code and think its superior in
any way to other pitiful hacks in the kernel.  Come on now.  And UDEV
and libsysfs are works in progress, and I must say they've come a long
way in a very short time.  Kudos to Greg and others BTW.

> DEVFS is a really simple to use, compile it into kernel and configure the programs to use DEVFS filenames and thats it.
> 

Userspace can adapt to a different solution.

> I think that it is very good that devicename files are out from the disk, one cannot delete those files, disk
> errors do not affect the, and searching device files is faster.
> 

UDEV is currently slow right now while some libsysfs changes are being
made IIRC.  Not a very apt comparison.

> Booting kernel is faster compared to UDEV.
> 

See above.

> And DEVFS has worked for years for me at least very well, I haven't had any problems with it.
> 

Consider yourself lucky.

> I do not understand some opinions that DEVFS uses memory.
> Compared to the size of applications people run in linux
> , the memory what kernel with DEVFS takes is practically
> nonexistent.
> I think that files in SYSFS-directory (needed by UDEV) probably take more memory than those in DEVFS-dir.
> 

How on earth do you figure this?  The /sys directory is links to things
that are already in memory, it is just providing a way to access those
structures and information, think procfs.

> UDEV otherwise is very complex for average user and it
> is definetly much slower , it has much greater chance
> for errors because very complicated scrips which seem 
> to need many different gnu commandline utilities.
> 

It's still young and will be better as time passes.  At least UDEV isn't
going to take 4 years and come out with crap.

> It is quite funny that when DEVFS creates device files
> automagically and in the ram-memory, some people want
> to go backwards, and use shell scripts to 
> create those files on hard disk, and then it is technically better solution.
> 

Honestly I'm trying to sound insulting here, but consider the fact that
only a couple of people are currently working on UDEV, and yeah some
things are hacked together right now.  And remember init is mostly shell
scripts, I don't see how this is so inferior.

> If one you look at the /sysfs-directory there are
> device filenames, (but not the actual devicefiles), so
> it does same thing that DEVFS, but actually much worce
> way, it created devicefilenames in the ram, but
> one cannot use them, because they are not devicefiles.
> 

*sigh* see above

> Why could you develop it so that UDEV could create those
> actual device files there also, then most linux
> users would not need those horrible scipts anymore.
> All that is then needed link from /sysfs to /dev dir.
> 

*sigh* read the FAQ

> In my option good operating system kernel should use disk and external programs little as possible.
> 

Here we go, IMO, I like that :)  The thing is, you need some cooperation
and balance between the kernel and userspace.  Things are shelled off to
userspace because they can be, and it also takes burden off the core
kernel functions and reduces the kernel's memory footprint.  This is
good for embedded devices too.


Ok for the sake of non-argument, keep using devfs if you want, but
remember it is obsolete, and nothing is going to change that AFICS.

Good Luck,

sb

> T Jari Söderholm
> jari.soderholm#stadia.fi
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

