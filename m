Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267770AbUIUPpy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267770AbUIUPpy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 11:45:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267772AbUIUPpy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 11:45:54 -0400
Received: from cantor.suse.de ([195.135.220.2]:14056 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S267770AbUIUPpt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 11:45:49 -0400
Date: Tue, 21 Sep 2004 17:45:42 +0200
From: Andi Kleen <ak@suse.de>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: Andi Kleen <ak@suse.de>, Christoph Lameter <clameter@sgi.com>,
       akpm@osdl.org, "David S. Miller" <davem@davemloft.net>,
       benh@kernel.crashing.org, wli@holomorphy.com, davem@redhat.com,
       raybry@sgi.com, ak@muc.de, manfred@colorfullife.com,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       vrajesh@umich.edu, hugh@veritas.com
Subject: Re: page fault scalability patch V8: [4/7] universally available cmpxchg on i386
Message-ID: <20040921154542.GB12132@wotan.suse.de>
References: <Pine.LNX.4.58.0408150630560.324@schroedinger.engr.sgi.com> <Pine.LNX.4.58.0409201348070.4628@schroedinger.engr.sgi.com> <20040920205752.GH4242@wotan.suse.de> <200409211841.25507.vda@port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409211841.25507.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 21, 2004 at 06:41:25PM +0300, Denis Vlasenko wrote:
> On Monday 20 September 2004 23:57, Andi Kleen wrote:
> > On Mon, Sep 20, 2004 at 01:49:20PM -0700, Christoph Lameter wrote:
> > > On Mon, 20 Sep 2004, Denis Vlasenko wrote:
> > > 
> > > > I think it shouldn't be this way.
> > > >
> > > > OTOH for !CONFIG_386 case it makes perfect sense to have it inlined.
> > > 
> > > Would the following revised patch be acceptable?
> > 
> > You would need an EXPORT_SYMBOL at least. But to be honest your
> > original patch was much simpler and nicer and cmpxchg is not called
> > that often that it really matters. I would just ignore Denis' 
> > suggestion and stay with the old patch.
> 
> A bit faster approach (for CONFIG_386 case) would be using

It's actually slower. Many x86 CPUs cannot predict indirect jumps
and those that do cannot predict them as well as a test and jump.

-Andi
