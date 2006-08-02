Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751333AbWHBUra@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751333AbWHBUra (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 16:47:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751353AbWHBUra
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 16:47:30 -0400
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:32784 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751333AbWHBUr3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 16:47:29 -0400
Date: Wed, 2 Aug 2006 21:47:23 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Dave Jones <davej@redhat.com>, Linux Kernel <linux-kernel@vger.kernel.org>,
       Mathias Adam <a2@adamis.de>
Subject: Re: make 16C950 UARTs work
Message-ID: <20060802204723.GE7173@flint.arm.linux.org.uk>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Mathias Adam <a2@adamis.de>
References: <20060802194938.GL5972@redhat.com> <20060802201723.GC7173@flint.arm.linux.org.uk> <20060802203146.GB23389@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060802203146.GB23389@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 02, 2006 at 04:31:46PM -0400, Dave Jones wrote:
> Still, leaving a patch out in the cold for 11 months, when we know it
> at least makes things work for some users strikes me as wrong.
> If we took this approach with every driver, we'd end up not supporting
> the majority of things we support today.

Define "majority".  How do we know whether what's merged works for
the majority, and this fix breaks it for one type of card.

Eg, there's another 950 setup which I received a report back in May
which had a 16MHz crystal, and the _only_ way to get that to work
reliably was to use setserial with spd_cust to specify 104 for 9600
baud, etc.  We never got to work out exactly what was going on.

However, based on my experience with dwmw2's card, registers such as
the TCR are programmed on card powerup to have some non-default state
depending on the manufacturers knowledge of the card.  This means if
we start fscking around with them in order to support these "wizzy
new features" other normal things will break.

Let me repeat what I want - I want some way that any changes which are
proposed in this area get tested against some 950-based implementation
which we call "the control implementation".  That way we get to know if
we're going forwards, backwards or sideways.

Blindly applying patches which mess around with 950 clocking registers
based upon what one random card does just isn't acceptable.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
