Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752115AbWFLQL0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752115AbWFLQL0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 12:11:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752116AbWFLQL0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 12:11:26 -0400
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:56200
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S1752115AbWFLQL0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 12:11:26 -0400
Message-ID: <448D922F.80801@microgate.com>
Date: Mon, 12 Jun 2006 11:11:27 -0500
From: Paul Fulghum <paulkf@microgate.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Chuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.16.18 kernel freezes while pppd is exiting
References: <200606081909_MC3-1-C1F0-8B6B@compuserve.com>	 <1150124830.3703.6.camel@amdx2.microgate.com> <1150127588.25462.7.camel@localhost.localdomain>
In-Reply-To: <1150127588.25462.7.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
>> 	spin_unlock_irqrestore(&tty->buf.lock, flags);
>>+	clear_bit(TTY_FLUSHING, &tty->flags);
> 
> 
> Shouldn't those two be reversed if you want to go with this path.

I don't see that is necessary.

 > How is this occuring anyway the flush_to_ldisc path should never re-enter.

If a driver has low_latency set, flush_to_ldisc
can be called from both scheduled work (due to
hitting TTY_DONT_FLIP) and directly from an ISR.
On an SMP system, they can run in parallel.

I don't know for sure that is the path being hit,
it could be some other odd combination.
But there is no inherent serialization
of flush_to_ldisc.

-- 
Paul Fulghum
Microgate Systems, Ltd.
