Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310789AbSCLMUl>; Tue, 12 Mar 2002 07:20:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310788AbSCLMUb>; Tue, 12 Mar 2002 07:20:31 -0500
Received: from pc-62-31-92-140-az.blueyonder.co.uk ([62.31.92.140]:52912 "EHLO
	kushida.apsleyroad.org") by vger.kernel.org with ESMTP
	id <S310789AbSCLMUR>; Tue, 12 Mar 2002 07:20:17 -0500
Date: Tue, 12 Mar 2002 12:19:37 +0000
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Oskar Liljeblad <oskar@osk.mine.nu>, linux-kernel@vger.kernel.org
Subject: Re: directory notifications lost after fork?
Message-ID: <20020312121937.A4281@kushida.apsleyroad.org>
In-Reply-To: <20020310210802.GA1695@oskar> <20020311084154.C4573@riesen-pc.gr05.synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020311084154.C4573@riesen-pc.gr05.synopsys.com>; from Alexander.Riesen@synopsys.com on Mon, Mar 11, 2002 at 08:41:54AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Riesen wrote:
> Just a "me too".
> I have tried also to use the default (SIGIO) by setting owner pid (just
> in case). It is all the same.
> Does someone use the notifications, btw?
> The whole thing seems somewhat untested.

I don't yet, but I am planning to use them for an ultra-high-performance
dynamic web server and make-like tool.

The idea is that a dynamic page's cache validity (or the validity of a
subrequest) may depend on a large number of stat() results.

Dnotify can be used, as I understand it, to avoid having to actually do
the stat() calls on each request.

In this way, cached dynamic pages can be served as quickly as static
pages, right down to using the minimum set of system calls.

At the same time, dynamic pages are served perfectly _as if_ they are
recalculated every time from their prerequisite files, including: script
code (Perl, PHP etc.), included files, templates, images, database
files.  So with things like setting the width and height of each IMG tag
from scanning the image files, and complex templates such as navigation
bars that you currently remake by hand using "make" -- these things
immediately update as you modify the site's source files.

It makes a pretty nice document editing environment too -- save file
from Emacs, immediately view formatted file in web browser :-)

I can do this at the moment, but with a number of stat() calls on each
request.  With dnotify I think I can eliminate those but I haven't got
that far yet.

If dnotify is too buggy as stands then for this project I'd very much
like it to be fixed.  Loss of notifications after fork() sounds like a
rather serious bug :-/

cheers,
-- Jamie

