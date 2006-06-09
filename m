Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030200AbWFIPHZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030200AbWFIPHZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 11:07:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030201AbWFIPHZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 11:07:25 -0400
Received: from nz-out-0102.google.com ([64.233.162.205]:21975 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1030200AbWFIPHY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 11:07:24 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pWnf22u9+00d5P7VfCqZEoc4PSW9R9mX9Le1uNqE2Gfa+9ZCi4xMGI2a93cruNwted6Y6+9xY1olvyAR8d5S1FEanrT34/W0teFQyEpRgUDwlp1RQwwZyge/X/mauZYNxoK2kG3QtgORu9376HLvHoqlJ/VBH69cfWPziR/Y1DQ=
Message-ID: <305c16960606090807g6372b69dy3167b0e191b2c113@mail.gmail.com>
Date: Fri, 9 Jun 2006 12:07:23 -0300
From: "Matheus Izvekov" <mizvekov@gmail.com>
To: "Horst von Brand" <vonbrand@inf.utfsm.cl>
Subject: Re: Idea about a disc backed ram filesystem
Cc: "Sascha Nitsch" <Sash_lkl@linuxhowtos.org>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
In-Reply-To: <200606091343.k59DhC1f004434@laptop11.inf.utfsm.cl>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <mizvekov@gmail.com>
	 <305c16960606082159v2dc588abo6359d87173327c83@mail.gmail.com>
	 <200606091343.k59DhC1f004434@laptop11.inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/9/06, Horst von Brand <vonbrand@inf.utfsm.cl> wrote:
> Matheus Izvekov <mizvekov@gmail.com> wrote:
> > On 6/8/06, Horst von Brand <vonbrand@inf.utfsm.cl> wrote:
> > > tmpfs does use swap currently. Giving tmpfs a dedicated swap space is dumb,
> > > as it takes away the possibility of using that space for swapping when not
> > > in use by tmpfs (and viceversa).
>
> > The idea is not dumb per se. Maybe you want your applications to swap
> > to one device (or not swap at all) and a tmpfs mount to swap to
> > another.
>
> Why? If one device is faster, you'd want to prefer that one for swapping
> /and/ tmpfs. If not, I don't see the point. Except for limiting maximal
> sizes of tmpfs or swap, but limiting the later doesn't make much sense (why
> go OOM even though swap /is/ available?), and the former can be set on mount.
>
> >          For me at least it would make a difference.
>
> How?
>

Ok, but reality is that, even if i setup a swap partition with the
most lazy swapiness, it will swap my processes out. Is there a
pratical way to pin all processes to ram or otherwise tell the vm to
never swap any process? If there is, then you are right, there is no
point in doing this.

> > I dont use swap at all, have enough ram for all my processes.
>
> What is your beef then?
>

I just wanted to have no swap for my processes, but i wanted swap for
my tmpfs mount, as i explained. For my usage, there is no point in
having swap for processes. If something gets to use that much ram,
somethings gone wrong, and it should die anyway instead of getting my
system unusable for several minutes until swap is full too, and then
it dies anyway.

> >                                                               And ive
> > seen that for some workloads, setting a temporary directory as tmpfs
> > gives huge speed improvements. But just occasionally, the space used
> > in this temp dir will not fit in my ram, so in this case swapping
> > would be fine. The problem is, currently there is no way to enforce
> > this.
>
> That is exactly how tmpfs works, and has worked that way from the
> beginning. If it doesn't for you, it is a bug to report.
>

I know it works like this, my point was the separation.

> > Ditto for the fact that, when you have many swap devices set, each
> > with different performances, there is no way to give priorities/rules
> > to enforce who uses each device.
>
> There are priorities: See swapon(8). It has worked this way from day one
> (or for as long as I can remember, in any case). The "who gets to use swap
> and who doesn't" you can control partially via pinning processes to RAM or
> limiting their memory use.
>
> > When someone gets to implement those features,
>
> Done already, as far as it makes sense.

Good to know, except that there is no way in the universe the
algorithm can be smart enough to be optimal to all usage cases, so
some hand fiddling can be desired.

>
> >                                                this wouldnt be needed
> > anymore.
>
> Case closed.
>
> >          But that seems far away enough to justify a more immediate
> > workaround.
>
> On some level you /have/ to trust the system to do things right. It has
> much more detailed information (and better response time) than you could
> ever hope to get. Besides, adding even more knobs to fiddle just makes the
> system more complex (and thus bloated/slow) and harder to manage, for a
> limited gain in niche situations.

If it adds so much overhead, it can always be a compile option. The
system has many knobs already, its always a compromise. Im not giving
any proof that what i described is a good compromise, but at least it
can be.

> --
> Dr. Horst H. von Brand                   User #22616 counter.li.org
> Departamento de Informatica                     Fono: +56 32 654431
> Universidad Tecnica Federico Santa Maria              +56 32 654239
> Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
>
