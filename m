Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270321AbUJUH0z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270321AbUJUH0z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 03:26:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270333AbUJUH0P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 03:26:15 -0400
Received: from phoenix.infradead.org ([81.187.226.98]:51465 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S270241AbUJUHXj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 03:23:39 -0400
Date: Thu, 21 Oct 2004 08:23:38 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Chris Wedgwood <cw@f00f.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>
Subject: Re: [RFC] add struct hw_interrupt_type->release
Message-ID: <20041021072338.GA925@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Chris Wedgwood <cw@f00f.org>, LKML <linux-kernel@vger.kernel.org>,
	Ingo Molnar <mingo@elte.hu>
References: <20041020023156.GA8597@taniwha.stupidest.org> <20041020130715.GA20287@infradead.org> <20041020023156.GA8597@taniwha.stupidest.org> <20041021022630.GA320@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041021022630.GA320@taniwha.stupidest.org>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 20, 2004 at 07:26:30PM -0700, Chris Wedgwood wrote:
> On Tue, Oct 19, 2004 at 07:31:56PM -0700, Chris Wedgwood wrote:
> 
> > +++ b/kernel/irq/manage.c	2004-10-19 17:47:40 -07:00
> > @@ -260,6 +260,7 @@
> >  				else
> >  					desc->handler->disable(irq);
> >  			}
>                        ^^^
> > +			platform_free_irq_notify(irq, dev_id);
> >  			spin_unlock_irqrestore(&desc->lock,flags);
> >  			unregister_handler_proc(irq, action);
> >  
> 
> On Wed, Oct 20, 2004 at 02:07:15PM +0100, Christoph Hellwig wrote:
> 
> > This looks rather bogus to me.  What prevents UML from doing it's
> > work at the struct hw_interrupt_type level?
> 
> the ^^^ marked part reads something like if (!desc->action) { ... }
> presumably meaning the shutdown/disable is only done when the very
> last user of an interrupt source is removed
> 
> UML needs to be notified when *any* user is removed so either need
> some way to tell the generic code this or perhaps we could introduce
> another op to hw_interrupt_type along the lines of ->release like
> this:

Care to explain why it needs that?  How exactly is UML using hardirqs,
they seems to fit very badly into the concept of a usermode kernel if
you ask me.  Maybe UML would be better off to not use hardirqs at all,
ala s390.

