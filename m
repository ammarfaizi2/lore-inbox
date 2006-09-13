Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751586AbWIMF4T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751586AbWIMF4T (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 01:56:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751588AbWIMF4T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 01:56:19 -0400
Received: from europa.telenet-ops.be ([195.130.137.75]:11208 "EHLO
	europa.telenet-ops.be") by vger.kernel.org with ESMTP
	id S1751585AbWIMF4S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 01:56:18 -0400
From: Peter Korsgaard <jacmet@sunsite.dk>
To: Olof Johansson <olof@lixom.net>
Cc: rmk+serial@arm.linux.org.uk, linux-serial@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] Xilinx uartlite serial driver
References: <87ac9o3ak3.fsf@sleipner.barco.com>
	<878xlgercm.fsf@slug.be.48ers.dk>
	<20060912093301.77f75bfb@localhost.localdomain>
Date: Wed, 13 Sep 2006 07:56:03 +0200
In-Reply-To: <20060912093301.77f75bfb@localhost.localdomain> (Olof Johansson's
	message of "Tue, 12 Sep 2006 09:33:01 -0500")
Message-ID: <87ejugxqbw.fsf@slug.be.48ers.dk>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Olof" == Olof Johansson <olof@lixom.net> writes:

Hi Olof, thanks for looking into the driver..

 Olof> In my opinion there's a few pieces missing:

 Olof> 1. There's no early boot console support for PPC. There's another
 Olof> uartlite patch that's floating around that has this, very useful for
 Olof> early bringup tasks. I'd like to see this expanded to include that as
 Olof> well (the regular part of the other driver seems more or less broken
 Olof> though, so this is a better base driver). That shouldn't stop this part
 Olof> of the driver to go in though, just possible future work.

True. The board I have an uartlite on also has a 8250 so it hasn't
been an issue for me so far - But it would indeed be a nice
addition. Adding new stuff to arch/ppc at this moment isn't that
sensible, so perhaps it makes most sense to wait til 4xx is supported
under arch/powerpc?

 Olof> 2. There seems to be some timeout issues with tx_empty. If I boot a
 Olof> regular distro with getty, etc, I get veeeery slow console output right
 Olof> when init starts up. Adding a small default timeout in the init of the
 Olof> uart code seems to help -- the hanging thread seems to be sleeping in
 Olof> uart_wait_until_sent(). I picked a value of '5', seems ok. (Also,
 Olof> without this fix, getty won't start on the port for some reason, it
 Olof> sits in the same timeout forever, or at least for a very long time).

Huh, that's odd - I haven't noticed that. I'll test it again and get
back to you.

 Olof> 3. It would be useful to demonstrate how to hook up the device all the
 Olof> way through to the board port (i.e. add a config option and include it
 Olof> in the ml403 platform code or similar). It's not hard, but it'd make it
 Olof> easier for whomever comes next. Of course, with 4xx hopefully soon
 Olof> moving over to arch/powerpc, this would be taken care of through the
 Olof> device tree instead.

Yes - Afaik none of the Xilinx boards comes with uartlites
configured so it's not usable out-of-the-box, but you can ofcause do a
setup with the proper #ifdefs like the 8250 stuff in virtex.c.

-- 
Bye, Peter Korsgaard
