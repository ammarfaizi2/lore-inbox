Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266175AbUFIVF7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266175AbUFIVF7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 17:05:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266180AbUFIVF7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 17:05:59 -0400
Received: from smtp2.pp.htv.fi ([213.243.153.35]:26032 "EHLO smtp2.pp.htv.fi")
	by vger.kernel.org with ESMTP id S266175AbUFIVFW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 17:05:22 -0400
Subject: Re: [PATCH] ALSA: Remove subsystem-specific malloc (1/8)
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Chris Wright <chrisw@osdl.org>, linux-kernel@vger.kernel.org,
       tiwai@suse.de
In-Reply-To: <20040609205944.GA21150@devserv.devel.redhat.com>
References: <200406082124.i58LOuOL016163@melkki.cs.helsinki.fi>
	 <20040609113455.U22989@build.pdx.osdl.net>
	 <1086812001.13026.63.camel@cherry>
	 <1086812486.2810.21.camel@laptop.fenrus.com>
	 <1086814663.13026.70.camel@cherry>
	 <20040609205944.GA21150@devserv.devel.redhat.com>
Content-Type: text/plain
Message-Id: <1086815269.13026.76.camel@cherry>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 10 Jun 2004 00:07:49 +0300
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 09, 2004 at 11:57:43PM +0300, Pekka Enberg wrote:
> > +void *kcalloc(size_t n, size_t size, int flags)
> > +{
> > +	if (n != 0 && size > INT_MAX / n)
> > +		return NULL;
> > +
> > +	void *ret = kmalloc(n * size, flags);
> > +	if (ret)
> > +		memset(ret, 0, n * size);
> > +	return ret;
> > +}

On Wed, 2004-06-09 at 23:59, Arjan van de Ven wrote:
> ok I like it ;)
> 
> only question is what n==0 means, might as well short-circuit that but it's
> optional 

Nah, I don't see the point. Now if I can only convince the ALSA guys to
switch to this... =)

		Pekka

