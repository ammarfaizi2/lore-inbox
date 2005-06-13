Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261352AbVFMEsr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261352AbVFMEsr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 00:48:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261355AbVFMEsq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 00:48:46 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:14602 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S261352AbVFMEsp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 00:48:45 -0400
Date: Mon, 13 Jun 2005 14:48:10 +1000
To: Willy Tarreau <willy@w.ods.org>
Cc: davem@davemloft.net, xschmi00@stud.feec.vutbr.cz, alastair@unixtrix.com,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [PATCH] fix small DoS on connect() (was Re: BUG: Unusual TCP Connect() results.)
Message-ID: <20050613044810.GA32103@gondor.apana.org.au>
References: <20050612083409.GA8220@alpha.home.local> <20050612103020.GA25111@gondor.apana.org.au> <20050612114039.GI28759@alpha.home.local> <20050612120627.GA5858@gondor.apana.org.au> <20050612123253.GK28759@alpha.home.local> <20050612131323.GA10188@gondor.apana.org.au> <20050612133349.GA6279@gondor.apana.org.au> <20050612134725.GB8951@alpha.home.local> <20050612135018.GA10910@gondor.apana.org.au> <20050612142401.GA10772@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050612142401.GA10772@alpha.home.local>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 12, 2005 at 04:24:01PM +0200, Willy Tarreau wrote:
>
> 1) no firewall in front of A
>   - C spoofs A and sends a fake SYN to B
>   - B responds to A with a SYN-ACK
>   - A sends an RST to B, which clears the session
>   - A wants to connect and sends its SYN to B which accepts it.

Well the attacker simply has to keep sending the same SYN packet
over and over again until A runs out of SYN retries.

What I really don't like about your patch is the fact that it is
trying to impose a policy decision (that of forbidding all
simultaneous connection initiations) inside the TCP stack.

A much better place to do that is netfilter.  If you do it there
then not only will your protect all Linux machines from this attack,
but you'll also protect all the other BSD-derived TCP stacks.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
