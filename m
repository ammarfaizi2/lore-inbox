Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135723AbREDBzQ>; Thu, 3 May 2001 21:55:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135738AbREDBzG>; Thu, 3 May 2001 21:55:06 -0400
Received: from chromium11.wia.com ([207.66.214.139]:26894 "EHLO
	neptune.kirkland.local") by vger.kernel.org with ESMTP
	id <S135723AbREDBzD>; Thu, 3 May 2001 21:55:03 -0400
Message-ID: <3AF20CE3.63C92B3C@chromium.com>
Date: Thu, 03 May 2001 18:58:59 -0700
From: Fabio Riccardi <fabio@chromium.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: mingo@elte.hu
CC: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Christopher Smith <x@xman.org>, Andrew Morton <andrewm@uow.edu.au>,
        "Timothy D. Witham" <wookie@osdlab.org>, David_J_Morse@Dell.com
Subject: Re: X15 alpha release: as fast as TUX but in user space
In-Reply-To: <Pine.LNX.4.33.0105011906420.2202-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have fixed the stale header cache problem. Files are statted on every
request, no "practical" tricks.

Performance doesn't seem to have suffered :)

I also have added a cache garbage collector to close "old" file descriptors
and remove even older header cache entries. This should make sure that you
don't exceed your system resources. The definition of old and the sweep
frequency are user configurable.

You can download the new version
from: http://www.chromium.com/X15-Alpha-3.tgz

 - Fabio

Ingo Molnar wrote:

> On Tue, 1 May 2001, Fabio Riccardi wrote:
>
> > This is actually a bug in the current X15, I know how to fix it (with
> > negligible overhead) but I've been lazy :)
>
> yep, i think it's pretty straightforward: you have a cache of open file
> descriptors (like Squid i think), and you can start a background 'cache
> synchronization thread' that does a stat() on every open file's real VFS
> path, every second or so. This should have small overhead (the number of
> file descriptors cached should be limited anyway via some sort of LRU),
> and guarantees 'practical coherency', without having the overhead of
> immediate coherency. [total coherency is pointless anyway, not even the
> kernel guarantees it to all parallel VFS users.]
>
>         Ingo

