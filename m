Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262454AbTJOI24 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 04:28:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262457AbTJOI24
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 04:28:56 -0400
Received: from main.gmane.org ([80.91.224.249]:32386 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262454AbTJOI2y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 04:28:54 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Florian Zwoch <zwoch@backendmedia.com>
Subject: Re: why does netfilter make upload very slow? (was: Re: e1000 ->
 82540EM on linux 2.6.0-test[45] very slow in one direction)
Date: Wed, 15 Oct 2003 10:28:50 +0200
Message-ID: <3F8D0542.1060101@backendmedia.com>
References: <20031008131320.GD16964@favonius> <20031008153237.GC25743@sunbeam.de.gnumonks.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
Cc: netfilter-devel@lists.netfilter.org, netdev@oss.sgi.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030909 Thunderbird/0.2
X-Accept-Language: en-us, en
In-Reply-To: <20031008153237.GC25743@sunbeam.de.gnumonks.org>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Harald Welte wrote:
>>Would somebody like to explain why netfilter (in kernel, but not in use)
>>makes upload go very slow? I am by no means a network guru, but eager to
>>learn :-)
> 
> 
> let's get this straight.  There are five possible cases
> 
> a) CONFIG_NETFILTER disabled.  you won't even have the netfilter hooks
>    in the network stack (so certainly no netfilter-using modules loaded)

no problem

> b) CONFIG_NETFILTER enabled, but _no_ modules (iptable_filter,
>    ip_conntrack, ...) attached to the netfilter hook

no problem

> c) CONFIG_NETFILTER enabled and iptable_filter.o (which pulls ip_tables.o)
>    loaded, NO RULES in the table

no problem

> d) CONFIG_NETFILTER enabled and iptable_filter.o (which pulls ip_tables.o)
>    loaded, RULES in the table

no problem (as long as i dont load any rules that require ip_conntrack)

> e) CONFIG_NETFILTER enabled and ip_conntrack.o loaded, iptable_filter
>    loaded or not, rules or not

*boink*

whenever i try to load ip_conntrack the nic performance drops from 5mb/s 
to 200k/s.

still using 2.6.0-test6.

regards,
Florian


