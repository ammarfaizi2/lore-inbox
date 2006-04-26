Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751151AbWDZIQU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751151AbWDZIQU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 04:16:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751184AbWDZIQU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 04:16:20 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:24749 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1751151AbWDZIQU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 04:16:20 -0400
Date: Wed, 26 Apr 2006 11:16:17 +0300 (EEST)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: Arjan van de Ven <arjan@infradead.org>
cc: Hua Zhong <hzhong@gmail.com>, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] likely cleanup: remove unlikely for kfree(NULL)
In-Reply-To: <1146038324.5956.0.camel@laptopd505.fenrus.org>
Message-ID: <Pine.LNX.4.58.0604261112120.3522@sbz-30.cs.Helsinki.FI>
References: <Pine.LNX.4.64.0604251120420.5810@localhost.localdomain> 
 <84144f020604260030v26f42b0bke639053928d5e471@mail.gmail.com>
 <1146038324.5956.0.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/25/06, Hua Zhong <hzhong@gmail.com> wrote:
> > > diff --git a/mm/slab.c b/mm/slab.c
> > > index e6ef9bd..0fbc854 100644
> > > --- a/mm/slab.c
> > > +++ b/mm/slab.c
> > > @@ -3380,7 +3380,7 @@ void kfree(const void *objp)
> > >         struct kmem_cache *c;
> > >         unsigned long flags;
> > >
> > > -       if (unlikely(!objp))
> > > +       if (!objp)
> > >                 return;

> On Wed, 2006-04-26 at 10:30 +0300, Pekka Enberg wrote:
> > NAK. Fix the callers instead.

On Wed, 26 Apr 2006, Arjan van de Ven wrote:
> eh dude... they are being fixed... to remove the NULL check :)

Most of which are on error paths. The problem we're seeing is in handful 
of fastpath offenders which should be fixed either by re-design or adding 
the NULL check along with a big fat comment like Andrew is doing.

					Pekka
