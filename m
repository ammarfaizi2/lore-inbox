Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292763AbSBZUCy>; Tue, 26 Feb 2002 15:02:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292768AbSBZUCo>; Tue, 26 Feb 2002 15:02:44 -0500
Received: from gurney.bluecom.no ([217.118.32.13]:48139 "EHLO smtp.bluecom.no")
	by vger.kernel.org with ESMTP id <S292763AbSBZUC0>;
	Tue, 26 Feb 2002 15:02:26 -0500
Subject: Re: [PATCH] 2.4.18 Eicon ISDN driver fix.
From: petter wahlman <petter@bluezone.no>
To: Dave Jones <davej@suse.de>
Cc: linux-kernel@vger.kernel.org, info@melware.de
In-Reply-To: <20020226205422.N2222@suse.de>
In-Reply-To: <1014679267.27236.6.camel@BadEip> 
	<20020226205422.N2222@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 26 Feb 2002 20:49:08 +0100
Message-Id: <1014752949.27234.10.camel@BadEip>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-02-26 at 20:54, Dave Jones wrote:
> On Tue, Feb 26, 2002 at 08:26:18PM +0100, petter wahlman wrote:
>  > +++ linux-2.4.18-pw/drivers/isdn/eicon/eicon_mod.c      Mon Feb 25
> 
>  > -                       if (user)
>  > +                       if (user) {
>  > +                               spin_unlock_irqrestore(&eicon_lock,
>  > flags);
>  >                                 copy_to_user(p, skb->data, cnt);
>  > +                               spin_lock_irqsave(&eicon_lock, flags);
>  > +                       }
> 
> What happens if something else adds/removes to card->statq, or
> frees the skb after you drop the lock?  I'm not familiar with
> this code, but from a quick look, it looks like this introduces
> a race no ?
> 

Yes, it will introduce a new race.
I did not actually intend to send this unfinished patch, but fscked up
:)
Anyway, calling copy_to_user while holding a spinlock is defiantly a bad
idea.


> -- 
> | Dave Jones.        http://www.codemonkey.org.uk
> | SuSE Labs
> 

Petter Wahlman.


