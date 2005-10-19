Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932427AbVJSBW4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932427AbVJSBW4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 21:22:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932428AbVJSBW4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 21:22:56 -0400
Received: from atlrel8.hp.com ([156.153.255.206]:17821 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S932427AbVJSBWz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 21:22:55 -0400
Subject: Re: [discuss] Re: x86_64: 2.6.14-rc4 swiotlb broken
From: Alex Williamson <alex.williamson@hp.com>
To: Ravikiran G Thirumalai <kiran@scalex86.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
       discuss@x86-64.org, tglx@linutronix.de, shai@scalex86.org,
       y-goto@jp.fujitsu.com
In-Reply-To: <20051018232203.GB4535@localhost.localdomain>
References: <20051017134401.3b0d861d.akpm@osdl.org>
	 <Pine.LNX.4.64.0510171405510.3369@g5.osdl.org>
	 <20051018001620.GD8932@localhost.localdomain>
	 <Pine.LNX.4.64.0510180845470.3369@g5.osdl.org>
	 <Pine.LNX.4.64.0510180848540.3369@g5.osdl.org>
	 <20051018195423.GA6351@localhost.localdomain>
	 <1129670907.17545.20.camel@lts1.fc.hp.com>
	 <20051018215351.GA3982@localhost.localdomain>
	 <1129673040.17545.32.camel@lts1.fc.hp.com>
	 <1129675023.17545.41.camel@lts1.fc.hp.com>
	 <20051018232203.GB4535@localhost.localdomain>
Content-Type: text/plain
Organization: LOSL
Date: Tue, 18 Oct 2005 19:22:46 -0600
Message-Id: <1129684966.17545.50.camel@lts1.fc.hp.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-10-18 at 16:22 -0700, Ravikiran G Thirumalai wrote:

> Hope the following works.   Using __alloc_bootmem_node now with a hard coded
> goal to avoid 16MB DMA zone.  It is ugly :( and hope it works this time
> <fingers crossed>. 

   Nope, it still gives me memory above 4GB.  If I change goal to 0x0 it
works.  One nit, shouldn't IS_LOW_AGES() be more like this:

#define IS_LOWPAGES(paddr, size) ((paddr+size-1) < 0x100000000UL)

Minor optimization not checking the start, but a 64MB swiotlb starting
at 4GB-64MB should be found as ok.  Thanks,

	Alex


