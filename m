Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261239AbUKEWYg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261239AbUKEWYg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 17:24:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261237AbUKEWYb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 17:24:31 -0500
Received: from marasystems.com ([83.241.133.2]:49133 "EHLO
	filer.marasystems.com") by vger.kernel.org with ESMTP
	id S261236AbUKEWYP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 17:24:15 -0500
Date: Fri, 5 Nov 2004 23:24:05 +0100 (CET)
From: Henrik Nordstrom <hno@marasystems.com>
To: Pablo Neira <pablo@eurodev.net>
cc: Patrick McHardy <kaber@trash.net>,
       Matthias Andree <matthias.andree@gmx.de>, linux-net@vger.kernel.org,
       netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org,
       "David S. Miller" <davem@redhat.com>,
       Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [BK PATCH] Fix ip_conntrack_amanda data corruption bug that
 breaks amanda dumps
In-Reply-To: <418BE156.4020400@eurodev.net>
Message-ID: <Pine.LNX.4.61.0411052320490.2017@filer.marasystems.com>
References: <20041104121522.GA16547@merlin.emma.line.org> <418A7B0B.7040803@trash.net>
 <20041104231734.GA30029@merlin.emma.line.org> <418AC0F2.7020508@trash.net>
 <418BE156.4020400@eurodev.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Nov 2004, Pablo Neira wrote:

> Patrick, what about this? this way we save a copy to a buffer for linear 
> skbs.

You need to make sure you or any of the later string match/extract 
functions are not reading outside of the skb, after the current data 
segment.

>From what I could tell this was missing in your proposed change. If the 
helper sees a packet with a C as last byte it would read past the end of 
the skb, and without looking at the whole source I see it very likely 
there is operations on the data further down assuming a null terminated 
string..

Regards
Henrik
