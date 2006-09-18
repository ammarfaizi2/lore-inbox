Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965283AbWIRPTl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965283AbWIRPTl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 11:19:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965282AbWIRPTl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 11:19:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:47779 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751768AbWIRPTk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 11:19:40 -0400
From: Andi Kleen <ak@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Network performance degradation from 2.6.11.12 to 2.6.16.20
Date: Mon, 18 Sep 2006 17:19:34 +0200
User-Agent: KMail/1.9.3
Cc: David Miller <davem@davemloft.net>, master@sectorb.msk.ru, hawk@diku.dk,
       harry@atmos.washington.edu, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
References: <p73k6414lnp.fsf@verdi.suse.de> <200609181629.53949.ak@suse.de> <1158592789.6069.115.camel@localhost.localdomain>
In-Reply-To: <1158592789.6069.115.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609181719.34160.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 18 September 2006 17:19, Alan Cox wrote:
> Ar Llu, 2006-09-18 am 16:29 +0200, ysgrifennodd Andi Kleen:
> > The only delay this would add would be the queueing time from the NIC
> > to the softirq. Do you really think that is that bad?
> 
> If you are trying to do things like network record/playback then you
> want the minimal delay. 

But it's not minimal. Maybe it was long ago when the code was designed
on a 3c509 but not with modern hardware: Think interrupt mitigation and NAPI. 

And with NAPI we tend to process the packets directly after they
are fetched out of the RX queue, so there is practically no delay
between driver seeing the packet and softirq seeing it.  All the queuing
is done either at hardware level or later at socket level.

> There's a reason the original timestamp code 
> supported the hardware setting the timestamp itself - we actually had a
> separare set of logic on a board that was doing the timestamping by
> watching the IRQ line of the NIC chip.

That would be fine too (because it will be likely fast), but unfortunately
I don't know of any driver that does that.

-Andi
