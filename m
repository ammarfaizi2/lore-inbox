Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133099AbQLOA2I>; Thu, 14 Dec 2000 19:28:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133086AbQLOA1x>; Thu, 14 Dec 2000 19:27:53 -0500
Received: from sgi.SGI.COM ([192.48.153.1]:15656 "EHLO sgi.com")
	by vger.kernel.org with ESMTP id <S132669AbQLOA1i>;
	Thu, 14 Dec 2000 19:27:38 -0500
From: "LA Walsh" <law@sgi.com>
To: "lkml" <linux-kernel@vger.kernel.org>
Subject: Linus's include file strategy redux
Date: Thu, 14 Dec 2000 15:55:32 -0800
Message-ID: <NBBBJGOOMDFADJDGDCPHIENJCJAA.law@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So, I brought up the idea of a linux/sys for kernel level include files.

A few other people came up with a desire of a 'kernel' dir under
include, parallel w/linux.


So I ran into a snag with that scenario.  Let's suppose we have
a module developer or a company developing a driver in their own
/home/nvidia/video/drivers/newcard directory.  Now they need to include
kernel
development files and are used to just doing the:
#include <linux/blahblah.h>

Which works because in a normal compile environment they have /usr/include
in their include path and /usr/include/linux points to the directory
under /usr/src/linux/include.

So if we create a separate /usr/src/linux/include/kernel dir, does that
imply that we'll have a 2nd link:

/usr/include/kernel ==> /usr/src/linux/include/kernel  ?

If the idea was to 'hide' kernel interfaces and make them not 'easy'
to include doesn't providing a 2nd link defeat that?

If we don't provide a 2nd link, how do module writers access kernel
includes?

If the kernel directory is under 'linux' (as in linux/sys), then the
link is already there and we can just say 'don't use sys in apps'.  If
we create 'kernel' under 'include', it seems we'll still end up having to
tell users "don't include files under directory "x"' (either kernel/ or
linux/sys/)

Note that putting kernel as a new directory parallel to linux requires
adding another symlink -- so is that solving anything or adding more
administrative "gotcha's"?

-linda

--
L A Walsh                        | Trust Technology, Core Linux, SGI
law@sgi.com                      | Voice/Vmail: (650) 933-5338

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
