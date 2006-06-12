Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751055AbWFLGt7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751055AbWFLGt7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 02:49:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751401AbWFLGt7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 02:49:59 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:54204
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751055AbWFLGt6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 02:49:58 -0400
Date: Sun, 11 Jun 2006 23:50:05 -0700 (PDT)
Message-Id: <20060611.235005.51843280.davem@davemloft.net>
To: mingo@elte.hu
Cc: herbert@gondor.apana.org.au, stefanr@s5r6.in-berlin.de,
       Valdis.Kletnieks@vt.edu, jirislaby@gmail.com, akpm@osdl.org,
       arjan@infradead.org, mingo@redhat.com, linux-kernel@vger.kernel.org,
       linux1394-devel@lists.sourceforge.net, netdev@vger.kernel.org
Subject: Re: 2.6.17-rc5-mm3-lockdep -
From: David Miller <davem@davemloft.net>
In-Reply-To: <20060612063807.GA23939@elte.hu>
References: <4485AFB9.3040005@s5r6.in-berlin.de>
	<20060607071208.GA1951@gondor.apana.org.au>
	<20060612063807.GA23939@elte.hu>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar <mingo@elte.hu>
Date: Mon, 12 Jun 2006 08:38:07 +0200

> yeah. I'll investigate - it's quite likely that sk_receive_queue.lock 
> will have to get per-address family locking rules - right?

That's right.

> Maybe it's enough to introduce a separate key for AF_UNIX alone (and 
> still having all other protocols share the locking rules for 
> sk_receive_queue.lock) , by reinitializing its spinlock after 
> sock_init_data()?

AF_NETLINK and/or AF_PACKET might be in a similar situation
as AF_UNIX.
