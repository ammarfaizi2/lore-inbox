Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261637AbUBYWNu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 17:13:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261767AbUBYWNY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 17:13:24 -0500
Received: from alt.aurema.com ([203.217.18.57]:29593 "EHLO smtp.sw.oz.au")
	by vger.kernel.org with ESMTP id S261647AbUBYWMp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 17:12:45 -0500
Date: Thu, 26 Feb 2004 09:12:37 +1100 (EST)
From: John Lee <johnl@aurema.com>
To: Timothy Miller <miller@techsource.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] O(1) Entitlement Based Scheduler
In-Reply-To: <403CD6DB.7040507@techsource.com>
Message-ID: <Pine.GSO.4.03.10402260834530.27582-100000@swag.sw.oz.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 25 Feb 2004, Timothy Miller wrote:

> Well, considering that X is suid root, it's okay to require that it be 
> run at nice -15, but how is the user without root access going to renice 
> xmms?  

Hm, I would have thought the vast majority of xmms users would be running
it on their own machines, to which they have root access. Hope I'm not 
missing something here... :-)

> Even for those who do, they're not going to want to have to 
> renice xmms every time they run it.  Furthermore, it seems like a bad 
> idea to keep marking more and more programs as suid root just so that 
> they can boost their priority.

Assuming that all/most xmms users do have root permissions, I would think
that this is a very minor inconvenience... isn't xmms something which you
tend to start up once and leave running until you log out?

I don't think xmms needs to be an suid program, it can just be given a
renice once (ie. more shares, -9 ==> 101 shares, which is 5 times
the default, just my choice) and then left alone. Furthermore, the
controls that my patch features are intended to be exercised as root,
normal users can do less (as for nice, you can give your own processes
less shares but not more, and can apply _more_ restrictive CPU caps on
your tasks).

>From my testing so far, X and xmms have been the only candidates for a
shares increase, as these two have been the most talked about :-).
And after all, one purpose of the patch is to allow users to allocate CPU
to their tasks in any way they deem fit.

> Not to say that your idea is bad... in fact, it may be a pipe dream to 
> get "flawless" interactivity without explicitly marking which programs 
> have to be boosted in priority.  Still, Nick and Con have done a 
> wonderful job at getting close.

They have indeed, there haven't been any "poor interactivity" emails for a
while now :-).

Good interactivity was just one of my goals, I was also aiming for better
CPU resource allocation and simplification of the main code paths in the
scheduler by doing away with heuristics, and therefore better throughput.

Cheers,

John


