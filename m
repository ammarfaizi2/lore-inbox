Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131949AbRDPSte>; Mon, 16 Apr 2001 14:49:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131953AbRDPStY>; Mon, 16 Apr 2001 14:49:24 -0400
Received: from ppp58-133-59-62.rtm.zonnet.nl ([62.59.133.58]:53134 "HELO
	lyta.coker.com.au") by vger.kernel.org with SMTP id <S131949AbRDPStV> convert rfc822-to-8bit;
	Mon, 16 Apr 2001 14:49:21 -0400
Content-Type: text/plain; charset=US-ASCII
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: linas@backlot.linas.org (Linas Vepstas), linux-kernel@vger.kernel.org,
        almesber@lrc.epfl.ch, johninsd@san.rr.com
Subject: Re: lilo + raid + kernel-2.4.x failure to boot
Date: Mon, 16 Apr 2001 17:40:02 +0200
X-Mailer: KMail [version 1.2]
In-Reply-To: <20010415234706.A865@backlot.linas.org>
In-Reply-To: <20010415234706.A865@backlot.linas.org>
MIME-Version: 1.0
Message-Id: <01041617400202.18452@lyta>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 16 April 2001 06:47, Linas Vepstas wrote:
> I am running kernel-2.4.x.  Two ide hard drives, with partitions 1,5,6,7,8
> in use. The partitions on the two drives are mirrored using RAID-1 to
> create /dev/md1, /dev/md5, /dev/md6, etc.  The root fs is on /dev/md1. 

What partitions are used to make /dev/md1?

> Thus, lilo.conf looks like:
>
>
> boot=/dev/md1

All my use of lilo and RAID is with boot=/dev/hda.
I guess the above should work if the system is setup to look for a boot 
record on /dev/hda1 (or whichever is the name of a part of the RAID-1 mirror) 
by having it marked active and having the Debian MBR, the DOS "fdisk /mbr" or 
something similar.  But why would you want to?  Is the aim of this to enable 
swapping /dev/hda and /dev/hdc (or whichever drives comprise the RAID-1) 
without re-running LILO?

> % dpkg -s lilo
> Package: lilo
> Status: install ok installed
> Priority: important
> Section: base
> Installed-Size: 271
> Maintainer: Russell Coker <russell@coker.com.au>
> Version: 1:21.7-3
> Depends: libc6 (>= 2.2.1-2), debconf (>= 0.2.26), logrotate
>
> The debian version of lilo writes a boot sector that hangs hard for the
> above kernel+raid+lilo.conf configuration: specifically:
>
> LIL-     after a reboot.   Needless to say, recovery was painful.  But I
> was able to verify that the redhat lilo rpm always functioned correctly,
> and the debian-unstable dpkg always hung in this way.  Although at one
> point, during my twisting & turning, I got the debian lilo to get to only
> LI  before hanging.  I have no idea of what I did different to get to that
> as opposed to LIL-

>From Manual.txt.gz:
   LI   The first stage boot loader was able to load the second stage boot
    loader, but has failed to execute it. This can either be caused by a
    geometry mismatch or by moving /boot/boot.b without running the map
    installer.
   LIL-   The descriptor table is corrupt. This can either be caused by a
    geometry mismatch or by moving /boot/map without running the map
    installer.

The error "LI" is easy to cause.  Just do mv /boot/boot.b.backup /boot/boot.b 
...

As for "LIL-".  Are you sure that everything is fine with your geometry?  
Maybe your BIOS and the kernel have different ideas about how things are 
supposed to be?  I imagine that you installed a newer kernel etc at the time 
of your upgrade from Red Hat to Debian so this could be a partial cause.

> BTW, I noticed that oddly, every time I ran lilo, and then ran lilo -q -v
> -v, it reported different sector numbers for the kernel images.  This
> freaked me out at first, but I came to accept it as normal: doesn't affect
> bootability.  But is this really w.a.d?  (I was assuming, appearently
> erroneously, that lilo -q -v -v was reporting the physical location of the
> kernel image on the disk; but since the numbers bounce around, that can't
> be right. Or is this just weird bios head/cyl/sect math flakiness?)

I'll leave that for John to answer.

-- 
http://www.coker.com.au/bonnie++/     Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/       Postal SMTP/POP benchmark
http://www.coker.com.au/projects.html Projects I am working on
http://www.coker.com.au/~russell/     My home page
