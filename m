Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030245AbVIILVN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030245AbVIILVN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 07:21:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030246AbVIILVN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 07:21:13 -0400
Received: from ns2.suse.de ([195.135.220.15]:51665 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030245AbVIILVM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 07:21:12 -0400
Date: Fri, 9 Sep 2005 13:21:08 +0200
From: Andi Kleen <ak@suse.de>
To: Hugh Dickins <hugh@veritas.com>
Cc: Andi Kleen <ak@suse.de>, Jan Beulich <JBeulich@novell.com>,
       linux-kernel@vger.kernel.org, discuss@x86-64.org
Subject: Re: [discuss] [PATCH] allow CONFIG_FRAME_POINTER for x86-64
Message-ID: <20050909112108.GK19913@wotan.suse.de>
References: <43207D28020000780002451E@emea1-mh.id2.novell.com> <4321749202000078000248C5@emea1-mh.id2.novell.com> <Pine.LNX.4.61.0509091133180.5937@goblin.wat.veritas.com> <200509091258.13300.ak@suse.de> <Pine.LNX.4.61.0509091208350.6247@goblin.wat.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0509091208350.6247@goblin.wat.veritas.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 09, 2005 at 12:14:38PM +0100, Hugh Dickins wrote:
> 
> Ah, right.  I'm using kdb with it.  (And my recollection of when
> show_stack did have a framepointer version, is that it was hopelessly
> broken on interrupt frames, and we're much better off without it.)

Not sure if the x86-64 kdb had code to follow them either.
The i386 one has.


> 
> > The only reason to use them would be external debuggers, but those
> > don't need them on x86-64 neither.
> 
> Don't need them, but find them as useful on x86_64 as on i386?
> 
> Certainly, I can go on patching in FRAME_POINTERs for x86_64
> as I have done, no problem with that.  But it seems both bogus
> and unhelpful to have that "&& !X86_64" in lib/Kconfig.debug -
> framepointers are as helpful/useless on x86_64 as the rest.

The original reason was that they were never enabled because
nobody passed -fno-omit-frame-pointer. That was apparently
later fixed.

But kdb should be using a dwarf2 unwinder instead. kgdb certainly
supports that, as does NLKD.

-Andi
