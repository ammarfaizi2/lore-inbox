Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262188AbTLNR0h (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Dec 2003 12:26:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262195AbTLNR0h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Dec 2003 12:26:37 -0500
Received: from mail.jlokier.co.uk ([81.29.64.88]:22916 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S262188AbTLNR0g
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Dec 2003 12:26:36 -0500
Date: Sun, 14 Dec 2003 17:26:27 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Ross Dickson <ross@datscreative.com.au>
Cc: forming@charter.net, Ian Kumlien <pomac@vapor.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Fixes for nforce2 hard lockup, apic, io-apic, udma133 covered
Message-ID: <20031214172627.GB28923@mail.shareable.org>
References: <200312140407.28580.ross@datscreative.com.au> <200312140949.52489.ross@datscreative.com.au> <20031214042714.GB21241@mail.shareable.org> <200312142124.45966.ross@datscreative.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200312142124.45966.ross@datscreative.com.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ross Dickson wrote:
> Hmmm It may well be the settling time of the cpu PLL (phase lock
> loop) changing from low power disconnect speed up to bus speed -
> higher speed bus on the same type of silicon may take longer? as
> also it may take more power to run faster so the internal bus bit
> drivers may also take more time to settle? These sorts of things are
> mentioned in earlier model athlon errata. Especially if there is perhaps
> a marginal northbridge timing in the area Ian has thought about?

If you're waiting for a PLL to settle, it could vary tremendously.

Is there some way to sense the disconnect state and put in a proper
delay e.g. 10 microseconds when it is sensed?  I'd guess the
disconnect state isn't encounted much under system load, which is the
only time you really care about fast timer interrupts.

> I am now going to try increasing the wait loop delay from 100ns to 400ns
> in case the apic does not like being hammered repetitively during the delay
> time. - It could be that the bus between the cpu core and the local apic is
> marginal on either timing (PLL) or current and if we hammer it we may
> be asking for incorrect reads?

It's possible that hammering it will consume more bus power and push
a stabilising PLL and/or power supply a bit far.

If it's purely marginal timing, then doing fewer reads just means
you'll hit the marginal state less often, not avoid it completely.

-- Jamie
