Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261866AbUCILIU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 06:08:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261867AbUCILIU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 06:08:20 -0500
Received: from gate.crashing.org ([63.228.1.57]:4561 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261866AbUCILIT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 06:08:19 -0500
Subject: Re: ppc/ppc64 and x86 vsyscalls
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ulrich Drepper <drepper@redhat.com>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <404D7AC3.9050207@redhat.com>
References: <1078708647.5698.196.camel@gaston> <404D7AC3.9050207@redhat.com>
Content-Type: text/plain
Message-Id: <1078830318.9746.3.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 09 Mar 2004 22:05:20 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> This is no reason for not using the DSO form.  The userlevel code finds
> the vDSO via the auxiliary vector.  By passing up different values for
> 32 and 64 bit processes you easily handle the last problem.
> 
> Many functions are no real issue either.  It not inefficient to use the
> symbol table.

Thanks for the clue.

> The only issue is that the vDSO should (IMO must) be position
> independent.  You certainly want to map the same copy in each address
> space.  This means the symbol table cannot contain addresses, only offsets.

Ok. The problem is building the DSO in the kernel from the various
individual functions depending on the CPU & app mode.

> .../...
>
> Why lack?  As a real DSO the vDSO can use the normal unwind info
> handling userlevel DSOs use, too.  I do not see a reason which this
> cannot work.  The unwind info for DSOs is position-independent so it
> should work just fine.

Ok. So the challenge is to write the necessary code in the kernel
to build that DSO based on the various functions after detection
of the CPU type.

Another option would be to pre-build a bunch of them at kernel compile
time. I have to investigate. The risk is that we end up with too
many combinations, thus bloating the kernel image.

Ben.


