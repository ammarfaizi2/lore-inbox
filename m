Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261552AbTK0XDg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Nov 2003 18:03:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261555AbTK0XDf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Nov 2003 18:03:35 -0500
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:11269 "EHLO
	kerberos.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S261552AbTK0XDd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Nov 2003 18:03:33 -0500
Subject: Re: [PATCH 2.6]: IPv6: strcpy -> strlcpy
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: "YOSHIFUJI Hideaki / ?$B5HF#1QL@?(B" <yoshfuji@linux-ipv6.org>,
       davem@redhat.com,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
       netdev@oss.sgi.com
In-Reply-To: <20031127221928.F25015@flint.arm.linux.org.uk>
References: <1069934643.2393.0.camel@teapot.felipe-alfaro.com>
	 <20031127.210953.116254624.yoshfuji@linux-ipv6.org>
	 <20031127194602.A25015@flint.arm.linux.org.uk>
	 <20031128.045413.133305490.yoshfuji@linux-ipv6.org>
	 <20031127200041.B25015@flint.arm.linux.org.uk>
	 <1069970770.2138.10.camel@teapot.felipe-alfaro.com>
	 <20031127221928.F25015@flint.arm.linux.org.uk>
Content-Type: text/plain
Message-Id: <1069974209.5349.7.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8) 
Date: Fri, 28 Nov 2003 00:03:29 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-11-27 at 23:19, Russell King wrote:

> You misunderstand me.  Consider the difference between:

OK, it's perfectly clear now :-)

> Note my final sentence there.  Consider the following:
> 
> 	char foo[256];
> 
> 	strlcpy(foo, "hello", sizeof(foo);
> 
> 	copy_to_user(uptr, foo, sizeof(foo));
> 
> That ends up writing uninitialised kernel data to (unprivileged) user
> space.  So would strcpy() used in that situation.
> 
> strncpy() on the other hand, will zero the rest of the buffer (on x86
> at least) but you'll have to manually ensure that there is a terminator
> on the end.  Or, you use strlcpy but memset the entire space you're
> copying the string into beforehand, which could be wasteful.
> 
> Note: we should really fix the generic strncpy() - there are places in
> the kernel source which rely on the x86 strncpy() behaviour today (eg,
> binfmt_*.c core file generation.)

So, as I see:

1. We should fix strncpy()
2. I should replace strlcpy() with strncpy() in my patches.


