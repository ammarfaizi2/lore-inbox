Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267409AbUHaIUs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267409AbUHaIUs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 04:20:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267431AbUHaIT6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 04:19:58 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:39183 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S267409AbUHaITd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 04:19:33 -0400
Date: Tue, 31 Aug 2004 09:19:29 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MMC updates
Message-ID: <20040831091929.C4457@flint.arm.linux.org.uk>
Mail-Followup-To: Pierre Ossman <drzeus-list@drzeus.cx>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
References: <20040830232801.G22480@flint.arm.linux.org.uk> <41341A42.1070804@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <41341A42.1070804@drzeus.cx>; from drzeus-list@drzeus.cx on Tue, Aug 31, 2004 at 08:27:14AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 31, 2004 at 08:27:14AM +0200, Pierre Ossman wrote:
> Russell King wrote:
> >For anyone who's interested, here's an update to the MMC code Linus
> >recently merged.  Essentially, I've added SG support to the MMCI
> >primecell driver.
>
> Just to make sure I've understood this correctly. SGIO takes a number of 
> memory locations and fills these with data from a continous stream of 
> data from the card? I.e. only the local memory locations need special 
> handling. No seeking on the card? And any "gaps" where data is not 
> wanted is handled by upper layers?

Correct.  One "request" is for a set of sectors from N to N+L, where
data is read/written to a set of possibly non-contiguous pages.

You don't have to support it - there are defaults chosen by the code
to ensure that we won't see these "SG" requests unless the driver can
handle them.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
