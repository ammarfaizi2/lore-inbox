Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261930AbTJXBW3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 21:22:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261932AbTJXBW3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 21:22:29 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:25830 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S261930AbTJXBW1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 21:22:27 -0400
Subject: Re: [RFC] must fix lists
From: Albert Cahalan <albert@users.sf.net>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "viro@parcelfarce.linux.theplanet.co.uk" 
	<viro@parcelfarce.linux.theplanet.co.uk>,
       Albert Cahalan <albert@users.sourceforge.net>, Andi Kleen <ak@suse.de>,
       Badari Pulavarty <pbadari@us.ibm.com>,
       Dominik Brodowski <linux@brodo.de>,
       "David S. Miller" <davem@redhat.com>,
       Dipankar Sarma <dipankar@in.ibm.com>,
       Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@redhat.com>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       Jens Axboe <axboe@suse.de>, Lars Marowsky-Bree <lmb@suse.de>,
       Mike Anderson <andmike@us.ibm.com>,
       Patrick Mansfield <patmans@us.ibm.com>,
       Russell King <rmk@arm.linux.org.uk>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Andrew Morton OSDL <akpm@osdl.org>
In-Reply-To: <3F986859.2000101@cyberone.com.au>
References: <3F94C833.8040204@cyberone.com.au>
	 <1066943359.6102.14.camel@dhcp23.swansea.linux.org.uk>
	 <3F986859.2000101@cyberone.com.au>
Content-Type: text/plain
Organization: 
Message-Id: <1066957616.1623.34.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 23 Oct 2003 21:06:57 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-10-23 at 19:46, Nick Piggin wrote:
 
> +o alan, Albert Cahalan: 1000 HZ timer increases the need for a stable time
> +  source. Many laptops, SMI can lose ticks. ACPI timers? TSC?

Oh, I have an example for you.

Consider the Intel Plumas chipset. There are
some predictable time windows during which the
RTC will return garbage. The BIOS "fix" leads to
SMI/SMM stuff stealing large chunks of CPU time.
On a logic analyser, somebody at work observed
chunks of time as large as 4 ms. That's 3 to 5
clock ticks. Maybe that isn't worst-case even.

To avoid this disaster, Linux must _never_ touch
the RTC registers. The HPET can be used instead.
The TSC is of course also reliable, but Linux
stops using it as soon as a problem hits!

The ignore-the-TSC code really should be doing
just the opposite. Ticks are likely to be lost.
I've never seen an unstable TSC. :-)

>  o 64-bit dev_t.  Seems almost ready, but it's not really known how much
>    work is still to do.  Patches exist in -mm but with the recent rise of the
>    neo-viro I'm not sure where things are at.

Hey, 32-bit dev_t is in already. That's it. Done.


