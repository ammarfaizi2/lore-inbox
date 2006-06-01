Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750861AbWFASa4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750861AbWFASa4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 14:30:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965097AbWFASa4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 14:30:56 -0400
Received: from smtp.osdl.org ([65.172.181.4]:37274 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750861AbWFASaz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 14:30:55 -0400
Date: Thu, 1 Jun 2006 11:34:55 -0700
From: Andrew Morton <akpm@osdl.org>
To: jbeulich@novell.com, mingo@elte.hu, jeff@garzik.org, htejun@gmail.com,
       reuben-lkml@reub.net, linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rc5-mm2
Message-Id: <20060601113455.c02ba3cc.akpm@osdl.org>
In-Reply-To: <20060601091927.31414541.akpm@osdl.org>
References: <20060601014806.e86b3cc0.akpm@osdl.org>
	<447EB4AD.4060101@reub.net>
	<20060601025632.6683041e.akpm@osdl.org>
	<447EBD46.7010607@reub.net>
	<20060601103315.GA1865@elte.hu>
	<20060601105300.GA2985@elte.hu>
	<447EF7A8.76E4.0078.0@novell.com>
	<20060601091927.31414541.akpm@osdl.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Jun 2006 09:19:27 -0700
Andrew Morton <akpm@osdl.org> wrote:

> > It can't do anything
> > in that case, so the only solution I see is to either
> > - not at all call the unwinder from trap.c if the instruction pointer before the first unwind is not within kernel
> > space, or
> > - force fall-through to the old logic if the first unwind attempt didn't yield a change to either rIP or rSP (implying
> > that in that case there was no unwind information found to start with).
> > 
> > What do you think?
> 
> - Make the code robust and able to detect "unexpected" states at all
>   points through the process.  If at the end of the process we see that we
>   have encountered an unexpected state,
> 
>   - emit a diagnostic so Jan can work out if there's a way to improve
>     the unwinder in this situation
> 
>   - do a traditional backtrace as well.

Let me just agree with myself here.  It would be wildly unacceptable for
the unwinder to cause us to get _less_ information than we presently do
under any circumstances, please.  That would be a really bad impediment to
kernel development.
