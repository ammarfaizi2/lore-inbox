Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266706AbRG2JOt>; Sun, 29 Jul 2001 05:14:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266710AbRG2JOj>; Sun, 29 Jul 2001 05:14:39 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:46134 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S266706AbRG2JOV>; Sun, 29 Jul 2001 05:14:21 -0400
To: swsnyder@home.com
Cc: Chris Wedgwood <cw@f00f.org>, linux-kernel@vger.kernel.org
Subject: Re: What does "Neighbour table overflow" message indicate?
In-Reply-To: <01072820231401.01125@mercury.snydernet.lan>
	<01072820534802.01125@mercury.snydernet.lan>
	<20010729135728.B3282@weta.f00f.org>
	<01072821151103.01125@mercury.snydernet.lan>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 29 Jul 2001 03:08:13 -0600
In-Reply-To: <01072821151103.01125@mercury.snydernet.lan>
Message-ID: <m11yn0cdc2.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

> Further snooping shows the error msg text in file inux/net/ipv4/route.c:
> 
>     if (net_ratelimit())
>         printk("Neighbour table overflow.\n");

> 
> The reference to "net_ratelimit" make me wonder if it is related to 
> iptables.  I am using iptable, and have since kernel 2.4.1, but I've seen 
> these messages before.  Hmmm.

My experience with this is the message occurs when you a machine starts
arping for a non-existent ip address.  I suspect net_ratelimit triggers
when there are too many arps.

Run tcpdump -n -i eth0 (assuming your network is on eth0) and see if you
see an arp request that never gets answered.

Eric
