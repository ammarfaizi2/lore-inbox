Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161268AbWHJNk4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161268AbWHJNk4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 09:40:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161272AbWHJNk4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 09:40:56 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:19104 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1161268AbWHJNkz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 09:40:55 -0400
Date: Thu, 10 Aug 2006 06:41:35 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Mike Christie <michaelc@cs.wisc.edu>
Cc: stelian@popies.net, linux-kernel@vger.kernel.org, akpm@osdl.org,
       paulus@au1.ibm.com, anton@au1.ibm.com, open-iscsi@googlegroups.com,
       pradeep@us.ibm.com, mashirle@us.ibm.com
Subject: Re: [PATCH] memory ordering in __kfifo primitives
Message-ID: <20060810134135.GB1298@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20060810001823.GA3026@us.ibm.com> <20060810003310.GA3071@us.ibm.com> <44DAC892.7000100@cs.wisc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44DAC892.7000100@cs.wisc.edu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2006 at 01:48:02AM -0400, Mike Christie wrote:
> Paul E. McKenney wrote:
> > OK, it appears that we are even.  I forgot to attach the promised
> > analysis of the callers to __kfifo_put() and __kfifo_get(), and
> > the open-iscsi@googlegroups.com email address listed as maintainer
> > in drivers/scsi/libiscsi.c bounces complaining that, as a non-member,
> > I am not allowed to send it email.  ;-)
> 
> Sorry about that. I do not have any control over the email list. I will
> change the maintainer info entry to indicate that users should just send
> mail to me or linux-scsi.

Sounds good!

> > Anyway, this time the analysis really is attached, sorry for my confusion!
> 
> We have change the code a little since the analysis was made. But, it
> does not really matter much now. I am fine with us just grabbing the
> session lock or xmitmitex (I will send a patch and test it as well) if
> your barrier patch is not accepted. We grab the session lock in the fast
> path now so there is not much benefit left for us.

I am happy to go either way -- the patch with the memory barriers
(which does have the side-effect of slowing down kfifo_get() and
kfifo_put(), by the way), or a patch removing the comments saying
that it is OK to invoke __kfifo_get() and __kfifo_put() without
locking.

Any other thoughts on which is better?  (1) the memory barriers or
(2) requiring the caller hold appropriate locks across calls to
__kfifo_get() and __kfifo_put()?

							Thanx, Paul
