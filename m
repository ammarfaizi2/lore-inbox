Return-Path: <linux-kernel-owner+w=401wt.eu-S1030369AbWLTXNN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030369AbWLTXNN (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 18:13:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030375AbWLTXNN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 18:13:13 -0500
Received: from smtp112.sbc.mail.mud.yahoo.com ([68.142.198.211]:34875 "HELO
	smtp112.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1030416AbWLTXNM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 18:13:12 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=Z+9s2xL2JBKSqyDx7X6FVGYIizQ4dzbfR4As3a+SwjrHeUyAIiSJyBuo1cX8xGwuiJv3UIzKsQxwZLFWPc41Z96zaoUw5CsyetENDYeQ5wLKykB9b+IBYvl5/PINoSGjR7UAlr62cAqmjI+as5bcTNoWsv8L1wqnvuKJW7KEszc=  ;
X-YMail-OSG: 2Kp3pccVM1mmGADAgsVFxDQj6HMaa3WugILIb2n3CjitZTs08Yi0vm.8j0RUbX53_7BaByojKeDwin3Qaozp1Po076W8Vn9XBuMEak8tJ4nMLsQVacvoGHnBzCk1bebBvgP3ckCx2VbpYN0-
From: David Brownell <david-b@pacbell.net>
To: Nicolas FERRE <nicolas.ferre@rfo.atmel.com>
Subject: Re: [PATCH] input/spi: add ads7843 support to ads7846 touchscreen driver
Date: Wed, 20 Dec 2006 15:13:09 -0800
User-Agent: KMail/1.7.1
Cc: Patrice Vilchez <patrice.vilchez@rfo.atmel.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
References: <4582BD29.4020203@rfo.atmel.com>
In-Reply-To: <4582BD29.4020203@rfo.atmel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612201513.09705.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 15 December 2006 7:20 am, Nicolas FERRE wrote:
> Add support for the ads7843 touchscreen controller to the ads7846 driver code.

Glad to see this!  Is this for AT91sam9261-EK board support, maybe?


> The "pen down" information is managed quite differently as we do not have a
> touch-presure mesurement on the ads7843.
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@rfo.atmel.com>
> ---
> 
> I add a ads7843_rx function to manage the end of a measurement cycle. As for
> ads7846_rx, it does the real work and comnunicates with the input subsystem.
> The timer function is responsible of taking the pen up/pen down state through
> the board specific get_pendown_state() callback.

Hmm, unfortunately there are a lot of updates to this driver sitting in
the linux-omap tree ... the N770 guys really put a lot of solid work into
it (ISTR seeing a statistical plot showing how touchscreen debounce helps
get stable readings!), but those patches didn't get upstream yet.

One of the more critical of those patches addressed much the same pendown
state issue; it turns out that measuring pressure (after the pendown irq)
isn't the best way to notice when pen status becomes "up".

Let me try to sort out the mess with those updates, and ask you to refresh
this ads7843 support against that more-current ads7846 code.  (Or if you
want a preview, have a look at the linux-omap tree.  There's a clone of
that in the GIT area on kernel.org if you want.)


> As the SPI underlying code behaves quite differently from a controller driver
> to another whan not having a tx_buf filled, I have add a zerroed buffer to give
> to the spi layer while receiving data.

You must be working with a buggy controller driver then.  That part of
this patch should never be needed.  It's expected that rx-only transfers
will omit a tx buf; all controller drivers must handle that case.

- Dave


> Already posted to lkml :
> http://lkml.org/lkml/2006/12/15/71
> 
