Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132479AbRAZSzD>; Fri, 26 Jan 2001 13:55:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136337AbRAZSyx>; Fri, 26 Jan 2001 13:54:53 -0500
Received: from adsl-209-182-168-213.value.net ([209.182.168.213]:11781 "EHLO
	draco.foogod.com") by vger.kernel.org with ESMTP id <S132479AbRAZSyl>;
	Fri, 26 Jan 2001 13:54:41 -0500
Date: Fri, 26 Jan 2001 10:54:36 -0800
From: alex@foogod.com
To: Paul Powell <moloch16@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Undoing chroot?
Message-ID: <20010126105436.C4321@draco.foogod.com>
In-Reply-To: <20010126183140.17534.qmail@web112.yahoomail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <20010126183140.17534.qmail@web112.yahoomail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 26, 2001 at 10:31:40AM -0800, Paul Powell wrote:
> I have a linux bootable CD which executes a custom
> init.  The job of init is to figure out on which
> device the CD is located.  After finding the CD, init
> mounts the device and executes a CHROOT to set the
> root directory to the CD.
> 
> After I'm done I'd like to umount the CD and then
> eject it by sending an IOCTL eject command.  But since
> I executed a CHROOT I can't umount the CD, umount
> complains that the device is busy.
> 
> So how do you reverse a CHROOT?

By definition, a chroot() is not undoable.  There are strong security reasons 
for this (chroot() is often used to create protected "jails" for untrusted 
code.  If the code could just undo the chroot() it wouldn't be very useful).  
However, chroot() is per-process, therefore what you probably want to do is 
fork(), then do a chroot() in the child and do whatever you want to do there, 
when you're done with the CD, exit the child, and have the parent eject it.

-alex
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
