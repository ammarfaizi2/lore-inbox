Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130192AbRAKT5s>; Thu, 11 Jan 2001 14:57:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131576AbRAKT5i>; Thu, 11 Jan 2001 14:57:38 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:23763 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S130192AbRAKT5c>;
	Thu, 11 Jan 2001 14:57:32 -0500
Date: Thu, 11 Jan 2001 14:57:30 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: "Stephen C. Tweedie" <sct@redhat.com>
cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Andi Kleen <ak@suse.de>,
        Daniel Phillips <phillips@innominate.de>, linux-kernel@vger.kernel.org
Subject: Re: Subtle MM bug
In-Reply-To: <20010111194753.P25375@redhat.com>
Message-ID: <Pine.GSO.4.21.0101111452070.17363-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 11 Jan 2001, Stephen C. Tweedie wrote:

> > And how is that different from the current situation?
> 
> It's not, which is the point I was making: COW doesn't actually solve
> the pthreads problem.  Far better to do it in user space.

Oh, certainly. We need COW for completely unrelated reasons - suppose
you open() a file and then change your *ID. You definitely want credentials
on the opened file to stay unchanged.

Pthreads are non-issue as far as I'm concerned. I'ld rather avoid mixing
them with credentials' cache. BTW, what about *BSD implementations? Do
they change creds of all threads upon set*id(2)?

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
