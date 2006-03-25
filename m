Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751597AbWCYBfn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751597AbWCYBfn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 20:35:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751530AbWCYBfn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 20:35:43 -0500
Received: from saraswathi.solana.com ([198.99.130.12]:53914 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1751462AbWCYBfm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 20:35:42 -0500
Date: Fri, 24 Mar 2006 20:36:15 -0500
From: Jeff Dike <jdike@addtoit.com>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: Nix <nix@esperi.org.uk>, Rob Landley <rob@landley.net>,
       Mariusz Mazur <mmazur@kernel.pl>,
       LKML Kernel <linux-kernel@vger.kernel.org>,
       llh-discuss@lists.pld-linux.org
Subject: Re: State of userland headers
Message-ID: <20060325013615.GD8117@ccure.user-mode-linux.org>
References: <200603141619.36609.mmazur@kernel.pl> <200603231811.26546.mmazur@kernel.pl> <DE01BAD3-692D-4171-B386-5A5F92B0C09E@mac.com> <200603241623.49861.rob@landley.net> <878xqzpl8g.fsf@hades.wkstn.nix> <D903C0E1-4F7B-4059-A25D-DD5AB5362981@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D903C0E1-4F7B-4059-A25D-DD5AB5362981@mac.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2006 at 05:46:27PM -0500, Kyle Moffett wrote:
> 4)  UML runs into a lot of problems when glibc's headers and the  
> native kernel headers headers conflict.

> UML has other issues with conflicts between the native kernel headers  
> and the GLIBC-provided stubs.  It's been mentioned on the prior  
> threads about this topic that this sort of system would ease most of  
> the issues that UML runs into.

Actually, this isn't quite the same as what UML hits.  I have an
amicable solution (with some warts) to the glibc/kernel header
conflicts - files build against either glibc headers or kernel
headers, but never both.  

The warts are where I pass information between those two sets of files
that could be interpretted differently on either side, but aren't
because both sides are Linux.  For example, I freely pass errno values
across that interface in the hope that the glibc headers and the
kernel headers agree on what they mean. 

My problem with the kernel headers is that they are a mixture of
things that are usable in userspace and things that aren't.  This is
closely related, but not identical to, things which are part of the
ABI and things which aren't.

For example, the kernel locks are quite usable in userspace, but you
would never make them part of the ABI.

So, a set of KABI headers would likely make UML's headers cleaner, by
avoiding copying arch headers and using various nasty tricks to
disable objectionable pieces of headers which I steal from the arch.

So what I really want is a superset of the KABI headers, but the KABI
will give me most of what I want.

				Jeff
