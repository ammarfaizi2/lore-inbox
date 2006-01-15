Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751911AbWAOMNG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751911AbWAOMNG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 07:13:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751912AbWAOMNG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 07:13:06 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:51724 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1751911AbWAOMNF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 07:13:05 -0500
Date: Sun, 15 Jan 2006 13:12:42 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Chris Stromsoe <cbs@cts.ucla.edu>
Cc: Roberto Nibali <ratz@drugphish.ch>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org
Subject: Re: bad pmd filemap.c, oops; 2.4.30 and 2.4.32
Message-ID: <20060115121242.GA20277@w.ods.org>
References: <20060105054348.GA28125@w.ods.org> <Pine.LNX.4.64.0601061352510.24856@potato.cts.ucla.edu> <Pine.LNX.4.64.0601061411350.24856@potato.cts.ucla.edu> <43BF8785.2010703@drugphish.ch> <Pine.LNX.4.64.0601070246150.29898@potato.cts.ucla.edu> <43C2C482.6090904@drugphish.ch> <Pine.LNX.4.64.0601091221260.1900@potato.cts.ucla.edu> <43C2E243.5000904@drugphish.ch> <Pine.LNX.4.64.0601091654380.6479@potato.cts.ucla.edu> <Pine.LNX.4.64.0601150322020.5053@potato.cts.ucla.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0601150322020.5053@potato.cts.ucla.edu>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 15, 2006 at 03:29:15AM -0800, Chris Stromsoe wrote:
> On Mon, 9 Jan 2006, Chris Stromsoe wrote:
> >On Mon, 9 Jan 2006, Roberto Nibali wrote:
> >
> >>>That is the SCSI BIOS rev.  The machine is a Dell PowerEdge 2650 and 
> >>>that's the onboard AIC 7899.  It comes up as "BIOS Build 25309".
> >>
> >>Brain is engaged now, thanks ;). If you find time, could you maybe 
> >>compile a 2.4.32 kernel using following config (slightly changed from 
> >>yours):
> >>
> >>http://www.drugphish.ch/patches/ratz/kernel/configs/config-2.4.32-chris_s
> >
> >If/when the current run with DEBUG_SLAB oopses, I'll reboot with the 
> >config modifications.
> 
> I've been running stable with the propsed changes since the 10th.  The 
> original config and the currently running config are both at 
> <http://hashbrown.cts.ucla.edu/pub/oops-200512/>.  This is the diff:
> 
> cbs@hashbrown:~ > diff config-2.4.32 config-2.4.32-20060115
> 
> 65c65
> < CONFIG_HIGHIO=y
> ---
> ># CONFIG_HIGHIO is not set

I wonder if this change could be suspected of affecting stability. With
this unset, data will be sent from the card to low memory, then bounced
to high mem when needed. Maybe the card, northbridge or anything else
sometimes corrupts memory during direct highmem I/O from PCI ? :-/

Or perhaps it's simply too early to conclude anything.

Thanks for your report anyway.

Regards,
Willy

