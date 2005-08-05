Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261385AbVHEQcD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261385AbVHEQcD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 12:32:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263025AbVHEQcD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 12:32:03 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:60060
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S261385AbVHEQcB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 12:32:01 -0400
Date: Fri, 05 Aug 2005 09:32:08 -0700 (PDT)
Message-Id: <20050805.093208.74729918.davem@davemloft.net>
To: sandos@home.se
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       herbert@gondor.apana.org.au, akpm@osdl.org
Subject: Re: assertion (cnt <= tp->packets_out) failed
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <42F38B67.5040308@home.se>
References: <42F38B67.5040308@home.se>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Bäckstrand <sandos@home.se>
Date: Fri, 05 Aug 2005 17:53:11 +0200

> KERNEL: assertion (cnt <= tp->packets_out) failed at 
> net/ipv4/tcp_input.c (1476)

I suspect this is a side effect of some changes Herbert Xu and
myself did to fix some other bugs.

Herbert, I think there are serious consequences for changing the
TSO counts for packets we have sent out already.  This mucks up
all of the loss packet counts, which triggers asserts all over
in tcp_input.c

As you may note, we have all of this special code when we fragment
packets that updates all of the counters properly.  And we're
not doing that for the new code that reinits the TSO count when
the MSS is found to no longer match.

It therefore may be desirable to keep Herbert's fix in there, but
back out my changes until they can be reimplemented correctly.

Herbert?
