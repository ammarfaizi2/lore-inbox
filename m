Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270394AbTGMU4J (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 16:56:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270395AbTGMU4I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 16:56:08 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:50068 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S270394AbTGMU4F
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 16:56:05 -0400
Date: Sun, 13 Jul 2003 22:10:45 +0100
From: Jamie Lokier <jamie@shareable.org>
To: David Schwartz <davids@webmaster.com>
Cc: Davide Libenzi <davidel@xmailserver.org>, Eric Varsanyi <e0206@foo21.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Patch][RFC] epoll and half closed TCP connections
Message-ID: <20030713211045.GD21612@mail.jlokier.co.uk>
References: <Pine.LNX.4.55.0307121346140.4720@bigblue.dev.mcafeelabs.com> <MDEHLPKNGKAHNMBLJOLKIEEPEFAA.davids@webmaster.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKIEEPEFAA.davids@webmaster.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Schwartz wrote:
> 	For most real-world loads, M is some fraction of N. The fraction
> asymptotically approaches 1 as load increases because under load it takes
> you longer to get back to polling, so a higher fraction of the descriptors
> will be ready when you do.

Ah, but as the fraction approaches 1, you'll find that you are
asymptotically approaching the point where you can't handle the load
_regardless_ of epoll overhead.

> 	By the way, I'm not arguing against epoll. I believe it will use less
> resources than poll in pretty much every conceivable situation. I simply
> take issue with the argument that it has better ultimate scalability or
> scales at a different order.

It scales according to the amount of work pending, which means that it
doesn't take any _more_ time than actually doing the pending work.
(This assumes you use epoll appropriately; there are many ways to use
epoll which don't have this property).

That was always the complaint about select() and poll(): they dominate
the run time for large numbers of connections.  epoll, on the other
hand, will always be in the noise relative to other work.

If you want a formula for slides :), time_polling/time_working is O(1)
with epoll, but O(N) with poll() & select().

-- Jamie
