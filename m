Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267899AbTAHXd1>; Wed, 8 Jan 2003 18:33:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267979AbTAHXd0>; Wed, 8 Jan 2003 18:33:26 -0500
Received: from cm19173.red.mundo-r.com ([213.60.19.173]:19936 "EHLO
	demo.mitica") by vger.kernel.org with ESMTP id <S267899AbTAHXdZ>;
	Wed, 8 Jan 2003 18:33:25 -0500
To: Robert Love <rml@tech9.net>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Andrea Arcangeli <andrea@suse.de>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH]: Remove PF_MEMDIE as it is redundant
References: <m2r8bn6yxz.fsf@demo.mitica> <1042066824.694.3634.camel@phantasy>
X-Url: http://people.mandrakesoft.com/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
In-Reply-To: <1042066824.694.3634.camel@phantasy>
Date: 09 Jan 2003 00:49:59 +0100
Message-ID: <m2lm1v6w2g.fsf@demo.mitica>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2.92
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "robert" == Robert Love <rml@tech9.net> writes:

robert> On Wed, 2003-01-08 at 17:47, Juan Quintela wrote:
>> PF_MEMDIE don't have any use in current kernels.  Please
>> remove, we only set it in one place, and there we also set
>> PF_MEMALLOC.  And we only test it in other place, and we also
>> test for PF_MEMALLOC.  This patch has existed in aa for some
>> quite time.

robert> I independently thought this same thing, and did a patch for 2.5 which
robert> had the same effect.

robert> I was reminded by better-VM-hackers-than-I that PF_MEMALLOC can be
robert> cleared in various paths so the PF_MEMDIE is required to ensure that the
robert> check in page_alloc.c is always true for OOM'ed tasks.

That is a nice theory, and I think that this could be true in the
past, but in 2.4.2X, PF_MEMDIE only appears in the two places that I
show, and it is completely redundant, look at the patch, we are just 
|-ing both PF_MEMALLOC and PF_MEMDIE and later we are &-ing against
the or of the two.  Use find & grep yourself if you don't believe me.

Later, Juan.

-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
