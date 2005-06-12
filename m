Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262352AbVFLMW2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262352AbVFLMW2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 08:22:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262420AbVFLMW2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 08:22:28 -0400
Received: from postel.suug.ch ([195.134.158.23]:63173 "EHLO postel.suug.ch")
	by vger.kernel.org with ESMTP id S262352AbVFLMW0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 08:22:26 -0400
Date: Sun, 12 Jun 2005 14:22:47 +0200
From: Thomas Graf <tgraf@suug.ch>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Willy Tarreau <willy@w.ods.org>, davem@davemloft.net,
       xschmi00@stud.feec.vutbr.cz, alastair@unixtrix.com,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [PATCH] fix small DoS on connect() (was Re: BUG: Unusual TCP Connect() results.)
Message-ID: <20050612122247.GB22463@postel.suug.ch>
References: <20050611074350.GD28759@alpha.home.local> <E1DhBic-0005dp-00@gondolin.me.apana.org.au> <20050611195144.GF28759@alpha.home.local> <20050612081327.GA24384@gondor.apana.org.au> <20050612083409.GA8220@alpha.home.local> <20050612103020.GA25111@gondor.apana.org.au> <20050612114039.GI28759@alpha.home.local> <20050612120627.GA5858@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050612120627.GA5858@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Herbert Xu <20050612120627.GA5858@gondor.apana.org.au> 2005-06-12 22:06
> On Sun, Jun 12, 2005 at 01:40:39PM +0200, Willy Tarreau wrote:
> >
> > Sorry Herbert, but both RFC793 page 32 figure 9 and my Linux box disagree
> > with this statement. Look: at line 5, A rejects the SYN-ACK because the
> > ACK is wrong during the session setup.
> 
> Look at the first check inside th->ack in tcp_rcv_synsent_state_process.

Usually a continious flow of ACK+RST is used to prevent a connection
from being established, it's more reliable because even if you hit the
ISS+rcv_next window the connection attempt will still be reset.
