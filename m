Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130552AbRC0GdW>; Tue, 27 Mar 2001 01:33:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130577AbRC0GdN>; Tue, 27 Mar 2001 01:33:13 -0500
Received: from tomts7.bellnexxia.net ([209.226.175.40]:34780 "EHLO
	tomts7-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S130552AbRC0Gc6>; Tue, 27 Mar 2001 01:32:58 -0500
Date: Tue, 27 Mar 2001 01:32:24 -0500 (EST)
From: Scott Murray <scott@spiteful.org>
To: <sl@fireplug.net>
cc: <amit@muppetlabs.com>, <linux-kernel@vger.kernel.org>
Subject: Re: question \ information request on init \ boot sequence when
 using initrd
In-Reply-To: <99p487$18m$1@whiskey.enposte.net>
Message-ID: <Pine.LNX.4.30.0103270108190.14734-100000@godzilla.spiteful.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 26 Mar 2001, Stuart Lynne wrote:

> In article <985660830.32357@whiskey.enposte.net>,
> Amit D Chaudhary <amit@muppetlabs.com> wrote:
[snip]
> You can run your linuxrc with:
>
> 	init=/linuxrc

Yes.

> and then end your /linuxrc with:
>
> 	exec /sbin/init

No.  He's doing a pivot_root to a new root filesystem.  You have
to do the 'exec chroot . /sbin/init ...' command given in the file
Documentation/initrd.txt in order for init to start up correctly.

Having played with pivoting to a ramfs out of an initrd for the
last several days, I can think of a couple of possible problems.
The first is that Amit's final linuxrc command:

>exec sbin/chroot . sbin/init.new 3 <dev/console >dev/console 2>&1

is different from what's described in initrd.txt.  I'm using the
exact line that's in there in my linuxrc, and it works fine.
Amit, try changing that line to:

exec chroot . /sbin/init.new 3 <dev/console >dev/console 2>&1

and see if that works.  This does require having chroot in your
initrd, but that is mentioned in initrd.txt as a requirement
anyways.  If init.new is the wrapper that I think was mentioned
here previously, I'd suggest just trying a regular init and doing
the umount and free of the ramdisk later somewhere in your
rc.sysinit or equivalent.

The second potential problem I can think of would be a missing
dev/console node in the new root filesystem.  I think I experienced
a similar failure mode once last Friday; it may have been the time
I forgot to mount devfs on /dev in my new root filesystem.

Scott


--
=============================================================================
Scott Murray                                        email: scott@spiteful.org
http://www.spiteful.org (coming soon)                 ICQ: 10602428
-----------------------------------------------------------------------------
     "Good, bad ... I'm the guy with the gun." - Ash, "Army of Darkness"

