Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264998AbUEYR06@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264998AbUEYR06 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 13:26:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264989AbUEYR05
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 13:26:57 -0400
Received: from mx1.redhat.com ([66.187.233.31]:17584 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264990AbUEYR0i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 13:26:38 -0400
Date: Tue, 25 May 2004 10:25:47 -0700
From: "David S. Miller" <davem@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: wesolows@foobazco.org, willy@debian.org, andrea@suse.de,
       benh@kernel.crashing.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       mingo@elte.hu, bcrl@kvack.org, linux-mm@kvack.org,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH] ppc64: Fix possible race with set_pte on a present PTE
Message-Id: <20040525102547.35207879.davem@redhat.com>
In-Reply-To: <Pine.LNX.4.58.0405250841280.9951@ppc970.osdl.org>
References: <1085369393.15315.28.camel@gaston>
	<Pine.LNX.4.58.0405232046210.25502@ppc970.osdl.org>
	<1085371988.15281.38.camel@gaston>
	<Pine.LNX.4.58.0405232134480.25502@ppc970.osdl.org>
	<1085373839.14969.42.camel@gaston>
	<Pine.LNX.4.58.0405232149380.25502@ppc970.osdl.org>
	<20040525034326.GT29378@dualathlon.random>
	<Pine.LNX.4.58.0405242051460.32189@ppc970.osdl.org>
	<20040525114437.GC29154@parcelfarce.linux.theplanet.co.uk>
	<Pine.LNX.4.58.0405250726000.9951@ppc970.osdl.org>
	<20040525153501.GA19465@foobazco.org>
	<Pine.LNX.4.58.0405250841280.9951@ppc970.osdl.org>
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 May 2004 09:19:52 -0700 (PDT)
Linus Torvalds <torvalds@osdl.org> wrote:

> On Tue, 25 May 2004, Keith M Wesolowski wrote:
> > 
> > Some sparc32 CPUs are also vulnerable to this race; in fact the
> > supersparc manual describes it specifically and even outlines the
> > compare-exchange loop using our rotten swap instruction.  In our case,
> > the race is with a hardware walker.
> 
> Yes, but the sparc32 page tables are not the same as the linux kernel page 
> tables, so in your case it's a different path and a different page table. 
> Only the shared case really matters (ie things that do hw/microcode walk 
> of a page table _tree_ not a hash).

Not true on 32-bit Sparc sun4m systems, it's exactly like i386 except
the hardware is stupid and we only have an atomic swap instruction.
:-)
