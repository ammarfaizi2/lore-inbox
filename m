Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261896AbVFLOoI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261896AbVFLOoI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 10:44:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262614AbVFLOoI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 10:44:08 -0400
Received: from postel.suug.ch ([195.134.158.23]:55494 "EHLO postel.suug.ch")
	by vger.kernel.org with ESMTP id S261896AbVFLOoF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 10:44:05 -0400
Date: Sun, 12 Jun 2005 16:44:26 +0200
From: Thomas Graf <tgraf@suug.ch>
To: Willy Tarreau <willy@w.ods.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, davem@davemloft.net,
       xschmi00@stud.feec.vutbr.cz, alastair@unixtrix.com,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [PATCH] fix small DoS on connect() (was Re: BUG: Unusual TCP Connect() results.)
Message-ID: <20050612144426.GC22463@postel.suug.ch>
References: <E1DhBic-0005dp-00@gondolin.me.apana.org.au> <20050611195144.GF28759@alpha.home.local> <20050612081327.GA24384@gondor.apana.org.au> <20050612083409.GA8220@alpha.home.local> <20050612103020.GA25111@gondor.apana.org.au> <20050612114039.GI28759@alpha.home.local> <20050612120627.GA5858@gondor.apana.org.au> <20050612123253.GK28759@alpha.home.local> <20050612131323.GA10188@gondor.apana.org.au> <20050612133654.GA8951@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050612133654.GA8951@alpha.home.local>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Willy Tarreau <20050612133654.GA8951@alpha.home.local> 2005-06-12 15:36
> > The RST packet is sent by client A using its sequence numbers.  Therefore
> > it will pass the sequence number check on server B.
> >
> > 4) server B resets the connection.
> 
> No, precisely the RST sent by A will take its SEQ from C's ACK number.
> This is why B will *not* reset the connection (again, tested) if C's ACK
> was not within B's window.

Absolutely but it relies on the other stack being correctly implemented.
The attack would work perfectly fine if there wasn't the rule that a RST
must not be sent in response to another RST. The attack has been
successful and still is because some firewalls are configured to send
RSTs without respecting this rule.

I like your patch and the idea behind it, it can successfully defeat the
most simple method of preventing connections being established.
