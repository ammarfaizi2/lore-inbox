Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269773AbTGOV7K (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 17:59:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269776AbTGOV7K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 17:59:10 -0400
Received: from login.osdl.org ([65.172.181.5]:5547 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269773AbTGOV7I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 17:59:08 -0400
Date: Tue, 15 Jul 2003 15:06:45 -0700
From: Andrew Morton <akpm@osdl.org>
To: george anzinger <george@mvista.com>
Cc: bernie@develer.com, linux-kernel@vger.kernel.org, rmk@arm.linux.org.uk,
       torvalds@osdl.org
Subject: Re: do_div64 generic
Message-Id: <20030715150645.4fa11de7.akpm@osdl.org>
In-Reply-To: <3F1477B2.6090106@mvista.com>
References: <3F1360F4.2040602@mvista.com>
	<200307150717.54981.bernie@develer.com>
	<20030714223805.4e5bee3f.akpm@osdl.org>
	<200307150823.01602.bernie@develer.com>
	<3F1477B2.6090106@mvista.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

george anzinger <george@mvista.com> wrote:
>
> > George, do you agree? May I go on and post a patch killing
> > div_long_long_rem() everywhere?
> 
> The issue is that div is a very long instruction and the do_div() 
> thing uses 2 or three of them, while the div_long_long_rem() is just 
> 1.  Also, a lot of archs already have the required div by a different 
> name.  It all boils down to a performance thing.

It is only used in nanosleep(), and then only in the case where the sleep
terminated early.

If someone is calling nanosleep() so frequently for this to matter, the
time spent in divide is the least of their problems.  Unless you have some
real-worldish benchmarks to demonstrate otherwise?

You know what they say about premtur optmstns, and having to propagate
funky new divide primitives across N architectures is indeed evil.

Bernardo, can you do the patch please?
