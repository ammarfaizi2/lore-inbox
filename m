Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751301AbWF0JJY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751301AbWF0JJY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 05:09:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751311AbWF0JJY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 05:09:24 -0400
Received: from castle.nmd.msu.ru ([193.232.112.53]:33800 "HELO
	castle.nmd.msu.ru") by vger.kernel.org with SMTP id S933397AbWF0JJN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 05:09:13 -0400
Message-ID: <20060627130911.A13959@castle.nmd.msu.ru>
Date: Tue, 27 Jun 2006 13:09:11 +0400
From: Andrey Savochkin <saw@swsoft.com>
To: Herbert Poetzl <herbert@13thfloor.at>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       Daniel Lezcano <dlezcano@fr.ibm.com>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, serue@us.ibm.com, haveblue@us.ibm.com,
       clg@fr.ibm.com, Andrew Morton <akpm@osdl.org>, dev@sw.ru,
       devel@openvz.org, sam@vilain.net, viro@ftp.linux.org.uk,
       Alexey Kuznetsov <alexey@sw.ru>
Subject: Re: [patch 2/6] [Network namespace] Network device sharing by view
References: <20060609210202.215291000@localhost.localdomain> <20060609210625.144158000@localhost.localdomain> <20060626134711.A28729@castle.nmd.msu.ru> <449FF5A0.2000403@fr.ibm.com> <20060626192751.A989@castle.nmd.msu.ru> <44A00215.2040608@fr.ibm.com> <m1hd27uaxw.fsf@ebiederm.dsl.xmission.com> <20060626183649.GB3368@MAIL.13thfloor.at> <m1u067r9qk.fsf@ebiederm.dsl.xmission.com> <20060626200225.GA5330@MAIL.13thfloor.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2i
In-Reply-To: <20060626200225.GA5330@MAIL.13thfloor.at>; from "Herbert Poetzl" on Mon, Jun 26, 2006 at 10:02:25PM
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert,

On Mon, Jun 26, 2006 at 10:02:25PM +0200, Herbert Poetzl wrote:
> 
> keep in mind that you actually have three kinds
> of network traffic on a typical host/guest system:
> 
>  - traffic between unit and outside
>    - host traffic should be quite minimal
>    - guest traffic will be quite high
> 
>  - traffic between host and guest
>    probably minimal too (only for shared services)
> 
>  - traffic between guests
>    can be as high (or even higher) than the
>    outbound traffic, just think web guest and
>    database guest

My experience with host-guest systems tells me the opposite:
outside traffic is a way higher than traffic between guests.
People put web server and database in different guests not more frequent than
they put them on separate physical server.
Unless people are building a really huge system when 1 server can't take the
whole load, web and database live together and benefit from communications
over UNIX sockets.

Guests are usually comprised of web-db pairs, and people place many such
guests on a single computer.

> 
> > The routing between network namespaces does have the potential to be
> > more expensive than just a packet trivially coming off the wire into a
> > socket.
> 
> IMHO the routing between network namespaces should
> not require more than the current local traffic
> does (i.e. you should be able to achieve loopback
> speed within an insignificant tolerance) and not
> nearly the time required for on-wire stuff ...

I'd like to caution about over-optimizing communications between different
network namespaces.
Many optimizations of local traffic (such as high MTU) don't look so
appealing when you start to think about live migration of namespaces.

Regards
	Andrey
