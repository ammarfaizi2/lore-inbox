Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261467AbUK2SRn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261467AbUK2SRn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 13:17:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261469AbUK2SRm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 13:17:42 -0500
Received: from mx1.redhat.com ([66.187.233.31]:63389 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261467AbUK2SRk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 13:17:40 -0500
Date: Mon, 29 Nov 2004 13:17:19 -0500
From: Dave Jones <davej@redhat.com>
To: Gerd Knorr <kraxel@bytesex.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: MTRR vesafb and wrong X performance
Message-ID: <20041129181718.GA16782@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Gerd Knorr <kraxel@bytesex.org>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <1101338139.1780.9.camel@PC3.dom.pl> <20041124171805.0586a5a1.akpm@osdl.org> <1101419803.1764.23.camel@PC3.dom.pl> <87is7ogb93.fsf@bytesex.org> <20041129154006.GB3898@redhat.com> <20041129162242.GA25668@bytesex> <20041129165701.GA903@redhat.com> <20041129173419.GC26190@bytesex>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041129173419.GC26190@bytesex>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 29, 2004 at 06:34:19PM +0100, Gerd Knorr wrote:
 > > size_total is calculated thus:
 > > 
 > >     size_total = screen_info.lfb_size * 65536;
 > 
 > That comes almost directly from the BIOS, the screen_info struct is
 > filled by the real mode boot code (vga.S IIRC).

ah yes, video.S, (sets PARAM_LFB_SIZE), which is why my grep failed.

 > > or blacklist if there aren't too many perhaps?
 > 
 > Hmm, how identify them?  Map the BIOS and poke around there?
 > screen_info gives next to no info here.
 > 
 > Maybe it works better to walk the PCI device list, find the correct
 > gfx card using the framebuffer start address, then double-check the
 > size by looking at the PCI ressources?

Maybe.

Something I toyed with at one point, which only works for AGP cards is..
search the pci config space for an agp header, and then check the amount
of prefetchable memory range behind the bridge.
Even that wasn't foolproof however, and there were a few quirks
to work around still.  You see all sorts of strange things there,
like onboard gfx with 16MB advertising 64MB prefetchable ranges.

		Dave

