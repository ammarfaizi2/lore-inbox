Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750921AbWA0EFL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750921AbWA0EFL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 23:05:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751199AbWA0EFL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 23:05:11 -0500
Received: from [202.53.187.9] ([202.53.187.9]:34232 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S1750921AbWA0EFJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 23:05:09 -0500
From: Nigel Cunningham <nigel@suspend2.net>
Organization: Suspend2.net
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [ 01/23] [Suspend2] Make workqueues freezeable.
Date: Fri, 27 Jan 2006 14:01:30 +1000
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, Pavel Machek <pavel@suse.cz>
References: <20060126034518.3178.55397.stgit@localhost.localdomain> <20060126034527.3178.99591.stgit@localhost.localdomain> <200601270017.18773.rjw@sisk.pl>
In-Reply-To: <200601270017.18773.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601271401.31488.nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael.

On Friday 27 January 2006 09:17, Rafael J. Wysocki wrote:
> Hi,
>
> On Thursday, 26 January 2006 04:45, Nigel Cunningham wrote:
> > Prior to this patch, kernel threads and workqueues are unconditionally
> > unfreezeable. This patch reverses that behaviour, making the default
> > for kernel processes to be frozen. New variations of the routines for
> > starting kernel threads and workqueues (containing _nofreeze_) allow
> > threads that need to run during suspend to be made nofreeze again.
>
> This looks like "let's make everything freezable and hunt for things that
> must not be frozen" kind of approach, but isn't it error-prone?  I mean,
> for example, if someone creates a kernel thread that in fact must not
> be frozen, but forgets to use the _nofreeze_ call, things will break for
> some people and the problem will be worse than the current one,
> it seems.

You're right that the default is now to freeze threads. This is mostly because 
the majority of kernel threads can and should be frozen because they're not 
needed. If a thread is frozen which shouldn't be, the user (which will 
hopefully be the developer testing their work) will experience a deadlock 
when they try to suspend. If, on the other hand, we let threads run that 
should be frozen, well - the outcome depends on what is done when the thread 
should be frozen. Obviously it doesn't hurt too much to let kernel threads 
run, or we'd see problems at the moment. For this reason, I consider this 
patch more to be a nicety than a necessity. Nice because it makes kernel 
threads behave in a manner consistent with what happens to userspace (hence 
defaulting to freezing, rather than not).

Regards,

Nigel
-- 
See our web page for Howtos, FAQs, the Wiki and mailing list info.
http://www.suspend2.net                IRC: #suspend2 on Freenode
