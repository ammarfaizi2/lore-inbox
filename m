Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263035AbRFEA1A>; Mon, 4 Jun 2001 20:27:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263036AbRFEA0u>; Mon, 4 Jun 2001 20:26:50 -0400
Received: from lsmls02.we.mediaone.net ([24.130.1.15]:40144 "EHLO
	lsmls02.we.mediaone.net") by vger.kernel.org with ESMTP
	id <S263035AbRFEA0q>; Mon, 4 Jun 2001 20:26:46 -0400
Message-ID: <3B1C277D.6F0EF0F9@kegel.com>
Date: Mon, 04 Jun 2001 17:27:41 -0700
From: Dan Kegel <dank@kegel.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.14-5.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Pierre Phaneuf <pp@ludusdesign.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: re: disk-based fds in select/poll
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pierre Phaneuf <pp@ludusdesign.com> wrote:
> It's fairly widely-known that select/poll returns immediately when
> testing a filesystem-based file descriptor for writability or
> readability.
> 
> On top of this, even when in non-blocking mode, read() could block if
> the pages needed aren't in core. sendfile() behaves in a similar way.
> 
> What would be needed to alleviate this?
> ...
> I remember seeing a suggestion by Linus for an event-based I/O
> interface, similar to kqueue on FreeBSD but much simpler. I'd just say
> "I want it too!", ok? :-)
>
> SGI's AIO might be a solution here, does it use threads? I'm trying to
> avoid context switching as much as possible, to keep the CPU cache as
> warm as possible.

IMHO, you want AIO.  SGI's is fine for now.  I hear rumors that there will be
something even better coming in 2.5, though I have no details.

Or you could use explicit userspace threads... say, divide up your
network connections among 8 or so threads.  Then if one thread blocks,
the others are there to usefully soak up the CPU time.

Readiness events for readahead completion on disk files used to 
seem like a neat idea to me, but now AIO seems more appealing
in the long run, since they handle random access properly.

- Dan
