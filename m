Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267981AbTAHXox>; Wed, 8 Jan 2003 18:44:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267982AbTAHXox>; Wed, 8 Jan 2003 18:44:53 -0500
Received: from cm19173.red.mundo-r.com ([213.60.19.173]:23520 "EHLO
	demo.mitica") by vger.kernel.org with ESMTP id <S267981AbTAHXow>;
	Wed, 8 Jan 2003 18:44:52 -0500
To: Robert Love <rml@tech9.net>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Andrea Arcangeli <andrea@suse.de>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH]: Remove PF_MEMDIE as it is redundant
References: <m2r8bn6yxz.fsf@demo.mitica> <1042066824.694.3634.camel@phantasy>
	<m2lm1v6w2g.fsf@demo.mitica> <1042069614.694.3696.camel@phantasy>
X-Url: http://people.mandrakesoft.com/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
In-Reply-To: <1042069614.694.3696.camel@phantasy>
Date: 09 Jan 2003 01:01:28 +0100
Message-ID: <m2fzs36vjb.fsf@demo.mitica>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2.92
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "robert" == Robert Love <rml@tech9.net> writes:

robert> On Wed, 2003-01-08 at 18:49, Juan Quintela wrote:
>> That is a nice theory, and I think that this could be true in the
>> past, but in 2.4.2X, PF_MEMDIE only appears in the two places that I
>> show, and it is completely redundant, look at the patch, we are just 
>> |-ing both PF_MEMALLOC and PF_MEMDIE and later we are &-ing against
>> the or of the two.  Use find & grep yourself if you don't believe me.

robert> I realize this.

robert> The issue is that PF_MEMALLOC can be _cleared_.  In that case, if you
robert> only set PF_MEMALLOC, that check can be false when we want it true.  So
robert> we need a flag that is more persistent.

robert> PF_MEMDIE, which is not cleared on various allocation paths in the VM,
robert> ensures that the check holds true for all OOM'ed tasks.

robert> I thought the same as you, "hey this thing is worthless let us dump it",
robert> and Rik and Andrew told me otherwise.

robert> I am not saying you are wrong, though - I could be very wrong.  But my
robert> point is not what you say above; it is that the flag is needed because
robert> just setting PF_MEMALLOC is insufficient since it can be unset.

I saw the light, thanks for the explanation.

Later, Juan.

-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
