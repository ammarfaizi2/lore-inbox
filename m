Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161120AbWF0PsW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161120AbWF0PsW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 11:48:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161122AbWF0PsV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 11:48:21 -0400
Received: from MAIL.13thfloor.at ([212.16.62.50]:31196 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S1161120AbWF0PsU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 11:48:20 -0400
Date: Tue, 27 Jun 2006 17:48:19 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: Andrey Savochkin <saw@swsoft.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       Daniel Lezcano <dlezcano@fr.ibm.com>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, serue@us.ibm.com, haveblue@us.ibm.com,
       clg@fr.ibm.com, Andrew Morton <akpm@osdl.org>, dev@sw.ru,
       devel@openvz.org, sam@vilain.net, viro@ftp.linux.org.uk,
       Alexey Kuznetsov <alexey@sw.ru>
Subject: Re: [patch 2/6] [Network namespace] Network device sharing by view
Message-ID: <20060627154818.GA28984@MAIL.13thfloor.at>
Mail-Followup-To: Andrey Savochkin <saw@swsoft.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Daniel Lezcano <dlezcano@fr.ibm.com>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, serue@us.ibm.com, haveblue@us.ibm.com,
	clg@fr.ibm.com, Andrew Morton <akpm@osdl.org>, dev@sw.ru,
	devel@openvz.org, sam@vilain.net, viro@ftp.linux.org.uk,
	Alexey Kuznetsov <alexey@sw.ru>
References: <20060609210625.144158000@localhost.localdomain> <20060626134711.A28729@castle.nmd.msu.ru> <449FF5A0.2000403@fr.ibm.com> <20060626192751.A989@castle.nmd.msu.ru> <44A00215.2040608@fr.ibm.com> <m1hd27uaxw.fsf@ebiederm.dsl.xmission.com> <20060626183649.GB3368@MAIL.13thfloor.at> <m1u067r9qk.fsf@ebiederm.dsl.xmission.com> <20060626200225.GA5330@MAIL.13thfloor.at> <20060627130911.A13959@castle.nmd.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060627130911.A13959@castle.nmd.msu.ru>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2006 at 01:09:11PM +0400, Andrey Savochkin wrote:
> Herbert,
> 
> On Mon, Jun 26, 2006 at 10:02:25PM +0200, Herbert Poetzl wrote:
> > 
> > keep in mind that you actually have three kinds
> > of network traffic on a typical host/guest system:
> > 
> >  - traffic between unit and outside
> >    - host traffic should be quite minimal
> >    - guest traffic will be quite high
> > 
> >  - traffic between host and guest
> >    probably minimal too (only for shared services)
> > 
> >  - traffic between guests
> >    can be as high (or even higher) than the
> >    outbound traffic, just think web guest and
> >    database guest
> 
> My experience with host-guest systems tells me the opposite: outside
> traffic is a way higher than traffic between guests. People put web
> server and database in different guests not more frequent than they
> put them on separate physical server. Unless people are building a
> really huge system when 1 server can't take the whole load, web and
> database live together and benefit from communications over UNIX
> sockets.

well, that's probably because you (or your company)
focuses on providers which simply (re)sell the entities
to their customers, in which case it would be more
expensive to put e.g. the database into a separate
guest. but let me state here that this is not the only
application for this technology

many folks use Linux-VServer for separating services
(e.g. mail, web, database, ...) and here a _lot_ of
traffic happens between guests (as it would on a normal
linux system or within a single guest in your case)

> Guests are usually comprised of web-db pairs, and people place many
> such guests on a single computer.

in case two guests cost more than one, yes, in case
two guests allow for better isolation and easier
maintainance without additional cost, no :)

> > > The routing between network namespaces does have the potential to
> > > be more expensive than just a packet trivially coming off the wire
> > > into a socket.
> > 
> > IMHO the routing between network namespaces should
> > not require more than the current local traffic
> > does (i.e. you should be able to achieve loopback
> > speed within an insignificant tolerance) and not
> > nearly the time required for on-wire stuff ...
> 
> I'd like to caution about over-optimizing communications between
> different network namespaces. Many optimizations of local traffic
> (such as high MTU) don't look so appealing when you start to think
> about live migration of namespaces.

I think the 'optimization' (or to be precise: desire
not to sacrifice local/loopback traffic for some use
case as you describe it) does not interfere with live
migration at all, we still will have 'local' and 'remote'
traffic, and personally I doubt that the live migration
is a feature for the masses ...

best,
Herbert

> Regards
> 	Andrey
