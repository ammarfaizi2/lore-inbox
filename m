Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030843AbWKOSnF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030843AbWKOSnF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 13:43:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030836AbWKOSnF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 13:43:05 -0500
Received: from gw.goop.org ([64.81.55.164]:56984 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1030846AbWKOSnD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 13:43:03 -0500
Message-ID: <455B5FB6.7010009@goop.org>
Date: Wed, 15 Nov 2006 10:43:02 -0800
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Arjan van de Ven <arjan@infradead.org>, akpm@osdl.org, ak@suse.de,
       linux-kernel@vger.kernel.org, Michael.Fetterman@cl.cam.ac.uk,
       Ian Campbell <Ian.Campbell@XenSource.com>
Subject: Re: i386 PDA patches use of %gs
References: <1158046540.2992.5.camel@laptopd505.fenrus.org> <45075829.701@goop.org> <20060913095942.GA10075@elte.hu> <45082F1C.8000003@goop.org> <20061115182613.GA2227@elte.hu> <20061115182915.GA2705@elte.hu>
In-Reply-To: <20061115182915.GA2705@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> for example, your test_fs() code does:
>
>         for(i = 0; i < COUNT; i++) {
>                 asm volatile("push %%fs; mov %1, %%fs; addl $1, %%fs:%0; popl %%fs"
>                              : "+m" (*offset): "r" (seg) : "memory");
>                 sync();
>         }
>
> that loads (and uses) a single selector value for %fs, and doesnt do any 
> mixed use as far as i can see.

I'm not sure what you're getting at.  Each loop iteration is analogous
to a user->kernel->user transition with respect to the
save/reload/use/restore pattern on the segment register.  In this case,
%fs starts as a null selector, gets reloaded with a non NULL selector,
and then is restored to null.  Do you mean some other mixing?

    J
