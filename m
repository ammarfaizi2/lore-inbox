Return-Path: <linux-kernel-owner+w=401wt.eu-S965171AbWLUJ0d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965171AbWLUJ0d (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 04:26:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965172AbWLUJ0d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 04:26:33 -0500
Received: from mtagate5.uk.ibm.com ([195.212.29.138]:11209 "EHLO
	mtagate5.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965171AbWLUJ0c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 04:26:32 -0500
Subject: Re: [PATCH] mm: fix page_mkclean_one (was: 2.6.19 file content
	corruption on ext3)
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Linus Torvalds <torvalds@osdl.org>, Martin Michlmayr <tbm@cyrius.com>,
       Hugh Dickins <hugh@veritas.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Arjan van de Ven <arjan@infradead.org>,
       Andrei Popa <andrei.popa@i-neo.ro>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Florian Weimer <fw@deneb.enyo.de>,
       Marc Haber <mh+linux-kernel@zugschlus.de>,
       Heiko Carstens <heiko.carstens@de.ibm.com>,
       Arnd Bergmann <arnd.bergmann@de.ibm.com>, gordonfarquharson@gmail.com
In-Reply-To: <1166692812.32117.2.camel@twins>
References: <Pine.LNX.4.64.0612181151010.3479@woody.osdl.org>
	 <1166571749.10372.178.camel@twins>
	 <Pine.LNX.4.64.0612191609410.6766@woody.osdl.org>
	 <1166605296.10372.191.camel@twins>
	 <1166607554.3365.1354.camel@laptopd505.fenrus.org>
	 <1166614001.10372.205.camel@twins>
	 <Pine.LNX.4.64.0612201237280.28787@blonde.wat.veritas.com>
	 <1166622979.10372.224.camel@twins>
	 <20061220170323.GA12989@deprecation.cyrius.com>
	 <Pine.LNX.4.64.0612200928090.6766@woody.osdl.org>
	 <20061220175309.GT30106@deprecation.cyrius.com>
	 <Pine.LNX.4.64.0612201043170.6766@woody.osdl.org>
	 <Pine.LNX.4.64.0612201139280.3576@woody.osdl.org>
	 <1166652901.30008.1.camel@twins>
	 <Pine.LNX.4.64.0612201441030.3576@woody.osdl.org>
	 <1166655805.30008.18.camel@twins>  <1166692586.27750.4.camel@localhost>
	 <1166692812.32117.2.camel@twins>
Content-Type: text/plain
Organization: IBM Corporation
Date: Thu, 21 Dec 2006 10:26:15 +0100
Message-Id: <1166693175.27750.7.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-12-21 at 10:20 +0100, Peter Zijlstra wrote:
> > Now you are flushing the tlb twice. ptep_clear_flush clears the pte and
> > flushes the tlb, ptep_establish sets the new pte and flushes the tlb.
> > Not good. Use set_pte_at instead of the ptep_establish.
> 
> Yeah, sorry, I already noticed and corrected that :-|
> 
> Also, I'm dubious about the while thing and stuck a WARN_ON(ret) thing
> at the beginning of the loop. flush_tlb_page() does IPI the other cpus
> to flush their tlb too, so there should not be a SMP race, Arjan?

The while loop is protected by the pte lock and flush_tlb_page has to
remove the tlbs on all cpus. So yes, I think the while loop is not
necessary.

-- 
blue skies,
  Martin.

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

"Reality continues to ruin my life." - Calvin.


