Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261318AbVDZFA5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261318AbVDZFA5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 01:00:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261304AbVDZFA5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 01:00:57 -0400
Received: from smtp.istop.com ([66.11.167.126]:1717 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S261318AbVDZFAn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 01:00:43 -0400
From: Daniel Phillips <phillips@istop.com>
To: Jesper Juhl <juhl-lkml@dif.dk>
Subject: Re: [PATCH 1b/7] dlm: core locking
Date: Tue, 26 Apr 2005 01:00:54 -0400
User-Agent: KMail/1.7
Cc: David Teigland <teigland@redhat.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
References: <20050425165826.GB11938@redhat.com> <Pine.LNX.4.62.0504252105430.2941@dragon.hyggekrogen.localhost>
In-Reply-To: <Pine.LNX.4.62.0504252105430.2941@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200504260100.54490.phillips@istop.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 25 April 2005 16:41, Jesper Juhl wrote:
> > +     }
> > +
> > +     if (!lkb->lkb_lvbptr)
> > +             return;
>
> goto out;
>
> > +
> > +     if (!(lkb->lkb_exflags & DLM_LKF_VALBLK))
> > +             return;
>
> goto out;
>
> > +
> > +     if (!r->res_lvbptr)
> > +             r->res_lvbptr = allocate_lvb(r->res_ls);
> > +
> > +     memcpy(r->res_lvbptr, lkb->lkb_lvbptr, DLM_LVB_LEN);
> > +     r->res_lvbseq++;
> > +     clear_bit(RESFL_VALNOTVALID, &r->res_flags);
>
> out:
>         return;
>
> > +}
>
> A single return function exit point instead of multiple reduces the risk
> of errors when code is later modified.
> Applies to many other functions besides this one (and this one may not
> even be the best example, but hey, I wanted to make that comment, and
> this function was at hand).

Great comments on the whole, but this one is really well into the "matter of 
taste" zone.  Naked return vs goto return... either way is ugly.  I prefer 
the style that is two lines shorter and does not make my eyes do an extra 
hop.

Regards,

Daniel
