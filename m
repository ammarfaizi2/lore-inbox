Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992719AbWJTV2T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992719AbWJTV2T (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 17:28:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992725AbWJTV2T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 17:28:19 -0400
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:49934 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S2992719AbWJTV2S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 17:28:18 -0400
Date: Fri, 20 Oct 2006 22:28:05 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: David Miller <davem@davemloft.net>, nickpiggin@yahoo.com.au,
       ralf@linux-mips.org, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       anemo@mba.ocn.ne.jp, linux-arch@vger.kernel.org,
       Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH 1/3] Fix COW D-cache aliasing on fork
Message-ID: <20061020212805.GG8894@flint.arm.linux.org.uk>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	David Miller <davem@davemloft.net>, nickpiggin@yahoo.com.au,
	ralf@linux-mips.org, Andrew Morton <akpm@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	anemo@mba.ocn.ne.jp, linux-arch@vger.kernel.org,
	Martin Schwidefsky <schwidefsky@de.ibm.com>
References: <Pine.LNX.4.64.0610200846260.3962@g5.osdl.org> <20061020.123635.95058911.davem@davemloft.net> <Pine.LNX.4.64.0610201251440.3962@g5.osdl.org> <20061020.125851.115909797.davem@davemloft.net> <Pine.LNX.4.64.0610201302090.3962@g5.osdl.org> <20061020205929.GE8894@flint.arm.linux.org.uk> <Pine.LNX.4.64.0610201408070.3962@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0610201408070.3962@g5.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2006 at 02:12:11PM -0700, Linus Torvalds wrote:
> On Fri, 20 Oct 2006, Russell King wrote:
> > Well, looking at do_wp_page() I'm now quite concerned about ARM and COW.
> > I can't see how this code could _possibly_ work with a virtually indexed
> > cache as it stands.  Yet, the kernel does appear to work.
> 
> It really shouldn't need any extra code, exactly because by the time it 
> hits any page-fault, the caches had better be in sync with the physical 
> page contents _anyway_ (yes, being virtual, the caches will _duplicate_ 
> the contents, but since the pages are read-only, that aliasing should be 
> perfectly fine).

Oh, of course!  That explains why it actually works as expected!  Thanks
for filling back in that bit of swapped-out-years-ago-and-lost information.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
