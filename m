Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274206AbRIXWV6>; Mon, 24 Sep 2001 18:21:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274208AbRIXWVt>; Mon, 24 Sep 2001 18:21:49 -0400
Received: from pc-62-30-67-185-az.blueyonder.co.uk ([62.30.67.185]:26862 "EHLO
	kushida.jlokier.co.uk") by vger.kernel.org with ESMTP
	id <S274206AbRIXWVe>; Mon, 24 Sep 2001 18:21:34 -0400
Date: Mon, 24 Sep 2001 23:21:23 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Gordon Oliver <gordo@pincoya.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dan Kegel <dank@kegel.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH] /dev/epoll update ...
Message-ID: <20010924232123.B10253@kushida.jlokier.co.uk>
In-Reply-To: <20010924230909.A10253@kushida.jlokier.co.uk> <XFMail.20010924152011.davidel@xmailserver.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <XFMail.20010924152011.davidel@xmailserver.org>; from davidel@xmailserver.org on Mon, Sep 24, 2001 at 03:20:11PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Libenzi wrote:
> Sure you can avoid the scan, if you pick up one event at a time.  To
> be compared to /dev/epoll you need the signal-per-fd patch plus a
> method to collect the whole event-set in a single system call ( see
> perfs ).

Yes, I agree.  A variant of sigwaitinfo that will return multiple queued
signals was mentioned ages ago, but because the siginfo structure is
much larger than is needed, that isn't a very effective use of cache.

Something specialised for fd events is more appropriate IMO.  Large
numbers of queued RT signals aren't used for anything else AFAIK anyway,
not even timers.

-- Jamie
