Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129734AbRBBUTj>; Fri, 2 Feb 2001 15:19:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129487AbRBBUT3>; Fri, 2 Feb 2001 15:19:29 -0500
Received: from chiara.elte.hu ([157.181.150.200]:32775 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S129734AbRBBUTK>;
	Fri, 2 Feb 2001 15:19:10 -0500
Date: Fri, 2 Feb 2001 21:18:26 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: <bcrl@redhat.com>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>, <linux-aio@kvack.org>,
        <kiobuf-io-devel@lists.sourceforge.net>,
        "Stephen C. Tweedie" <sct@redhat.com>
Subject: Re: 1st glance at kiobuf overhead in kernel aio vs pread vs user
 aio
In-Reply-To: <Pine.LNX.4.30.0102021317470.4628-100000@today.toronto.redhat.com>
Message-ID: <Pine.LNX.4.30.0102022101120.6394-100000@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ben,

- first of all, great patch! I've got a conceptual question: exactly how
does the AIO code prevent filesystem-related scheduling in the issuing
process' context? I'd like to use (and test) your AIO code for TUX, but i
do not see where it's guaranteed that the process that does the aio does
not block - from the patch this is not yet clear to me. (Right now TUX
uses separate 'async IO' kernel threads to avoid this problem.) Or if it's
not yet possible, what are the plans to handle this?

- another conceptual question. async IO doesnt have much use if many files
are used and open() is synchronous. (which it is right now) Thus for TUX
i've added ATOMICLOOKUP to the VFS - and 'missed' (ie. not yet
dentry-cached) VFS lookups are passed to the async IO threads as well. Do
you have any plans to add file-open() as an integral part of the async IO
framework as well?

once these issues are solved (or are they already?), i'd love to drop the
ad-hoc kernel-thread based async IO implementation of TUX and 'use the
real thing'. (which will also probably perform better) [Btw., context
switches are not that much of an issue in kernel-space, due to lazy TLB
switching. So basically in kernel-space the async IO threads are barely
more than a function call.]

	Ingo

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
