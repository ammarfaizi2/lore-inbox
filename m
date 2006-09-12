Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750824AbWILIfV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750824AbWILIfV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 04:35:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751332AbWILIfU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 04:35:20 -0400
Received: from mx1.redhat.com ([66.187.233.31]:62859 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750824AbWILIfT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 04:35:19 -0400
Date: Tue, 12 Sep 2006 04:35:11 -0400
From: Jakub Jelinek <jakub@redhat.com>
To: Andi Kleen <ak@suse.de>
Cc: Jan Beulich <jbeulich@novell.com>, sam@ravnborg.org,
       Michael Matz <matz@suse.de>, Richard Guenther <rguenther@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [development-gcc] Re: do_exit stuck
Message-ID: <20060912083511.GR12531@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <200608291332.18499.ak@suse.de> <200609112217.16811.ak@suse.de> <4506767D.76E4.0078.0@novell.com> <200609120832.06645.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200609120832.06645.ak@suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2006 at 08:32:06AM +0200, Andi Kleen wrote:
> On Tuesday 12 September 2006 08:57, Jan Beulich wrote:
> > >Isn't a Kconfig patch missing? I don't see any place that defines
> > >CONFIG_AS_CFI_SIGNAL_FRAME. Actually Kconfig wouldn't
> > >be very good for this, so auto testing would be preferable
> > >(like the cfi test is doing)
> >
> > Using that framework was the intention (you used a CONFIG_
> > prefix there, and so did I), but as I wasn't sure about its status,
> > and as I also was doing this against plain 2.6.18-rc6, I didn't add
> > the actual detection logic. Actually I also think that should be
> > done a little differently to allow for better future extension, i.e.
> > instead of adding to CFLAGS store the auto-detected results in
> > a header and forcibly -include it.
> 
> Ok. I guess I'll do it in the same way as the CFI detection
> and maybe one of the kbuild folks can figure out a better way longer term.
> 
> BTW which binutils release started supporting this properly?

2006-02-27 and later CVS, so in H.J's releases that's 2.16.91.0.7 and later
(and in upstream 2.17 and later).  But there are several distributions that
backported the changes even to older binutils, so doing a compile time check
if assembler groks .cfi_signal_frame is preferrable to a version check.

	Jakub
