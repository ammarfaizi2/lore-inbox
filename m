Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750780AbWDPSDG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750780AbWDPSDG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Apr 2006 14:03:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750782AbWDPSDG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Apr 2006 14:03:06 -0400
Received: from uproxy.gmail.com ([66.249.92.174]:58083 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750780AbWDPSDE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Apr 2006 14:03:04 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XsJOhvzZ+2UaFIE3BGl6tmZNQcYbZ0gMOmNZVhsF3DsVarouTDFdkIA8puoO1ZrnwkWORPIczK+KjlnBxheDVE5drWZJNjLgYzSXLMeqhs+4ly34eZ6Lzcrsc9M/A7S8dUCCAN3T2lDhBXN2iEO37pBa1Ds2eJ2uB1u75HckXd4=
Message-ID: <12c511ca0604161103l3013f5f1t99c93ee38f102e95@mail.gmail.com>
Date: Sun, 16 Apr 2006 11:03:03 -0700
From: "Tony Luck" <tony.luck@intel.com>
To: "Arnd Bergmann" <arnd@arndb.de>
Subject: Re: [PATCH 00/05] robust per_cpu allocation for modules
Cc: "Steven Rostedt" <rostedt@goodmis.org>,
       "Paul Mackerras" <paulus@samba.org>,
       "Nick Piggin" <nickpiggin@yahoo.com.au>,
       LKML <linux-kernel@vger.kernel.org>, "Andrew Morton" <akpm@osdl.org>,
       "Linus Torvalds" <torvalds@osdl.org>, "Ingo Molnar" <mingo@elte.hu>,
       "Thomas Gleixner" <tglx@linutronix.de>, "Andi Kleen" <ak@suse.de>,
       "Martin Mares" <mj@atrey.karlin.mff.cuni.cz>, bjornw@axis.com,
       schwidefsky@de.ibm.com, benedict.gaster@superh.com, lethal@linux-sh.org,
       "Chris Zankel" <chris@zankel.net>, "Marc Gauthier" <marc@tensilica.com>,
       "Joe Taylor" <joe@tensilica.com>,
       "David Mosberger-Tang" <davidm@hpl.hp.com>, rth@twiddle.net,
       spyro@f2s.com, starvik@axis.com, linux-ia64@vger.kernel.org,
       ralf@linux-mips.org, linux-mips@linux-mips.org,
       grundler@parisc-linux.org, parisc-linux@parisc-linux.org,
       linuxppc-dev@ozlabs.org, linux390@de.ibm.com, davem@davemloft.net,
       rusty@rustcorp.com.au
In-Reply-To: <200604161734.20256.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1145049535.1336.128.camel@localhost.localdomain>
	 <17473.60411.690686.714791@cargo.ozlabs.ibm.com>
	 <1145194804.27407.103.camel@localhost.localdomain>
	 <200604161734.20256.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/16/06, Arnd Bergmann <arnd@arndb.de> wrote:
> #define PER_CPU_BASE 0xe000000000000000UL /* arch dependant */

On ia64 the percpu area is at 0xffffffffffff0000 so that it can be
addressed without tying up another register (all percpu addresses
are small negative offsets from "r0").  When David Mosberger
chose this address he said that gcc 4 would actually make
ue of this, but I haven't checked the generated code to see
whether it really is doing so.

-Tony
