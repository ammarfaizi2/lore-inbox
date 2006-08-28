Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751166AbWH1QLs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751166AbWH1QLs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 12:11:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751161AbWH1QLs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 12:11:48 -0400
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:51638 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S1751166AbWH1QLr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 12:11:47 -0400
Date: Mon, 28 Aug 2006 18:11:45 +0200
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, mingo@elte.hu,
       jesse.barnes@intel.com, dwalker@mvista.com
Subject: Re: [PATCH] maximum latency tracking infrastructure (version 3)
Message-ID: <20060828161145.GA25161@rhlx01.fht-esslingen.de>
References: <1156780080.3034.207.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1156780080.3034.207.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.2.1i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Aug 28, 2006 at 05:48:00PM +0200, Arjan van de Ven wrote:
> The proposed solution is to have an interface where drivers can
> * announce the maximum latency (in microseconds) that they can deal with
> * modify this latency
> * give up their constraint
> and a function where the code that decides on power saving strategy can query
> the current global desired maximum.

Nifty (aka "dumb") idea: would it make sense to enable drivers to register a
callback "we're going to go idle now" to e.g. let a driver refill or
service its hardware buffers the very moment before idling? That way
a driver could increase its announced latency requirements,
allowing longer idle sleeps until a hardware buffer overflows or whatever
(but in many cases a hardware service issue would be covered by an IRQ then).

However the time scales involved here (a couple of microseconds per sleep
or so versus a possibly comparably big amount of processing time per callback)
could render such a thing impractical, especially when multiple drivers
and thus multiple callbacks are involved (one might need to watch
total callback processing time then).

Andreas Mohr
