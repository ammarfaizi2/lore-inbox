Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751514AbWGaKvR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751514AbWGaKvR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 06:51:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751517AbWGaKvR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 06:51:17 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:7839 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1751514AbWGaKvQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 06:51:16 -0400
Date: Mon, 31 Jul 2006 14:50:37 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: drepper@redhat.com, zach.brown@oracle.com, davem@davemloft.net,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [RFC 1/4] kevent: core files.
Message-ID: <20060731105037.GA2073@2ka.mipt.ru>
References: <20060731103322.GA1898@2ka.mipt.ru> <E1G7V7r-0006jL-00@gondolin.me.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <E1G7V7r-0006jL-00@gondolin.me.apana.org.au>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Mon, 31 Jul 2006 14:50:38 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2006 at 08:35:55PM +1000, Herbert Xu (herbert@gondor.apana.org.au) wrote:
> Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
> >
> >> - if there is space, report it in the ring buffer.  Yes, the buffer
> >>   can be optional, then all events are reported by the system call.
> > 
> > That requires a copy, which can neglect syscall overhead.
> > Do we really want it to be done?
> 
> Please note that we're talking about events here, not actual data.  So
> only the event is being copied, which is presumably rather small compared
> to the data.

In syscall time kevents copy 40bytes for each event + 12 bytes of header 
(number of events, timeout and command number). That's likely two cache
lines if only one event is reported.

-- 
	Evgeniy Polyakov
