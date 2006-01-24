Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964995AbWAXS7Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964995AbWAXS7Y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 13:59:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965001AbWAXS7Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 13:59:24 -0500
Received: from users.ccur.com ([66.10.65.2]:25558 "EHLO gamx.iccur.com")
	by vger.kernel.org with ESMTP id S964995AbWAXS7Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 13:59:24 -0500
Date: Tue, 24 Jan 2006 13:59:03 -0500
From: Joe Korty <joe.korty@ccur.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Christoph Hellwig <hch@infradead.org>, mingo@elte.hu, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: Define __raw_read_lock etc for uniprocessor builds
Message-ID: <20060124185903.GA16565@tsunami.ccur.com>
Reply-To: joe.korty@ccur.com
References: <20060124180954.GA14506@tsunami.ccur.com> <20060124181712.GA13277@infradead.org> <20060124182942.GA16241@tsunami.ccur.com> <1138127523.2977.70.camel@laptopd505.fenrus.org> <20060124183808.GA16507@tsunami.ccur.com> <1138128156.2977.73.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1138128156.2977.73.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2006 at 07:42:36PM +0100, Arjan van de Ven wrote:
> On Tue, 2006-01-24 at 13:38 -0500, Joe Korty wrote:
> > On Tue, Jan 24, 2006 at 07:32:02PM +0100, Arjan van de Ven wrote:
> > > On Tue, 2006-01-24 at 13:29 -0500, Joe Korty wrote:
> > > > On Tue, Jan 24, 2006 at 06:17:12PM +0000, Christoph Hellwig wrote:
> > > > > On Tue, Jan 24, 2006 at 01:09:54PM -0500, Joe Korty wrote:
> > > > > > 
> > > > > > Make NOPed versions of __raw_read_lock and family available
> > > > > > under uniprocessor kernels.
> > > > > > 
> > > > > > Discovered when compiling a uniprocessor kernel with the
> > > > > > fusyn patch applied.
> > > > > > 
> > > > > > The standard kernel does not use __raw_read_lock etc
> > > > > > outside of spinlock.c, which may account for this bug
> > > > > > being undiscovered until now.
> > > > > 
> > > > > No one should call these directly.   Please fix your odd patch instead.
> > > > 
> > > > Actually the patch calls the _raw version which is #defined to the __raw
> > > > version.  So it is doing the correct thing.
> > > 
> > > no it's not, it has no business calling the _raw version either.
> > 
> > Nope.
> > 
> > 1) The _raw_spin_lock family is used everywhere in the kernel.  
> 
> no it's not. It's used in a few very special architecture places, and in
> the spinlock.c code, and in one place of the scheduler, which is
> arguably special.
> 
> I don't know what kernel you're looking at.. but it's not a kernel.org
> one.
> 
> 
> > 2) The _raw versions are intended to be used in places where it is
> > known that preemption is already disabled, so that the overhead of
> > re-disabling/enabling it can be avoided.
> 
> that's not true either. If it was, then the name would have been
> different.

I'll leave it to Ingo to decide.  After all, the NOPed versions are in the
tree already and have been for some time.  They just are under the wrong
#ifdef, so it seems like it was his intent to provide it, but failed to
do so in a way that actually enabled them.

(and '_raw'  is a perfect prefix for the core spinlock services).

Joe
