Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261294AbVATXca@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261294AbVATXca (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 18:32:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261296AbVATXca
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 18:32:30 -0500
Received: from hera.kernel.org ([209.128.68.125]:13708 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S261294AbVATXc0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 18:32:26 -0500
To: linux-kernel@vger.kernel.org
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: TCP checksum calculation
Date: Thu, 20 Jan 2005 15:32:27 -0800
Organization: Open Source Development Lab
Message-ID: <20050120153227.69fd1d55@dxpl.pdx.osdl.net>
References: <Pine.GSO.4.58.0501201541510.13444@chrome.njit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Trace: build.pdx.osdl.net 1106263943 29227 172.20.1.103 (20 Jan 2005 23:32:23 GMT)
X-Complaints-To: abuse@osdl.org
NNTP-Posting-Date: Thu, 20 Jan 2005 23:32:23 +0000 (UTC)
X-Newsreader: Sylpheed-Claws 0.9.13 (GTK+ 1.2.10; x86_64-unknown-linux-gnu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Jan 2005 15:52:34 -0500 (EST)
Rahul Jain <rbj2@oak.njit.edu> wrote:

> Hi,
> 
> I have written a module that changes IP addrs and TCP port values. After
> changing these fields, I am able to recalculate the IP checksum  within
> the module. To recalculate the TCP checksum, I wrote a new function in
> tcp_ipv4.c which is very similar to tcp_v4_send_check(). The only
> difference is that, my function does not use the sock parameter and gets
> the saddr and daddr from sk_buff. I call this function before the
> following piece of code in tcp_v4_rcv()
> 
> if ((skb->ip_summed != CHECKSUM_UNNECESSARY &&
>              tcp_v4_checksum_init(skb) < 0))
>                 goto bad_packet;
> 
> However I am still getting a bad tcp checksum error. Does anyone know what
> I am missing and point me in the right direction.
> 

Look at the netfilter code, in fact if you are changing values there may already
be a netfilter module to do what you want, and you could have saved the effort.

-- 
Stephen Hemminger	<shemminger@osdl.org>
