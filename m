Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965138AbWFINpG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965138AbWFINpG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 09:45:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965187AbWFINpG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 09:45:06 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:34021 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S965138AbWFINpF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 09:45:05 -0400
Message-Id: <200606091343.k59DhC1f004434@laptop11.inf.utfsm.cl>
To: "Matheus Izvekov" <mizvekov@gmail.com>
cc: "Horst von Brand" <vonbrand@inf.utfsm.cl>,
       "Sascha Nitsch" <Sash_lkl@linuxhowtos.org>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: Idea about a disc backed ram filesystem 
In-Reply-To: Message from "Matheus Izvekov" <mizvekov@gmail.com> 
   of "Fri, 09 Jun 2006 01:59:25 -0300." <305c16960606082159v2dc588abo6359d87173327c83@mail.gmail.com> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 19)
Date: Fri, 09 Jun 2006 09:43:12 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0.2 (inti.inf.utfsm.cl [200.1.21.155]); Fri, 09 Jun 2006 09:43:13 -0400 (CLT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matheus Izvekov <mizvekov@gmail.com> wrote:
> On 6/8/06, Horst von Brand <vonbrand@inf.utfsm.cl> wrote:
> > tmpfs does use swap currently. Giving tmpfs a dedicated swap space is dumb,
> > as it takes away the possibility of using that space for swapping when not
> > in use by tmpfs (and viceversa).

> The idea is not dumb per se. Maybe you want your applications to swap
> to one device (or not swap at all) and a tmpfs mount to swap to
> another.

Why? If one device is faster, you'd want to prefer that one for swapping
/and/ tmpfs. If not, I don't see the point. Except for limiting maximal
sizes of tmpfs or swap, but limiting the later doesn't make much sense (why
go OOM even though swap /is/ available?), and the former can be set on mount.

>          For me at least it would make a difference.

How?

> I dont use swap at all, have enough ram for all my processes.

What is your beef then?

>                                                               And ive
> seen that for some workloads, setting a temporary directory as tmpfs
> gives huge speed improvements. But just occasionally, the space used
> in this temp dir will not fit in my ram, so in this case swapping
> would be fine. The problem is, currently there is no way to enforce
> this.

That is exactly how tmpfs works, and has worked that way from the
beginning. If it doesn't for you, it is a bug to report.

> Ditto for the fact that, when you have many swap devices set, each
> with different performances, there is no way to give priorities/rules
> to enforce who uses each device.

There are priorities: See swapon(8). It has worked this way from day one
(or for as long as I can remember, in any case). The "who gets to use swap
and who doesn't" you can control partially via pinning processes to RAM or
limiting their memory use.

> When someone gets to implement those features,

Done already, as far as it makes sense.

>                                                this wouldnt be needed
> anymore.

Case closed.

>          But that seems far away enough to justify a more immediate
> workaround.

On some level you /have/ to trust the system to do things right. It has
much more detailed information (and better response time) than you could
ever hope to get. Besides, adding even more knobs to fiddle just makes the
system more complex (and thus bloated/slow) and harder to manage, for a
limited gain in niche situations.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
