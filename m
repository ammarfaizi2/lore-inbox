Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277219AbRJINtO>; Tue, 9 Oct 2001 09:49:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277217AbRJINtE>; Tue, 9 Oct 2001 09:49:04 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:10505 "EHLO
	deathstar.prodigy.com") by vger.kernel.org with ESMTP
	id <S277218AbRJINsx>; Tue, 9 Oct 2001 09:48:53 -0400
Date: Tue, 9 Oct 2001 09:49:24 -0400
Message-Id: <200110091349.f99DnOr11299@deathstar.prodigy.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Context switch times
X-Newsgroups: linux.dev.kernel
In-Reply-To: <200110090455.f994tNB22322@vindaloo.ras.ucalgary.ca>
Organization: TMR Associates, Schenectady NY
From: davidsen@tmr.com (bill davidsen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200110090455.f994tNB22322@vindaloo.ras.ucalgary.ca> rgooch@ras.ucalgary.ca asked:

| Hm. Perhaps when I did my tests (where I noticed a penalty), we didn't
| have lazy FPU saving. Now we disable the FPU, and restore state when
| we trap, right?
| 
| I do note this comment in arch/i386/kernel/process.c:
|  * We fsave/fwait so that an exception goes off at the right time
|  * (as a call from the fsave or fwait in effect) rather than to
|  * the wrong process. Lazy FP saving no longer makes any sense
|  * with modern CPU's, and this simplifies a lot of things (SMP
|  * and UP become the same).
| 
| So what exactly is the difference between our "delayed FPU restore
| upon trap" (which I think of as lazy FPU saving), and the "lazy FP"
| saving in the comments?

We always save the FPU, but only restore it when/if it is going to be
used. And obviously we don't want to save it if it hasn't been used,
since it wasn't restored...

-- 
bill davidsen <davidsen@tmr.com>
 "If I were a diplomat, in the best case I'd go hungry.  In the worst
  case, people would die."
		-- Robert Lipe
