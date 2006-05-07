Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932198AbWEGRA6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932198AbWEGRA6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 May 2006 13:00:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932200AbWEGRA6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 May 2006 13:00:58 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:33335 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932198AbWEGRA5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 May 2006 13:00:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LXI7nsrovL5jkRf7Oi1yPJ1EoJFeEbPwa+swwc6Z/MGHRYgrcYxHQQX4nWDBsBZXyneQxWHTogsp2EQJRlBZtbDnpi25iAgffEy4bkzo5ZIF8mOQGI/4qz0+ZaJ3JHWDX/cwjPbfQhCp67sPZKl53WM4mvGzEBItjBZF+x7ZsBo=
Message-ID: <82ecf08e0605071000s55818329q4c51c1771f88e372@mail.gmail.com>
Date: Sun, 7 May 2006 14:00:55 -0300
From: "Thiago Galesi" <thiagogalesi@gmail.com>
To: "Matt Mackall" <mpm@selenic.com>
Subject: Re: [PATCH 7/14] random: Remove SA_SAMPLE_RANDOM from network drivers
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060507160013.GM15445@waste.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060505203436.GW15445@waste.org>
	 <20060506115502.GB18880@thunk.org> <20060506164808.GY15445@waste.org>
	 <20060506.170810.74552888.davem@davemloft.net>
	 <20060507045920.GH15445@waste.org>
	 <82ecf08e0605070613o7b217a2bw4c71c3a8c33bed28@mail.gmail.com>
	 <20060507160013.GM15445@waste.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >
> > OK, here goes...
> >
> > 1 - by eliminating feeding enthopy from network cards you are
>
> Keep up, folks, I dropped that position in the very first round of replies.

>As I said at the beginning of this thread, I'm perfectly happy to
>continue taking samples from network devices. My concerns are entirely
>with how we account their entropy, which is strictly in the realm of
>theory to start with.

ok, now I get it...

>
> > 2 - some platforms have much better enthropy sources than ethernet (or
> > user input), just think hardware rngs, or even the sound card rng
> > thing mentioned above
>
> Point?

Point is, sometimes you have plenty of enthropy available and
sometimes you only have the network card (and maybe an HD). Two
different situations, in one of them we can accept (it's even beter)
not acquiring enthropy from the network card completely.

>
> > 3 - as people said, your example (CRC-16 on specific platfoms) is
> > (IMHO) an exxageration.
>
> Yes, CRC-16 was a rhetorical device. MD4 would not have been. HZ=100
> is not an exaggeration.

Agreed

 Odds are pretty good you have such a Linux box
> in the form of a router or such already. This completely invalidates
> all the arguments about the hardware making the timing too
> unpredictable as it does so on a timescale of microseconds or less.

Yes, that situation is pretty common.

Here is my point: I don't think the kernel shoud "try very hard" to
fix "lack of good enthropy sources". Yes, you've presented situations
where someone (ultimately) could guess what is being read from
/dev/random.

In practice, though, it should ultimatelly fall upon the
end-user/developer to have a system with good enough (for him/her)
enthropy sources. If he is happy with lots of "bad enthropy" so be it.
Hovever, if he wants / needs to be sure that /dev/random is not
predictable, (IMHO) he can always plug a hardware RNG and only read
from that (hence what I said about configuring who are your enthropy
sources).
