Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262985AbTEVSQo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 14:16:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263011AbTEVSQn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 14:16:43 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:10226 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S262985AbTEVSQm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 14:16:42 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16077.5909.155004.502440@gargle.gargle.HOWL>
Date: Thu, 22 May 2003 20:29:41 +0200
From: mikpe@csd.uu.se
To: William Lee Irwin III <wli@holomorphy.com>
Cc: akpm@digeo.com, linux-kernel@vger.kernel.org
Subject: Re: arch/i386/kernel/mpparse.c warning fixes
In-Reply-To: <20030522162305.GT8978@holomorphy.com>
References: <20030522155320.GP29926@holomorphy.com>
	<16076.62927.525714.113342@gargle.gargle.HOWL>
	<20030522162305.GT8978@holomorphy.com>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III writes:
 > William Lee Irwin III writes:
 > >> -	if (m->mpc_apicid > MAX_APICS) {
 > >> +	if (MAX_APICS - m->mpc_apicid <= 0) {
 > >>  		printk(KERN_WARNING "Processor #%d INVALID. (Max ID: %d).\n",
 > >>  			m->mpc_apicid, MAX_APICS);
 > >>  		--num_processors;
 > 
 > On Thu, May 22, 2003 at 06:07:43PM +0200, mikpe@csd.uu.se wrote:
 > > Eeew. Whatever the original problem is, this "fix" is just too
 > > obscure and ugly.
 > 
 > m->mpc_apicid is an 8-bit type; MAX_APICS can be 256. The above fix
 > properly compares two integral expressions of equal width.

In the original "_>_", the 8-bit mpc_apicid is implicitly converted to int
before the comparison, as part of the "integer promotions" in the "usual
arithmetic conversions" (C standard lingo). The same happens in your "_-_<=0".
So what's the benefit of the rewrite?

 > Also, as MAX_APICS-1 is reserved for the broadcast physical APIC ID
 > (it's 0xF for serial APIC and 0xFF for xAPIC) the small semantic change
 > here is correct.

No argument there, except that ">=" gets the job done in a cleaner way.
