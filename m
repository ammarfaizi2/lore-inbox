Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932682AbVJ0XCL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932682AbVJ0XCL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 19:02:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932680AbVJ0XCL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 19:02:11 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:55971 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S932684AbVJ0XCK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 19:02:10 -0400
Subject: Re: Notifier chains are unsafe
From: Chandra Seetharaman <sekharan@us.ibm.com>
Reply-To: sekharan@us.ibm.com
To: Alan Stern <stern@rowland.harvard.edu>, Keith Owens <kaos@ocs.com.au>
Cc: Kernel development list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.0510271658510.6660-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.0510271658510.6660-100000@iolanthe.rowland.org>
Content-Type: text/plain
Organization: IBM
Date: Thu, 27 Oct 2005 16:02:08 -0700
Message-Id: <1130454128.3586.268.camel@linuxchandra>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-10-27 at 17:21 -0400, Alan Stern wrote:

> > How does the following code look (only change w.r.t the existing usage
> > model is that unregister can now return -EAGAIN, if the list is busy).
> > 
> > One assumption the following code makes is that the store of a pointer
> > (next in the list) is atomic. If that assumption is unacceptable, we can
> > do one of two things:
> >     1. change notify_register to return -EAGAIN if list is busy.
> >     2. move the chain list in call_chain under lock and use that
> >        list instead of using the chain in the head, and restore it back
> >        before returning.
> 
> I see a couple of problems (aside from the trivial one where you increment 
> nh->readers before the early exit).

Just a programmatic error. shouldn't be a problem.

> 
> The biggest problem is allowing unregister to return an error.  None of 
> its callers will expect that, and they all will have to be changed.  There 
> are a lot more calls to unregister than there are chain definitions.

IMO, we will not be changing the interface so it should be fine.

> The other problem is that you violated Keith's statement that 
> notifier_call_chain shouldn't take any locks.  On the other hand, if we

I would interpret Keith's comment like this: callout should not be
called with any locks held (because that would limit the callouts from
blocking). 

Keith, can you please clarify
>  
> put together all the requirements people have listed for notifier chains, 
> the resulting set is inconsistent!  That's part of the reason why I 
> suggested implementing two different kinds of chains.
> 
> Alan Stern
> 
> 
-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------


