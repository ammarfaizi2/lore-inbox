Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262128AbULQUEc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262128AbULQUEc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 15:04:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262156AbULQUEc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 15:04:32 -0500
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:44535 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S262128AbULQUE1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 15:04:27 -0500
Subject: Re: 2.6.10-rc3-mm1-V0.7.33-03 and NVidia wierdness, with
	workaround...
From: Steven Rostedt <rostedt@goodmis.org>
To: Valdis.Kletnieks@vt.edu
Cc: Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <200412171810.iBHIAQP3026387@turing-police.cc.vt.edu>
References: <200412161626.iBGGQ5CI020770@turing-police.cc.vt.edu>
	 <1103300362.12664.53.camel@localhost.localdomain>
	 <1103303011.12664.58.camel@localhost.localdomain>
	 <200412171810.iBHIAQP3026387@turing-police.cc.vt.edu>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Fri, 17 Dec 2004 15:04:21 -0500
Message-Id: <1103313861.12664.71.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-12-17 at 13:10 -0500, Valdis.Kletnieks@vt.edu wrote:
> On Fri, 17 Dec 2004 12:03:31 EST, Steven Rostedt said:
> 
> > Update: I just tried some of my fixes to the rc3-mm1 kernel, and that
> > worked without a problem.  But I still didn't get by the sleep problem
> > in Ingo's RT patch.  Did you get further, and did you make fixes to both
> > the nvidia module as well as the kernel?
> 
> I have to admit I haven't *hit* a sleep problem specific to Ingo's code, unless
> you have a different config/hardware and my BKL wierdness and your sleep are
> 2 different manifestations of the same problem.  Or maybe they're 2 different
> bugs... ;)
> 
> I'm running Ingo's patch and the nvidia 6629 drivers as I'm typing this. Given
> you had to fool with pgd_offset_k and friends, you're probably trying an older
> driver (6111?) and should upgrade - the 6629 picked up a *bunch* of 2.6-related
> fixes.  Maybe 6629 fixed your sleep issue?
> 

Nope! I have the 6629. Actually, the patch you have for NV solved the
pgd_offset problem. But I'm amazed that you didn't get into the
may_sleep calls.  In the nvidia code os-interface.c, would call hooks
into the kernel with interrupts turned off and hit the may_sleep.  But
looking into it further now, one of the crashes came from
ioremap_nocache and the sleep happened in kmem_cache_alloc. So maybe
Ingo fixed this.  I lied earlier (not intentionally), the last kernel I
tried with the NVidia was V0.7.32-18, so let me try again.

Thanks, for the references though.

-- Steve


