Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131258AbRAIT3t>; Tue, 9 Jan 2001 14:29:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131657AbRAIT3k>; Tue, 9 Jan 2001 14:29:40 -0500
Received: from mons.uio.no ([129.240.130.14]:57774 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S131258AbRAIT3Z>;
	Tue, 9 Jan 2001 14:29:25 -0500
To: Daniel Phillips <phillips@innominate.de>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: Subtle MM bug
In-Reply-To: <dnbstgewoj.fsf@magla.iskon.hr> <Pine.LNX.4.10.10101091041150.2070-100000@penguin.transmeta.com> <3A5B61F7.FB0E79C1@innominate.de>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 09 Jan 2001 20:29:02 +0100
In-Reply-To: Daniel Phillips's message of "Tue, 09 Jan 2001 20:09:43 +0100"
Message-ID: <shsvgror0ch.fsf@charged.uio.no>
X-Mailer: Gnus v5.6.45/XEmacs 21.1 - "Channel Islands"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Daniel Phillips <phillips@innominate.de> writes:

     > Linus Torvalds wrote:
    >> (This is why I worked so hard at getting the PageDirty
    >> semantics right in the last two months or so - and why I
    >> released 2.4.0 when I did. Getting PageDirty right was the big
    >> step to make all of the VM stuff possible in the first
    >> place. Even if it probably looked a bit foolhardy to change the
    >> semantics of "writepage()" quite radically just before 2.4 was
    >> released).

     > On the topic of writepage, it's not symmetric with readpage at
     > the moment - it still takes (struct file *).  Is this in the
     > cleanup pipeline?  It looks like nfs_readpage already ignores
     > the struct file *, but maybe some other net filesystems are
     > still depending on it.

NO! We definitely want to pass the struct file down to nfs_readpage()
when it's available.

Al has mentioned that he wants us to move towards a *BSD-like system
of credentials (i.e. struct ucred) that could be used here, but that's
in the far future. In the meantime, we cache RPC credentials in the
struct file...

Cheers,
  Trond
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
