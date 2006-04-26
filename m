Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751184AbWDZI2f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751184AbWDZI2f (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 04:28:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751196AbWDZI2f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 04:28:35 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:31945 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751184AbWDZI2f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 04:28:35 -0400
Subject: Re: [PATCH] likely cleanup: remove unlikely for kfree(NULL)
From: Arjan van de Ven <arjan@infradead.org>
To: Pekka J Enberg <penberg@cs.Helsinki.FI>
Cc: Hua Zhong <hzhong@gmail.com>, linux-kernel@vger.kernel.org, akpm@osdl.org
In-Reply-To: <Pine.LNX.4.58.0604261112120.3522@sbz-30.cs.Helsinki.FI>
References: <Pine.LNX.4.64.0604251120420.5810@localhost.localdomain>
	 <84144f020604260030v26f42b0bke639053928d5e471@mail.gmail.com>
	 <1146038324.5956.0.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.58.0604261112120.3522@sbz-30.cs.Helsinki.FI>
Content-Type: text/plain
Date: Wed, 26 Apr 2006 10:27:18 +0200
Message-Id: <1146040038.7016.0.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-04-26 at 11:16 +0300, Pekka J Enberg wrote:
> On 4/25/06, Hua Zhong <hzhong@gmail.com> wrote:
> > > > diff --git a/mm/slab.c b/mm/slab.c
> > > > index e6ef9bd..0fbc854 100644
> > > > --- a/mm/slab.c
> > > > +++ b/mm/slab.c
> > > > @@ -3380,7 +3380,7 @@ void kfree(const void *objp)
> > > >         struct kmem_cache *c;
> > > >         unsigned long flags;
> > > >
> > > > -       if (unlikely(!objp))
> > > > +       if (!objp)
> > > >                 return;
> 
> > On Wed, 2006-04-26 at 10:30 +0300, Pekka Enberg wrote:
> > > NAK. Fix the callers instead.
> 
> On Wed, 26 Apr 2006, Arjan van de Ven wrote:
> > eh dude... they are being fixed... to remove the NULL check :)
> 
> Most of which are on error paths. The problem we're seeing is in handful 
> of fastpath offenders which should be fixed either by re-design or adding 
> the NULL check along with a big fat comment like Andrew is doing.

what I would like is kfree to become an inline wrapper that does the
null check inline, that way gcc can optimize it out (and it will in 4.1
with the VRP pass) if gcc can prove it's not NULL.


