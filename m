Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964929AbWEaJoi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964929AbWEaJoi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 05:44:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964930AbWEaJoi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 05:44:38 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:33199 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S964929AbWEaJoh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 05:44:37 -0400
Date: Wed, 31 May 2006 13:44:24 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: David Miller <davem@davemloft.net>
Cc: draghuram@rocketmail.com, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: Question about tcp hash function tcp_hashfn()
Message-ID: <20060531094421.GA7806@2ka.mipt.ru>
References: <20060531.004953.91760903.davem@davemloft.net> <20060531020009.A1868@openss7.org> <20060531090301.GA26782@2ka.mipt.ru> <20060531.021243.122061524.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20060531.021243.122061524.davem@davemloft.net>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Wed, 31 May 2006 13:44:27 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 31, 2006 at 02:12:43AM -0700, David Miller (davem@davemloft.net) wrote:
> I think it will need to be changed nevertheless.  Even though this
> hash works on established sockets, it is attackable just like the
> routing hash used to be.  If an attacker has sufficient resources, he
> can make hash chains in the TCP established hash table very long.  As
> the years pass, it becomes easier and easier for one to have enough
> computing power at their disposal to carry out this kind of attack.

Jenkins hash is very complex compared to tcp XOR one, and even simple
test showed it's bottlenecks in some setups, so it's tuning will be 
quite challenging both from mathematical and engineering points of view.

And socket code actually differs from routing cache, since the former is
limited to 64k connections in a time, while routing cache can grow to 
unpredictibe sizes.

> So something like Jenkins with a random hash input become more and
> more critical.  And this requires some kind of way to rehash, RCU
> table locking opens the door for that.  Current locking scheme is
> too tightly bound for that kind of flexibility.
> 
> I wish Ben L. would resubmit the TCP hash locking stuff he said he'd
> work on.  :)

It was good approach indeed.

-- 
	Evgeniy Polyakov
