Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275313AbTHMTAT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 15:00:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275328AbTHMTAT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 15:00:19 -0400
Received: from amdext2.amd.com ([163.181.251.1]:48875 "EHLO amdext2.amd.com")
	by vger.kernel.org with ESMTP id S275313AbTHMTAN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 15:00:13 -0400
Message-ID: <99F2150714F93F448942F9A9F112634C0638AF57@txexmtae.amd.com>
From: richard.brunner@amd.com
To: ak@suse.de, alan@lxorguk.ukuu.org.uk
cc: linux-kernel@vger.kernel.org
Subject: RE: 2.6.0-test3-mm1: scheduling while atomic (ext3?)
Date: Wed, 13 Aug 2003 13:59:55 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
X-WSS-ID: 132455251530573-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

See below.

] -Rich ...
] AMD Fellow
] richard.brunner at amd com 
 
> From: Andi Kleen [mailto:ak@suse.de] 

> On Wed, Aug 13, 2003 at 04:20:11PM +0100, Alan Cox wrote:
> > On Mer, 2003-08-13 at 15:20, Andi Kleen wrote:

> > Has AMD confirmed that your solution is ok for the K7 as well as K8 - 
> > ie that if we hit the errata the fixup recovers the CPU from whatever 
> > lunatic state it is now in ?
> 
> My solution is a fix as the problem is described in the 
> Opteron Specification Update (and also as our own testing 
> showed - we discovered the problem originally) 

Hi, AMD has not confirmed anything with respect to this issue
on K7/Athlon. We are currently trying to get the code that reproduces
this bug into AMD so we can see what triggers it.

Andi's workaround for Opteron (before a BIOS fix was available),
is probably a fine *short-term* workaround until we can get back 
to you on this. AMD believes that dimissing a exception on
prefetch as spurious on Athlon will work you around the current
problem.

Linking the Opteron bug to an Athlon bug is pre-mature at this point.

> The Errata is basically: When there is a prefetch and a load for the 
> same address in flight and the load faults and the CPU is in 
> a very specific complicated state then the Exception is 
> reported on the prefetch, not the fault. 
> 
> The fix just handles the exception and doesn't crash.
> 
> At least on Opteron it can be also fixed with a magic bit in 
> the BIOS, maybe that's possible on XP too. But I opted to 
> work around it in the kernel to not force all people to get a 
> new BIOS.

Let us get back to you, ok? I am starting up our
internal validation people to go poke at this.

