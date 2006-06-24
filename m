Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964831AbWFXMqZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964831AbWFXMqZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 08:46:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933391AbWFXMqZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 08:46:25 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:39593 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S933390AbWFXMqY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 08:46:24 -0400
Subject: Re: [PATCH] ext3_clear_inode(): avoid kfree(NULL)
From: Arjan van de Ven <arjan@infradead.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Andrew Morton <akpm@osdl.org>, Jeff Garzik <jeff@garzik.org>,
       linux-kernel@vger.kernel.org, torvalds@osdl.org
In-Reply-To: <Pine.LNX.4.58.0606240833010.23318@gandalf.stny.rr.com>
References: <200606231502.k5NF2jfO007109@hera.kernel.org>
	 <449C3817.2030802@garzik.org> <20060623142430.333dd666.akpm@osdl.org>
	 <1151151104.3181.30.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.58.0606240817170.23087@gandalf.stny.rr.com>
	 <1151152059.3181.37.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.58.0606240833010.23318@gandalf.stny.rr.com>
Content-Type: text/plain
Date: Sat, 24 Jun 2006 14:46:17 +0200
Message-Id: <1151153177.3181.39.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-06-24 at 08:33 -0400, Steven Rostedt wrote:
> On Sat, 24 Jun 2006, Arjan van de Ven wrote:
> 
> > On Sat, 2006-06-24 at 08:20 -0400, Steven Rostedt wrote:
> > > On Sat, 24 Jun 2006, Arjan van de Ven wrote:
> > >
> > > >
> > > > >
> > > > > Because at that callsite, NULL is the common case.  We avoid a do-nothing
> > > > > function call most of the time.  It's a nano-optimisation.
> > > >
> > > > but a function call is basically free, while an if () is not... even
> > > > with unlikely()...
> > > >
> > > > sounds like a misoptimization to me.
> > > >
> > >
> > > How is a function call free when an if is not?
> >
> > in general, a function call is 100% predictable without any real control
> > flow dependencies for the processor, and thus there is no real issue in
> > the execution pipeline. An if is a conditional branch, which breaks up
> > the execution pipeline if mispredicted...
> 
> But doesn't the unlikely help the prediction? 

nope none at all, at least not on x86/x86-64.
(in fact there is no way to help the prediction on those architectures
that actually works)

