Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261331AbVBGVgw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261331AbVBGVgw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 16:36:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261333AbVBGVgw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 16:36:52 -0500
Received: from gate.crashing.org ([63.228.1.57]:47511 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261331AbVBGVgt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 16:36:49 -0500
Subject: Re: question on symbol exports
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Chris Friesen <cfriesen@nortel.com>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
       linuxppc-dev list <linuxppc-dev@ozlabs.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Arjan van de Ven <arjan@infradead.org>
In-Reply-To: <42077EE0.2060505@nortel.com>
References: <41FECA18.50609@nortelnetworks.com>
	 <1107243398.4208.47.camel@laptopd505.fenrus.org>
	 <41FFA21C.8060203@nortelnetworks.com>
	 <1107273017.4208.132.camel@laptopd505.fenrus.org>
	 <20050204203050.GA5889@dmt.cnet>  <4203D793.1040604@nortel.com>
	 <1107595148.30302.5.camel@gaston>  <42077EE0.2060505@nortel.com>
Content-Type: text/plain
Date: Tue, 08 Feb 2005 08:35:01 +1100
Message-Id: <1107812101.7734.42.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-02-07 at 08:44 -0600, Chris Friesen wrote:
> Benjamin Herrenschmidt wrote:
> >>It turns out that to call ptep_clear_flush_dirty() on ppc64 from a 
> >>module I needed to export the following symbols:
> >>
> >>__flush_tlb_pending
> >>ppc64_tlb_batch
> >>hpte_update
> > 
> > 
> > Any reason why you need to call that from a module ? Is the module
> > GPL'd ?
> 
> I explained this at the beginning of the thread, but I'll do so again. 
> The module will be released under the GPL.
> 
> The basic idea is that we want to be able to track pages dirtied by a 
> userspace process.  The system has no swap, so we use the dirty bit for 
> this.  On demand we look up the page tables for an address range 
> specified by the caller, store the addresses of any dirty pages, then 
> mark them clean so that the next write causes them to get marked dirty 
> again.  It is this act of marking them clean that requires the 
> additional exports.
> 
> I've included the current code below.  If there is any way to accomplish 
> this without the additional exports, I'd love to hear about it.

Interesting... more than no swap, you must also make sure you have no
r/w mmap'ed file (which are technically equivalent to swap).

I'm not too fan about exporting those symbols, but I'll talk to paulus,
it should be possible at least to EXPORT_SYMBOL_GPL them...

Ben.


