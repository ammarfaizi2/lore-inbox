Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266242AbUIIQ3T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266242AbUIIQ3T (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 12:29:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266257AbUIIQ3S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 12:29:18 -0400
Received: from mailgw.cvut.cz ([147.32.3.235]:45721 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S266242AbUIIQ2x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 12:28:53 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Thu, 9 Sep 2004 18:29:50 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: PROBLEM: x86 alignment check bug
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       davej@codemonkey.org.uk, hpa@zytor.com, bgerst@didntduck.org,
       Riley@Williams.Name, zach@vmware.com
X-mailer: Pegasus Mail v3.50
Message-ID: <315C5E33D6A@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  8 Sep 04 at 14:26, Alan Cox wrote:
> On Mer, 2004-09-08 at 00:51, Zachary Amsden wrote:
> > Exception reporting for alignment check violations on x86 is broken 
> > (unfortunately, rather badly, and rather hard to fix).  Look at the trap 
> > function which fills in the si_addr field during an unaligned memory 
> > access, 2.6.8.1-mm4+, arch/i386/kernel/traps.c, Line 522:
> 
> So it fills in a value with random data that should be zero. Ok thats
> hardly "badly". 

These are not random data.  It is old value of CR2, which happens to
be address of last page fault which occured on this CPU.

By artifically triggering alignment fault you can find at which virtual 
address last pagefault on this CPU occured - so you can have some 
additional information channel which can disclose information about 
other processes running on your box.  And although probably all security
related apps learned that page faults can be sensed from time taken to
answer request, and add random delays to their failure answers, this 
additional channel could be used to more precisely determine where
failure occured.

Yes, likelihood that you can use it to hack passwords on your linux box
is zero, but given that currently si_addr reports garbage for alignment
faults (on all x86 processors), why not always report zero (or all F,
or any other constant value or eip) in si_addr? It has same relevance as 
any other random value, and when compared with semi-random value it does
not provide an additional information about system behavior.
                                                Best regards,
                                                    Petr Vandrovec

