Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274305AbRITEkr>; Thu, 20 Sep 2001 00:40:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274307AbRITEkh>; Thu, 20 Sep 2001 00:40:37 -0400
Received: from c007-h000.c007.snv.cp.net ([209.228.33.206]:56254 "HELO
	c007.snv.cp.net") by vger.kernel.org with SMTP id <S274305AbRITEkU>;
	Thu, 20 Sep 2001 00:40:20 -0400
X-Sent: 20 Sep 2001 04:40:08 GMT
Message-ID: <3BA97155.4D2D53AC@distributopia.com>
Date: Wed, 19 Sep 2001 23:32:21 -0500
From: "Christopher K. St. John" <cks@distributopia.com>
X-Mailer: Mozilla 4.61 [en] (X11; I; Linux 2.0.36 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Davide Libenzi <davidel@xmailserver.org>
Subject: Re: [PATCH] /dev/epoll update ...
In-Reply-To: <XFMail.20010919192804.davidel@xmailserver.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Libenzi wrote:
> 
> Here are examples basic functions when used with
> coroutines.
>
 
 I think all might be made clear if you did a quick
test harness that didn't use coroutines. I'm guessing
the vast majority of potential users will not be using
a coroutine library.

 On "nio-improve" page, you've got:

        for (;;) {
          evp.ep_timeout = STD_SCHED_TIMEOUT;
          evp.ep_resoff = 0;
          nfds = ioctl(kdpfd, EP_POLL, &evp);
          pfds = (struct pollfd *) (map + evp.ep_resoff);
          for (ii = 0; ii < nfds; ii++, pfds++) {
             ...
          }
        }

 Assume your server is so overloaded that you need
to avoid any unproductive calls to read() or write()
or accept(). Assume that instead of many very fast
connections coming in at a furious rate, you get a
large steady current of very slow connections.

 If you try to flesh out the above template with those
goals in mind, I think you'll quickly see what I've
been trying to get at with regard to the awkwardness
of not getting back some indication of the initial
state of the fd.

 The current situation isn't fatal, just awkward. And
fixable. For the low low price of a tiny bit of
idealogical purity...



-- 
Christopher St. John cks@distributopia.com
DistribuTopia http://www.distributopia.com
