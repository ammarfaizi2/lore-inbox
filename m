Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278587AbRJSSkE>; Fri, 19 Oct 2001 14:40:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278592AbRJSSjz>; Fri, 19 Oct 2001 14:39:55 -0400
Received: from air-1.osdl.org ([65.201.151.5]:61708 "EHLO osdlab.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S278589AbRJSSjl>;
	Fri, 19 Oct 2001 14:39:41 -0400
Date: Fri, 19 Oct 2001 11:40:14 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@osdlab.pdx.osdl.net>
To: <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] New Driver Model for 2.5
In-Reply-To: <20011020030138.A22096@beernut.flames.org.au>
Message-ID: <Pine.LNX.4.33.0110191127100.17647-100000@osdlab.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Am I correct in thinking that the current "state of play" after these recent
> discussions is a 3 step suspend process, following an algorithm similar to:

Yes. After some discussion, I think we need a 3-step process. I will be
updating the docs today.

> If this is approximately the right idea, then how will write_out_state work if
> the device(s) that this operation uses aren't accepting requests anymore
> (because they've done suspend_save_state)?  Is it that "Stop accepting
> requests" is actually "Stop accepting requests that will cause a change in the
> device state"?  In that case, devices that can have the state written out to
> them will be limited to those where the act of writing it out will never cause
> such a request, right?

That's an interesting question, and one that depends on the answer to
several questions.

The mechanism for going to sleep is dependent first on the architecture
and secondly on the power managment scheme. It is up to the scheme to work
out the finer details concerning it.

(That's not a copout; we're just not likely to have a generic suspend
routine. Even if every implementation is using the same mechanism, I don't
know if it could ever be consolidated into one singular body of code.)

So then, how do we do suspend to disk? All the progress in that area has
been made by swsusp. I don't know the finer details of how it works, so
I'm not about to comment on how to make it work or modify it to better fit
our needs. Maybe someone from that camp could comment on whether or not
the 3-stage model would completely screw them or not? Or, how to make it
work under this model? Or if it even matters?

	-pat




