Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313537AbSGDTMG>; Thu, 4 Jul 2002 15:12:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313558AbSGDTMF>; Thu, 4 Jul 2002 15:12:05 -0400
Received: from OL65-148.fibertel.com.ar ([24.232.148.65]:14468 "EHLO
	almesberger.net") by vger.kernel.org with ESMTP id <S313537AbSGDTME>;
	Thu, 4 Jul 2002 15:12:04 -0400
Date: Thu, 4 Jul 2002 16:18:44 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Brian Gerst <bgerst@didntduck.org>
Cc: Keith Owens <kaos@ocs.com.au>,
       Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: simple handling of module removals Re: [OKS] Module removal
Message-ID: <20020704161843.P2295@almesberger.net>
References: <12364.1025755693@kao2.melbourne.sgi.com> <3D246392.7030807@quark.didntduck.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D246392.7030807@quark.didntduck.org>; from bgerst@didntduck.org on Thu, Jul 04, 2002 at 11:02:42AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brian Gerst wrote:
> PS.  If you really want to make the broken cases show themselves, poison 
> the module memory when it is unloaded.  The same can be done for dumping 
> init data and text.

Unfortunately, many of the code paths leading to the races are
sufficiently different that it's currently unlikely to actually
hit them. (E.g. it's kind of hard for some 1000+ instructions
code path to compete successfully with a cached, pre-fetched,
and pre-decoded "ret" instruction. Entry-after-removal races
(and the related data races) may be a little bit easier to catch,
but I suppose we're still talking about a likely difference of
orders of magnitude.)

I don't think preemption changes that fundamentally.
Microthreading may, and NUMA will make execution times more
variable, increasing the risk of hitting a race.

The best way to trigger such races is probably to simulate
microthreading, e.g. with an UML-SMP where only one "CPU" can
run at a time, and where execution switching is under script
control.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://icapeople.epfl.ch/almesber/_____________________________________/
