Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265792AbSKAWTi>; Fri, 1 Nov 2002 17:19:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265795AbSKAWTi>; Fri, 1 Nov 2002 17:19:38 -0500
Received: from almesberger.net ([63.105.73.239]:37128 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id <S265792AbSKAWTg>; Fri, 1 Nov 2002 17:19:36 -0500
Date: Fri, 1 Nov 2002 19:25:45 -0300
From: Werner Almesberger <wa@almesberger.net>
To: David Lang <david.lang@digitalinsight.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lkcd-general@lists.sourceforge.net, lkcd-devel@lists.sourceforge.net
Subject: Re: What's left over.
Message-ID: <20021101192545.F2599@almesberger.net>
References: <Pine.LNX.4.44.0211011107470.4673-100000@penguin.transmeta.com> <Pine.LNX.4.44.0211011218560.26353-100000@dlang.diginsite.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0211011218560.26353-100000@dlang.diginsite.com>; from david.lang@digitalinsight.com on Fri, Nov 01, 2002 at 12:21:35PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ Cc: trimmed ]

David Lang wrote:
> One question I have is how much of the driver problem you refer to is
> becouse of optimizations that the various drivers have, could you fall
> back to the simplest, works-with-everything,
> all-timeouts-longer-then-the-slowest-disk slug of a driver that could be
> used to do this dump?

Welcome to the wonderful world of code duplication. And don't forget
the "simplified" TCP/IP stack for network dumps. Uh, USB-attached
storage, anyone ? :-)

Special-case dump drivers make perfect sense in isolated cases (e.g.
narrowly specified boxes) or as a band-aid solution.

But for a general solution, it seems more appropriate to me to solve
the problem of moving the kernel data from the damaged system to an
intact system only once, e.g. using the MCORE approach, than over
and over again for all possible types of hardware and attachment
methods.

The only inherent weakness I see in MCORE is the need to reliably
reset a device, either to the point where it is operational (if
used in the process of dumping), or at least to the point where it
doesn't get in the way (if not used for the dump, e.g. video, HID,
etc.).

But this should still be significantly easier than introducing
"dumb" versions for all drivers. Besides, having a way for cleanly
shutting down or resetting devices is desirable in other contexts,
too (e.g. kexec).

- Werner (disclaimer: not affiliated with Mission Critical Linux,
	 any vendor, or any other form of gainful employment)

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
