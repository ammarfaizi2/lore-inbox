Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932482AbWAXSiZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932482AbWAXSiZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 13:38:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932484AbWAXSiZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 13:38:25 -0500
Received: from users.ccur.com ([66.10.65.2]:26819 "EHLO gamx.iccur.com")
	by vger.kernel.org with ESMTP id S932482AbWAXSiZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 13:38:25 -0500
Date: Tue, 24 Jan 2006 13:38:08 -0500
From: Joe Korty <joe.korty@ccur.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Christoph Hellwig <hch@infradead.org>, mingo@elte.hu, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: Define __raw_read_lock etc for uniprocessor builds
Message-ID: <20060124183808.GA16507@tsunami.ccur.com>
Reply-To: joe.korty@ccur.com
References: <20060124180954.GA14506@tsunami.ccur.com> <20060124181712.GA13277@infradead.org> <20060124182942.GA16241@tsunami.ccur.com> <1138127523.2977.70.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1138127523.2977.70.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2006 at 07:32:02PM +0100, Arjan van de Ven wrote:
> On Tue, 2006-01-24 at 13:29 -0500, Joe Korty wrote:
> > On Tue, Jan 24, 2006 at 06:17:12PM +0000, Christoph Hellwig wrote:
> > > On Tue, Jan 24, 2006 at 01:09:54PM -0500, Joe Korty wrote:
> > > > 
> > > > Make NOPed versions of __raw_read_lock and family available
> > > > under uniprocessor kernels.
> > > > 
> > > > Discovered when compiling a uniprocessor kernel with the
> > > > fusyn patch applied.
> > > > 
> > > > The standard kernel does not use __raw_read_lock etc
> > > > outside of spinlock.c, which may account for this bug
> > > > being undiscovered until now.
> > > 
> > > No one should call these directly.   Please fix your odd patch instead.
> > 
> > Actually the patch calls the _raw version which is #defined to the __raw
> > version.  So it is doing the correct thing.
> 
> no it's not, it has no business calling the _raw version either.

Nope.

1) The _raw_spin_lock family is used everywhere in the kernel.  Why the
arbitrary special rule for _raw_read_lock??????  It makes no sense.

2) The _raw versions are intended to be used in places where it is
known that preemption is already disabled, so that the overhead of
re-disabling/enabling it can be avoided.

Joe
--
"All the revision in the world will not save a bad first draft, for the
architecture of the thing comes, or fails to come, in the first conception,
and revision only affects the detail and ornament. -- T.E. Lawrence
