Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265143AbSKSDjZ>; Mon, 18 Nov 2002 22:39:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265171AbSKSDjZ>; Mon, 18 Nov 2002 22:39:25 -0500
Received: from mail.gmx.net ([213.165.64.20]:8587 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S265143AbSKSDjY>;
	Mon, 18 Nov 2002 22:39:24 -0500
Message-ID: <3DD9B3F8.DC291106@gmx.de>
Date: Tue, 19 Nov 2002 04:46:00 +0100
From: Edgar Toernig <froese@gmx.de>
MIME-Version: 1.0
To: Davide Libenzi <davidel@xmailserver.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [rfc] epoll interface change and glibc bits ...
References: <Pine.LNX.4.44.0211181533501.979-100000@blue1.dev.mcafeelabs.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Libenzi wrote:
> 
> http://www.xmailserver.org/linux-patches/epoll.2
> http://www.xmailserver.org/linux-patches/epoll_create.2
> http://www.xmailserver.org/linux-patches/epoll_ctl.2
> http://www.xmailserver.org/linux-patches/epoll_wait.2
> 
> it is going to change though with the latest talks about the interface.

My 2 cents:

Remove the waitqueue stuff from epoll.2.  It has meaning only to
linux kernel developers and noone else.

Please add more semantic details of the new facility.  It is new
and these man pages are the only (and normative) reference.  I.e.:

What about adding an fd twice to the epoll-set?  Do you get an
error, will it override the previous settings for that fd, will
it be ignored, or is it registered twice and you get two results
for that fd?  Can two epoll-sets wait for the same fd?  Are events
reported to both epoll-fds?

Is the epoll-fd itself poll/epoll/selectable?  Can I build cluster
of epoll-sets?  What happens if the epollfd is put into its own
fd set?  Can I send the epoll-fd over a unix-socket to another
process?

Then, please add more details of how events are generated.  You
say, that an inactive-to-active transition causes an event.  What
is the starting point of the collection?  (I guess, all transitions
between two epoll_wait calls.)  There could be a couple of transi-
tions on an fd between two epoll_wait calls.  Are these events com-
bined into a single reported event or is each single edge reported?
Does an operation on an fd effect the already collected but not yet
reported events?

About epoll_wait: it looks like a "read with timeout" call.  Is that
really necessary or wouldn't a normal read(2) work as well?  Similar
for epoll_ctl: couldn't a write(2) to the epoll-fd do the same?

That are the things that come into my mind at the moment.  I guess
there are more details I've missed...

Ciao, ET.
