Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932159AbWATUUV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932159AbWATUUV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 15:20:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932163AbWATUUV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 15:20:21 -0500
Received: from wproxy.gmail.com ([64.233.184.206]:16305 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932159AbWATUUU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 15:20:20 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=R9kEC/DzDPFh3Hqe0vCV29e3gyRcaeRuvTi/ZOBzERDqrUQXgb0icz8hSrtt/3tNBPQLPoNfioWZNiewE+Y/8Np/B9UwHUECnGY+CknsMFJfxlehsWKzz/KmE8QlaEDrOSdH3+7Yt4adOF6rmFKugOXKLgtlG+Ny7TDOy6cvgg4=
Message-ID: <9a8748490601201220h2d85fa4au780715ff287cf1eb@mail.gmail.com>
Date: Fri, 20 Jan 2006 21:20:19 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Michael Loftis <mloftis@wgops.com>
Subject: Re: Development tree, PLEASE?
Cc: dtor_core@ameritech.net, James Courtier-Dutton <James@superbug.co.uk>,
       linux-kernel@vger.kernel.org
In-Reply-To: <30D11C032F1FC0FE9CA1CDFD@d216-220-25-20.dynip.modwest.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <D1A7010C56BB90C4FA73E6DD@dhcp-2-206.wgops.com>
	 <43D10FF8.8090805@superbug.co.uk>
	 <6769FDC09295B7E6078A5089@d216-220-25-20.dynip.modwest.com>
	 <d120d5000601200850w611e8af8v41a0786b7dc973d9@mail.gmail.com>
	 <30D11C032F1FC0FE9CA1CDFD@d216-220-25-20.dynip.modwest.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/20/06, Michael Loftis <mloftis@wgops.com> wrote:
>
[snip]
> I'm trying to think of a way to relate this better but I just can't.
> What's needed is a 'target' for incremental updates, things like minor
> changes, bugfixes, etc.  I feel like supporting entirely new hardware

That's called a vendor kernel.
You pay the vendor money, the vendor maintains a stable (as in feature
frozen) kernel, backports bugfixes for you etc.
Take a look at the RedHat and SuSE enterprise kernels, they seem to be
what you want.

> (provided that the API is 'frozen' when it's realeased mainstream) in a
> stable kernel is fine, even adding features and functionality to existing
> stuff is fine but without having to take the whole damned enchilada of
> changes a development tree entails, which is all of the internal APIs.
> Yeah, it would/will become generally stagnant tree, but that's the point of
> a stable release.
>

In my book 'stable' means 'doesn't crash' and 'doesn't break userspace
without long advance notice', it doesn't mean 'does not evolve/goes
stale'.
And in my oppinion the current 2.6 tree succeeds in being a stable kernel.

Besides, I don't agree with your view that we break userspace all the
time as you seem to be saying in several of your mails, quite the
opposite - a lot of work goes into *not* breaking userspace.
Just take a look at how syscalls are maintained, even old obsolete
ones stay in place since removing them would break userspace. Stuff in
/proc does not get changed since that would potentially break
userspace. Look at the fact that you can still run ancient a.out
binaries on a recent 2.6.x kernel.
Even internal kernel APIs usually stay around with __deprecated or as
wrappers around new APIs for extensive periods of time.
And when stuff is removed it's announced for ages in advance. That
devfs would be removed was announced several *years* before it
actually happened. That old OSS drivers will be removed (but only for
hardware that has ALSA equivalents) has been announced months ago and
the removal won't happen for several months (at least) yet.

I'd say the kernel tries damn hard at maintaining backwards
compatibility for userspace.
It tries less hard, but still makes a pretty good effort, for internal
APIs, but the real solution to the internal API churn is to get your
code merged as it'll then get updated automagically whenever something
changes - people who remove or change internals try very hard to also
update all (in-tree) users of the old stuff - take a look at when I
removed a small thing like verify_area() if you want an example.


> It's horrificly expensive to maintain large numbers of machines (even if
> it's automated) as it is.  If you're doing embedded development too or
> instead, it gets even harder when you need certain bugfixes or minor
> changes, but end up having to redevelop things or start maintaining your
> own kernel fork.
>
The solution here is to get your code merged in mainline.

[snip]

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
