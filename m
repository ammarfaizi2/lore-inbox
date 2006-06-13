Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932354AbWFMVtY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932354AbWFMVtY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 17:49:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932353AbWFMVtY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 17:49:24 -0400
Received: from rtr.ca ([64.26.128.89]:49641 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S932345AbWFMVtX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 17:49:23 -0400
Message-ID: <448F32E1.8080002@rtr.ca>
Date: Tue, 13 Jun 2006 17:49:21 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: David Miller <davem@davemloft.net>
Cc: jheffner@psc.edu, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: 2.6.17: networking bug??
References: <Pine.LNX.4.64.0606131048550.5498@g5.osdl.org>	<448F0344.9000008@rtr.ca>	<448F0D4B.30201@rtr.ca> <20060613.142603.48825062.davem@davemloft.net>
In-Reply-To: <20060613.142603.48825062.davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



David Miller wrote:
>..
> First, you are getting window scaling by default with the older
> kernel too.  It's just a smaller window scale, using a shift
> value of say 1 or 2.
> 
> What these broken middle boxes do is ignore the window scale
> entirely.
> 
> So they don't apply a window scale to the advertised windows in each
> packet.  Therefore, they think a smaller amount of window space is
> being advertised than really is.  So they will silently drop packets
> they think is outside of this bogus window they've calculated.
> 
> Now, when the window scale is smaller, the connection can still limp
> along, albeit slowly, making forward progress even in the face of such
> broken devices because half or a quarter of the window is still
> available.  It will retransmit a lot, and the congestion window won't
> grow at all.
> 
> When the window scale is larger, this middle box bug makes it such
> that not even one packet can fit into the miscalculated window and
> things wedge.  The box thinks that your window is "94" instead of
> "94 << WINDOW_SCALE".
..

Unilaterally following the standard is all well and good
for those who know how to get around it when a site becomes
inaccessible, but not for Joe User.

If it always fails, or always works, that's not such a big problem.
I would never have complained if I had never been able to access
the web sites in question.  But since it IS working in 2.6.16,
and got broken in 2.6.17, I'm bloody well going to complain.

I suppose the most important objection to our current behaviour
is that this behaviour *changes* when something totally unrelated
(to Joe User) happens:  adding or removing a stick of RAM.

So I'm not against the window scaling, just against it's apparent
randomness (to the vast majority who are not "in the know").

We should perhaps just have a fixed upper memory setting, as we
currently do in 2.6.16, so that the behaviour is predictable.

On a related note.. I wonder if we can choose better values for
the window size, so that if the scale factor is ignored, we still
end up with reasonably sized packets?  So that the other box
will not think our window is a mere "94" when the scale factor
is lost?

-ml

