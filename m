Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264577AbUEJJrh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264577AbUEJJrh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 05:47:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264592AbUEJJrh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 05:47:37 -0400
Received: from fw.osdl.org ([65.172.181.6]:18923 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264591AbUEJJrd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 05:47:33 -0400
Date: Mon, 10 May 2004 02:46:58 -0700
From: Andrew Morton <akpm@osdl.org>
To: arjanv@redhat.com
Cc: helgehaf@aitel.hist.no, mpm@selenic.com, linux-kernel@vger.kernel.org
Subject: Re: dentry bloat.
Message-Id: <20040510024658.53cb0b80.akpm@osdl.org>
In-Reply-To: <1084177928.4925.13.camel@laptop.fenrus.com>
References: <20040508120148.1be96d66.akpm@osdl.org>
	<Pine.LNX.4.58.0405081208330.3271@ppc970.osdl.org>
	<Pine.LNX.4.58.0405081216510.3271@ppc970.osdl.org>
	<20040508204239.GB6383@in.ibm.com>
	<20040508135512.15f2bfec.akpm@osdl.org>
	<20040508211920.GD4007@in.ibm.com>
	<20040508171027.6e469f70.akpm@osdl.org>
	<Pine.LNX.4.58.0405081947290.1592@ppc970.osdl.org>
	<20040508201215.24f0d239.davem@redhat.com>
	<Pine.LNX.4.58.0405082039510.1592@ppc970.osdl.org>
	<20040509210312.GL5414@waste.org>
	<409F3CEE.8060102@aitel.hist.no>
	<1084177928.4925.13.camel@laptop.fenrus.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjanv@redhat.com> wrote:
>
> On Mon, 2004-05-10 at 10:27, Helge Hafting wrote:
>  > Matt Mackall wrote:
>  > 
>  > >One also wonders about whether all the RCU stuff is needed on UP. I'm
>  > >not sure if I grok all the finepoints here, but it looks like the
>  > >answer is no and that we can make struct_rcu head empty and have
>  > >call_rcu fall directly through to the callback. This would save
>  > >something like 16-32 bytes (32/64bit), not to mention a bunch of
>  > >dinking around with lists and whatnot.
>  > >
>  > >So what am I missing?
>  > >  
>  > >
>  > Preempt can happen anytime, I believe.
> 
>  ok so for UP-non-preempt we can still get those 16 bytes back from the
>  dentry....

I suppose so.  And on small SMP, really.  We chose not to play those games
early on so the code got the best testing coverage.

