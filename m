Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264843AbUHDMpO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264843AbUHDMpO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 08:45:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264097AbUHDMpO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 08:45:14 -0400
Received: from mx2.elte.hu ([157.181.151.9]:19092 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S264965AbUHDMoZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 08:44:25 -0400
Date: Wed, 4 Aug 2004 14:45:38 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Con Kolivas <kernel@kolivas.org>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.8-rc2-mm2
Message-ID: <20040804124538.GA15505@elte.hu>
References: <20040802015527.49088944.akpm@osdl.org> <410E3CAF.6080305@kolivas.org> <410F3423.3020409@yahoo.com.au> <cone.1091518501.973503.9648.502@pc.kolivas.org> <cone.1091519122.804104.9648.502@pc.kolivas.org> <41109FCC.4070906@yahoo.com.au> <20040804103143.GA13072@elte.hu> <cone.1091616443.996442.9775.502@pc.kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cone.1091616443.996442.9775.502@pc.kolivas.org>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Con Kolivas <kernel@kolivas.org> wrote:

> Ingo Molnar writes:
> 
> Thanks for replying.
> 
> >* Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> >
> >>Also, basic interactivity in X is bad with the interactive sysctl set
> >>to 0 (is X supposed to be at nice 0?), however fairness is bad when
> >>interactive is 1. I'm not sure if this is an acceptable tradeoff - are
> >>you planning to fix it?
> >
> >it also has clear interactivity problems when just running lots of CPU
> >hogs even with the default interactive=1 compute=0 setting.
> 
> Can you define them please? I haven't had any reported to me.

sure: take a process that uses 85% of CPU time (and sleeps 15% of the
time) if running on an idle system. Start just two of these hogs at
normal priority. 2.6.8-rc2-mm2 becomes almost instantly unusable even
over a text console: a single 'top' refresh takes ages, 'ls' displays
one line per second or so. Start more of these and the system
effectively locks up.

unapply staircase-cpu-scheduler-268-rc2-mm1.patch and the same workload
becomes usable.

	Ingo
