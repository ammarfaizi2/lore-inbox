Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313412AbSDGRx2>; Sun, 7 Apr 2002 13:53:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313413AbSDGRx1>; Sun, 7 Apr 2002 13:53:27 -0400
Received: from ausxc10.us.dell.com ([143.166.98.229]:27665 "EHLO
	ausxc10.us.dell.com") by vger.kernel.org with ESMTP
	id <S313412AbSDGRxZ>; Sun, 7 Apr 2002 13:53:25 -0400
Message-ID: <71714C04806CD51193520090272892170452B5C0@ausxmrr502.us.dell.com>
From: Matt_Domsch@Dell.com
To: kaos@ocs.com.au, rmk@arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: RE: 2.4.19-pre6 dead Makefile entries
Date: Sun, 7 Apr 2002 12:52:50 -0500 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >On Sun, Apr 07, 2002 at 09:01:39PM +1000, Keith Owens wrote:
> >> lib/Makefile                    crc32.o
> >
> >crc32.c seems to exist in linux/lib/ in 2.5.7 and 2.5.8-pre2
> 
> But not in 2.4.19-pre6.  Given an object which has no source, it could
> be dead, a typing error or a placeholder for future work.  There is no
> way to tell which, most are dead entries.
> 
> I don't object to placeholder entries ("will be back ported from 2.5
> one day" or "is only used in ia64") as long as they are commented out
> until the source also exists.  In this case, crc32 is 
> required for ia64
> on 2.4 kernels and we have a broken merge.  The Makefile was updated
> from the ia64 patch but the source was not.  In 2.5 everybody uses
> crc32.  Best fix is to delete crc32 from 2.4 Makefiles and add it only
> in the ia64 patch.

Per Jeff Garzik's request, 2.4.19-pre2 included the 2.4 kernel crc32
cleanups, which did not add a lib/crc32.c, but made the crc32 functions
static inline in include/linux/crc32.h.

Until this past week, the 2.4.x IA-64 port patch was adding
lib/{crc32.c,Makefile}.  I provided David Mosberger (and he has since
merged) a new patch for fs/partitions/efi.[ch] which has essentially the 2.5
crc32 code in there, and no longer touches include/linux/crc32.h or
lib/crc32.c.  In that patch I neglected to delete lib/crc32.c and remove
stuff from lib/Makefile for it, though I did tell David that he could delete
lib/crc32.c and include/linux/crc32.h from his patch entirely.

For now in 2.4.x, please simply remove the crc32 lines from lib/Makefile.
IA-64 doesn't need them anymore.
At some point, if someone wants to backport the 2.5.x crc32 library code,
that'd be fine by me.  Marcelo didn't want any changes that could cause
instability in 2.4.x, so that's the way it's been done.

Thanks,
Matt

-- 
Matt Domsch
Sr. Software Engineer
Dell Linux Solutions www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
#1 US Linux Server provider for 2001! (IDC Mar 2002)
