Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270483AbTGNBMt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 21:12:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270484AbTGNBMt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 21:12:49 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:57492 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S270483AbTGNBMq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 21:12:46 -0400
Date: Mon, 14 Jul 2003 02:27:25 +0100
From: Jamie Lokier <jamie@shareable.org>
To: David Schwartz <davids@webmaster.com>
Cc: Davide Libenzi <davidel@xmailserver.org>, Eric Varsanyi <e0206@foo21.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Patch][RFC] epoll and half closed TCP connections
Message-ID: <20030714012725.GC22663@mail.jlokier.co.uk>
References: <20030713211045.GD21612@mail.jlokier.co.uk> <MDEHLPKNGKAHNMBLJOLKEEFKEFAA.davids@webmaster.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKEEFKEFAA.davids@webmaster.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Schwartz wrote:
> 	But so does 'poll'. If you double the number of active and inactive
> connections, 'poll' takes twice as long. But you do twice as much per call
> to 'poll'. You will both discover more connections ready to do work on and
> move more bytes per connection as the load increases.

Well, with that assumption sure there is nothing _to_ scale - poll and
select are perfect.

> > That was always the complaint about select() and poll(): they dominate
> > the run time for large numbers of connections.  epoll, on the other
> > hand, will always be in the noise relative to other work.
> 
> 	I think this is largely true for Linux because of bad implementation of
> 'poll' and therefore 'select'.

It's true those implementations could use clever methods to reduce the
amount of time they take by caching poll results, and probably
approach epoll speeds.

However their APIs have a built-in problem - at minimum, the kernel
has to read & write O(N) memory per call.

With your assumption of a fixed ratio of active/idle sockets, and
where that ration is not very small (10% is not very small), of course
the API is not a problem.

> > If you want a formula for slides :), time_polling/time_working is O(1)
> > with epoll, but O(N) with poll() & select().
> 
> 	It's not O(N) with 'poll' and 'select'. Twice as many file descriptors
> means twice as many active file descriptors which means twice as many
> discovered per call to 'poll'.

It is O(N).  When the load pattern follows your example, O(N) == O(1) :)

-- Jamie
