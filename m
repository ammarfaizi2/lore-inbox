Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273986AbRISCVA>; Tue, 18 Sep 2001 22:21:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273987AbRISCUu>; Tue, 18 Sep 2001 22:20:50 -0400
Received: from lsmls01.we.mediaone.net ([24.130.1.20]:28656 "EHLO
	lsmls01.we.mediaone.net") by vger.kernel.org with ESMTP
	id <S273986AbRISCUg>; Tue, 18 Sep 2001 22:20:36 -0400
Message-ID: <3BA80108.C830D602@kegel.com>
Date: Tue, 18 Sep 2001 19:20:56 -0700
From: Dan Kegel <dank@kegel.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Davide Libenzi <davidel@xmailserver.org>
Subject: re: [PATCH] /dev/epoll update ...
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide wrote:

> The /dev/epoll patch has been updated :
> 
> *) Stale events removal
> *) Help in Configure.help ( thanks to David E. Weekly )
> *) Fit 2.4.9
> ...
> http://www.xmailserver.org/linux-patches/nio-improve.html

Davide, 
I'm getting ready to stress-test /dev/epoll finally.
In porting my Poller_devpoll.{cc,h} to support /dev/epoll, I noticed
the following issues:

1. it would be very nice to be able to expand the interest list
   without affecting the currently ready list.  In fact, this may
   be needed to support existing programs.    A quick look at
   your code gives me the impression that it would be easy to add
   a ioctl(kdpfd, EP_REALLOC, newmaxfds) call to do this.  Do you agree?

2. The names made visible to userland by your patch do not follow
   a consistent naming convention.  May I suggest that you use
   EPOLL_ as a uniform prefix, and epoll.h as the user-visible include file?
   http://www.opengroup.org/onlinepubs/007908799/xsh/compilation.html
   shows that Posix cares greatly about this kind of namespace issue,
   and it'd be nice to follow their lead, even though this isn't a Posix
   interface.

3. You modify asm/poll.h.  Can your modifications be restricted to epoll.h 
   instead?  (Hey, I don't know much, maybe there's a good reason you did this.)

Thanks,
Dan Kegel
