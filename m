Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261745AbSIZAjg>; Wed, 25 Sep 2002 20:39:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261757AbSIZAjf>; Wed, 25 Sep 2002 20:39:35 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:17902 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S261745AbSIZAjb>; Wed, 25 Sep 2002 20:39:31 -0400
Message-ID: <3D9259C3.6CA5D211@us.ibm.com>
Date: Wed, 25 Sep 2002 17:50:11 -0700
From: Nivedita Singhvi <niv@us.ibm.com>
X-Mailer: Mozilla 4.78 [en] (Win98; U)
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] NF-HIPAC: High Performance Packet Classification
References: <3D924F9D.C2DCF56A@us.ibm.com> <20020925.170336.77023245.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" wrote:
> 
>    From: "Nivedita Singhvi" <niv@us.ibm.com>
>    Date: 25 Sep 2002 17:06:53 -0700
>    ...
> 
>    > Everything, from packet forwarding, to firewalling, to TCP socket
>    > packet receive, can be described with routes.  It doesn't make sense
>    > for forwarding, TCP, netfilter, and encapsulation schemes to duplicate
>    > all of this table lookup logic and in fact it's entirely superfluous.
> 
>    Are you saying combine the tables themselves?
> 
>    One of the tradeoffs would be serialization of the access, then,
>    right? i.e. Much less stuff could happen in parallel? Or am I
>    completely misunderstanding your proposal?
> 
> In fact the exact opposite, such a suggested flow cache is about
> as parallel as you can make it.
> 
> Even if the per-cpu toplevel flow cache idea were not implemented and
> we used the current top-level route lookup infrastructure, it is fully
> parallelized since the toplevel hash table uses per-hashchain locks.
> Please see net/ipv4/route.c:ip_route_input() and friends.

Well, true - we have per hashchain locks, but are we now adding
the times we need to lookup something on this chain because we now 
have additional info other than the route, is what I was
wondering..?


> I don't understand why you think using the routing tables to their
> full potential would imply serialization.  If you still believe this
> you have to describe why in more detail.

thanks,
Nivedita
