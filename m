Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964815AbWFXMwM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964815AbWFXMwM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 08:52:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933381AbWFXMwM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 08:52:12 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:38884 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S933085AbWFXMwL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 08:52:11 -0400
Date: Sat, 24 Jun 2006 08:51:58 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Arjan van de Ven <arjan@infradead.org>
cc: Andrew Morton <akpm@osdl.org>, Jeff Garzik <jeff@garzik.org>,
       linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH] ext3_clear_inode(): avoid kfree(NULL)
In-Reply-To: <1151153177.3181.39.camel@laptopd505.fenrus.org>
Message-ID: <Pine.LNX.4.58.0606240849460.23525@gandalf.stny.rr.com>
References: <200606231502.k5NF2jfO007109@hera.kernel.org>  <449C3817.2030802@garzik.org>
 <20060623142430.333dd666.akpm@osdl.org>  <1151151104.3181.30.camel@laptopd505.fenrus.org>
  <Pine.LNX.4.58.0606240817170.23087@gandalf.stny.rr.com> 
 <1151152059.3181.37.camel@laptopd505.fenrus.org> 
 <Pine.LNX.4.58.0606240833010.23318@gandalf.stny.rr.com>
 <1151153177.3181.39.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 24 Jun 2006, Arjan van de Ven wrote:

> > >
> > > in general, a function call is 100% predictable without any real control
> > > flow dependencies for the processor, and thus there is no real issue in
> > > the execution pipeline. An if is a conditional branch, which breaks up
> > > the execution pipeline if mispredicted...
> >
> > But doesn't the unlikely help the prediction?
>
> nope none at all, at least not on x86/x86-64.
> (in fact there is no way to help the prediction on those architectures
> that actually works)
>

But doesn't gcc optimize it. That is, it puts the code in the if block
as the jump. So if you never take the if, the pipeline is not hurt.

-- Steve

