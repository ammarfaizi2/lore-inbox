Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314278AbSHVRBN>; Thu, 22 Aug 2002 13:01:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314396AbSHVRBN>; Thu, 22 Aug 2002 13:01:13 -0400
Received: from natpost.webmailer.de ([192.67.198.65]:42151 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S314278AbSHVRBN>; Thu, 22 Aug 2002 13:01:13 -0400
Date: Thu, 22 Aug 2002 18:51:08 +0200
From: Dominik Brodowski <devel@brodo.de>
To: Gabriel Paubert <paubert@iram.es>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Yoann Vandoorselaere <yoann@prelude-ids.org>,
       cpufreq@lists.arm.linux.org.uk, cpufreq@www.linux.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: fix 32bits integer overflow in loops_per_jiffy calculation
Message-ID: <20020822185107.A1160@brodo.de>
References: <3D64D51C.9040603@iram.es> <20020822143115.15323@192.168.4.1> <3D65020D.5070201@iram.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
In-Reply-To: <3D65020D.5070201@iram.es>; from paubert@iram.es on Thu, Aug 22, 2002 at 03:23:57PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> > Well... it's clearly located inside kernel/cpufreq.c, so there is
> > little risk, though it may be worth a big bold comment
> 
> Hmm, in my experience people hardly ever read detailed comments even 
> when they are well-written. Perhaps if you called the function 
> imprecise_scale or coarse_scale, it might ring a bell.

First of all, it's located in include/linux/cpufreq.h [to be accessible for
arch/i386/kernel/time.c, called cpufreq_scale() which should mean that it is
only meant for CPUFreq and nothing else.

> >>In this case a generic scaling function, while not a standard libgcc/C
> >>library feature has potentially more applications than this simple 
> >>cpufreq approximation. But I don't see very much the need for scaling a 
> >>long (64 bit on 64 bit archs) value, 32 bit would be sufficient.
> > 
> > 
> > Well... if you can write one, go on then ;) In my case, I'm happy
> > with Yoann implementation for cpufreq right now. Though I agree that
> > could ultimately be moved to arch code.
> 
> Ok, I'll give it a try this week-end (PPC, i386 and all 64 bit should 
> archs should be trivial).

IMHO per-arch functions are really not needed. The only architectures which
have CPUFreq drivers by now are ARM and i386. This will change, hopefully;
IMHO it should be enough to include some basic limit checking in 
cpufreq_scale().

Dominik
