Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261406AbVGCMx3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261406AbVGCMx3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Jul 2005 08:53:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261407AbVGCMx3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Jul 2005 08:53:29 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:51404 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261406AbVGCMtD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Jul 2005 08:49:03 -0400
Subject: Re: function ordering (was: Re: [RFC] exit_thread() speedups in
	x86 process.c)
From: Arjan van de Ven <arjan@infradead.org>
To: Hugh Dickins <hugh@veritas.com>
Cc: Denis Vlasenko <vda@ilport.com.ua>,
       Chuck Ebbert <76306.1226@compuserve.com>,
       "cutaway@bellsouth.net" <cutaway@bellsouth.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Coywolf Qi Hunt <coywolf@gmail.com>
In-Reply-To: <Pine.LNX.4.61.0507031323280.6427@goblin.wat.veritas.com>
References: <200507012258_MC3-1-A340-3A81@compuserve.com>
	 <200507021456.40667.vda@ilport.com.ua>
	 <1120391140.3164.39.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.61.0507031323280.6427@goblin.wat.veritas.com>
Content-Type: text/plain
Date: Sun, 03 Jul 2005 14:48:42 +0200
Message-Id: <1120394922.3164.41.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 3.7 (+++)
X-Spam-Report: SpamAssassin version 2.63 on pentafluge.infradead.org summary:
	Content analysis details:   (3.7 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-07-03 at 13:30 +0100, Hugh Dickins wrote:
> On Sun, 3 Jul 2005, Arjan van de Ven wrote:
> > 
> > hmm. I wonder if a slightly different approach (based on the __slow)
> > idea would make sense
> > 1) Use -ffunction-sections option from gcc to put each function in it's
> > own section
> > 2) Use readprofile/oprofile data to collect an (external to the code)
> > list of hot/cold functions (we can put a default list in the kernel
> > source somewhere and allow people to measure their own if they want)
> > 3) Use this list to make a linker script to order the functions
> > 
> > this way we don't need to put a lot of __slow's in the code *and* it's
> > based on measurements not assumptions, and can be tuned for a specific
> > situation in addition.
> 
> This is reminiscent of "fur", whose source Old SCO opened.
> Google for SCO fur: amidst all the hits about "fur flying"
> you might find something useful!

it's also similar to the idea to Nat's grope ;)
it's just a lot easier for the kernel than for the average userspace
since we already have linker scripts

