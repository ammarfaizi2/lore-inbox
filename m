Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261763AbUDOWwC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 18:52:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261981AbUDOWwC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 18:52:02 -0400
Received: from fw.osdl.org ([65.172.181.6]:58509 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261763AbUDOWwA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 18:52:00 -0400
Date: Thu, 15 Apr 2004 15:54:08 -0700
From: Andrew Morton <akpm@osdl.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: manfred@colorfullife.com, drepper@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: message queue limits
Message-Id: <20040415155408.0902a0c0.akpm@osdl.org>
In-Reply-To: <20040415214632.GA4402@logos.cnet>
References: <407A2DAC.3080802@redhat.com>
	<20040415145350.GF2085@logos.cnet>
	<20040415122411.0bcb9195.akpm@osdl.org>
	<20040415195430.GB3568@logos.cnet>
	<20040415214632.GA4402@logos.cnet>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti <marcelo.tosatti@cyclades.com> wrote:
>
> This adds a new "RLIMIT_SIGPENDING" limit, which is used to limit
> per-uid pending signals. Currently an unpriviledged user can queue 
> more than maximum of allowed signals and cause overall system 
> malfunction.

So now it takes two users to gang up and do the same thing.  We should
either exempt root from the global check or simply remove the global limit
altogether.

Is it possible for a process to do setuid() with outstanding signals?  If
so, they may end up with a negative current->user->signal_pending?

You need to initialise ->signal_pending in alloc_uid().

What are you doing for testing of this?

Thanks.
