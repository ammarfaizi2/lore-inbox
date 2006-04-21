Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750742AbWDUS44@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750742AbWDUS44 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 14:56:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750807AbWDUS44
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 14:56:56 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:10130 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1750742AbWDUS44 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 14:56:56 -0400
Subject: Re: kfree(NULL)
From: Steven Rostedt <rostedt@goodmis.org>
To: Daniel Walker <dwalker@mvista.com>
Cc: Tilman Schmidt <tilman@imap.cc>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, "Stephen C. Tweedie" <sct@redhat.com>
In-Reply-To: <1145644977.20843.25.camel@localhost.localdomain>
References: <63XWg-1IL-5@gated-at.bofh.it> <63YfP-26I-11@gated-at.bofh.it>
	 <63ZEY-45n-27@gated-at.bofh.it>  <4448F97D.5000205@imap.cc>
	 <1145635403.20843.21.camel@localhost.localdomain>
	 <1145642459.24962.12.camel@localhost.localdomain>
	 <1145644977.20843.25.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 21 Apr 2006 14:56:38 -0400
Message-Id: <1145645798.26713.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-04-21 at 11:42 -0700, Daniel Walker wrote:
> On Fri, 2006-04-21 at 14:00 -0400, Steven Rostedt wrote:
> 
> > [     6491]  c01aafc4 - start_this_handle+0x234/0x4b0
> > [     8404]  c01aba66 - do_get_write_access+0x2e6/0x5a0
> 
> 
> IMO , these two are overloaded with goto's it makes it hard to know
> whats going on .
> 

(I've added Stephen Tweedie to the CC list since these two functions are
his)

Perhaps this patch is something that can be useful. It can tell us where
we need to either fix the logic so that a kfree(NULL) doesn't happen, or
it can tell us where we should have a "if (obj) kfree(obj)" since it is
quicker than doing the function call.

Right now, these two locations seem to be good candidates to putting in
the NULL check before calling kfree.

-- Steve


