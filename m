Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270488AbTGNBgr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 21:36:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270489AbTGNBgr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 21:36:47 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:61844 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S270488AbTGNBgq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 21:36:46 -0400
Date: Mon, 14 Jul 2003 02:51:22 +0100
From: Jamie Lokier <jamie@shareable.org>
To: David Schwartz <davids@webmaster.com>
Cc: Davide Libenzi <davidel@xmailserver.org>, Eric Varsanyi <e0206@foo21.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Patch][RFC] epoll and half closed TCP connections
Message-ID: <20030714015122.GC22769@mail.jlokier.co.uk>
References: <Pine.LNX.4.55.0307131334380.15022@bigblue.dev.mcafeelabs.com> <MDEHLPKNGKAHNMBLJOLKGEFKEFAA.davids@webmaster.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKGEFKEFAA.davids@webmaster.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Schwartz wrote:
> 	This is really just due to bad coding in 'poll', or more precisely very bad
> for this case. For example, why is it allocating a wait queue buffer if the
> odds that it will need to wait are basically zero? Why is it adding file
> descriptors to the wait queue before it has determined that it needs to
> wait?

Pfeh!  That's just tweaking.

If you really want to optimise 'poll', maintain a per-task event
interest set like epoll does (you could use the epoll infrastructure),
and on each call to 'poll' just apply the differences between the
interest set and whatever is passed to poll.

That would actually reduce the number of calls to per-fd f_op->poll()
methods to O(active), making the internal overhead of 'poll' and
'select' comparable with epoll.

I'd not be surprised if someone has done it already.  I heard of a
"scalable poll" patch some years ago.

That leaves the overhead of the API, which is O(interested) but it is
a much lower overhead factor than the calls to f_op->poll().

Enjoy,
-- Jamie
