Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263364AbTKQGs6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 01:48:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263369AbTKQGs6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 01:48:58 -0500
Received: from mail.jlokier.co.uk ([81.29.64.88]:8374 "EHLO mail.shareable.org")
	by vger.kernel.org with ESMTP id S263364AbTKQGs5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 01:48:57 -0500
Date: Mon, 17 Nov 2003 06:48:32 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Krzysztof Benedyczak <golbi@mat.uni.torun.pl>
Cc: linux-kernel@vger.kernel.org, Manfred Spraul <manfred@colorfullife.com>,
       Urlich Drepper <drepper@redhat.com>,
       Michal Wronski <wrona@mat.uni.torun.pl>
Subject: Re: [PATCH] POSIX message queues - syscalls & SIGEV_THREAD
Message-ID: <20031117064832.GA16597@mail.shareable.org>
References: <Pine.GSO.4.58.0311161546260.25475@Juliusz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.58.0311161546260.25475@Juliusz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Krzysztof Benedyczak wrote:
> Intuitive
> solution is with FUTEX_FD & poll but this will have synchronization
> problems. The solution with one futex and multiple values would be very
> complicated (we need mechanism for cancellation of notification and of
> course information which queue(s) produced event(s)). On the another hand
> I can think about signals doing all the work - using thread sig mask we
> have synchronization and signals can carry quite a lot information. Of
> course this are only suggestions and I can miss something about futexes.

Please can you describe your "intuitive solution" using FUTEX_FD more clearly?

I don't quite understand what you wrote, but there are flaws(*) in the
current FUTEX_FD implementation which I would like to fix anyway.

Perhaps we can improve async futexes in a way which is useful for you?

Thanks,
-- Jamie

(*) FUTEX_FD cannot be used as a drop-in replacement for synchronous
futexes, due to a race condition in cancellation.
