Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267200AbTBUF2G>; Fri, 21 Feb 2003 00:28:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267204AbTBUF2G>; Fri, 21 Feb 2003 00:28:06 -0500
Received: from rth.ninka.net ([216.101.162.244]:4520 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id <S267200AbTBUF2F>;
	Fri, 21 Feb 2003 00:28:05 -0500
Subject: Re: [ATM] who 'owns' the skb created by drivers/atm?
From: "David S. Miller" <davem@redhat.com>
To: James Morris <jmorris@intercode.com.au>
Cc: chas williams <chas@locutus.cmf.nrl.navy.mil>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0302211241070.12797-100000@blackbird.intercode.com.au>
References: <Pine.LNX.4.44.0302211241070.12797-100000@blackbird.intercode.com.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 20 Feb 2003 22:22:50 -0800
Message-Id: <1045808570.22228.2.camel@rth.ninka.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-02-20 at 17:42, James Morris wrote:
> skb->cb is owned by whatever layer is currently processing the skb.

Furthermore, once you netif_rx() an SKB it is no longer yours.
It is owned by the networking stack.

If the ATM layer wants to do fancy things and still pass the SKB
to netif_rx(), _it_ should clone the SKB and give that clone to
the ATM layer directly.

