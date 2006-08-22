Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751308AbWHVHBd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751308AbWHVHBd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 03:01:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751307AbWHVHBd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 03:01:33 -0400
Received: from alnrmhc12.comcast.net ([204.127.225.92]:27105 "EHLO
	alnrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1751268AbWHVHBd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 03:01:33 -0400
Subject: Re: [take12 0/3] kevent: Generic event handling mechanism.
From: Nicholas Miell <nmiell@comcast.net>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: lkml <linux-kernel@vger.kernel.org>, David Miller <davem@davemloft.net>,
       Ulrich Drepper <drepper@redhat.com>, Andrew Morton <akpm@osdl.org>,
       netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>
In-Reply-To: <11561555871530@2ka.mipt.ru>
References: <11561555871530@2ka.mipt.ru>
Content-Type: text/plain
Date: Tue, 22 Aug 2006 00:00:51 -0700
Message-Id: <1156230051.8055.27.camel@entropy>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5.0.njm.1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-08-21 at 14:19 +0400, Evgeniy Polyakov wrote:
> Generic event handling mechanism.

Since this is the sixth[1] event notification system that's getting
added to the kernel, could somebody please convince me that the
userspace API is right this time? (Evidently, the others weren't and are
now just backward compatibility bloat.)

Just looking at the proposed kevent API, it appears that the timer event
queuing mechanism can't be used for the queuing of POSIX.1b interval
timer events (i.e. via a SIGEV_KEVENT notification value in a struct
sigevent) because (being a very thin veneer over the internal kernel
timer system) you can't specify a clockid, the time value doesn't have
the flexibility of a struct itimerspec (no re-arm timeout or absolute
times), and there's no way to alter, disable or query a pending timer or
query a timer overrun count.

Overall, kevent timers appear to be inconvenient to use and limited
compared to POSIX interval timers (excepting the fact you can read their
expiray events out of a queue, of course).



[1] Previously: select, poll, AIO, epoll, and inotify. Did I miss any?

-- 
Nicholas Miell <nmiell@comcast.net>

