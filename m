Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264761AbSJOTV2>; Tue, 15 Oct 2002 15:21:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264762AbSJOTV2>; Tue, 15 Oct 2002 15:21:28 -0400
Received: from relay1.pair.com ([209.68.1.20]:35858 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id <S264761AbSJOTVV>;
	Tue, 15 Oct 2002 15:21:21 -0400
X-pair-Authenticated: 24.126.73.164
Message-ID: <3DAC6ED0.E4379BEF@kegel.com>
Date: Tue, 15 Oct 2002 12:38:56 -0700
From: Dan Kegel <dank@kegel.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-3custom i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Davide Libenzi <davidel@xmailserver.org>
CC: Benjamin LaHaise <bcrl@redhat.com>, Shailabh Nagar <nagar@watson.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-aio <linux-aio@kvack.org>, Andrew Morton <akpm@digeo.com>,
       David Miller <davem@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Stephen Tweedie <sct@redhat.com>
Subject: Re: [PATCH] async poll for 2.5
References: <Pine.LNX.4.44.0210151229010.1554-100000@blue1.dev.mcafeelabs.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Libenzi wrote:
> 
> On Tue, 15 Oct 2002, Benjamin LaHaise wrote:
> 
> > On Tue, Oct 15, 2002 at 12:16:39PM -0700, Davide Libenzi wrote:
> > > Ben, one of the reasons of the /dev/epoll speed is how it returns events
> > > and how it collapses them. A memory mapped array is divided by two and
> > > while the user consumes events in one set, the kernel fill the other one.
> > > The next wait() will switch the pointers. There is no copy from kernel to
> > > user space. Doing :
> > >
> > > int sys_epoll_wait(int epd, struct pollfd **pevts, int timeout);
> > >
> > > the only data the kernel has to copy to userspace is the 4(8) bytes for
> > > the "pevts" pointer.
> >
> > Erm, the aio interface has support for the event ringbuffer being accessed
> > by userspace (it lives in user memory and the kernel acts as a writer, with
> > userspace as a reader), that's one of its advantages -- completion events
> > are directly accessible from userspace after being written to by an
> > interrupt.  Ideally this is to be wrapped in a vsyscall, but we don't have
> > support for that yet on x86, although much of the code written for x86-64
> > should be reusable.
> 
> In general I would like to have a "common" interface to retrieve IO
> events, but IMHO the two solutions should be benchmarked before adopting
> the one or the other.

Seems like /dev/epoll uses a double-buffering scheme rather than
a ring buffer, and this is not just a trivial difference; it's
related to how redundant events are collapsed, right?
- Dan
