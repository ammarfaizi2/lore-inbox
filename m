Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964891AbVJDSM2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964891AbVJDSM2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 14:12:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964897AbVJDSM2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 14:12:28 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:14476 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964891AbVJDSM1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 14:12:27 -0400
Date: Tue, 4 Oct 2005 19:12:26 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "Vladimir V. Saveliev" <vs@namesys.com>
Cc: Christoph Hellwig <hch@infradead.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: I request inclusion of reiser4 in the mainline kernel
Message-ID: <20051004181226.GA30125@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Vladimir V. Saveliev" <vs@namesys.com>,
	LKML <linux-kernel@vger.kernel.org>
References: <432AFB44.9060707@namesys.com> <20050918110658.GA22744@infradead.org> <432E8282.6060905@namesys.com> <20050919092444.GA17501@infradead.org> <43302CF7.2010901@namesys.com> <20050920154711.GA6698@infradead.org> <433D2B21.6040406@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <433D2B21.6040406@namesys.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 30, 2005 at 04:10:09PM +0400, Vladimir V. Saveliev wrote:
> > Looking at the actual code all these point to the spin lock obsufcation
> > SPIN_LOCK_FUNCTIONS/RW_LOCK_FUNCTIONS from spin_macros.h which I told
> > to get rid of in the first round of reviews. 
> > ...
> 
> reiser4 spinlock macros provide following functionality:
> 
>     (1) encapsulation of locks: instead of writing spin_lock(&obj->lock),
>     where obj is object of type foo, one writes spin_lock_foo(obj).
> 
>     (2) keeping information about number of locks of particular type currently
> held by thread
> 
>     (3) checking that locks are acquired in the proper order.
> 
>     (4) collection of spin lock contention statistics
> 
> 
> I agree that (1) is not very necessary. (2) and (4) helped a lot in early
> debugging. Now we are about to remove it.
> 
> However, we would prefer to keep (3). It makes catching spinlock deadlocks very
> easy. Don't you think that makes sence?

(4) is provided by the lockmeter patch which is or has been in -mm.
(1) is not just unessecary but actually considered obsfucation
(2) and (3) sounds useful and it would be cool if you could integrate
them into the core spinlock code.  I'd suggest to remove the feature
temporarily and reimplement it so further reiser4 progress isn't blocked
on that.

