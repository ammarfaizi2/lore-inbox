Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750821AbVL3Db2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750821AbVL3Db2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 22:31:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750838AbVL3Db2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 22:31:28 -0500
Received: from relais.videotron.ca ([24.201.245.36]:43597 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1750821AbVL3Db1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 22:31:27 -0500
Date: Thu, 29 Dec 2005 22:31:22 -0500 (EST)
From: Nicolas Pitre <nico@cam.org>
Subject: Re: [patch 00/2] improve .text size on gcc 4.0 and newer compilers
In-reply-to: <1135897092.2935.81.camel@laptopd505.fenrus.org>
X-X-Sender: nico@localhost.localdomain
To: Arjan van de Ven <arjan@infradead.org>
Cc: Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@osdl.org>,
       Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, mpm@selenic.com
Message-id: <Pine.LNX.4.64.0512292218580.3309@localhost.localdomain>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <1135798495.2935.29.camel@laptopd505.fenrus.org>
 <Pine.LNX.4.64.0512281300220.14098@g5.osdl.org>
 <20051228212313.GA4388@elte.hu> <20051228214845.GA7859@elte.hu>
 <20051228201150.b6cfca14.akpm@osdl.org> <20051229073259.GA20177@elte.hu>
 <Pine.LNX.4.64.0512290923420.14098@g5.osdl.org>
 <20051229202852.GE12056@redhat.com>
 <Pine.LNX.4.64.0512291240490.3298@g5.osdl.org>
 <Pine.LNX.4.64.0512291322560.3298@g5.osdl.org>
 <20051229224839.GA12247@elte.hu>
 <1135897092.2935.81.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Dec 2005, Arjan van de Ven wrote:

> Some data from an x86-64 allyesconfig build.
> 
> 25573            cfi_build_cmd                   [108]   <245>

Beware this one.  The CFI code is not realistically ever used with 
everything set to y in real life scenarios.  In fact, when only the 
needed buswidth and interleave option are selected then this particular 
inlined function gets reduced to a simple constant, such as 0x00700070 
for example.

However if gcc wasn't forced to always inline, then in the allyesconfig 
this function would benefit from being uninlined automatically.


Nicolas
