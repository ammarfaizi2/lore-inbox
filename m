Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266208AbUIOO07@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266208AbUIOO07 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 10:26:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265489AbUIOO07
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 10:26:59 -0400
Received: from sd291.sivit.org ([194.146.225.122]:25559 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S266233AbUIOOVL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 10:21:11 -0400
Date: Wed, 15 Sep 2004 16:21:07 +0200
From: Stelian Pop <stelian@popies.net>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC, 2.6] a simple FIFO implementation
Message-ID: <20040915142107.GD21917@sd291.sivit.org>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	Dmitry Torokhov <dtor_core@ameritech.net>,
	linux-kernel@vger.kernel.org
References: <20040913135253.GA3118@crusoe.alcove-fr> <200409150827.55011.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200409150827.55011.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2004 at 08:27:54AM -0500, Dmitry Torokhov wrote:

> On Monday 13 September 2004 08:52 am, Stelian Pop wrote:
> > +static inline unsigned int kfifo_len(struct kfifo *fifo) {
> > +       unsigned long flags;
> > +       unsigned int result;
> > +       
> > +       spin_lock_irqsave(&fifo->lock, flags);
> > +       
> > +       result = fifo->len;
> > +
> > +       spin_unlock_irqrestore(&fifo->lock, flags);
> > +
> > +       return result;
> > +}
> 
> Hi,
> 
> I do not think that taking/releasing spinlock here serves any purpose as
> len can get canged right after releasing the lock and therefore no longer
> valid... 

Indeed, removed.

> And relying on result of kfifo_len to decide if the FIF can be
> drained is not reliable so probably the inteface is better off without this
> function.

Still, one should have a way to get at least a hint on whether the
FIFO has data or not (think poll() implementation).

What about adding a note in the header saying the function can be racy
and does not guarantee a subsequent kfifo_get will succeed ?

> Also I think that most users would put only sertain structures (homogenous?)
> in their FIFOs so maybe it should be:
> 
> struct kfifo *kfifo_alloc(unsigned int el_size, unsigned int len)
> unsigned int kfifo_put(struct kfifo *fifo, void *buffer)
> unsigned int kfifo_get(struct kfifo *fifo, void *buffer)

It's easy to adapt the generic interface to what you want, but difficult
to do the contrary. Let's be the most generic here (who knows, maybe 
somebody wants to add several structures at once...).

> Also, don't we have a rule that for functions the opening curly brace should
> be on a new line?

Sure, corrected.

Stelian.
-- 
Stelian Pop <stelian@popies.net>    
