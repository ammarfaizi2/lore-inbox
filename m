Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267449AbUJRV6T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267449AbUJRV6T (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 17:58:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267454AbUJRV6T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 17:58:19 -0400
Received: from fw.osdl.org ([65.172.181.6]:38836 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267449AbUJRV6R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 17:58:17 -0400
Date: Mon, 18 Oct 2004 15:02:17 -0700
From: Andrew Morton <akpm@osdl.org>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: Re: [PATCH] add unschedule_delayed_work to the workqueue API
Message-Id: <20041018150217.0fbf714f.akpm@osdl.org>
In-Reply-To: <1098136049.2792.329.camel@mulgrave>
References: <1098117067.2011.64.camel@mulgrave>
	<20041018142524.5b81a09a.akpm@osdl.org>
	<1098134824.2011.322.camel@mulgrave>
	<1098134994.2792.325.camel@mulgrave>
	<20041018144354.2118138f.akpm@osdl.org>
	<1098136049.2792.329.camel@mulgrave>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley <James.Bottomley@SteelEye.com> wrote:
>
> > > OK, found it in the headers, sorry .. it's not synchronous, so it can't
> > > really be used in most of the cases where we use del_timer_sync().
> > 
> > cancel_delayed_work() will tell you whether it successfully cancelled the
> > timer.  If it didn't, you should run flush_workqueue() to wait on the final
> > handler.  The combination of the two is synchronous.
> 
> Right, but it potentially does too much work for my purposes.

Are you sure?

>  I want to
> cancel the work if it's cancellable or wait for it if it's already
> executing.  I don't want to have to wait for all the work in the queue
> just because the timer fired and it got added to the workqueue schedule.

The probability that the handler is running when you call
cancel_delayed_work() is surely very low.  And the probability that there
is more than one thing pending in the queue at that time is also low. 
Multiplying them both together, then multiplying that by the relative
expense of the handler makes me say "show me" ;)
