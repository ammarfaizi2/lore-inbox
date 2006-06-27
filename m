Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161164AbWF0QbL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161164AbWF0QbL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 12:31:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161162AbWF0QbL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 12:31:11 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:12198 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1161157AbWF0QbJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 12:31:09 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Herbert Poetzl <herbert@13thfloor.at>
Cc: Kirill Korotaev <dev@sw.ru>
Cc: Daniel Lezcano <dlezcano@fr.ibm.com>, Andrey Savochkin <saw@swsoft.com>,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org, serue@us.ibm.com,
       haveblue@us.ibm.com, clg@fr.ibm.com, Andrew Morton <akpm@osdl.org>,
       devel@openvz.org, sam@vilain.net, ebiederm@xmission.com,
       viro@ftp.linux.org.uk, Alexey Kuznetsov <alexey@sw.ru>
Subject: Re: [patch 2/6] [Network namespace] Network device sharing by view
References: <20060609210202.215291000@localhost.localdomain>
	<20060609210625.144158000@localhost.localdomain>
	<20060626134711.A28729@castle.nmd.msu.ru>
	<449FF5A0.2000403@fr.ibm.com> <20060626192751.A989@castle.nmd.msu.ru>
	<44A00215.2040608@fr.ibm.com>
	<20060627131136.B13959@castle.nmd.msu.ru>
	<44A0FBAC.7020107@fr.ibm.com> <44A1006B.3040700@sw.ru>
	<20060627160908.GC28984@MAIL.13thfloor.at>
Date: Tue, 27 Jun 2006 10:29:39 -0600
In-Reply-To: <20060627160908.GC28984@MAIL.13thfloor.at> (Herbert Poetzl's
	message of "Tue, 27 Jun 2006 18:09:08 +0200")
Message-ID: <m1y7vilfyk.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Poetzl <herbert@13thfloor.at> writes:

> On Tue, Jun 27, 2006 at 01:54:51PM +0400, Kirill Korotaev wrote:
>> >>My point is that if you make namespace tagging at routing time, and
>> >>your packets are being routed only once, you lose the ability
>> >>to have separate routing tables in each namespace.
>> >
>> >
>> >Right. What is the advantage of having separate the routing tables ?
>
>> it is impossible to have bridged networking, tun/tap and many other 
>> features without it. I even doubt that it is possible to introduce 
>> private netfilter rules w/o virtualization of routing.
>
> why? iptables work quite fine on a typical linux
> system when you 'delegate' certain functionality
> to certain chains (i.e. doesn't require access to
> _all_ of them)
>
>> The question is do we want to have fully featured namespaces which
>> allow to create isolated virtual environments with semantics and
>> behaviour of standalone linux box or do we want to introduce some
>> hacks with new rules/restrictions to meet ones goals only?
>
> well, soemtimes 'hacks' are not only simpler but also 
> a much better solution for a given problem than the
> straight forward approach ... 

Well I would like to see a hack that qualifies.  I watched the
linux-vserver irc channel for a while and almost every network problem
was caused by the change in semantics vserver provides.

In this case when you allow a guest more than one IP your hack while
easy to maintain becomes much more complex.  Especially as you address
each case people care about one at a time.

In one shot this goes the entire way.  Given how many people miss
that you do the work at layer 2 than at layer 3 I would not call this
the straight forward approach.  The straight forward implementation yes,
but not the straight forward approach.

> for example, you won't have multiple routing tables
> in a kernel where this feature is disabled, no?
> so why should it affect a guest, or require modified
> apps inside a guest when we would decide to provide
> only a single routing table?
>
>> From my POV, fully virtualized namespaces are the future. 
>
> the future is already there, it's called Xen or UML, or QEMU :)

Yep.  And now we need it to run fast.

>> It is what makes virtualization solution usable (w/o apps
>> modifications), provides all the features and doesn't require much
>> efforts from people to be used.
>
> and what if they want to use virtualization inside
> their guests? where do you draw the line?

The implementation doesn't have any problems with guests inside
of guests.

The only reason to restrict guests inside of guests is because
the we aren't certain which permissions make sense.

Eric
