Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267410AbUIFDfr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267410AbUIFDfr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 23:35:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267415AbUIFDfr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 23:35:47 -0400
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:39090
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S267410AbUIFDfp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 23:35:45 -0400
Date: Sun, 5 Sep 2004 20:33:31 -0700
From: "David S. Miller" <davem@davemloft.net>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: anton@samba.org, akpm@osdl.org, torvalds@osdl.org, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 0/3] beat kswapd with the proverbial clue-bat
Message-Id: <20040905203331.7a2a2fad.davem@davemloft.net>
In-Reply-To: <413AE5DA.9070208@yahoo.com.au>
References: <413AA7B2.4000907@yahoo.com.au>
	<20040904230939.03da8d2d.akpm@osdl.org>
	<20040905062743.GG7716@krispykreme>
	<413AE5DA.9070208@yahoo.com.au>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 05 Sep 2004 20:09:30 +1000
Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> Yeah I had seen a few, surprisingly few though. Sorry I'm a bit clueless
> about networking - I suppose there is a good reason for the 16K MTU? My
> first thought might be that a 4K one could be better on CPU cache as well
> as lighter on the mm. I know the networking guys know what they're doing
> though...

It's better to get as long a stride as possible for the copy
from userspace, and yes as you get larger you run into cache
issues.  16K turned out the be the break point considering those
two attributes when I did my testing.

Just fool around with ifconfig lo mtu XXX and TCP bandwidth tests.
See what you come up with.
