Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265555AbSKABYS>; Thu, 31 Oct 2002 20:24:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265261AbSKABXy>; Thu, 31 Oct 2002 20:23:54 -0500
Received: from bjl1.asuk.net.64.29.81.in-addr.arpa ([81.29.64.88]:25011 "EHLO
	bjl1.asuk.net") by vger.kernel.org with ESMTP id <S265551AbSKABWC>;
	Thu, 31 Oct 2002 20:22:02 -0500
Date: Fri, 1 Nov 2002 01:23:24 +0000
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Linus Torvalds <torvalds@transmeta.com>,
       Linux-Kernel ML <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] Clear TLS on execve
Message-ID: <20021101012324.GB30865@bjl1.asuk.net>
References: <20021031143439.GA1697@home.ldb.ods.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021031143439.GA1697@home.ldb.ods.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luca Barbieri wrote:
> This trivial patch causes the TLS to be cleared on execve (code is
> in flush_thread).  This is necessary to avoid ESRCH errors when
> set_thread_area is asked to choose a free TLS entry after several
> nested execve's.

Ouch!

> The LDT also has a similar problem, but it is less serious because the
> LDT code doesn't scan for free entries. I'll probably send a patch to
> fix this too, unless there is something important relying on this behavior.

Ouch again!  Does the LDT really not get released on execve?  I am
using threading code which _does_ scan for free entries in the LDT -
using the lar instruction.  I'd never stumbled across this, though.
I'll be glad of your patch.

-- Jamie
