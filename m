Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266536AbUG0SX2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266536AbUG0SX2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 14:23:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266545AbUG0SW3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 14:22:29 -0400
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:13066 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S266543AbUG0SVg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 14:21:36 -0400
Date: Tue, 27 Jul 2004 20:21:34 +0200 (CEST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.6.8-rc1-mm1] decode local APIC errors
In-Reply-To: <200407271753.i6RHr13I013000@harpo.it.uu.se>
Message-ID: <Pine.LNX.4.58L.0407272004460.32433@blysk.ds.pg.gda.pl>
References: <200407271753.i6RHr13I013000@harpo.it.uu.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Jul 2004, Mikael Pettersson wrote:

> I got tired of having to manually decode local APIC
> error codes in problem reports sent to LKML, so I
> rewrote arch/i386/kernel/apic:smp_error_interrupt()
> to do the decoding for us. Instead of:
> 
> APIC error on CPU0: 04(00)
> 
> this patch makes the kernel print:
> 
> APIC error on CPU0: Send Accept Error (0x00)
> 
> The code handles multiple set error flags, and will
> also report if any unknown or reserved bits are set.

 Hmm, no objection in principle, but calling printk() for a string that
does not end with a trailing '\n' leads to log being messed up if another
message is placed from elsewhere inbetween.  Using sprintf() to construct
the message may be an unnecessary complication, though.  Perhaps it would
be reasonable to report a single bit per line.  What do you think?

 Anyway, please note that such decoding used to be there, but it was
removed in 2.4.0-test7 for being too verbose, IIRC. ;-)  For me either way
is alike, though.

  Maciej
