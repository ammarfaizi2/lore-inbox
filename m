Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272368AbTHFJdo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 05:33:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272924AbTHFJdo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 05:33:44 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:60427 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S272368AbTHFJdX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 05:33:23 -0400
Date: Wed, 6 Aug 2003 10:33:20 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.5/2.6 PCMCIA Issues
Message-ID: <20030806103320.A2094@flint.arm.linux.org.uk>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20030804232204.GA21763@nasledov.com> <20030805144453.A8914@flint.arm.linux.org.uk> <20030806045627.GA1625@nasledov.com> <200308060559.h765xhI05860@mail.osdl.org> <20030805234212.081c0493.akpm@osdl.org> <200308060711.h767B0I19677@mail.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200308060711.h767B0I19677@mail.osdl.org>; from torvalds@osdl.org on Wed, Aug 06, 2003 at 12:11:00AM -0700
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 06, 2003 at 12:11:00AM -0700, Linus Torvalds wrote:
> Andrew Morton wrote:
> > Disabling i82635 in config fixes it up.
> 
> Ok. Misha confirmed that disabling 82365 works for him too.

Interesting.

> Something is broken in resource handling that the i82365 driver
> even tries to probe for the ports that are in use.

Not really - I suspect there's something else going on.

When yenta initialises, we claim the PCI resources for it, and disable
the legacy IO space by writing 0 to it (it reads back 1.)  This is the
same that we've always done.

I wonder if the PNP code is activating the legacy IO space, and thereby
screwing up the configuration which yenta has setup.

Could someone with both yenta and i82365 with PNP try running lspci -vv
after both have tried to initialise, and obviously before inserting a
card in a slot?  You should see:

        16-bit legacy interface ports at 0001

as the last line for each of the Cardbus bridge devices.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

