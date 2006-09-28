Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751891AbWI1O0d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751891AbWI1O0d (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 10:26:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751067AbWI1O0d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 10:26:33 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:57512 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750720AbWI1O0d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 10:26:33 -0400
Date: Thu, 28 Sep 2006 15:26:16 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "Paul E. McKenney" <paulmck@us.ibm.com>
Cc: Dipankar Sarma <dipankar@in.ibm.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
Subject: Re: [-mm PATCH 1/4] RCU: split classic rcu
Message-ID: <20060928142616.GA20185@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Paul E. McKenney" <paulmck@us.ibm.com>,
	Dipankar Sarma <dipankar@in.ibm.com>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
References: <20060923152957.GA13432@in.ibm.com> <20060923153141.GB13432@in.ibm.com> <20060925165433.GA28898@infradead.org> <20060927163239.GC1291@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060927163239.GC1291@us.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 27, 2006 at 09:32:40AM -0700, Paul E. McKenney wrote:
> We will be switching to a new implementation.  I am working to make it
> as reliable as I know how, but it seems reasonable to have a changeover
> period that might be measured in years.  I -really- don't want to be
> inflicting even the possibility of RCU implementation bugs on anyone who
> has not "signed up" for code that has not yet be hammered into total
> and complete submission!  CONFIG_PREEMPT_RT is quite reliable even now,
> but there is "quite reliable" and then there is "hammered into total
> and complete submission".  ;-)
> 
> Also, we need any new implementation of RCU to be in a separate file.
> I don't want to even think about the number of times that I accidentally
> changed the wrong version of RCU when working on the -rt implementation
> before we split it -- the functions have the same name, right?  :-/

Still there's absolutely no point in putting all this into mainline.  Do
it in your toy tree (whether it's called -rt or -pk :)) and keep one
stable implementation in mainline.  That one implementation should be
srcu capable rather sooner than later (as soon as you're satisfied with it)
because there's lots of interesting use cases for sleeping in RCU read
sections.  But until then keep the mainline code simple.
