Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265745AbTL3LNH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 06:13:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265747AbTL3LNH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 06:13:07 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:41365 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S265745AbTL3LNE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 06:13:04 -0500
Message-ID: <3FF15DAB.8080203@colorfullife.com>
Date: Tue, 30 Dec 2003 12:12:43 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031030
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeremy Fitzhardinge <jeremy@goop.org>
CC: Linus Torvalds <torvalds@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] optimize ia32 memmove
References: <200312300713.hBU7DGC4024213@hera.kernel.org>	 <3FF129F9.7080703@pobox.com> <20031229235158.755e026c.akpm@osdl.org>	 <3FF12FC7.5030202@pobox.com>	 <Pine.LNX.4.58.0312300152250.2065@home.osdl.org> <1072779479.16344.95.camel@ixodes.goop.org>
In-Reply-To: <1072779479.16344.95.camel@ixodes.goop.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeremy Fitzhardinge wrote:

 >On Tue, 2003-12-30 at 01:58, Linus Torvalds wrote:
 >
 >>But then anything that does the loads in ascending order is still ok, so
 >>it shouldn't matter - by the time "dest" has been overwritten, the source
 >>data has already been read. And all the "memcpy()"  implementations had
 >>better do that anyway, in order to get nice memory access patterns. "rep
 >>movsl" certainly does.

AMD recommends to perform bulk copies backwards: That defeats the hw 
prefecher, and results in even better access patterns. Doesn't matter in 
this case, memmove is never used for bulk copies.

 >A PPC memcpy may end up clearing the destination before reading the
 >source (using the cache-line zeroing instruction, to prevent the
 >destination from being spuriously read to populate the cache line).
 >
The change is i386 only, no effect on other archs.
I found the unoptimized memmove in oprofiles of dbt2 testruns: slab 
contains a few memmoves to keep it's recently used arrays in strict LIFO 
order. Typically perhaps 100 bytes.

--
    Manfred


