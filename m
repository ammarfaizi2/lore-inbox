Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276439AbRJCQQB>; Wed, 3 Oct 2001 12:16:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276448AbRJCQPv>; Wed, 3 Oct 2001 12:15:51 -0400
Received: from hermes.toad.net ([162.33.130.251]:43653 "EHLO hermes.toad.net")
	by vger.kernel.org with ESMTP id <S276439AbRJCQPb>;
	Wed, 3 Oct 2001 12:15:31 -0400
Subject: call_pnp_bios() okay
To: linux-kernel@vger.kernel.org
Date: Wed, 3 Oct 2001 12:15:28 -0400 (EDT)
X-Mailer: ELM [version 2.4ME+ PL73 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Message-Id: <20011003161528.757EA5AC@thanatos.toad.net>
From: jdthood@home.dhs.org (Thomas Hood)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Given that the args are u16s and u16s are unsigned shorts, it looks to me
> as if this is going to zero out all the odd-numbered args.  But if that's
> what's happening then I'm amazed this driver works at all.  I see that
> in some cases the odd-numbered args are zero anyway, but in others not.
> Result #1:  The driver isn't getting a real value for the maximum node size.
>             But a random value will sometimes not oops the kernel.
> Result #2:  PnP BIOS is sometimes getting 0 as its DS selector
> Result #3:  The get_dev_node config selector is always 0 (should be 1 or 2)
> Result #4:  The set_dev_node handle is 0; but this is duplicated in the
>             node info structure, so the function may still work.  However,
>             the selector number of the node data is wrong
> 
> I'm off to patch this bug and see if it fixes my problem.
> It may fix the Sony and Dell problems too.

Well, on closer look the call_pnp_bios code is okay after all.
The variables get promoted to 32 bits prior to the 16 bit shifts,
despite the shifts being in parentheses.  I.e, Never Mind.  :)

Stelian: Sorry, I put your e-mail address in the previous subject heading
by mistake.

-- 
Thomas Hood
(Don't reply to the From: address but to jdthood_AT_yahoo.co.uk)
