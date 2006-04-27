Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964988AbWD0I4Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964988AbWD0I4Q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 04:56:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964989AbWD0I4Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 04:56:16 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:32015 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S964988AbWD0I4P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 04:56:15 -0400
Date: Thu, 27 Apr 2006 10:56:14 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Pekka J Enberg <penberg@cs.Helsinki.FI>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       Hua Zhong <hzhong@gmail.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [PATCH] likely cleanup: remove unlikely for kfree(NULL)
Message-ID: <20060427085614.GE3570@stusta.de>
References: <1146046118.7016.5.camel@laptopd505.fenrus.org> <Pine.LNX.4.58.0604261354310.9797@sbz-30.cs.Helsinki.FI> <1146049414.7016.9.camel@laptopd505.fenrus.org> <20060426110656.GD29108@wohnheim.fh-wedel.de> <Pine.LNX.4.58.0604270853510.20454@sbz-30.cs.Helsinki.FI> <445061DC.5030008@yahoo.com.au> <Pine.LNX.4.58.0604270926380.20454@sbz-30.cs.Helsinki.FI> <1146120640.2894.1.camel@laptopd505.fenrus.org> <20060427083157.GD3570@stusta.de> <1146127273.2894.21.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1146127273.2894.21.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 27, 2006 at 10:41:12AM +0200, Arjan van de Ven wrote:
> On Thu, 2006-04-27 at 10:31 +0200, Adrian Bunk wrote:
> > On Thu, Apr 27, 2006 at 08:50:40AM +0200, Arjan van de Ven wrote:
> > > On Thu, 2006-04-27 at 09:28 +0300, Pekka J Enberg wrote:
> > > > On Thu, 27 Apr 2006, Nick Piggin wrote:
> > > > > Not to dispute your conclusions or method, but I think doing a
> > > > > defconfig or your personal config might be more representative
> > > > > of % size increase of text that will actually be executed. And
> > > > > that is the expensive type of text.
> > > > 
> > > > True but I was under the impression that Arjan thought we'd get text 
> > > > savings with GCC 4.1 by making kfree() inline.
> > > 
> > > not savings in text size, I'll settle for the same size.
> > >...
> > 
> > It will always be bigger since there are cases where it's unknown at 
> > compile time whether it will be NULL when called.
> 
> if it's "unknown" you could call into a separate kfree() which does
> check out of line. (sure that's a dozen bytes bigger but that is
> noise ;)

It's noise and _much work.

So in the end, we are removing the current kfree() and replacing them 
with one kfree_can_be_null() and one kfree_cannot_be_null()
(one of them might continue to be called kfree())?

Keeping kfree() as it is today has the advantages:
- smallest code
- noone can forget the NULL check
- KISS

Do you have any benchmarks where your approach brings a measurable 
benefit? I wouldn't have expected kfree() being in many hotpaths.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

