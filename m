Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263517AbTJaSrx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Oct 2003 13:47:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263518AbTJaSrx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Oct 2003 13:47:53 -0500
Received: from [213.78.161.178] ([213.78.161.178]:8065 "HELO stockwith.co.uk")
	by vger.kernel.org with SMTP id S263517AbTJaSrw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Oct 2003 13:47:52 -0500
From: Chris Lingard <chris@ukpost.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: initrd help -- umounts root after pivot_root
Date: Fri, 31 Oct 2003 18:47:47 +0000
User-Agent: KMail/1.5.2
References: <Pine.A32.3.91.1031030191344.46426A@student.ccbc.cc.md.us>
In-Reply-To: <Pine.A32.3.91.1031030191344.46426A@student.ccbc.cc.md.us>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310311847.47920.chris@ukpost.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 31 October 2003 12:18 am, John R Moser wrote:
> Been trying with 2.4.20, 2.4.22, 2.6.0-test9, how the heck do I get this
> to work?
> I set everthing up on /dev/shm type tmpfs, then
> cd /dev/shm
> mkdir initrd
> pivot_root . initrd

Might be better to do something like:

mount -t devfs  none  /dev
mount -t proc none /proc
mkdir  -p  ram
mount -t tmpfs tmpfs /ram
cd /ram
mkdir proc  cdrom
mount  -t proc  none /ram/proc
/mount_cdrom

This is the start of my linuxrc script and creates the future root at /ram

> Of course, the kernel unmounts / and then swears that it can't find init
> when the linuxrc exits.
>
> The documentation says that linuxrc should pivot_root to the real root in
> Documentation/initrd.txt so I thought that's what the script sholud do.
> Apparently the doc is bad/old.

man pivot_root

mkdir initrd
sbin/pivot_root  .  initrd
mount devfs -t devfs /dev
exec /usr/sbin/chroot . /sbin/init  <dev/console >dev/console 2>&1

(These is no automatic call to /sbin/init)

The documentation is bad insofar as root=/dev/rd/0 now fails

Also you will need to search for a patch to umount your old /initrd.  Please
feel free you email me direct for a very unofficial patch to linux-2.4.22

Chris Lingard
