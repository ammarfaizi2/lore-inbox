Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751618AbWIFHVW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751618AbWIFHVW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 03:21:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751619AbWIFHVW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 03:21:22 -0400
Received: from mtagate5.uk.ibm.com ([195.212.29.138]:18146 "EHLO
	mtagate5.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1751617AbWIFHVU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 03:21:20 -0400
Date: Wed, 6 Sep 2006 09:20:43 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Arjan van de Ven <arjan@infradead.org>,
       Daniel Walker <dwalker@mvista.com>, Hua Zhong <hzhong@gmail.com>
Subject: Re: lockdep oddity
Message-ID: <20060906072043.GC6898@osiris.boeblingen.de.ibm.com>
References: <20060901015818.42767813.akpm@osdl.org> <20060905130356.GB6940@osiris.boeblingen.de.ibm.com> <20060905181241.GC16207@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060905181241.GC16207@elte.hu>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Found this will debugging some random memory corruptions that happen 
> > when CONFIG_PROVE_LOCKING and CONFIG_PROFILE_LIKELY are both on. 
> > Switching both off or having only one of them on seems to work.
> 
> previously i had some weirdnesses with PROFILE_LIKELY too, they were 
> caused by it generating cross-calls from within lockdep. Do the 
> corruptions go away if you remove all likely() and unlikely() markings 
> from kernel/lockdep.c?

No, unfortunately that doesn't help. I'm also wondering why the profile
patch contains this:

+       if (ret)
+               likeliness->count[1]++;
+       else
+               likeliness->count[0]++;

This isn't smp safe. Is that on purpose or a bug?
