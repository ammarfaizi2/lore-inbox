Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262226AbUDDHLo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Apr 2004 03:11:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262236AbUDDHLo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Apr 2004 03:11:44 -0400
Received: from dbl.q-ag.de ([213.172.117.3]:30870 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S262226AbUDDHLn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Apr 2004 03:11:43 -0400
Message-ID: <406FB51E.3090001@colorfullife.com>
Date: Sun, 04 Apr 2004 09:11:26 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.4.1) Gecko/20031114
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: hadi@cyberus.ca
CC: netdev@oss.sgi.com, linux-kernel@vger.kernel.org,
       Michal Wronski <wrona@mat.uni.torun.pl>,
       Krzysztof Benedyczak <golbi@mat.uni.torun.pl>
Subject: Re: [RFC, PATCH] netlink based mq_notify(SIGEV_THREAD)
References: <406F13A1.4030201@colorfullife.com>	 <1081023487.2037.19.camel@jzny.localdomain>	 <406F21FB.4010502@colorfullife.com> <1081029667.2037.55.camel@jzny.localdomain>
In-Reply-To: <1081029667.2037.55.camel@jzny.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jamal wrote:

>Your split of netlink_unicast seems fine ; 
>I guess the bigger question is whether this interface could be a
>speacilized netlink protocol instead? It doesnt seem too nasty as is
>right now, just tending towards cleanliness.
>It seems that user space must first open a netlink socket for this to
>work but somehow the result skb is passed back to userspace using the
>mq_notify and not via the socket interface opened?
>
No, the result is returned via the socket fd. It's just created due to 
the mq_notify call.

> Why should user space
>even bother doing this? The kernel could on its behalf, no? Are you sure
>there will always be one and only one message outstanding always?
>  
>
There can be multiple messages outstanding. Each sucessful mq_notify 
call generates exactly one message, but a process could create multiple 
message queues and then there can be multiple messages in the 
notification socket.

--
    Manfred

