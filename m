Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263497AbTK1WYO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Nov 2003 17:24:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263513AbTK1WYO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Nov 2003 17:24:14 -0500
Received: from ivoti.terra.com.br ([200.176.3.20]:62922 "EHLO
	ivoti.terra.com.br") by vger.kernel.org with ESMTP id S263497AbTK1WYE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Nov 2003 17:24:04 -0500
From: Lucas Correia Villa Real <lucasvr@gobolinux.org>
To: Lista da disciplina de Sistemas Operacionais III 
	<sisopiii-l@cscience.org>,
       Ricardo Nabinger Sanchez <rnsanchez@terra.com.br>,
       Tim Schmielau <tim@physik3.uni-rostock.de>
Subject: Re: [SisopIII-l] Re: [PATCH] fix #endif misplacement
Date: Fri, 28 Nov 2003 20:24:05 -0200
User-Agent: KMail/1.5.1
Cc: Andrew Morton <akpm@osdl.org>, sisopiii-l@cscience.org,
       linux-kernel@vger.kernel.org
References: <20031128141927.5ff1f35a.rnsanchez@terra.com.br> <Pine.LNX.4.53.0311281732100.21904@gockel.physik3.uni-rostock.de> <20031128193541.448d2893.rnsanchez@terra.com.br>
In-Reply-To: <20031128193541.448d2893.rnsanchez@terra.com.br>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311282024.06096.lucasvr@gobolinux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 28 November 2003 19:35, Ricardo Nabinger Sanchez wrote:
> Quoting  Tim Schmielau <tim@physik3.uni-rostock.de>
> Sent on  Fri, 28 Nov 2003 17:34:49 +0100 (CET)
>
> > > This patch fixes an #endif misplacement, which leads to dead code in
> > > sched_clock() in arch/i386/kernel/timers/timer_tsc.c, due to a return
> > > outside the ifdef/endif.
> >
> > No, this is exactly what is intended: don't use the TSC on NUMA, use
> > jiffies instead.
> > Look at the comment just above those lines.
>
> I'm breaking things.  Sorry.
>
> I think I understood it now: the #ifndef protects only the check for TSC
> availability on non-NUMA archs.  If it's available, and not under NUMA (so
> the ifndef), use it (jump to the rdtscll()), otherwise return the
> expression result.
>
> The strange thing to me is that I'm getting 1/10 of the expected value when
> measuring tasks timeslices.  Instead of getting ~100ms for tasks which just
> burn CPU, I'm getting 10ms.
>
> I measure timeslices inside schedule(), updating the average timeslice for
> the leaving process, using (now - prev->timestamp).
>
> Any clue of what am I doing wrong?

Hi,

It could it be possible that TSC isn't being enabled on your processor due to 
a buggy TSC. You can try to trace the code on init_tsc(), in 
arch/i386/kernel/timers/timer_tsc.c to realize what's going on.

You can also try to check whether you're using HPET or not (when enabled and 
supported it makes use of TSC) in your .config . In the case you're not using 
it, the code that calibrates and dictates how to deal with the stamp counter 
is calibrate_tsc(), in arch/i386/kernel/timers/common.c.

Hope this helps,
Lucas
