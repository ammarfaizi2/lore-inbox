Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261732AbUCGAF4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Mar 2004 19:05:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261733AbUCGAFz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Mar 2004 19:05:55 -0500
Received: from hq.pm.waw.pl ([195.116.170.10]:54220 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id S261732AbUCGAFx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Mar 2004 19:05:53 -0500
To: Grzegorz Kulewski <kangur@polcom.net>
Cc: Mariusz Mazur <mmazur@kernel.pl>, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] linux-libc-headers 2.6.3.0
References: <200402291942.45392.mmazur@kernel.pl>
	<200403031829.41394.mmazur@kernel.pl>
	<m3brnc8zun.fsf@defiant.pm.waw.pl>
	<200403042149.36604.mmazur@kernel.pl>
	<m3brnb8bxa.fsf@defiant.pm.waw.pl>
	<Pine.LNX.4.58.0403060022570.5790@alpha.polcom.net>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Sat, 06 Mar 2004 23:30:11 +0100
In-Reply-To: <Pine.LNX.4.58.0403060022570.5790@alpha.polcom.net> (Grzegorz
 Kulewski's message of "Sat, 6 Mar 2004 00:44:37 +0100 (CET)")
Message-ID: <m38yidk3rg.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grzegorz Kulewski <kangur@polcom.net> writes:

> But how synchronize kernel development with glibcs (+ all other C libs + 
> all other programs that must interface directly with the kernel)?

The kernel API should be stable enough, at least within stable trees.
Outside stable trees we should still maintain backward compatibility,
except when it comes to things which wouldn't work anyway (non-libc API
such as ipfw/ipchains/iptables etc).

> When kernel developers want to stop using something, how they should tell 
> that to glibc developers and others.

They should not stop :-)
Adding things is another story.

> Most admins change kernels more often than all other programs and libs 
> and these programs can potenitially not be updated yet.

I don't think so.
Applying a kernel patch usually doesn't change the API. Changing kernel
config should never change the API.

> My proposal is to move these things from linux-common to linux-userland 
> instead of removng them from the kernel immendiatelly.
> So no compatibility with user program and libs will be broken (and after a 
> few releases of kernel, when all programs and libs will be updated, these 
> things can be removed completly from kernel headers of all three types).

Things which are IMHO not options:
- removing kernel headers (i.e. headers which are required by kernel
  files to compile) from the kernel tree,
- duplicating kernel header definitions in external packages (a straight
  copy for distro users is ok, things which need maintenance aren't).
  Existing duplicates should be dealt with.
-- 
Krzysztof Halasa, B*FH
