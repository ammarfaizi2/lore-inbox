Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161158AbWI1OoS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161158AbWI1OoS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 10:44:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161160AbWI1OoS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 10:44:18 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:8091 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1161158AbWI1OoR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 10:44:17 -0400
Date: Thu, 28 Sep 2006 20:14:03 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Christoph Hellwig <hch@infradead.org>,
       "Paul E. McKenney" <paulmck@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
Subject: Re: [-mm PATCH 1/4] RCU: split classic rcu
Message-ID: <20060928144403.GA27499@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20060923152957.GA13432@in.ibm.com> <20060923153141.GB13432@in.ibm.com> <20060925165433.GA28898@infradead.org> <20060927163239.GC1291@us.ibm.com> <20060928142616.GA20185@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060928142616.GA20185@infradead.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 28, 2006 at 03:26:16PM +0100, Christoph Hellwig wrote:
> On Wed, Sep 27, 2006 at 09:32:40AM -0700, Paul E. McKenney wrote:
> > We will be switching to a new implementation.  I am working to make it
> > as reliable as I know how, but it seems reasonable to have a changeover
> > period that might be measured in years.  I -really- don't want to be
> > inflicting even the possibility of RCU implementation bugs on anyone who
> > has not "signed up" for code that has not yet be hammered into total
> > and complete submission!  CONFIG_PREEMPT_RT is quite reliable even now,
> > but there is "quite reliable" and then there is "hammered into total
> > and complete submission".  ;-)
> > 
> > Also, we need any new implementation of RCU to be in a separate file.
> > I don't want to even think about the number of times that I accidentally
> > changed the wrong version of RCU when working on the -rt implementation
> > before we split it -- the functions have the same name, right?  :-/
> 
> Still there's absolutely no point in putting all this into mainline.  Do
> it in your toy tree (whether it's called -rt or -pk :)) and keep one
> stable implementation in mainline.  That one implementation should be
> srcu capable rather sooner than later (as soon as you're satisfied with it)
> because there's lots of interesting use cases for sleeping in RCU read
> sections.  But until then keep the mainline code simple.

Christoph,

The RCU read path is so sensitive that unless a large number of
users test the rcupreempt implementation, it will be difficult
for us to safely switch over without hurting. We cannot get that
test exposure from -rt or -pk :-) Really, the mainline code split is
very simple and should be maintainable with an understanding
that within a year or so, we can switch over to just one
implementation. I am not comfortable with the risk of causing
sudden performance problems for some users. By staging it,
we can minimize that risk.

Srcu is independent of the underlying RCU mechanism, it works with 
both the RCU implementations.

Thanks
Dipankar
