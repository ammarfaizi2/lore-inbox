Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261430AbVBWIws@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261430AbVBWIws (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 03:52:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261431AbVBWIws
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 03:52:48 -0500
Received: from fire.osdl.org ([65.172.181.4]:50058 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261430AbVBWIwl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 03:52:41 -0500
Date: Wed, 23 Feb 2005 00:51:35 -0800
From: Andrew Morton <akpm@osdl.org>
To: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
Cc: kaigai@ak.jp.nec.com, jlan@sgi.com, lse-tech@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, tim@physik3.uni-rostock.de,
       erikj@subway.americas.sgi.com, limin@dbear.engr.sgi.com,
       jbarnes@sgi.com, elsa-devel@lists.sourceforge.net
Subject: Re: [Lse-tech] Re: A common layer for Accounting packages
Message-Id: <20050223005135.3d8ce2f3.akpm@osdl.org>
In-Reply-To: <1109147623.1738.91.camel@frecb000711.frec.bull.fr>
References: <42168D9E.1010900@sgi.com>
	<20050218171610.757ba9c9.akpm@osdl.org>
	<421993A2.4020308@ak.jp.nec.com>
	<421B955A.9060000@sgi.com>
	<421C2B99.2040600@ak.jp.nec.com>
	<20050222232002.4d934465.akpm@osdl.org>
	<1109147623.1738.91.camel@frecb000711.frec.bull.fr>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Guillaume Thouvenin <guillaume.thouvenin@bull.net> wrote:
>
> ...
> 
> > We really want to avoid doing such stuff in-kernel if at all possible, of
> > course.
> > 
> > Is it not possible to implement the fork/exec/exit notifications to
> > userspace so that a daemon can track the process relationships and perform
> > aggregation based upon individual tasks' accounting?  That's what one of
> > the accounting systems is proposing doing, I believe.
> 
> It's what I'm proposing. The problem is to be alerted when a new process
> is created in order to add it in the correct group of processes if the
> parent belongs to one (or several) groups. The notification can be done
> with the fork connector patch. 

Yes, it sounds sane.

The 2.6.8.1 ELSA patch adds quite a bit of kernel code, but from what
you're saying it seems like most of that has become redundant, and all
you now need is the fork notifier.  Is that correct?

That 2.6.8.1 ELSA patch looks reasonable to me - it only adds two lines to
generic code and the rest looks pretty straightforward.  Are we sure that
this level of functionality is not sufficient for everyone else?

> > (In fact, why do we even need the notifications?  /bin/ps can work this
> > stuff out).
> 
> Yes it can but the risk is to lose some forks no? 
> I think that /bin/ps is using the /proc interface. If we're polling
> the /proc to catch process creation we may lost some of them. With the
> fork connector we catch all forks and we can check that by using the
> sequence number (incremented by each fork) of the message.

Oh, I wasn't proposing that it all be done via existing /proc interfaces -
I was just getting my head straight ;)

