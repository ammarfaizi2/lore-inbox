Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264096AbUCZRob (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 12:44:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264095AbUCZRob
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 12:44:31 -0500
Received: from aslan.scsiguy.com ([63.229.232.106]:49675 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP id S264088AbUCZRoR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 12:44:17 -0500
Date: Fri, 26 Mar 2004 10:43:09 -0700
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Reply-To: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Kevin Corry <kevcorry@us.ibm.com>, linux-kernel@vger.kernel.org,
       Neil Brown <neilb@cse.unsw.edu.au>, linux-raid@vger.kernel.org
Subject: Re: "Enhanced" MD code avaible for review
Message-ID: <1564440000.1080322989@aslan.btc.adaptec.com>
In-Reply-To: <406375B0.5040406@pobox.com>
References: <760890000.1079727553@aslan.btc.adaptec.com> <16480.61927.863086.637055@notabene.cse.unsw.edu.au> <40624235.30108@pobox.com> <200403251200.35199.kevcorry@us.ibm.com> <40632804.1020101@pobox.com> <1030470000.1080257746@aslan.btc.adaptec.com> <406375B0.5040406@pobox.com>
X-Mailer: Mulberry/3.1.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> I respectfully disagree with the EMD folks that a userland approach is
>>> impossible, given all the failure scenarios.
>> 
>> 
>> I've never said that it was impossible, just unwise.  I believe
>> that a userland approach offers no benefit over allowing the kernel
>> to perform all meta-data operations.  The end result of such an
>> approach (given feature and robustness parity with the EMD solution)
>> is a larger resident side, code duplication, and more complicated
>> configuration/management interfaces.
> 
> There is some code duplication, yes.  But the right userspace solution
> does not have a larger RSS, and has _less_ complicated management
> interfaces.
>
> A key benefit of "do it in userland" is a clear gain in flexibility,
> simplicity, and debuggability (if that's a word).

This is just as much hand waving as, 'All that just screams "do it in
userland".' <sigh>

I posted a rather detailed, technical, analysis of what I believe would
be required to make this work correctly using a userland approach.  The
only response I've received is from Neil Brown.  Please, point out, in
a technical fashion, how you would address the feature set being proposed:

 o Rebuilds
 o Auto-array enumeration
 o Meta-data updates for topology changes (failed members, spare activation)
 o Meta-data updates for "safe mode"
 o Array creation/deletion
 o "Hot member addition"

Only then can a true comparative analysis of which solution is "less
complex", "more maintainable", and "smaller" be performed.

> But it's hard.  It requires some deep thinking.  It's a whole lot easier
> to do everything in the kernel -- but that doesn't offer you the
> protections of userland, particularly separate address spaces from the
> kernel, and having to try harder to crash the kernel.  :)

A crash in any component of a RAID solution that prevents automatic
failover and rebuilds without customer intervention is unacceptable.
Whether it crashes your kernel or not is really not that important other
than the customer will probably notice that their data is no longer
protected *sooner* if the system crashes.  In other-words, the solution
must be *correct* regardless of where it resides.  Saying that doing
a portion of it in userland allows it to safely be buggier seems a very
strange argument.

--
Justin

