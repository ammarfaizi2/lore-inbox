Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932129AbVHRIX1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932129AbVHRIX1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 04:23:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932133AbVHRIX1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 04:23:27 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:40462 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932129AbVHRIX0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 04:23:26 -0400
Date: Thu, 18 Aug 2005 09:23:21 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mmc: Multi-sector writes
Message-ID: <20050818092321.B3966@flint.arm.linux.org.uk>
Mail-Followup-To: Pierre Ossman <drzeus-list@drzeus.cx>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <42FF3C05.70606@drzeus.cx> <20050817155641.12bb20fc.akpm@osdl.org> <43042114.7010503@drzeus.cx> <20050817224805.17f29cfb.akpm@osdl.org> <20050818073824.C2365@flint.arm.linux.org.uk> <4304380B.5070406@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <4304380B.5070406@drzeus.cx>; from drzeus-list@drzeus.cx on Thu, Aug 18, 2005 at 09:26:03AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 18, 2005 at 09:26:03AM +0200, Pierre Ossman wrote:
> We had this discussion on LKML and Alan Cox' comment on it was that a
> solution like this would be acceptable, where we try and shove
> everything out first and then fall back on sector-by-sector to determine
> where an error occurs. This will only break if the problematic sector
> keeps shifting around, but at that point the card is probably toast
> anyway (if the thing keeps moving how can you bad block it?).

There are two different kinds of error - the ones at the transport
level which we are able to force a result of "no sectors transferred"
for.  For all other errors and successful completions, the driver
reports "all sectors tranferred" since the driver level doesn't know
that an error occurred.

This causes us to tell the upper levels that we were successful,
even if we weren't.  Hence the problem.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
