Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262482AbTJOJ6l (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 05:58:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262490AbTJOJ6l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 05:58:41 -0400
Received: from mail3.ithnet.com ([217.64.64.7]:20962 "HELO
	heather-ng.ithnet.com") by vger.kernel.org with SMTP
	id S262482AbTJOJ6k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 05:58:40 -0400
X-Sender-Authentication: net64
Date: Wed, 15 Oct 2003 11:58:37 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Strange dcache memory pressure when highmem enabled
Message-Id: <20031015115837.63444093.skraw@ithnet.com>
In-Reply-To: <16268.57123.661746.500616@notabene.cse.unsw.edu.au>
References: <16268.52761.907998.436272@notabene.cse.unsw.edu.au>
	<20031014224352.0171e971.akpm@osdl.org>
	<16268.57123.661746.500616@notabene.cse.unsw.edu.au>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Oct 2003 15:46:11 +1000
Neil Brown <neilb@cse.unsw.edu.au> wrote:

> On Tuesday October 14, akpm@osdl.org wrote:
> > Neil Brown <neilb@cse.unsw.edu.au> wrote:
> > >
> > > I noticed that shrink_caches calls shrink_dcache_memory independant
> > >   of the classzone that is being shrunk.  So if we are trying to
> > >   shrink ZONE_HIGHMEM, the dentry_cache is shrunk, even though the
> > >   dentry_cache doesn't live in highmem.  However I'm not sure if I have
> > >   understood the classzones well enough for that observation even to
> > >   make sense.
> > 
> > Makes heaps of sense.  Here's an instabackport of what we did in
> > 2.6:
> 
> Hey!!! That's what I call *Service*.
> 
> I'll give it a try tomorrow (let the poor students get a feeling of
> stability first before I start changing things again :-)
> 
> > +			if (classzone - classzone->zone_pgdat->node_zones <
> > +						ZONE_HIGHMEM) {
> 
> That's the bit I was missing.  I feel that once I fully understand
> that, I will be a long way towards understanding the zones memory
> management :-)
> 
> NeilBrown

I have another simple advice for you: use the latest 2.4.23-pre. I think I saw
your problem and it seems solved.

Regards,
Stephan
