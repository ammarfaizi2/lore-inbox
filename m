Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315430AbSHVR56>; Thu, 22 Aug 2002 13:57:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315440AbSHVR55>; Thu, 22 Aug 2002 13:57:57 -0400
Received: from ALyon-209-1-13-54.abo.wanadoo.fr ([217.128.17.54]:10684 "EHLO
	alph.dyndns.org") by vger.kernel.org with ESMTP id <S315430AbSHVR54>;
	Thu, 22 Aug 2002 13:57:56 -0400
Subject: Re: [PATCH]: fix 32bits integer overflow in loops_per_jiffy
	calculation
From: Yoann Vandoorselaere <yoann@prelude-ids.org>
To: Dominik Brodowski <devel@brodo.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Gabriel Paubert <paubert@iram.es>, cpufreq@lists.arm.linux.org.uk,
       cpufreq@www.linux.org.uk, linux-kernel@vger.kernel.org
In-Reply-To: <20020822194655.C2016@brodo.de>
References: <20020822185107.A1160@brodo.de>
	<20020822193516.15445@192.168.4.1>  <20020822194655.C2016@brodo.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 22 Aug 2002 20:02:13 +0200
Message-Id: <1030039334.15430.256.camel@alph>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-08-22 at 19:46, Dominik Brodowski wrote:
> On Thu, Aug 22, 2002 at 09:35:16PM +0200, Benjamin Herrenschmidt wrote:
> > >IMHO per-arch functions are really not needed. The only architectures which
> > >have CPUFreq drivers by now are ARM and i386. This will change, hopefully;
> > >IMHO it should be enough to include some basic limit checking in 
> > >cpufreq_scale().
> > 
> > In this specific case, we were talking about PPC since the problem
> > occured when I implemented cpufreq support to switch the speed
> > of the latest powerbooks between 667 and 800Mhz
> 
> And the patch from Yoann solves this? 

Yep, the integer overflow resulted in an incorrectly computed
loops_per_jiffy :

Aug 21 19:50:41 titane kernel: adjust_jiffies: prechange cur=667000, new=800000
Aug 21 19:50:41 titane kernel: old loop_per_jiffy = 665.19 (cpufreq_ref_loops=3325952, cpufreq_ref_freq=667000).
Aug 21 19:50:41 titane kernel: new loop_per_jiffy = 669.02 (cpufreq_ref_loops=3325952, cpufreq_ref_freq=667000).

With the patch applied, it work fine :

Aug 22 11:33:40 titane kernel: adjust_jiffies: prechange cur=667000, new=800000
Aug 22 11:33:40 titane kernel: old loop_per_jiffy = 665.19 (cpufreq_ref_loops=3325952, cpufreq_ref_freq=667000).
Aug 22 11:33:40 titane kernel: new loop_per_jiffy = 797.82 (cpufreq_ref_loops=3325952, cpufreq_ref_freq=667000).

-- 
Yoann Vandoorselaere, http://www.prelude-ids.org

"Programming is a race between programmers, who try and make more and 
 more idiot-proof software, and universe, which produces more and more 
 remarkable idiots. Until now, universe leads the race"  -- R. Cook

