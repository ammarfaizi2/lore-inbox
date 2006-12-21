Return-Path: <linux-kernel-owner+w=401wt.eu-S1422977AbWLUQ7I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422977AbWLUQ7I (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 11:59:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422969AbWLUQ7I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 11:59:08 -0500
Received: from smtp.osdl.org ([65.172.181.25]:51122 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422977AbWLUQ7H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 11:59:07 -0500
Date: Thu, 21 Dec 2006 08:58:09 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrei Popa <andrei.popa@i-neo.ro>
cc: Andrew Morton <akpm@osdl.org>, Martin Michlmayr <tbm@cyrius.com>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Hugh Dickins <hugh@veritas.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Arjan van de Ven <arjan@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Florian Weimer <fw@deneb.enyo.de>,
       Marc Haber <mh+linux-kernel@zugschlus.de>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Heiko Carstens <heiko.carstens@de.ibm.com>,
       Arnd Bergmann <arnd.bergmann@de.ibm.com>, gordonfarquharson@gmail.com,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Subject: Re: [PATCH] mm: fix page_mkclean_one (was: 2.6.19 file content
 corruption on ext3)
In-Reply-To: <1166716081.6901.1.camel@localhost>
Message-ID: <Pine.LNX.4.64.0612210853420.3394@woody.osdl.org>
References: <Pine.LNX.4.64.0612181151010.3479@woody.osdl.org> 
 <1166571749.10372.178.camel@twins>  <Pine.LNX.4.64.0612191609410.6766@woody.osdl.org>
  <1166605296.10372.191.camel@twins>  <1166607554.3365.1354.camel@laptopd505.fenrus.org>
  <1166614001.10372.205.camel@twins>  <Pine.LNX.4.64.0612201237280.28787@blonde.wat.veritas.com>
  <1166622979.10372.224.camel@twins>  <20061220170323.GA12989@deprecation.cyrius.com>
  <Pine.LNX.4.64.0612200928090.6766@woody.osdl.org> 
 <20061220175309.GT30106@deprecation.cyrius.com>  <Pine.LNX.4.64.0612201043170.6766@woody.osdl.org>
  <Pine.LNX.4.64.0612201139280.3576@woody.osdl.org>  <20061220153207.b2a0a27f.akpm@osdl.org>
  <Pine.LNX.4.64.0612201548410.3576@woody.osdl.org>  <20061220161158.acb77ce6.akpm@osdl.org>
  <Pine.LNX.4.64.0612201615590.3576@woody.osdl.org> 
 <Pine.LNX.4.64.0612201622480.3576@woody.osdl.org> <1166716081.6901.1.camel@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 21 Dec 2006, Andrei Popa wrote:

> On Wed, 2006-12-20 at 16:24 -0800, Linus Torvalds wrote:
> > 
> > Martin, Peter, Andrei, pls give it a try. (Martin and Andrei may be 
> > talking about different bugs, so _both_ of your experiences definitely 
> > matter here).
> 
> with http://lkml.org/lkml/diff/2006/12/20/204/1
> I have corruption: Hash check on download completion found bad chunks,
> consider using "safe_sync".

Gaah. Martin Michlmayr reported that it apparently fixes his ARM 
corruption.

Now, admittedly I already suspected the issues might be different (if only 
because of the UP vs SMP/PREEMPT case), but I really had my hopes up after 
Martin's report, because if anything, _his_ issue might have been a 
superset of your problem (while obviously any subtle SMP races you might 
be seeing are definitely not an issue in his case).

Oh well. I think the ARM case is enough of a reason to apply those patches 
(if it hadn't made any difference at all, I'd have waited until after 
2.6.20), and we'll just have to continue on the SMP PREEMPT angle.

			Linus
