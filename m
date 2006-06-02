Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751243AbWFBHJP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751243AbWFBHJP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 03:09:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751244AbWFBHJP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 03:09:15 -0400
Received: from smtp.osdl.org ([65.172.181.4]:36993 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751243AbWFBHJO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 03:09:14 -0400
Date: Fri, 2 Jun 2006 00:13:09 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Jan Beulich" <jbeulich@novell.com>
Cc: mingo@elte.hu, jeff@garzik.org, htejun@gmail.com, reuben-lkml@reub.net,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rc5-mm2
Message-Id: <20060602001309.e8bc0b75.akpm@osdl.org>
In-Reply-To: <447FFCAC.76E4.0078.0@novell.com>
References: <20060601014806.e86b3cc0.akpm@osdl.org>
	<447EB4AD.4060101@reub.net>
	<20060601025632.6683041e.akpm@osdl.org>
	<447EBD46.7010607@reub.net>
	<20060601103315.GA1865@elte.hu>
	<20060601105300.GA2985@elte.hu>
	<447EF7A8.76E4.0078.0@novell.com>
	<447FFCAC.76E4.0078.0@novell.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 02 Jun 2006 08:54:04 +0200
"Jan Beulich" <jbeulich@novell.com> wrote:

> >- Make the code robust and able to detect "unexpected" states at all
> >  points through the process.  If at the end of the process we see that we
> >  have encountered an unexpected state,
> 
> The problem is that the unwind is expected to end with an odd state (i.e. fail), at least until all possible root
> points of execution (i.e. bottoms of call stacks) have a proper annotation forcing their parent program counter to zero
> (which I don't expect to happen soon, if ever, because I think this is something difficult to prove). Thus the only
> reasonable thing to do is to check whether the first level of unwinding failed.
> 

Are there other heuristics we can apply?  For example, we have a pretty
good idea whereabouts the top of a kernel stack is.  If we don't end up
close to that offset then we can assume that something went wrong?

> >  - emit a diagnostic so Jan can work out if there's a way to improve
> >    the unwinder in this situation
> 
> >  - do a traditional backtrace as well.
> 
> This might be a config or boot option (and might be forced on for a short while), but I generally don't think this is
> helpful, given that the entire point of the added logic is to remove (useless) information (even more that if you have
> to rely on the screen alone, you have to live with its limited size, and pushing out an old-style stack trace after the
> unwound one would likely make part or all of it as well as the register information disappear).
> 

Plus a config or boot option is too late.


