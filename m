Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161144AbWF0QJL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161144AbWF0QJL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 12:09:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161141AbWF0QJL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 12:09:11 -0400
Received: from MAIL.13thfloor.at ([212.16.62.50]:43996 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S1161138AbWF0QJJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 12:09:09 -0400
Date: Tue, 27 Jun 2006 18:09:08 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: Kirill Korotaev <dev@sw.ru>
Cc: Daniel Lezcano <dlezcano@fr.ibm.com>, Andrey Savochkin <saw@swsoft.com>,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org, serue@us.ibm.com,
       haveblue@us.ibm.com, clg@fr.ibm.com, Andrew Morton <akpm@osdl.org>,
       devel@openvz.org, sam@vilain.net, ebiederm@xmission.com,
       viro@ftp.linux.org.uk, Alexey Kuznetsov <alexey@sw.ru>
Subject: Re: [patch 2/6] [Network namespace] Network device sharing by view
Message-ID: <20060627160908.GC28984@MAIL.13thfloor.at>
Mail-Followup-To: Kirill Korotaev <dev@sw.ru>,
	Daniel Lezcano <dlezcano@fr.ibm.com>,
	Andrey Savochkin <saw@swsoft.com>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, serue@us.ibm.com, haveblue@us.ibm.com,
	clg@fr.ibm.com, Andrew Morton <akpm@osdl.org>, devel@openvz.org,
	sam@vilain.net, ebiederm@xmission.com, viro@ftp.linux.org.uk,
	Alexey Kuznetsov <alexey@sw.ru>
References: <20060609210202.215291000@localhost.localdomain> <20060609210625.144158000@localhost.localdomain> <20060626134711.A28729@castle.nmd.msu.ru> <449FF5A0.2000403@fr.ibm.com> <20060626192751.A989@castle.nmd.msu.ru> <44A00215.2040608@fr.ibm.com> <20060627131136.B13959@castle.nmd.msu.ru> <44A0FBAC.7020107@fr.ibm.com> <44A1006B.3040700@sw.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44A1006B.3040700@sw.ru>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2006 at 01:54:51PM +0400, Kirill Korotaev wrote:
> >>My point is that if you make namespace tagging at routing time, and
> >>your packets are being routed only once, you lose the ability
> >>to have separate routing tables in each namespace.
> >
> >
> >Right. What is the advantage of having separate the routing tables ?

> it is impossible to have bridged networking, tun/tap and many other 
> features without it. I even doubt that it is possible to introduce 
> private netfilter rules w/o virtualization of routing.

why? iptables work quite fine on a typical linux
system when you 'delegate' certain functionality
to certain chains (i.e. doesn't require access to
_all_ of them)

> The question is do we want to have fully featured namespaces which
> allow to create isolated virtual environments with semantics and
> behaviour of standalone linux box or do we want to introduce some
> hacks with new rules/restrictions to meet ones goals only?

well, soemtimes 'hacks' are not only simpler but also 
a much better solution for a given problem than the
straight forward approach ... 

for example, you won't have multiple routing tables
in a kernel where this feature is disabled, no?
so why should it affect a guest, or require modified
apps inside a guest when we would decide to provide
only a single routing table?

> From my POV, fully virtualized namespaces are the future. 

the future is already there, it's called Xen or UML, or QEMU :)

> It is what makes virtualization solution usable (w/o apps
> modifications), provides all the features and doesn't require much
> efforts from people to be used.

and what if they want to use virtualization inside
their guests? where do you draw the line?

best,
Herbert

> Thanks,
> Kirill
