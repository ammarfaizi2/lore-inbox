Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262424AbTJOFqV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 01:46:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262427AbTJOFqV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 01:46:21 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:39655 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S262424AbTJOFqT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 01:46:19 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Andrew Morton <akpm@osdl.org>
Date: Wed, 15 Oct 2003 15:46:11 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16268.57123.661746.500616@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Strange dcache memory pressure when highmem enabled
In-Reply-To: message from Andrew Morton on Tuesday October 14
References: <16268.52761.907998.436272@notabene.cse.unsw.edu.au>
	<20031014224352.0171e971.akpm@osdl.org>
X-Mailer: VM 7.17 under Emacs 21.3.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday October 14, akpm@osdl.org wrote:
> Neil Brown <neilb@cse.unsw.edu.au> wrote:
> >
> > I noticed that shrink_caches calls shrink_dcache_memory independant
> >   of the classzone that is being shrunk.  So if we are trying to
> >   shrink ZONE_HIGHMEM, the dentry_cache is shrunk, even though the
> >   dentry_cache doesn't live in highmem.  However I'm not sure if I have
> >   understood the classzones well enough for that observation even to
> >   make sense.
> 
> Makes heaps of sense.  Here's an instabackport of what we did in
> 2.6:

Hey!!! That's what I call *Service*.

I'll give it a try tomorrow (let the poor students get a feeling of
stability first before I start changing things again :-)

> +			if (classzone - classzone->zone_pgdat->node_zones <
> +						ZONE_HIGHMEM) {

That's the bit I was missing.  I feel that once I fully understand
that, I will be a long way towards understanding the zones memory
management :-)

NeilBrown
