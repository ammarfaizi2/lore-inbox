Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265305AbSLBHJl>; Mon, 2 Dec 2002 02:09:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265333AbSLBHJl>; Mon, 2 Dec 2002 02:09:41 -0500
Received: from packet.digeo.com ([12.110.80.53]:15748 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S265305AbSLBHJk>;
	Mon, 2 Dec 2002 02:09:40 -0500
Message-ID: <3DEB08EE.CBA49BA@digeo.com>
Date: Sun, 01 Dec 2002 23:17:02 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Nick Piggin <piggin@cyberone.com.au>
CC: lkml <linux-kernel@vger.kernel.org>,
       "ext3-users@redhat.com" <ext3-users@redhat.com>
Subject: Re: data corrupting bug in 2.4.20 ext3, data=journal
References: <3DE9C43D.61FF79C5@digeo.com> <3DEA0374.2040306@cyberone.com.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 02 Dec 2002 07:17:02.0671 (UTC) FILETIME=[CFB4CDF0:01C299D2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
> 
> Andrew Morton wrote:
> 
> >In 2.4.20-pre5 an optimisation was made to the ext3 fsync function
> >which can very easily cause file data corruption at unmount time.  This
> >was first reported by Nick Piggin on November 29th (one day after 2.4.20 was
> >released, and three months after the bug was merged.  Unfortunate timing)
> >
> In fact it was reported on lkml on 18th July IIRC before 2.4.19 was
> released if that is any help to you. 2.4.19 and 2.4.20 are affected
> and I haven't tested previous releases. I was going to re-report it
> sometime, but Alan brought it to light just the other day.
> 

Are you sure?  I can't make it happen on 2.4.19.  And disabling the new
BH_Freed logic (which went into 2.4.20-pre5) makes it go away.


--- linux-akpm/fs/jbd/commit.c~a	Sun Dec  1 23:10:12 2002
+++ linux-akpm-akpm/fs/jbd/commit.c	Sun Dec  1 23:10:27 2002
@@ -695,7 +695,7 @@ skip_commit: /* The journal should be un
 		 * use in a different page. */
 		if (__buffer_state(bh, Freed)) {
 			clear_bit(BH_Freed, &bh->b_state);
-			clear_bit(BH_JBDDirty, &bh->b_state);
+//			clear_bit(BH_JBDDirty, &bh->b_state);
 		}
 			
 		if (buffer_jdirty(bh)) {

_
