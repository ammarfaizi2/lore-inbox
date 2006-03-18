Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750942AbWCRU1E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750942AbWCRU1E (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 15:27:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750944AbWCRU1E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 15:27:04 -0500
Received: from 213-239-205-134.clients.your-server.de ([213.239.205.134]:51934
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1750942AbWCRU1C
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 15:27:02 -0500
Subject: Re: [patch 2/2] alarm unsigned signed conversion fixup
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu, trini@kernel.crashing.org
In-Reply-To: <20060318121251.66d2b55d.akpm@osdl.org>
References: <20060318142827.419018000@localhost.localdomain>
	 <20060318142831.114986000@localhost.localdomain>
	 <20060318121251.66d2b55d.akpm@osdl.org>
Content-Type: text/plain
Date: Sat, 18 Mar 2006 21:27:13 +0100
Message-Id: <1142713634.17279.136.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-03-18 at 12:12 -0800, Andrew Morton wrote:
> Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> > alarm() calls the kernel with an unsigend int timeout in seconds.
> >  The value is converted to a timeval which is used to setup the
> >  itimer. The tv_sec field of the timeval is a long, which causes
> >  the timeout to be negative on 32 bit machines if seconds > INT_MAX.
> >  Also this was silently caught before the hrtimer merge. 
> >  To avoid fixups all over the place the duplicated sys_alarm code 
> >  is moved to itimer.c.
> 
> It's not clear what you mean by this.   What does "silently caught" mean?
> 
> I _think_ you mean "a negative tv_sec gets treated in a random fashion, but
> with my preceding patch it will incorrectly get -EINVAL, so fix things to
> accept this large tv_sec".  Or something else.
> 
> Please clarify.
> 
> What happens if change sys_setitimer() to normalise the incoming timeval as
> I suggested?  I guess that doesn't affect this..

No, because a negative value does not become positive by normalizing.
Well except you build a normalizing function which converts negative
values to INT_MAX.

	tglx



