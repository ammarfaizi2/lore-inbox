Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750724AbWIOIXU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750724AbWIOIXU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 04:23:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750733AbWIOIXU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 04:23:20 -0400
Received: from smtp.osdl.org ([65.172.181.4]:36524 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750724AbWIOIXT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 04:23:19 -0400
Date: Fri, 15 Sep 2006 01:23:02 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jarek Poplawski <jarkao2@o2.pl>
Cc: Andi Kleen <ak@muc.de>, Dave Jones <davej@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mpparse.c:231: warning: comparison is always false
Message-Id: <20060915012302.d459c2dc.akpm@osdl.org>
In-Reply-To: <20060915081123.GA2572@ff.dom.local>
References: <20060913065010.GA2110@ff.dom.local>
	<20060914181754.bd963f6d.akpm@osdl.org>
	<20060915081123.GA2572@ff.dom.local>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Sep 2006 10:11:23 +0200
Jarek Poplawski <jarkao2@o2.pl> wrote:

> On Thu, Sep 14, 2006 at 06:17:54PM -0700, Andrew Morton wrote:
> > On Wed, 13 Sep 2006 08:50:10 +0200
> > Jarek Poplawski <jarkao2@o2.pl> wrote:
> > 
> > > Hello,
> > > 
> > > Probably after 2.6.18-rc6-git1 there is this cc warning: 
> > > "arch/i386/kernel/mpparse.c:231: warning: comparison is
> > > always false due to limited range of data type".
> > > Maybe this patch will be helpful.
> > > 
> > 
> > Thanks.   Andi has already queued a similar patch.
> > 
> > Andi, you might as well scoot that upstream, otherwise we'll get lots of
> > emails about it.
> ...
> > > +#if 0xFF >= MAX_MP_BUSSES
> > >  	if (m->mpc_busid >= MAX_MP_BUSSES) {
> 
> As a matter of fact today I think my patch is wrong.

No, I think it's OK.  Well, you had an off-by-one...

> I don't know how Andi has fixed it,

Same thing.  (He has `#if MAX_MP_BUSSES < 256').

> but after rethinking
> the question of Dave Jones I see it's fixing the result
> instead of the source of a problem (char or not char).

The mpc_busid field is set to eight-bits by BIOS; there's nothing we can do
about that...

