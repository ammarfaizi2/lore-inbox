Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161057AbWJKNz1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161057AbWJKNz1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 09:55:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161059AbWJKNz1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 09:55:27 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:26293 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1161057AbWJKNz1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 09:55:27 -0400
Subject: Re: RSS accounting (was: Re: 2.6.19-rc1-mm1)
From: Arjan van de Ven <arjan@infradead.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>, linux-mm@kvack.org,
       Nick Piggin <npiggin@suse.de>
In-Reply-To: <m17iz7m4xr.fsf@ebiederm.dsl.xmission.com>
References: <20061010000928.9d2d519a.akpm@osdl.org>
	 <1160464800.3000.264.camel@laptopd505.fenrus.org>
	 <20061010004526.c7088e79.akpm@osdl.org>
	 <1160467401.3000.276.camel@laptopd505.fenrus.org>
	 <1160486087.25613.52.camel@taijtu>
	 <1160496790.3000.319.camel@laptopd505.fenrus.org>
	 <m11wpfohg7.fsf@ebiederm.dsl.xmission.com>
	 <1160556462.3000.359.camel@laptopd505.fenrus.org>
	 <m17iz7m4xr.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Wed, 11 Oct 2006 15:55:13 +0200
Message-Id: <1160574913.3000.378.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-10-11 at 06:07 -0600, Eric W. Biederman wrote:
> Arjan van de Ven <arjan@infradead.org> writes:
> 
> > On Tue, 2006-10-10 at 17:54 -0600, Eric W. Biederman wrote:
> >
> >> For processes shared pages are not special.
> 
> Actually the above is not quite true you can map a shared page twice
> into the same process but in practice it rarely happens.

yeah I'm entirely fine with ignoring that case (or making the person who
does it pay for it :)

> 
> > depends on what question you want to answer with RSS.
> > If the question is "workload working set size" then you are right. If
> > the question is "how much ram does my application cause to be used" the
> > answer is FAR less clear....
> 
> There are two basic concerns.  How do you keep an application from
> going crazy and trashing the rest of your system?  A question on what
> number do you need to implement a resource limit.

yet at the same time if 2 apps mmap a shared file, and app 1 keeps it in
pagecache, it doesn't cause app2 to trash, or rather, it's not like if
app 2 did NOT have the page from that file, the system wouldn't trash.


> > You seem to have an implicit definition on what RSS should mean; but
> > it's implicit. Mind making an explicit definition of what RSS should be
> > in your opinion? I think that's the biggest problem we have right now;
> > several people have different ideas about what it should/could be, and
> > as such we're not talking about the same thing. Lets first agree/specify
> > what it SHOULD mean, and then we can figure out what gets counted for
> > that ;)
> 
> Well I tried to defined it in terms of what you can use it for.
> 
> I would define the resident set size as the total number of bytes
> of physical RAM that a process (or set of processes) is using,
> irrespective of the rest of the system.  
>  
> 
> So I think the counting should be primarily about what is mapped into
> the page tables.  But other things can be added as is appropriate or
> easy.
> 
> The practical effect should be that an application that needs more
> pages than it's specified RSS to avoid thrashing should thrash but
> it shouldn't take the rest of the system with it.


so by your definition, hugepages are part of RSS.

Ken: what is your definition of RSS ?


