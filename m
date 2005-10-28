Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965045AbVJ1Bgi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965045AbVJ1Bgi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 21:36:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965044AbVJ1Bgi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 21:36:38 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:7592 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S965045AbVJ1Bgh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 21:36:37 -0400
Subject: Re: Notifier chains are unsafe
From: Chandra Seetharaman <sekharan@us.ibm.com>
Reply-To: sekharan@us.ibm.com
To: Joe Seigh <jseigh_02@xemaps.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <djp9r4$8dj$1@sea.gmane.org>
References: <Pine.LNX.4.44L0.0510261636580.7186-100000@iolanthe.rowland.org>
	 <200510262344.37982.ak@suse.de> <1130368820.3586.213.camel@linuxchandra>
	 <djp9r4$8dj$1@sea.gmane.org>
Content-Type: text/plain
Organization: IBM
Date: Thu, 27 Oct 2005 18:36:36 -0700
Message-Id: <1130463396.3586.282.camel@linuxchandra>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-10-26 at 21:17 -0400, Joe Seigh wrote:
> Chandra Seetharaman wrote:
> > Andy, comment above rcu_read_lock says, "It is illegal to block while in
> > an RCU read-side critical section."
> > 
> > As i mentioned in the other email we are discussing about "task
> > notifier" in lse-tech. We thought of using RCU, but one of the
> > requirements was that the registered function should be able to block,
> > so we are looking for alternatives.
> > 
> 
> What are the requirements that preclude a conventional rwlock?  If you
> don't have any, then you should go with that.

I was thinking the problem is that we cannot hold any locks while
calling the callouts.

But, As Keith mentioned, we cannot even acquire a lock in the
notifier_call_chain.

Thanks,

chandra  
> 
> The other solutions I've mentioned before.
> 
> Copy on read.
> 
> Various lock-free schemes:
> SMR hazard pointers
> RCU+SMR (probably overkill since you don't need the read side performance)
> reference counting
> proxy reference counting
> 
> The last would probably be the easiest to implement expecially if you used
> a spinlock to safely increment the reference count without the more complicated
> atomic thread-safety.  It's also more self contained.
> 
> User land implementations of most of the above can be found at
> http://sourceforge.net/projects/atomic-ptr-plus/
> 
> The proxy refcounting stuff is in the atomic-ptr-plus package.  It's
> in c++ but you should be able to figure it out.
> 
> RCU+SMR is in the fastsmr package.
> 
> 
> 
> --
> Joe Seigh
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


