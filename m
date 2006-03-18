Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750914AbWCRUP4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750914AbWCRUP4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 15:15:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750919AbWCRUP4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 15:15:56 -0500
Received: from smtp.osdl.org ([65.172.181.4]:59542 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750914AbWCRUPz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 15:15:55 -0500
Date: Sat, 18 Mar 2006 12:12:51 -0800
From: Andrew Morton <akpm@osdl.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu, trini@kernel.crashing.org
Subject: Re: [patch 2/2] alarm unsigned signed conversion fixup
Message-Id: <20060318121251.66d2b55d.akpm@osdl.org>
In-Reply-To: <20060318142831.114986000@localhost.localdomain>
References: <20060318142827.419018000@localhost.localdomain>
	<20060318142831.114986000@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gleixner <tglx@linutronix.de> wrote:
>
> alarm() calls the kernel with an unsigend int timeout in seconds.
>  The value is converted to a timeval which is used to setup the
>  itimer. The tv_sec field of the timeval is a long, which causes
>  the timeout to be negative on 32 bit machines if seconds > INT_MAX.
>  Also this was silently caught before the hrtimer merge. 
>  To avoid fixups all over the place the duplicated sys_alarm code 
>  is moved to itimer.c.

It's not clear what you mean by this.   What does "silently caught" mean?

I _think_ you mean "a negative tv_sec gets treated in a random fashion, but
with my preceding patch it will incorrectly get -EINVAL, so fix things to
accept this large tv_sec".  Or something else.

Please clarify.

What happens if change sys_setitimer() to normalise the incoming timeval as
I suggested?  I guess that doesn't affect this..
