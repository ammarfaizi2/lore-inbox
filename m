Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263564AbUEDF7O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263564AbUEDF7O (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 01:59:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264240AbUEDF7O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 01:59:14 -0400
Received: from tantale.fifi.org ([216.27.190.146]:39043 "EHLO tantale.fifi.org")
	by vger.kernel.org with ESMTP id S263564AbUEDF7K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 01:59:10 -0400
To: Linus Torvalds <torvalds@osdl.org>
Cc: Albert Cahalan <albert@users.sourceforge.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton OSDL <akpm@osdl.org>
Subject: Re: errno
References: <1083634011.952.154.camel@cube>
	<Pine.LNX.4.58.0405032111450.1636@ppc970.osdl.org>
Mail-Copies-To: nobody
From: Philippe Troin <phil@fifi.org>
Date: 03 May 2004 22:58:56 -0700
In-Reply-To: <Pine.LNX.4.58.0405032111450.1636@ppc970.osdl.org>
Message-ID: <87r7u0g2cf.fsf@electrolyt.fifi.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> On Mon, 3 May 2004, Albert Cahalan wrote:
> > 
> > The obvious fix would be to stuff errno into the
> > task_struct, hmmm?
> 
> No. "errno" is one of those fundamentally broken things that should not 
> exist. It was wrogn in original UNIX, it's wrong now.
> 
> The kernel usage comes not from the kernel wanting to use it per se (the 
> kernel has always used the "negative error" approach), but from some 
> misguided kernel modules using the user-space interfaces.
> 
> The Linux way of returning negative error numbers is much nicer. It's
> inherently thread-safe, and it has no performance downsides. Of course, it
> does depend on having enough of a result domain that you can always
> separate error returns from good returns, but that's true in practice for
> all system calls.

Except of course for fcntl(fd, F_GETOWN) where the owner is a
(negative) process group... If the owning process group has a "low
enough" PGID, it collides with errors and glibc reports an error and
sets errno to -PGID. One might argue that in this instance, that the
BSD's overloading of the pid field with pgids is at fault, but the bug
still remains :-)

Phil.
