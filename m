Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132632AbRADUZv>; Thu, 4 Jan 2001 15:25:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132616AbRADUZm>; Thu, 4 Jan 2001 15:25:42 -0500
Received: from mail.valinux.com ([198.186.202.175]:62735 "EHLO
	mail.valinux.com") by vger.kernel.org with ESMTP id <S133110AbRADUZX>;
	Thu, 4 Jan 2001 15:25:23 -0500
Message-ID: <3A54EABA.EB3FBF7C@valinux.com>
Date: Thu, 04 Jan 2001 14:27:22 -0700
From: Keith Whitwell <keithw@valinux.com>
X-Mailer: Mozilla 4.61 [en] (X11; I; Linux 2.2.12-20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rik Faith <faith@valinux.com>
CC: DRI Development <dri-devel@lists.sourceforge.net>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Dri-devel] DRM patch for Linux 2.4.0-prerelease
In-Reply-To: <14932.51363.118932.987520@light.alephnull.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik,

It looks like this patch goes further than syncing with xfree 4.0.2, but syncs
with the dri trunk instead.  There has been a version bump in the mga drm
module on the dri trunk to add a 'blit' ioctl.  XFree 4.0.2 will barf on this.

As a broader question:  All our version checking (in client drivers and DDX
drivers) check

	found major == expected major
	found minor == expected minor 
	found patch >= expected patch

and if they don't receive this, they refuse to play.

As I understood it, the major number is bumped on backwards-incompatible
changes, the minor number on backwards-compatible changes and the patch on all
other changes, though in practise never.

Thus, wouldn't the appropriate test be:

	found major == expected major
	found minor >= expected minor
	(no test on patch)

This seems to match the semantics of the 3 numbers better?

Keith
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
