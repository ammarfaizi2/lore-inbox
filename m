Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261362AbUKCDER@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261362AbUKCDER (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 22:04:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261368AbUKCDEQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 22:04:16 -0500
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:53261 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S261362AbUKCDEK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 22:04:10 -0500
Date: Wed, 3 Nov 2004 03:04:06 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.9: Only handle system NMIs on the BSP
In-Reply-To: <20041103024944.GA8907@wotan.suse.de>
Message-ID: <Pine.LNX.4.58L.0411030255410.32079@blysk.ds.pg.gda.pl>
References: <Pine.LNX.4.58L.0411030125340.32079@blysk.ds.pg.gda.pl>
 <20041103024944.GA8907@wotan.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Nov 2004, Andi Kleen wrote:

> >  While discussing races in the NMI handler's trailer fiddling with RTC
> > registers, I've discovered we incorrectly attempt to handle NMIs coming
> > from the system (memory errors, IOCHK# assertions, etc.) with all
> > processors even though the interrupts are only routed to the bootstrap
> > processor.  If one of these events coincides with a NMI watchdog tick it
> 
> Where is this documented/guaranteed that only APs get such NMIs? 

 Only the BSP gets them (not APs) and it's we who arrange for that. ;-)  
We only enable LVT1 on the BSP -- APs have this input masked.  See 
setup_local_APIC().

> I don't see such a guarantee in the AMD documentation for example ... 

 It's specific to system software run.  You'd have to have a look at some
Linux documentation covering the area -- your best bet is the code itself.

  Maciej
