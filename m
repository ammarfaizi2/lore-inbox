Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750953AbWDZKFk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750953AbWDZKFk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 06:05:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751398AbWDZKFk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 06:05:40 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:18436 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750953AbWDZKFk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 06:05:40 -0400
Date: Wed, 26 Apr 2006 12:05:39 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Pekka J Enberg <penberg@cs.Helsinki.FI>, Hua Zhong <hzhong@gmail.com>,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] likely cleanup: remove unlikely for kfree(NULL)
Message-ID: <20060426100539.GF9359@stusta.de>
References: <Pine.LNX.4.64.0604251120420.5810@localhost.localdomain> <84144f020604260030v26f42b0bke639053928d5e471@mail.gmail.com> <1146038324.5956.0.camel@laptopd505.fenrus.org> <Pine.LNX.4.58.0604261112120.3522@sbz-30.cs.Helsinki.FI> <1146040038.7016.0.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1146040038.7016.0.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 26, 2006 at 10:27:18AM +0200, Arjan van de Ven wrote:
> On Wed, 2006-04-26 at 11:16 +0300, Pekka J Enberg wrote:
> > On 4/25/06, Hua Zhong <hzhong@gmail.com> wrote:
> > > > > diff --git a/mm/slab.c b/mm/slab.c
> > > > > index e6ef9bd..0fbc854 100644
> > > > > --- a/mm/slab.c
> > > > > +++ b/mm/slab.c
> > > > > @@ -3380,7 +3380,7 @@ void kfree(const void *objp)
> > > > >         struct kmem_cache *c;
> > > > >         unsigned long flags;
> > > > >
> > > > > -       if (unlikely(!objp))
> > > > > +       if (!objp)
> > > > >                 return;
> > 
> > > On Wed, 2006-04-26 at 10:30 +0300, Pekka Enberg wrote:
> > > > NAK. Fix the callers instead.
> > 
> > On Wed, 26 Apr 2006, Arjan van de Ven wrote:
> > > eh dude... they are being fixed... to remove the NULL check :)
> > 
> > Most of which are on error paths. The problem we're seeing is in handful 
> > of fastpath offenders which should be fixed either by re-design or adding 
> > the NULL check along with a big fat comment like Andrew is doing.
> 
> what I would like is kfree to become an inline wrapper that does the
> null check inline, that way gcc can optimize it out (and it will in 4.1
> with the VRP pass) if gcc can prove it's not NULL.

In many cases it's not clear at compile time whether it will be NULL.

In such cases, your suggestion would result in bigger code.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

