Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262789AbTJJNHa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 09:07:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262790AbTJJNHa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 09:07:30 -0400
Received: from pizda.ninka.net ([216.101.162.242]:64996 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S262789AbTJJNH0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 09:07:26 -0400
Date: Fri, 10 Oct 2003 06:00:50 -0700
From: "David S. Miller" <davem@redhat.com>
To: Ingo Oeser <ioe-lkml@rameria.de>
Cc: toby@cbcg.net, netdev@oss.sgi.com, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org, coreteam@netfilter.org,
       netfilter@lists.netfilter.org, akpm@zip.com.au, kuznet@ms2.inr.ac.ru,
       pekkas@netcore.fi, jmorris@intercode.com.au, yoshfuji@linux-ipv6.org,
       jgarzik@pobox.com
Subject: Re: [PATCH] kfree_skb() bug in 2.4.22
Message-Id: <20031010060050.057aab50.davem@redhat.com>
In-Reply-To: <200310101453.44353.ioe-lkml@rameria.de>
References: <1065617075.1514.29.camel@localhost>
	<3F840C9C.9050704@pobox.com>
	<20031008064735.7373227b.davem@redhat.com>
	<200310101453.44353.ioe-lkml@rameria.de>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Oct 2003 14:53:44 +0200
Ingo Oeser <ioe-lkml@rameria.de> wrote:

> On Wednesday 08 October 2003 15:47, David S. Miller wrote:
> > On Wed, 08 Oct 2003 09:09:48 -0400
> >
> > Jeff Garzik <jgarzik@pobox.com> wrote:
> > > I would prefer that you fix your code instead, to not pass NULL to
> > > kfree_skb()...
> >
> > Absolutely, there is no valid reason to pass NULL into these
> > routines.
> 
> Would you mind __attribute_nonnull__ for these functions, if we
> enable GCC 3.3 support for this[1]?

I would say yes, but why?  All this attribute does is optimize
away tests for NULL which surprise surprise we don't have any
of in kfree_skb().
