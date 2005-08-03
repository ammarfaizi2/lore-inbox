Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261953AbVHCBrJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261953AbVHCBrJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 21:47:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261971AbVHCBrI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 21:47:08 -0400
Received: from [62.206.217.67] ([62.206.217.67]:42205 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261953AbVHCBrD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 21:47:03 -0400
Message-ID: <42F02200.1090802@trash.net>
Date: Wed, 03 Aug 2005 03:46:40 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Denis Vlasenko <vda@ilport.com.ua>
CC: netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org,
       Harald Welte <laforge@netfilter.org>, James Morris <jmorris@redhat.com>,
       coreteam@netfilter.org, David Miller <davem@davemloft.net>
Subject: Re: [netfilter-core] iptables redirect is broken on bridged setup
References: <200507291209.37247.vda@ilport.com.ua>
In-Reply-To: <200507291209.37247.vda@ilport.com.ua>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko wrote:
> Linux 2.6.12
> 
> Was running for months with this simple iptables rule:
> 
> iptables -t nat -A PREROUTING -s 172.17.6.44 -d 172.16.42.201 -p tcp --dport 9100 -j REDIRECT --to 9123
> 
> Chain PREROUTING (policy ACCEPT 0 packets, 0 bytes)
>        0        0 REDIRECT   tcp  --  *      *       172.17.6.44          172.16.42.201      tcp dpt:9100 redir ports 9123
> 
> But now I need to bridge together two eth cards in this machine, and
> suddenly redirect is no longer works.

This doesn't look related to the nf_reset problem since it happens
in PREROUTING and only the output hooks are defered. I suspect a
configuration error, when there is no IP configured on a device
the REDIRECT target can't be used.
