Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265490AbSJSECM>; Sat, 19 Oct 2002 00:02:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265505AbSJSECM>; Sat, 19 Oct 2002 00:02:12 -0400
Received: from cse.ogi.edu ([129.95.20.2]:2955 "EHLO church.cse.ogi.edu")
	by vger.kernel.org with ESMTP id <S265490AbSJSECL>;
	Sat, 19 Oct 2002 00:02:11 -0400
To: jgmyers@netscape.com (John Myers)
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-aio <linux-aio@kvack.org>
Subject: Re: epoll (was Re: [PATCH] async poll for 2.5)
References: <Pine.LNX.4.44.0210171121390.1631-100000@blue1.dev.mcafeelabs.com>
	<3DB05AB2.3010907@netscape.com> <xu465vzo417.fsf@brittany.cse.ogi.edu>
	<3DB0AFCE.5030205@netscape.com>
From: "Charles 'Buck' Krasic" <krasic@acm.org>
Date: 18 Oct 2002 21:07:49 -0700
In-Reply-To: <3DB0AFCE.5030205@netscape.com>
Message-ID: <xu4of9r6pgq.fsf@brittany.cse.ogi.edu>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Artificial Intelligence)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


jgmyers@netscape.com (John Myers) writes:

> Close.  What we would have is a modification of the epoll_addf()
> semantics such that it would have an additional postcondition that if
> the new_fd is in the ready state (has data available) then at least
> one notification has been generated.  In the code above, the three
> lines comprising the if statement labeled "7*" would be removed.

I see.

I assume the kernel implementation is no big deal: epoll_addf() has to
call the kernel internal equivalent to poll() with a zero timeout.

This wouldn't break the first "solution" in my earlier post, but it
would cause every new connection to experience one extra EAGAIN.  

I see three possibilities:

  1) keep the current epoll_addf()
  2) modify it as John suggests, posting the initial ready state in 
     the next epoll_getevents()
  3) both: add an option to epoll_addf() that says which of 1 or 2 is desired.

-- Buck













How hard would it be to modify the current epoll code to work that
way?  I'd assume it's just a matter having epoll_addf call the legacy
poll() code to check the condition (with a zero timeout).



-- Buck






