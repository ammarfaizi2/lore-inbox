Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274165AbRITCM6>; Wed, 19 Sep 2001 22:12:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274124AbRITCMi>; Wed, 19 Sep 2001 22:12:38 -0400
Received: from lsmls02.we.mediaone.net ([24.130.1.15]:15002 "EHLO
	lsmls02.we.mediaone.net") by vger.kernel.org with ESMTP
	id <S272886AbRITCMg>; Wed, 19 Sep 2001 22:12:36 -0400
Message-ID: <3BA950AF.58CFCF29@kegel.com>
Date: Wed, 19 Sep 2001 19:13:03 -0700
From: Dan Kegel <dank@kegel.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Davide Libenzi <davidel@xmailserver.org>
CC: "Christopher K. St. John" <cks@distributopia.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] /dev/epoll update ...
In-Reply-To: <XFMail.20010919151147.davidel@xmailserver.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Libenzi wrote:
> 1)      if (recv()/send() == FAIL)
> 2)              ioctl(EP_POLL);

A lot of people, including me, were under the mistaken impression
that /dev/epoll, like /dev/poll, provided an efficient way to
retrieve the current readiness state of fd's.  I understand from your post
that /dev/epoll's purpose is to retrieve state changes; in other
words, it's exactly like F_SETSIG/F_SETOWN/O_ASYNC except that
the readiness change indications are picked up via an ioctl
rather than via a signal.

A scorecard for the confused (Davide, correct me if I'm wrong):

* API's that allow you to retrieve the current readiness state of
  a set of fd's:  poll(), select(), /dev/poll, kqueue().
  Buzzwords describing this kind of interface: level-triggered, multishot.

* API's that allow you to retrieve *changes* to the readiness state of
  a set of fd's: F_SETSIG/F_SETOWN/O_ASYNC + sigtimedwait(), /dev/epoll, kqueue().
  Buzzwords describing this kind of interface: edge-triggered, single-shot.

(Note that kqueue is in both camps.)

Er, I guess that means I'll rip up the /dev/epoll support I based on my
/dev/poll code, and replace it with some based on my O_ASYNC code...

- Dan
