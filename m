Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030400AbVJ1WPz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030400AbVJ1WPz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 18:15:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030409AbVJ1WPz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 18:15:55 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:39353 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030400AbVJ1WPy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 18:15:54 -0400
Subject: Re: Notifier chains are unsafe
From: Chandra Seetharaman <sekharan@us.ibm.com>
Reply-To: sekharan@us.ibm.com
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Keith Owens <kaos@ocs.com.au>,
       Kernel development list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.0510280956370.4862-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.0510280956370.4862-100000@iolanthe.rowland.org>
Content-Type: text/plain
Organization: IBM
Date: Fri, 28 Oct 2005 15:15:49 -0700
Message-Id: <1130537749.3586.336.camel@linuxchandra>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-10-28 at 10:23 -0400, Alan Stern wrote:
> On Thu, 27 Oct 2005, Chandra Seetharaman wrote:
> 
> > So, requirements to fix the bug are:
> > 	- no sleeping in register/unregister(if we want to keep the
> >           current way of use. We can change it and make the relevant
> >           changes in the kernel code, if it is agreeable)
> 
> I think we will have to make these changes.  In principal it shouldn't be 
> hard to add a simple "enabled" flag to each callout which currently is
> registered/unregistered atomically or while running.  We could even put 
> such a flag into the notifier_block structure and add routines to set or 
> clear it, using appropriate barriers.

I do not understand the purpose of enabled flag. Can you clarify
> 
> > 	- notifier_call_chain could be called from any context
> > 	- callout function could sleep
> > 	- no acquiring locks in notifier_call_chain
> >         - make sure the list is consistent :) (which is problem Alan
> >           started to fix)
> > 	- anything else ?
> 
> Let's clarify the "list is consistent" statement.  Obviously it implies 
> that no more than one thread can modify the list pointers at any time.  
> Beyond that, there should be a guarantee that when unregister returns, the 
> routine being removed is not in use and will not be called by any thread.  
> Likewise, after register returns, any invocation of notifier_call_chain 
> should see the new routine.

true
> 
> Alan Stern
> 
> 
-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------


