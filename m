Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270089AbTGNPBM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 11:01:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270634AbTGNO6J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 10:58:09 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:55961 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S270650AbTGNO4R
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 10:56:17 -0400
X-AuthUser: davidel@xmailserver.org
Date: Mon, 14 Jul 2003 08:03:41 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mcafeelabs.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: David Schwartz <davids@webmaster.com>, Jamie Lokier <jamie@shareable.org>,
       Eric Varsanyi <e0206@foo21.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [Patch][RFC] epoll and half closed TCP connections
In-Reply-To: <1058170455.561.30.camel@dhcp22.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.55.0307140748510.4371@bigblue.dev.mcafeelabs.com>
References: <MDEHLPKNGKAHNMBLJOLKEEFKEFAA.davids@webmaster.com> 
 <Pine.LNX.4.55.0307131605480.15022@bigblue.dev.mcafeelabs.com>
 <1058170455.561.30.camel@dhcp22.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Jul 2003, Alan Cox wrote:

> For some loads poll/select are actually extremely efficient. X clients
> batch commands up and there is a cost to switching between tasks for
> different clients. Viewed as an entire system you actually get quite
> interesting little graphs, especially in the critical load cases where
> select/poll's batching effect makes throughput increase rapidly at 100%
> CPU load, even if it gets you there far too early. Ditto with
> webservers.

Indeed, poll/select are very nice APIs and you definitely want to use them
if your apps does not need certain requirements. If N/M approaches 1, poll
scales exactly (alomst) like epoll. But poll does not born to scale on
huge number of fds, and this is recognized by ages. Yesterday I pulled out
a Mogul paper where (a long time ago) he talks about poll limits and he
also talks about three ideal APIs to deal with networking load :

declare_interest == epoll_ctl(EPOLL_CTL_ADD)
revoke_interest == epoll_ctl(EPOLL_CTL_DEL)
dequeue_next_events == epoll_wait()

This a long time before epoll :)



- Davide

