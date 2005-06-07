Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261750AbVFGFvw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261750AbVFGFvw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 01:51:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261754AbVFGFvv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 01:51:51 -0400
Received: from b3162.static.pacific.net.au ([203.143.238.98]:34021 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S261750AbVFGFue (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 01:50:34 -0400
Subject: Re: [PATCH] fix tulip suspend/resume
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Adam Belay <abelay@novell.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Karsten Keil <kkeil@suse.de>
In-Reply-To: <1118120598.3245.56.camel@localhost.localdomain>
References: <20050606224645.GA23989@pingi3.kke.suse.de>
	 <1118110545.6850.31.camel@gaston> <20050607025710.GD3289@neo.rr.com>
	 <1118115123.6850.43.camel@gaston>
	 <1118115751.3245.31.camel@localhost.localdomain>
	 <1118118559.6850.61.camel@gaston>
	 <1118120598.3245.56.camel@localhost.localdomain>
Content-Type: text/plain
Organization: Cycades
Message-Id: <1118123518.8089.129.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Tue, 07 Jun 2005 15:51:58 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Tue, 2005-06-07 at 15:03, Adam Belay wrote:
> I'd tend to agree with Pat then.  The original pm_ops seem to be
> designed around ACPI and after looking at the spec I don't think they're
> correct. (e.g. it looks like _PTS and _GTS should be run after
> device_suspend() instead of before, so *prepare may not be needed).  In
> short, this tends to be tricky.  It's probably best to have platforms
> handle it on their own with kernel/power as a library.

Hmm....

- We need a lot of arch dependent hooks so the right things are done at
the right time
- We need a lot of arch independent code run between the arch dependent
code so that the right things are done at the right time.

Therefore it doesn't matter whether the centre of the universe is arch
dependent or independent - either way we have to have hooks to get the
other stuff done.

Swsusp takes a minimalist design, so it doesn't look like much to worry
about if some of that code gets duplicated in arch specific places (taht
said, I'm not sure what whoever-it-was was thinking of duplicating).
Suspend2 takes a feature complete/user friendly/etc design and therefore
has a lot more arch independent code. We definitely want to minimise
duplication of code there.

So I'd suggest leaving the arch independent code in the drivers seat,
but simultaneously replacing/redesigning pm_ops & swsusp so that all the
ops that are or might be needed are there and called at the appropriate
time.

Regards,

Nigel

