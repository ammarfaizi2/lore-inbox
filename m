Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932451AbWE3Tuv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932451AbWE3Tuv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 15:50:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932452AbWE3Tuv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 15:50:51 -0400
Received: from smtp.osdl.org ([65.172.181.4]:901 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932451AbWE3Tuu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 15:50:50 -0400
Date: Tue, 30 May 2006 12:54:47 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andi Kleen <ak@suse.de>
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: [patch, -rc5-mm1] lock validator: disable NMI watchdog if
 CONFIG_LOCKDEP, i386
Message-Id: <20060530125447.b646d2dd.akpm@osdl.org>
In-Reply-To: <p73mzcz1g0h.fsf@verdi.suse.de>
References: <20060530022925.8a67b613.akpm@osdl.org>
	<20060530111138.GA5078@elte.hu>
	<1148990326.7599.4.camel@homer>
	<1148990725.8610.1.camel@homer>
	<20060530120641.GA8263@elte.hu>
	<1148991422.8610.8.camel@homer>
	<20060530121952.GA9625@elte.hu>
	<1148992098.8700.2.camel@homer>
	<20060530122950.GA10216@elte.hu>
	<p73mzcz1g0h.fsf@verdi.suse.de>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 30 May 2006 21:14:54 +0200
Andi Kleen <ak@suse.de> wrote:

> Ingo Molnar <mingo@elte.hu> writes:
> > 
> > The NMI watchdog uses spinlocks (notifier chains, etc.),
> > so it's not lockdep-safe at the moment.
> 
> That's totally unsafe even without lockdep and should be fixed
> instead. I guess someone bungled the notifier chain conversion.
> The NMI notifiers need to be lockless.
> 

Confused.  NMI uses notify_die(), which doesn't take locks?

We'll probably accidentally take locks when actually reporting an NMI
watchdog timeout, but that doesn't seem terribly important.
