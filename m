Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267979AbTAHXiM>; Wed, 8 Jan 2003 18:38:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267981AbTAHXiM>; Wed, 8 Jan 2003 18:38:12 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:32523
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S267979AbTAHXiL>; Wed, 8 Jan 2003 18:38:11 -0500
Subject: Re: [PATCH]: Remove PF_MEMDIE as it is redundant
From: Robert Love <rml@tech9.net>
To: Juan Quintela <quintela@mandrakesoft.com>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Andrea Arcangeli <andrea@suse.de>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <m2lm1v6w2g.fsf@demo.mitica>
References: <m2r8bn6yxz.fsf@demo.mitica>
	 <1042066824.694.3634.camel@phantasy>  <m2lm1v6w2g.fsf@demo.mitica>
Content-Type: text/plain
Organization: 
Message-Id: <1042069614.694.3696.camel@phantasy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-3) 
Date: 08 Jan 2003 18:46:55 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-01-08 at 18:49, Juan Quintela wrote:

> That is a nice theory, and I think that this could be true in the
> past, but in 2.4.2X, PF_MEMDIE only appears in the two places that I
> show, and it is completely redundant, look at the patch, we are just 
> |-ing both PF_MEMALLOC and PF_MEMDIE and later we are &-ing against
> the or of the two.  Use find & grep yourself if you don't believe me.

I realize this.

The issue is that PF_MEMALLOC can be _cleared_.  In that case, if you
only set PF_MEMALLOC, that check can be false when we want it true.  So
we need a flag that is more persistent.

PF_MEMDIE, which is not cleared on various allocation paths in the VM,
ensures that the check holds true for all OOM'ed tasks.

I thought the same as you, "hey this thing is worthless let us dump it",
and Rik and Andrew told me otherwise.

I am not saying you are wrong, though - I could be very wrong.  But my
point is not what you say above; it is that the flag is needed because
just setting PF_MEMALLOC is insufficient since it can be unset.

	Robert Love


