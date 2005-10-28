Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965043AbVJ1BeX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965043AbVJ1BeX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 21:34:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965044AbVJ1BeX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 21:34:23 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:2261 "EHLO e36.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S965043AbVJ1BeW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 21:34:22 -0400
Subject: Re: Notifier chains are unsafe
From: Chandra Seetharaman <sekharan@us.ibm.com>
Reply-To: sekharan@us.ibm.com
To: Keith Owens <kaos@ocs.com.au>, Alan Stern <stern@rowland.harvard.edu>
Cc: Kernel development list <linux-kernel@vger.kernel.org>
In-Reply-To: <6933.1130460480@ocs3.ocs.com.au>
References: <6933.1130460480@ocs3.ocs.com.au>
Content-Type: text/plain
Organization: IBM
Date: Thu, 27 Oct 2005 18:34:17 -0700
Message-Id: <1130463257.3586.278.camel@linuxchandra>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-10-28 at 10:48 +1000, Keith Owens wrote:
> On Thu, 27 Oct 2005 16:02:08 -0700, 
> Chandra Seetharaman <sekharan@us.ibm.com> wrote:
> >On Thu, 2005-10-27 at 17:21 -0400, Alan Stern wrote:
> >> The other problem is that you violated Keith's statement that 
> >> notifier_call_chain shouldn't take any locks.  On the other hand, if we
> >
> >I would interpret Keith's comment like this: callout should not be
> >called with any locks held (because that would limit the callouts from
> >blocking). 
> 
> We should be able to call notifier_call_chain() from any context.  That
> includes oops, panic, NMI and other unmaskable machine check events.
> If you can call notifier_call_chain() from an unmaskable context then
> it follows that the callbacks cannot take any locks.  Locks are not
> safe in NMI context.

Thanks Keith.

That really ties our hands down.

So, requirements to fix the bug are:
	- no sleeping in register/unregister(if we want to keep the
          current way of use. We can change it and make the relevant
          changes in the kernel code, if it is agreeable)
	- notifier_call_chain could be called from any context
	- callout function could sleep
	- no acquiring locks in notifier_call_chain
        - make sure the list is consistent :) (which is problem Alan
          started to fix)
	- anything else ?

Alan, i think your solution of maintaining two notifier chains satisfies
all the needs mentioned. Will look at it more closely and respond
tomorrow.

Thanks & Regards,

chandra

> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 
-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------


