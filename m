Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131397AbRASW1p>; Fri, 19 Jan 2001 17:27:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132115AbRASW1f>; Fri, 19 Jan 2001 17:27:35 -0500
Received: from fungus.teststation.com ([212.32.186.211]:18943 "EHLO
	fungus.svenskatest.se") by vger.kernel.org with ESMTP
	id <S131397AbRASW1V>; Fri, 19 Jan 2001 17:27:21 -0500
Date: Fri, 19 Jan 2001 23:27:08 +0100 (CET)
From: Urban Widmark <urban@teststation.com>
To: <linux-kernel@vger.kernel.org>
cc: Petr Vandrovec <VANDROVE@vc.cvut.cz>, Rainer Mager <rmager@vgkk.com>,
        "Scott A. Sibert" <kernel@hollins.edu>
Subject: [patch] smbfs cache rewrite for 2.4.1-pre
Message-ID: <Pine.LNX.4.30.0101192034500.30403-100000@cola.teststation.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


There have been a few reports on oopses in smbfs on 2.4 boxes with highmem
support enabled. This patch tries to fix that.

The patch replaces the smbfs dir cache code with something based on the
ncpfs code. Petr should recognize almost all of it. And the ntfs code has
contributed with new time decoding functions.


It compiles, it mounts and it hasn't crashed yet. No guarantees beyond
that. Tested on 2.4.1-pre3 and pre8, and pre8+HIGHMEM_DEBUG_MERE_MORTALS-1
(allows highmem use on non-highmem box). I have repeated crashes (hangs)
on the old cache code but not the new, so maybe it is better.

The patch is 34k. Those who want to test it or comment on it may download
it from here.
http://www.hojdpunkten.ac.se/054/samba/smbfs-2.4.1-pre3-cache.patch

There are a few things that are incomplete. The dates don't consider
timezones (I think), it should only work with win9x/NT/2k servers. And I
suspect the caching part doesn't use any of the things it caches (but I
know that some parts are disabled).

/Urban

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
