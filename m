Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751786AbWBMONg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751786AbWBMONg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 09:13:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932101AbWBMONg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 09:13:36 -0500
Received: from mail11.syd.optusnet.com.au ([211.29.132.192]:19586 "EHLO
	mail11.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751786AbWBMONf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 09:13:35 -0500
From: Con Kolivas <kernel@kolivas.org>
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Subject: Re: [rfc][patch] sched: remove smpnice
Date: Tue, 14 Feb 2006 01:12:57 +1100
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, npiggin@suse.de, mingo@elte.hu,
       rostedt@goodmis.org, pwil3058@bigpond.net.au,
       linux-kernel@vger.kernel.org, torvalds@osdl.org
References: <20060207142828.GA20930@wotan.suse.de> <20060207153617.6520f126.akpm@osdl.org> <20060209230145.A17405@unix-os.sc.intel.com>
In-Reply-To: <20060209230145.A17405@unix-os.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602140112.58888.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 10 February 2006 18:01, Siddha, Suresh B wrote:
> On Tue, Feb 07, 2006 at 03:36:17PM -0800, Andrew Morton wrote:
> > Suresh, Martin, Ingo, Nick and Con: please drop everything, triple-check
> > and test this:
> >
> > From: Peter Williams <pwil3058@bigpond.net.au>
> >
> > This is a modified version of Con Kolivas's patch to add "nice" support
> > to load balancing across physical CPUs on SMP systems.
>
> I have couple of issues with this patch.
>
> a) on a lightly loaded system, this will result in higher priority job
> hopping around from one processor to another processor.. This is because of
> the code in find_busiest_group() which assumes that SCHED_LOAD_SCALE
> represents a unit process load and with nice_to_bias calculations this is
> no longer true(in the presence of non nice-0 tasks)
>
> My testing showed that 178.galgel in SPECfp2000 is down by ~10% when run
> with nice -20 on a 4P(8-way with HT) system compared to a nice-0 run.

While I voted to remove smp nice till this regression is fixed can I just 
point out a mildly amusing catch 22 in this. Nice levels are _broken_ on smp 
without smp nice, yet it's only by using nice levels that you get this 
performance problem. I'm not arguing for changing our decision based on this.

Cheers,
Con
