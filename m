Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263714AbUHBVSv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263714AbUHBVSv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 17:18:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263725AbUHBVSv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 17:18:51 -0400
Received: from host4-67.pool80117.interbusiness.it ([80.117.67.4]:3735 "EHLO
	dedasys.com") by vger.kernel.org with ESMTP id S263714AbUHBVSs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 17:18:48 -0400
To: Paulo Marques <pmarques@grupopie.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] speedy boot from usb devices
References: <87fz79xk5q.fsf@dedasys.com> <410E27DC.4090009@grupopie.com>
From: davidw@dedasys.com (David N. Welton)
Date: 02 Aug 2004 23:17:00 +0200
Message-ID: <876581s0j7.fsf@dedasys.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paulo Marques <pmarques@grupopie.com> writes:

> David N. Welton wrote:

> >         Works like so: whenever a block device comes on line, it
> >         signals this fact to a wait queue, so that the init
> >         process can stop and wait for slow devices, in particular
> >         things such as USB storage devices, which are much slower
> >         than IDE devices.  The init process checks the list of
> >         available devices and compares it with the desired root
> >         device, and if there is a match, proceeds with the
> >         initialization process, secure in the knowledge that the
> >         device in question has been brought up.  This is useful if
> >         one wants to boot quickly from a USB storage device
> >         without a trimmed-down kernel, and without going through
> >         the whole initrd slog.

> I find this to be very useful. I always found the "sleep for a while
> until the device we want appears" approach very cumbersome.

Glad to hear someone likes it.

> However, after looking at your patch, it seems that having a
> get_blkdevs() function that alloc's an array of strings, and return
> it to a function that only compares the strings against the name it
> is looking for and drops the array altogether, is a little overkill.

> Why not have a simple blkdev_exists(char *name) function in genhd.c,
> call it directly, and drop the match_root_name() function
> completely?

Sure, that's probably better.  Maybe "blkdev_is_online"?  I'll see if
I can do it tommorow.

I'm also a bit dubious of having the wait queue floating around as a
global, but don't know the kernel well enough to find it a better
home.

Thanks!
-- 
David N. Welton
     Personal: http://www.dedasys.com/davidw/
Free Software: http://www.dedasys.com/freesoftware/
   Apache Tcl: http://tcl.apache.org/
       Photos: http://www.dedasys.com/photos/
