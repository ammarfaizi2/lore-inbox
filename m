Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261164AbVBWE6Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261164AbVBWE6Z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 23:58:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261189AbVBWE6Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 23:58:25 -0500
Received: from dsl027-180-174.sfo1.dsl.speakeasy.net ([216.27.180.174]:17117
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S261164AbVBWE6U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 23:58:20 -0500
Date: Tue, 22 Feb 2005 20:57:22 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: hugh@veritas.com, ak@suse.de, benh@kernel.crashing.org, torvalds@osdl.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] page table iterators
Message-Id: <20050222205722.4e228aba.davem@davemloft.net>
In-Reply-To: <1109134170.5177.9.camel@npiggin-nld.site>
References: <4214A1EC.4070102@yahoo.com.au>
	<4214A437.8050900@yahoo.com.au>
	<20050217194336.GA8314@wotan.suse.de>
	<1108680578.5665.14.camel@gaston>
	<20050217230342.GA3115@wotan.suse.de>
	<20050217153031.011f873f.davem@davemloft.net>
	<20050217235719.GB31591@wotan.suse.de>
	<4218840D.6030203@yahoo.com.au>
	<Pine.LNX.4.61.0502210619290.7925@goblin.wat.veritas.com>
	<421B0163.3050802@yahoo.com.au>
	<Pine.LNX.4.61.0502230136240.5772@goblin.wat.veritas.com>
	<20050222203115.49f79f42.davem@davemloft.net>
	<1109134170.5177.9.camel@npiggin-nld.site>
X-Mailer: Sylpheed version 1.0.1 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Feb 2005 15:49:30 +1100
Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> > It's easy to toy with the sparc64 optimization on other platforms,
> > just add the necessary hacks to pmd_set and pgd_set, allocation
> > of pmd and pgd tables
> 
> David: just an implementation detail that I had meant to bring
> up earlier - would it feel like less of a hack to put these in
> pmd_populate and pgd_populate?

Sure, no problem.  They get defined to pmd_set/pgd_set calls
anyways.  But wouldn't that miss pgd_clear() and pmd_clear()?
Someone may find it worthwhile to, on a *_clear(), to see if
a set bit can now be clear because all the neighboring entries
are empty as well.

That might have been the reason I put it there, but I may be
giving myself too much credit :-)
