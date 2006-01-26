Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932292AbWAZLFa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932292AbWAZLFa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 06:05:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932289AbWAZLFa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 06:05:30 -0500
Received: from port-195-158-169-59.dynamic.qsc.de ([195.158.169.59]:40105 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S932252AbWAZLF3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 06:05:29 -0500
Message-ID: <43D88C4F.7080302@trash.net>
Date: Thu, 26 Jan 2006 09:46:07 +0100
From: Patrick McHardy <kaber@trash.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Wei Yongjun <weiyj@soft.fujitsu.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH]ip_options_fragment() has no effect on fragmentation
References: <0a3101c6229a$3cc7c1b0$cfa0220a@WeiYJ>
In-Reply-To: <0a3101c6229a$3cc7c1b0$cfa0220a@WeiYJ>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wei Yongjun wrote:
> [1]Summary of the problem:
> ip_options_fragment() has no effect on fragmentation
> 
> [2]Full description of the problem:
> When I send IPv4 packet(contain Record Route Option) which need to be
> fragmented to the router, the router can not fragment it correctly.
> After fragmented by router, the second fragmentation still contain
> Record Route Option. Refer to RFC791, Record Route Option must Not be
> copied on fragmentation, goes in first fragment only.
> ip_options_fragment() is the implemental function, but there are some
> BUGs in it:
> 
> ip_option.c: line 207:
> void ip_options_fragment(struct sk_buff * skb)
> {
> unsigned char * optptr = skb->nh.raw;
> struct ip_options * opt = &(IPCB(skb)->opt);
> ...
> 
> optptr get a error pointer to the ipv4 options, correct is as following:
> 
> unsigned char * optptr = skb->nh.raw + sizeof(struct iphdr);
> 
> By the way, ip_options_fragment() just fill options not allowed in
> fragments with NOOPs, does not delete the space of the options,
> following patch has corrected the problem.

Please split the optptr fix and your enhancements in two patches and
send them to netdev@vger.kernel.org.

BTW, your mailer corrupts whitespace.
