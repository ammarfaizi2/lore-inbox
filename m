Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751216AbWIDIsi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751216AbWIDIsi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 04:48:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751211AbWIDIsh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 04:48:37 -0400
Received: from rhun.apana.org.au ([64.62.148.172]:58375 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S1751200AbWIDIsg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 04:48:36 -0400
Date: Mon, 4 Sep 2006 18:48:19 +1000
To: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
Cc: "David S. Miller" <davem@davemloft.net>, Krzysztof Halasa <khc@pm.waw.pl>,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: 2.6.18-rc5 with GRE, iptables and Speedtouch ADSL, PPP over ATM
Message-ID: <20060904084819.GA27121@gondor.apana.org.au>
References: <m3odty57gf.fsf@defiant.localdomain> <20060903111507.GA12580@gondor.apana.org.au> <20060904084414.GA19793@ms2.inr.ac.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060904084414.GA19793@ms2.inr.ac.ru>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 04, 2006 at 12:44:14PM +0400, Alexey Kuznetsov wrote:
> 
> Seems, it serializes mod_timer and timer handler to keep timer
> in predictable state. Maybe, this is not necessary. A priori, it is required.
> 
> Note that in dev_watchdog_down() queue_lock is released before
> taking xmit_lock. Probably, this is the thing which was supposed
> to be done in dev_watchdog_up() too.

Right, in that case this should definitely be unncessary because both
dev_watchdog_up and dev_watchdog_up are called under RTNL.

The function __dev_watchdog_up could possibly be dodgy though but that's
a different story.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

-- 
VGER BF report: H 3.52484e-12
