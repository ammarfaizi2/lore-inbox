Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261836AbVATUxK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261836AbVATUxK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 15:53:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261907AbVATUxK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 15:53:10 -0500
Received: from mail-gw4.njit.edu ([128.235.251.32]:62919 "EHLO
	mail-gw4.njit.edu") by vger.kernel.org with ESMTP id S261836AbVATUwi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 15:52:38 -0500
Date: Thu, 20 Jan 2005 15:52:34 -0500 (EST)
From: Rahul Jain <rbj2@oak.njit.edu>
To: Kernel Traffic Mailing List <linux-kernel@vger.kernel.org>
Subject: TCP checksum calculation
Message-ID: <Pine.GSO.4.58.0501201541510.13444@chrome.njit.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have written a module that changes IP addrs and TCP port values. After
changing these fields, I am able to recalculate the IP checksum  within
the module. To recalculate the TCP checksum, I wrote a new function in
tcp_ipv4.c which is very similar to tcp_v4_send_check(). The only
difference is that, my function does not use the sock parameter and gets
the saddr and daddr from sk_buff. I call this function before the
following piece of code in tcp_v4_rcv()

if ((skb->ip_summed != CHECKSUM_UNNECESSARY &&
             tcp_v4_checksum_init(skb) < 0))
                goto bad_packet;

However I am still getting a bad tcp checksum error. Does anyone know what
I am missing and point me in the right direction.

Thanks,
Rahul.
