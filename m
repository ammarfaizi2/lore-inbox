Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263434AbTLUPI3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Dec 2003 10:08:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263447AbTLUPI3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Dec 2003 10:08:29 -0500
Received: from mail.shareable.org ([81.29.64.88]:50823 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S263434AbTLUPIZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Dec 2003 10:08:25 -0500
Date: Sun, 21 Dec 2003 15:08:11 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [RFC,PATCH] use rcu for fasync_lock
Message-ID: <20031221150811.GL3438@mail.shareable.org>
References: <3FE492EF.2090202@colorfullife.com> <20031221113640.GF3438@mail.shareable.org> <3FE594D0.8000807@colorfullife.com> <20031221141456.GI3438@mail.shareable.org> <3FE5B56E.30507@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FE5B56E.30507@colorfullife.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul wrote:
> The wakeup happens at irq time. The band info is necessary for 
> send_sigio(). Calling f_poll at irq time is not an option - it will 
> definitively cause breakage.

Agree * 3.

> schedule_work() for every call is IMHO not an option.

Agree, the latency would suck and it wouldn't even work for RT processes.

> And even that is not reliable: fasync users might expect seperate
> POLL_OUT and POLL_IN signals.

They might, although they probably shouldn't (band is a bitmask for a
reason).

Anyway, you can handle all these problems by computing the band at
signal delivery time.  Yes it sounds like it would complicate the
signal delivery code, but sigio should really be handled specially
anyway, so that a signal queue entry for every fd is guaranteed and
queue overflow is not possible.  Somebody already has a patch for
that, it might be worth working from.

-- Jamie
