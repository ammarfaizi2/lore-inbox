Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284902AbRLFAjS>; Wed, 5 Dec 2001 19:39:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284908AbRLFAjJ>; Wed, 5 Dec 2001 19:39:09 -0500
Received: from node1500a.a2000.nl ([24.132.80.10]:57304 "HELO mail.alinoe.com")
	by vger.kernel.org with SMTP id <S284907AbRLFAjE>;
	Wed, 5 Dec 2001 19:39:04 -0500
Date: Thu, 6 Dec 2001 01:38:57 +0100
From: Carlo Wood <carlo@alinoe.com>
To: linux-kernel@vger.kernel.org
Subject: kqueue, kevent - kernel event notification mechanism
Message-ID: <20011206013857.A17313@alinoe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hiya,

are there any plans to implement the kqueue, kevent system calls
in the linux kernel?

There is no substitute for them currently; select() and poll()
both suffer from dramatic cpu usage when a daemon is loaded with
a few thousand clients.

It would be good for linux to implement event-driven i/o, if not
by means of kqueue/kevent (BSD-ish interface) then at least in
some other way.

It has been shown that a heavily loaded networking daemon like
an IRC daemon uses 35% less cpu on freeBSD by using event-driven
i/o instead of poll().

For those who are not into this material, allow me to explain
the difference.  The current i/o calls, select and poll, scan all
open file descriptors for events, every call.  This is clearly
not scalable.  Event driven means that the kernel never scans
all open file descriptors but queues events as they happen on
the network card - the latter would in principle be scalable
to any number of open file descriptors, as long as there is
enough memory and as long as there is a limited number of
file descriptors active per time unit.

-- 
Carlo Wood <carlo@alinoe.com>
