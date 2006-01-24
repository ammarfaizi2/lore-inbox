Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161025AbWAXSmm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161025AbWAXSmm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 13:42:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932485AbWAXSmm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 13:42:42 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:20712 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932465AbWAXSml (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 13:42:41 -0500
Subject: Re: Define __raw_read_lock etc for uniprocessor builds
From: Arjan van de Ven <arjan@infradead.org>
To: joe.korty@ccur.com
Cc: Christoph Hellwig <hch@infradead.org>, mingo@elte.hu, akpm@osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060124183808.GA16507@tsunami.ccur.com>
References: <20060124180954.GA14506@tsunami.ccur.com>
	 <20060124181712.GA13277@infradead.org>
	 <20060124182942.GA16241@tsunami.ccur.com>
	 <1138127523.2977.70.camel@laptopd505.fenrus.org>
	 <20060124183808.GA16507@tsunami.ccur.com>
Content-Type: text/plain
Date: Tue, 24 Jan 2006 19:42:36 +0100
Message-Id: <1138128156.2977.73.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-01-24 at 13:38 -0500, Joe Korty wrote:
> On Tue, Jan 24, 2006 at 07:32:02PM +0100, Arjan van de Ven wrote:
> > On Tue, 2006-01-24 at 13:29 -0500, Joe Korty wrote:
> > > On Tue, Jan 24, 2006 at 06:17:12PM +0000, Christoph Hellwig wrote:
> > > > On Tue, Jan 24, 2006 at 01:09:54PM -0500, Joe Korty wrote:
> > > > > 
> > > > > Make NOPed versions of __raw_read_lock and family available
> > > > > under uniprocessor kernels.
> > > > > 
> > > > > Discovered when compiling a uniprocessor kernel with the
> > > > > fusyn patch applied.
> > > > > 
> > > > > The standard kernel does not use __raw_read_lock etc
> > > > > outside of spinlock.c, which may account for this bug
> > > > > being undiscovered until now.
> > > > 
> > > > No one should call these directly.   Please fix your odd patch instead.
> > > 
> > > Actually the patch calls the _raw version which is #defined to the __raw
> > > version.  So it is doing the correct thing.
> > 
> > no it's not, it has no business calling the _raw version either.
> 
> Nope.
> 
> 1) The _raw_spin_lock family is used everywhere in the kernel.  

no it's not. It's used in a few very special architecture places, and in
the spinlock.c code, and in one place of the scheduler, which is
arguably special.

I don't know what kernel you're looking at.. but it's not a kernel.org
one.


> 2) The _raw versions are intended to be used in places where it is
> known that preemption is already disabled, so that the overhead of
> re-disabling/enabling it can be avoided.

that's not true either. If it was, then the name would have been
different.



