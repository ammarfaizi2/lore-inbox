Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752064AbWG1TYY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752064AbWG1TYY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 15:24:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752063AbWG1TYY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 15:24:24 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:55255 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1751998AbWG1TYX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 15:24:23 -0400
Date: Fri, 28 Jul 2006 23:24:03 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Zach Brown <zach.brown@oracle.com>
Cc: Benjamin LaHaise <bcrl@kvack.org>, David Miller <davem@davemloft.net>,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [RFC 1/4] kevent: core files.
Message-ID: <20060728192403.GA13690@2ka.mipt.ru>
References: <20060709132446.GB29435@2ka.mipt.ru> <20060724.231708.01289489.davem@davemloft.net> <44C91192.4090303@oracle.com> <20060727205806.GD16971@kvack.org> <44C933D2.4040406@oracle.com> <20060727220238.GE16971@kvack.org> <44CA5F08.3080500@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <44CA5F08.3080500@oracle.com>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Fri, 28 Jul 2006 23:24:09 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2006 at 12:01:28PM -0700, Zach Brown (zach.brown@oracle.com) wrote:
> Clearly we should port httpd to kevents and take some measurements :)

One of my main kevent benchmarks (socket notifications for
accept/receive) is handmade http server.
I compared it with FreeBSD kqueue, epoll and kevent_poll
(this is generic poll/select notifications ported to kevent)
based (it is the same server but with different event functions.

Client was httperf, I ran it with 30k connections in bursts of 3k
connection with 1 second timeout between bursts.


Here are results:

kevent:	more than 2600 requests/second
epoll and kevent_poll: about 1600-1800 requests/second
kqueue: enormous number of connection reset errors (only 62% of
successfull connections) (likely misconfiguration, default FreeBSD
6-something does not allow such rates at all).

More info can be found on kevent homepage:
http://tservice.net.ru/~s0mbre/old/?section=projects&item=kevent

> - z

-- 
	Evgeniy Polyakov
