Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287616AbSBCTK3>; Sun, 3 Feb 2002 14:10:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287633AbSBCTKT>; Sun, 3 Feb 2002 14:10:19 -0500
Received: from relay1.pair.com ([209.68.1.20]:16 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id <S287616AbSBCTKF>;
	Sun, 3 Feb 2002 14:10:05 -0500
X-pair-Authenticated: 24.126.75.99
Message-ID: <3C5D8C79.4C0792C5@kegel.com>
Date: Sun, 03 Feb 2002 11:16:09 -0800
From: Dan Kegel <dank@kegel.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Arjen Wolfs <arjen@euro.net>
CC: coder-com@undernet.org, feedback@distributopia.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [Coder-Com] Re: PROBLEM: high system usage / poor SMPnetwork 
 performance
In-Reply-To: <3C56E327.69F8B70F@kegel.com>
	 <001901c1a900$e2bc7420$0201010a@frodo>
	 <3C58D50B.FD44524F@kegel.com>
	 <001d01c1aa8e$2e067e60$0201010a@frodo> <5.1.0.14.2.20020203173247.02c946e8@pop.euronet.nl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjen Wolfs wrote:
> The ircu version that supports kqueue and /dev/poll is currently being
> beta-tested on a few servers on the Undernet. The graph at
> http://www.break.net/ircu10-to-11.png shows the load average (multiplied by
> 100) on a on a server with 3000-4000 clients using poll(), and /dev/poll.
> The difference is obviously quite dramatic, and the same effect is being
> seen with kqueue. You could also try some of the /dev/poll patches for
> linux, which migth save you writing a new engine. Note that ircu 2.10.11 is
> still beta though, and is known to crash in mysterious ways from time to time.

None of the original /dev/poll patches for Linux were much
good, I seem to recall; they had scaling problems and bugs.

The /dev/epoll patch is good, but the interface is different enough
from /dev/poll that ircd would need a new engine_epoll.c anyway.
(It would look like a cross between engine_devpoll.c and engine_rtsig.c,
as it would need to be notified by os_linux.c of any EWOULDBLOCK return values.
Both rtsigs and /dev/epoll only provide 'I just became ready' notification, 
but no 'I'm not ready anymore' notification.)

And then there's /dev/yapoll (http://www.distributopia.com), which
I haven't tried yet (I don't think the author ever published the patch?).

Anyway, the new engine wouldn't be too hard to write, and
would let irc run fast without a patched kernel.

- Dan
