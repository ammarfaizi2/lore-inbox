Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932111AbVJRXxD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932111AbVJRXxD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 19:53:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932143AbVJRXxD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 19:53:03 -0400
Received: from mail-kan.bigfish.com ([63.161.60.29]:25171 "EHLO
	mail52-kan-R.bigfish.com") by vger.kernel.org with ESMTP
	id S932111AbVJRXxC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 19:53:02 -0400
X-BigFish: V
Message-ID: <43558AD8.3010307@am.sony.com>
Date: Tue, 18 Oct 2005 16:52:56 -0700
From: Tim Bird <tim.bird@am.sony.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Roman Zippel <zippel@linux-m68k.org>, "Bird, Tim" <Tim.Bird@am.sony.com>,
       Andrew Morton <akpm@osdl.org>, tglx@linutronix.de, george@mvista.com,
       linux-kernel@vger.kernel.org, johnstul@us.ibm.com, paulmck@us.ibm.com,
       hch@infradead.org, oleg@tv-sign.ru
Subject: Re: [PATCH]  ktimers subsystem 2.6.14-rc2-kt5
References: <20051018084655.GA28933@elte.hu>
In-Reply-To: <20051018084655.GA28933@elte.hu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Antivirus: Scanned by F-Prot Antivirus (http://www.f-prot.com)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> My claim is that if you _know_ that a timer will expire most likely, you 
> want it to order at insertion time - i.e. you want to have a tree 
> structure. If you _know_ that a timer will most likely _not_ expire, 
> then you can avoid the tree overhead by 'delaying' the decision of 
> sorting timers, to the point in the future where we really are forced to
> do so.
> 
> The result of this mathematical paradox is that we end up with two data 
> structures: one is the timer wheel (kernel/timers.c) for 
> timeout/exception related use; the other one is ktimers 
> (kernel/ktimers.c), for expiry oriented use.

I'd like to make an observation on another
difference between the wheel and the rbtree.  Note that
the wheel implementation inherently coalesces timeouts
that are near each other, due to it's relatively
low resolution (at tick granularity - which is
still pretty low resolution on embedded hardware -
usually 10 milliseconds.)

One concern I have with the rbtree is that this
automatic coalescing is lost, and there may be
unanticipated overhead in the move to support
high resolution timers.

Whether some form of coalescing should be
preserved for timers, even when the system
supports higher resolution, will be a
function of the number of timers and their
intended use.  I don't see any support for that
in the current patch, but maybe I'm missing
something.

=============================
Tim Bird
Architecture Group Chair, CE Linux Forum
Senior Staff Engineer, Sony Electronics
=============================

