Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422712AbWF0XH0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422712AbWF0XH0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 19:07:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932587AbWF0XH0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 19:07:26 -0400
Received: from MAIL.13thfloor.at ([212.16.62.50]:35806 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S932578AbWF0XHZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 19:07:25 -0400
Date: Wed, 28 Jun 2006 01:07:23 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Kirill Korotaev <dev@sw.ru>, Daniel Lezcano <dlezcano@fr.ibm.com>,
       Andrey Savochkin <saw@swsoft.com>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, serue@us.ibm.com, haveblue@us.ibm.com,
       clg@fr.ibm.com, Andrew Morton <akpm@osdl.org>, devel@openvz.org,
       sam@vilain.net, viro@ftp.linux.org.uk, Alexey Kuznetsov <alexey@sw.ru>
Subject: Re: [patch 2/6] [Network namespace] Network device sharing by view
Message-ID: <20060627230723.GC2612@MAIL.13thfloor.at>
Mail-Followup-To: "Eric W. Biederman" <ebiederm@xmission.com>,
	Kirill Korotaev <dev@sw.ru>, Daniel Lezcano <dlezcano@fr.ibm.com>,
	Andrey Savochkin <saw@swsoft.com>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, serue@us.ibm.com, haveblue@us.ibm.com,
	clg@fr.ibm.com, Andrew Morton <akpm@osdl.org>, devel@openvz.org,
	sam@vilain.net, viro@ftp.linux.org.uk,
	Alexey Kuznetsov <alexey@sw.ru>
References: <20060609210625.144158000@localhost.localdomain> <20060626134711.A28729@castle.nmd.msu.ru> <449FF5A0.2000403@fr.ibm.com> <20060626192751.A989@castle.nmd.msu.ru> <44A00215.2040608@fr.ibm.com> <20060627131136.B13959@castle.nmd.msu.ru> <44A0FBAC.7020107@fr.ibm.com> <44A1006B.3040700@sw.ru> <20060627160908.GC28984@MAIL.13thfloor.at> <m1y7vilfyk.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1y7vilfyk.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2006 at 10:29:39AM -0600, Eric W. Biederman wrote:
> Herbert Poetzl <herbert@13thfloor.at> writes:
> 
> > On Tue, Jun 27, 2006 at 01:54:51PM +0400, Kirill Korotaev wrote:
> >> >>My point is that if you make namespace tagging at routing time, and
> >> >>your packets are being routed only once, you lose the ability
> >> >>to have separate routing tables in each namespace.
> >> >
> >> >
> >> >Right. What is the advantage of having separate the routing tables ?
> >
> >> it is impossible to have bridged networking, tun/tap and many other 
> >> features without it. I even doubt that it is possible to introduce 
> >> private netfilter rules w/o virtualization of routing.
> >
> > why? iptables work quite fine on a typical linux
> > system when you 'delegate' certain functionality
> > to certain chains (i.e. doesn't require access to
> > _all_ of them)
> >
> >> The question is do we want to have fully featured namespaces which
> >> allow to create isolated virtual environments with semantics and
> >> behaviour of standalone linux box or do we want to introduce some
> >> hacks with new rules/restrictions to meet ones goals only?
> >
> > well, soemtimes 'hacks' are not only simpler but also 
> > a much better solution for a given problem than the
> > straight forward approach ... 
> 
> Well I would like to see a hack that qualifies.  

> I watched the linux-vserver irc channel for a while and almost
> every network problem was caused by the change in semantics 
> vserver provides.

the problem here is not the change in semantics compared
to a real linux system (as there basically is none) but
compared to _other_ technologies like UML or QEMU, which
add the need for bridging and additional interfaces, while
Linux-VServer only focuses on the IP layer ...

> In this case when you allow a guest more than one IP your hack 
> while easy to maintain becomes much more complex. 

why? a set of IPs is quite similar to a single IP (which
is actually a subset), so no real change there, only
IP_ANY means something different for a guest ...

> Especially as you address each case people care about one at a time.

hmm?

> In one shot this goes the entire way. Given how many people miss that
> you do the work at layer 2 than at layer 3 I would not call this the
> straight forward approach. The straight forward implementation yes,
> but not the straight forward approach.

seems I lost you here ...

> > for example, you won't have multiple routing tables
> > in a kernel where this feature is disabled, no?
> > so why should it affect a guest, or require modified
> > apps inside a guest when we would decide to provide
> > only a single routing table?
> >
> >> From my POV, fully virtualized namespaces are the future. 
> >
> > the future is already there, it's called Xen or UML, or QEMU :)
> 
> Yep.  And now we need it to run fast.

hmm, maybe you should try to optimize linux for Xen then,
as I'm sure it will provide the optimal virtualization
and has all the features folks are looking for (regarding
virtualization)

I thought we are trying to figure a light-weight subset
of isolation and virtualization technologies and methods
which make sense to have in mainline ...

> >> It is what makes virtualization solution usable (w/o apps
> >> modifications), provides all the features and doesn't require much
> >> efforts from people to be used.
> >
> > and what if they want to use virtualization inside
> > their guests? where do you draw the line?
> 
> The implementation doesn't have any problems with guests inside
> of guests.
> 
> The only reason to restrict guests inside of guests is because
> the we aren't certain which permissions make sense.

well, we have not even touched the permission issues yet

best,
Herbert

> Eric
