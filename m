Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269245AbUJQSFz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269245AbUJQSFz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 14:05:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269251AbUJQSFz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 14:05:55 -0400
Received: from gate.in-addr.de ([212.8.193.158]:26319 "EHLO mx.in-addr.de")
	by vger.kernel.org with ESMTP id S269245AbUJQSFi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 14:05:38 -0400
Date: Sun, 17 Oct 2004 20:05:28 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: Buddy Lucas <buddy.lucas@gmail.com>
Cc: "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: Re: UDP recvmsg blocks after select(), 2.6 bug?
Message-ID: <20041017180528.GN7468@marowsky-bree.de>
References: <20041016062512.GA17971@mark.mielke.cc> <MDEHLPKNGKAHNMBLJOLKMEONPAAA.davids@webmaster.com> <20041017133537.GL7468@marowsky-bree.de> <5d6b657504101707175aab0fcb@mail.gmail.com> <20041017172244.GM7468@marowsky-bree.de> <5d6b657504101710542e054f53@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5d6b657504101710542e054f53@mail.gmail.com>
X-Ctuhulu: HASTUR
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2004-10-17T19:54:04, Buddy Lucas <buddy.lucas@gmail.com> wrote:

> Sigh. Read the quote to which I responded again. Not a word about
> atomicity. Nowhere does it say that a descriptor which was ready for
> reading at select() time is still readable at recvmsg() time.

That is the _whole point_ of select() on non-O_NONBLOCK sockets.

> There is no doubt that it would be very nice if select() would say
> something useful, but that's not the issue here.

According to the specs, it says something useful. It doesn't on Linux,
agreed.

> > This isn't per se the same as saying that it's not a sensible violation,
> > but very clearly the specs disagree with the current Linux behaviour.
> So document it.

That's one way of doing it, yes.

> > If the packet has been dropped in between, which _could_ have happened
> > because UDP is allowed to be dropped basically anywhere, EIO may be
> > returned. But blocking or returning EAGAIN/EWOULDBLOCK is verboten. The
> > spec is very clearly on that.
> Obviously returning EAGAIN/EWOULDBLOCK while reading from a blocking
> fd is not what we want (in the situation at hand). I don't see how it
> relates to the discussion.

Others have suggested it in this thread as a possible error code, so
that's how it relates to this discussion. Surprise ;-)

> > I'm not so sure what's so hard to accept about that. It may be well that
> > Linux is following the de-facto industry standard (or even setting it)
> > here, and I'd agree that if you don't want blocking use O_NONBLOCK, but
> > in no way can Linux claim POSIX/SuV spec compliance for this behaviour.
> It doesn't.

*sigh* According to the man pages and the Linux Standard Base it does,
and it has been claimed repeatedly in this thread too.

Please get your facts straight.


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering
SUSE Labs, Research and Development
SUSE LINUX AG - A Novell company

