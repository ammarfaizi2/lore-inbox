Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265959AbTL3U03 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 15:26:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265961AbTL3U03
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 15:26:29 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:29598 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S265959AbTL3U00 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 15:26:26 -0500
Date: Tue, 30 Dec 2003 21:25:54 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: Karel =?iso-8859-1?Q?Kulhav=FD?= <clock@twibright.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Can't mount USB partition as root
Message-ID: <20031230202554.GB8062@louise.pinerecords.com>
References: <20031229173853.A32038@beton.cybernet.src> <Pine.LNX.4.58.0312300045070.24938@silk.corp.fedex.com> <20031229183302.B32137@beton.cybernet.src> <20031229174951.GA304@louise.pinerecords.com> <20031230101010.A14772@beton.cybernet.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20031230101010.A14772@beton.cybernet.src>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dec-30 2003, Tue, 10:10 +0100
Karel Kulhavý <clock@twibright.com> wrote:

> On Mon, Dec 29, 2003 at 06:49:51PM +0100, Tomas Szepe wrote:
> > On Dec-29 2003, Mon, 18:33 +0100
> > Karel Kulhavý <clock@twibright.com> wrote:
> > 
> > > > You'll need to load the usb modules using initrd ramdisk, then switch root
> > > > to the usb device to continue booting the system.
> > > 
> > > This is the problem #2. I am not able to remount /. "device or resource busy".
> > > How do I remount the "/"?
> > 
> > /sbin/mount -o remount,rw /
> 
> bash-2.05b# mount
> /dev/hda4 on / type xfs (rw)
> none on /dev type devfs (rw)
> none on /proc type proc (rw)
> none on /dev/pts type devpts (rw)
> /dev/hda1 on /boot type ext2 (rw,noatime)
> none on /dev/shm type tmpfs (rw)
> bash-2.05b# mount -o remount,rw /dev/sda1 /
> bash-2.05b# mount
> /dev/hda4 on / type xfs (rw)
> ^^^^^^^^^
> none on /dev type devfs (rw)
> none on /proc type proc (rw)
> none on /dev/pts type devpts (rw)
> /dev/hda1 on /boot type ext2 (rw,noatime)
> none on /dev/shm type tmpfs (rw)
> 
> bash-2.05b# mount --version
> mount: mount-2.12
> bash-2.05b# cat /proc/version
> Linux version 2.6.0 (root@oberon) (gcc version 3.3.2 20031022 (Gentoo Linux
> 3.3.2-r3, propolice)) #4 Mon Dec 29 12:20:39 MET 2003
> 
> When doing find / after that, the IDE disk goes crazy, not the USB one.
> So that mount doesn't lie and nothing is really remounted (and no
> error message issued). Is this how things are supposed to work?

As others have said, you need to either

a) patch your kernel to wait for the usb disk to be detected.
	(Your only choice w/o an initrd.)

b) modify your initrd to mount the usb disk and pivot_root(2).

-- 
Tomas Szepe <szepe@pinerecords.com>
