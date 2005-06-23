Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262786AbVFWVhD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262786AbVFWVhD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 17:37:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262820AbVFWV3T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 17:29:19 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:35790 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262744AbVFWVWc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 17:22:32 -0400
Date: Thu, 23 Jun 2005 22:23:52 +0100
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: cspalletta@adelphia.net
Cc: linux-kernel@vger.kernel.org, mikew@google.com
Subject: Re: namespace question
Message-ID: <20050623212352.GO29811@parcelfarce.linux.theplanet.co.uk>
References: <5353647.1119551462209.JavaMail.root@web1.mail.adelphia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5353647.1119551462209.JavaMail.root@web1.mail.adelphia.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 23, 2005 at 02:31:02PM -0400, cspalletta@adelphia.net wrote:
> > > Running a kernel module using dpath iteratively on the mnt_mountpoint member ... I get a curious doubling of the mount point names:
> 
> >> proc /proc/proc proc
> >> sysfs /sys/sys sysfs
> >>  devpts /dev/pts/dev/pts devpts
> >>  tmpfs /dev/shm/dev/shm tmpfs
> >> /dev/hda1 /boot/boot ext2
> >> usbfs /proc/bus/usb/bus/usb usbfs
> 
> >  Using the same algorithm with mnt_root produces correct results.  
> 
> > >                 dentry = dget(vfsmnt_ptr->mnt_mountpoint);
> > 
> > should be:
> > 
> > dentry = dget(vfsmnt_ptr->mnt_root);
> 
> Yes I pointed that out above - what I want to know is why the doubling of the names for mnt_mntpoint.  It must be used for something, I suppose.

You are passing d_path() inconsistent arguments and get BS result.
Garbage in, garbage out...
