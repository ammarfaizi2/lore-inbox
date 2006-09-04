Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751192AbWIDIqG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751192AbWIDIqG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 04:46:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751190AbWIDIqG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 04:46:06 -0400
Received: from minus.inr.ac.ru ([194.67.69.97]:20964 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id S1751179AbWIDIqD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 04:46:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=ms2.inr.ac.ru;
  b=HLVYzaV+NbMMgWuC32xgTpn18pCy2Ahj5E+CirbVIkmSLv0Eg4bqUx1li2sK5jJrQOfK68QaSiV350EAuJN4Z2RiZ4MbDYgxRxSv3K2ql0LTXQrTe+6MDs/ABg3yJFyVjbMHbgVs2cUSHTTmcAnXBHUQdrABjZE0ALmVtPRrpSo=;
Date: Mon, 4 Sep 2006 12:44:14 +0400
From: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>, Krzysztof Halasa <khc@pm.waw.pl>,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: 2.6.18-rc5 with GRE, iptables and Speedtouch ADSL, PPP over ATM
Message-ID: <20060904084414.GA19793@ms2.inr.ac.ru>
References: <m3odty57gf.fsf@defiant.localdomain> <20060903111507.GA12580@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060903111507.GA12580@gondor.apana.org.au>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> This path obviously breaks assumption 1) and therefore can lead to ABBA
> dead-locks.

Yes...


> I've looked at the history and there seems to be no reason for the lock
> to be held at all in dev_watchdog_up.  The lock appeared in day one and
> even there it was unnecessary.

Seems, it serializes mod_timer and timer handler to keep timer
in predictable state. Maybe, this is not necessary. A priori, it is required.

Note that in dev_watchdog_down() queue_lock is released before
taking xmit_lock. Probably, this is the thing which was supposed
to be done in dev_watchdog_up() too.

Alexey

-- 
VGER BF report: U 0.46385
