Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130090AbRAPMsc>; Tue, 16 Jan 2001 07:48:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129868AbRAPMsW>; Tue, 16 Jan 2001 07:48:22 -0500
Received: from felix.convergence.de ([212.84.236.131]:42762 "EHLO
	convergence.de") by vger.kernel.org with ESMTP id <S129675AbRAPMsG>;
	Tue, 16 Jan 2001 07:48:06 -0500
Date: Tue, 16 Jan 2001 13:47:37 +0100
From: Felix von Leitner <leitner@convergence.de>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Is sendfile all that sexy?
Message-ID: <20010116134737.A29366@convergence.de>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20010116114018.A28720@convergence.de> <Pine.LNX.4.30.0101161338270.947-100000@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <Pine.LNX.4.30.0101161338270.947-100000@elte.hu>; from mingo@elte.hu on Tue, Jan 16, 2001 at 01:42:37PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thus spake Ingo Molnar (mingo@elte.hu):
> > I don't know how Linux does it, but returning the first free file
> > descriptor can be implemented as O(1) operation.
> to put it more accurately: the requirement is to be able to open(), use
> and close() an unlimited number of file descriptors with O(1) overhead,
> under any allocation pattern, with only RAM limiting the number of files.
> Both of my proposals attempt to provide this. It's possible to open() O(1)
> but do a O(log(N)) close(), but that is of no practical value IMO.

I cheated.  I was only talking about open().
close() is of course more expensive then.

Other than that: where does the requirement come from?
Can't we just use a free list where we prepend closed fds and always use
the first one on open()?  That would even increase spatial locality and
be good for the CPU caches.

Felix
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
