Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284914AbRLFAsi>; Wed, 5 Dec 2001 19:48:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284913AbRLFAsS>; Wed, 5 Dec 2001 19:48:18 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:39432 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S284911AbRLFAsO>; Wed, 5 Dec 2001 19:48:14 -0500
Subject: Re: kqueue, kevent - kernel event notification mechanism
To: carlo@alinoe.com (Carlo Wood)
Date: Thu, 6 Dec 2001 00:57:21 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011206013857.A17313@alinoe.com> from "Carlo Wood" at Dec 06, 2001 01:38:57 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16Bmqo-0008Fj-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> are there any plans to implement the kqueue, kevent system calls
> in the linux kernel?

Not that I know of

> It would be good for linux to implement event-driven i/o, if not
> by means of kqueue/kevent (BSD-ish interface) then at least in
> some other way.

The standards way is asynchronous io (aio_* interfaces). That is being
worked on

> the difference.  The current i/o calls, select and poll, scan all
> open file descriptors for events, every call.  This is clearly
> not scalable.  Event driven means that the kernel never scans

The API isnt directly the problem. In fact you can make a fine scalable select
by implementing

	poll_setup(..............)
	poll_add/poll_remove
	poll_wait

as multiple calls giving basically the same interface that apps expected
anyway.  Take a look at the various /dev/poll experimental interfaces and
bits of code.

Alan
