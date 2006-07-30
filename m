Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932427AbWG3Ss1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932427AbWG3Ss1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 14:48:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932428AbWG3Ss1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 14:48:27 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:20641 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932427AbWG3Ss0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 14:48:26 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XzzutBUlJTKn7BBAabJlZCvSbWrD4fD2d1baDzn4pkL2mfCjNXzz37eGPt82b4Ih00iggnZoGgpJT/cJtiuvY4ALd0E8ae+exXYB97cEVOCZxYBkOK6cqrCqwjOCJveeQT1V1Clu7BmA4oCYoMS0a8Q3Mj3skhksI0DQFL2RJ/8=
Message-ID: <9a8748490607301148q13992d9cr910a1dadb42e11fd@mail.gmail.com>
Date: Sun, 30 Jul 2006 20:48:23 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Paul Jackson" <pj@sgi.com>
Subject: Re: [PATCH 01/12] making the kernel -Wshadow clean - fix mconf
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
In-Reply-To: <20060730113416.7c1d8f80.pj@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200607301830.01659.jesper.juhl@gmail.com>
	 <200607301835.35053.jesper.juhl@gmail.com>
	 <20060730113416.7c1d8f80.pj@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/07/06, Paul Jackson <pj@sgi.com> wrote:
> Jesper wrote:
> > -             cprint("%s", filename);
> > +             cprint("%s", config_filename);
>
> Something seems strange here to me.  It looks like you are sometimes
> resolving the shadowed symbols by making the more local symbol have the
> longer name.
>
True.

> I'd have expected that the global symbol would be the one with the
> longer, more elaborate name.
>
Generally I'd agree with you, but my initial objective is to resolve
all (or at least most) of the clashes with as little pain as pssible
initially so that we can get to the point where we can add -Wshadow to
the Makefile - sometimes the path of least resistence is making the
local name longer.


> In other words, I would have expected that we would avoid having global
> names such as (from your other patches in this set):
>
>     filename

Here I changed the global to be longer - config_filename.

>     scroll

made the local longer - guilty as charged.


>     instr

I don't recall using that variable name - I believe you mean 'intr'
for interrupt that I used in place of 'irq'.


>     up

I'd *love* to change this one - and down() as well - to up_sem() &
down_sem(). But, making that change would be a pretty major and
somewhat disruptive api change, so I opted instead to change the local
variable names. I plan to introduce a sepperate patch set later on
that adds up_sem()/down_sem() wrappers around up()/down(), deprecate
the old names and add an entry to feature-removal.txt - but doing it
now as part of the -Wshadow cleanup would be too much pain.

>     sum
>     state
>     rep
>     complete
>     irq
>

Yes, here I made the local name longer. Long term that should probably
change. Short term it seemed the path of least resistance.


> Perhaps I am misreading this patch set?
>
i don't think you are. It's just that I want to take the least
intrusive route *now*, make us -Wshadow clean, get -Wshadow to be an
accepted part of the Makefile, *then* deal with the more
intrusive/controversial renamings, where I guess you'd have done
things in the opposite order - right?


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
