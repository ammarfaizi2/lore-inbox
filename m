Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030720AbWKUFfq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030720AbWKUFfq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 00:35:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030722AbWKUFfp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 00:35:45 -0500
Received: from smtp103.sbc.mail.mud.yahoo.com ([68.142.198.202]:58510 "HELO
	smtp103.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1030720AbWKUFfp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 00:35:45 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=IlEMoR4XMcoLVJGk1liQW1MqKS1OPIdrR35VW7dCJwqLoSFzEjqiTOzNnD2Jv840cWPR/wDYRVsZSE6/0FVKu4XYK9AwuJqDN8JPrxb5Jv6cWLVHEW6hkexeoEJL/0Ags4KPSZDr2lOlPkQVeA94IfYbPgF1lDdKDx1XlMaYjQs=  ;
X-YMail-OSG: ZlU6AxIVM1moafE.Oedo7MPgSJESBxZZhMy080WLryCE0Z.m1ISpS1Umxtzgs7_M5WRmJozfpTeqFHmHMavixACdyTiR5oHTq6RB.bOVQgC2hx6X.WH8vUj6J5rLsnMnoJ2wKT9IyJN9IGD9k14QK_fz.lawgSPzcvc-
From: David Brownell <david-b@pacbell.net>
To: Bill Gatliff <bgat@billgatliff.com>
Subject: Re: [patch/rfc 2.6.19-rc5] arch-neutral GPIO calls
Date: Mon, 20 Nov 2006 21:35:38 -0800
User-Agent: KMail/1.7.1
Cc: Paul Mundt <lethal@linux-sh.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Andrew Victor <andrew@sanpeople.com>,
       Haavard Skinnemoen <hskinnemoen@atmel.com>, jamey.hicks@hp.com,
       Kevin Hilman <khilman@mvista.com>, Nicolas Pitre <nico@cam.org>,
       Russell King <rmk@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>
References: <200611111541.34699.david-b@pacbell.net> <200611202045.09760.david-b@pacbell.net> <45628A1A.8060101@billgatliff.com>
In-Reply-To: <45628A1A.8060101@billgatliff.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611202135.39970.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 20 November 2006 9:09 pm, Bill Gatliff wrote:
> Why not have GPIO numbers refer to unique combinations of GPIO+pin? 

That sounds unduly complicated compared to just using the GPIO numbers
which are used throughout the hardware and software docs.  It'd also
be a big (and needless) disruption to code that's been working fine for
several years now ... and there'd need to be some scheme to recognize
that most GPIO numbers suddenly become invalid (since the space would
become large and sparsely populated, vs small and dense).

Maybe if it were being done over from scratch, that'd be workable.
But at this point I have a hard time seeing anyone want to change,
even if there were a better argument.


> If the GPIO line is tied to a piece of external hardware, that connection 
> is surely through a specific pin.  So it seems like you'd need GPIO+pin 
> every time there was an option.

Pin muxing is set up once, early, and from then on it suffices to use
the GPIO number.  The mux problems are orthogonal to GPIOs.


> 	It seems like the point 
> here is to help a driver find and assert their GPIO _pin_ so that the 
> driver can can talk to the attached external hardware.

Updating the GPIO controller is always (all architectures!) done in terms
of a number mapping to some controller and a bit number, not a pin.  The
drivers never care about pins.

The only thing that cares about pins is board setup code -- briefly.

- Dave
