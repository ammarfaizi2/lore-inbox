Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965194AbWEaWDA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965194AbWEaWDA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 18:03:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965198AbWEaWC7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 18:02:59 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:22215 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965194AbWEaWC7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 18:02:59 -0400
Subject: Re: [patch, -rc5-mm1] locking validator: special rule: 8390.c
	disable_irq()
From: Arjan van de Ven <arjan@infradead.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Alan Cox <alan@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060531220055.GD4059@elte.hu>
References: <20060531200236.GA31619@elte.hu>
	 <1149107500.3114.75.camel@laptopd505.fenrus.org>
	 <20060531214139.GA8196@devserv.devel.redhat.com>
	 <1149111838.3114.87.camel@laptopd505.fenrus.org>
	 <20060531214729.GA4059@elte.hu>
	 <1149112582.3114.91.camel@laptopd505.fenrus.org>
	 <20060531220055.GD4059@elte.hu>
Content-Type: text/plain
Date: Thu, 01 Jun 2006 00:02:50 +0200
Message-Id: <1149112970.3114.93.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-06-01 at 00:00 +0200, Ingo Molnar wrote:
> * Arjan van de Ven <arjan@infradead.org> wrote:
> 
> > > couldnt most of these problems be avoided by tracking whether a handler 
> > > _ever_ returned a success status? That means that irqpoll could safely 
> > > poll handlers for which we know that they somehow arent yet matched up 
> > > to any IRQ line?
> > 
> > I suspect the real solution is to have a
> > 
> > disable_irq_handler(irq, handler) 
> > 
> > function which does 2 things
> > 1) disable the irq at the hardware level
> > 2) mark the handler as "don't call me"
> > 
> > it matches the semantics here; what these drivers want is 1) not get 
> > an irq handler called and 2) not get an irq flood
> 
> ok, this would work. But there is a practical problem: only in drivers/* 
> there's 310 disable_irq() calls - each would have to be changed to 
> disable_irq_handler() [and i dont see any good way to automate that 
> conversion] ...

want to take a bet on the number of those 310 that are just totally
bogus ?


