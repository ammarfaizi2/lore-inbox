Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266560AbUIOPxl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266560AbUIOPxl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 11:53:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266534AbUIOPxN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 11:53:13 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:23490 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S266543AbUIOPu3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 11:50:29 -0400
Date: Wed, 15 Sep 2004 08:46:53 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: George Anzinger <george@mvista.com>
cc: john stultz <johnstul@us.ibm.com>,
       Albert Cahalan <albert@users.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>, tim@physik3.uni-rostock.de,
       Ulrich.Windl@rz.uni-regensburg.de, Len Brown <len.brown@intel.com>,
       linux@dominikbrodowski.de, David Mosberger <davidm@hpl.hp.com>,
       Andi Kleen <ak@suse.de>, paulus@samba.org, schwidefsky@de.ibm.com,
       jimix@us.ibm.com, keith maanthey <kmannth@us.ibm.com>,
       greg kh <greg@kroah.com>, Patricia Gaughen <gone@us.ibm.com>,
       Chris McDermott <lcm@us.ibm.com>
Subject: Re: [RFC][PATCH] new timeofday core subsystem (v.A0)
In-Reply-To: <4147F774.6000800@mvista.com>
Message-ID: <Pine.LNX.4.58.0409150843270.14721@schroedinger.engr.sgi.com>
References: <1094159238.14662.318.camel@cog.beaverton.ibm.com> 
 <4137CB3E.4060205@mvista.com> <1094193731.434.7232.camel@cube> 
 <41381C2D.7080207@mvista.com>  <1094239673.14662.510.camel@cog.beaverton.ibm.com>
  <4138EBE5.2080205@mvista.com>  <1094254342.29408.64.camel@cog.beaverton.ibm.com>
  <41390622.2010602@mvista.com>  <1094666844.29408.67.camel@cog.beaverton.ibm.com>
  <413F9F17.5010904@mvista.com>  <1094691118.29408.102.camel@cog.beaverton.ibm.com>
  <Pine.LNX.4.58.0409082005370.28366@schroedinger.engr.sgi.com> 
 <1094700768.29408.124.camel@cog.beaverton.ibm.com>  <413FDC9F.1030409@mvista.com>
  <1094756870.29408.157.camel@cog.beaverton.ibm.com>  <4140C1ED.4040505@mvista.com>
  <Pine.LNX.4.58.0409131420500.490@schroedinger.engr.sgi.com>
 <1095114307.29408.285.camel@cog.beaverton.ibm.com>
 <Pine.LNX.4.58.0409141045370.6963@schroedinger.engr.sgi.com>
 <41479369.6020506@mvista.com> <Pine.LNX.4.58.0409142024270.10739@schroedinger.engr.sgi.com>
 <4147F774.6000800@mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Sep 2004, George Anzinger wrote:

> Lets assume the pm counter which has 24 bits.  This means your shift is 40 bits.
>   In "s->multiply = (NSEC_PER_SEC << s->shift) / freq;" you will have an overflow.
> Here you need to keep (NSEC_PER_SEC << s->shift) in 64 bits AND multiply must
> also be 32 bits or less.  I really don't think you can choose the scale so easily.

Thanks for pointing that out. Will fix that. I sure wish one could
have a 128 bit intermediate result.

> > Nope. time_source_last is the global. l is just a copy of
> > time_source_last.
>
> Right, I miss read the function.  cycles() should be now() if I am reading this
> right.

Sortof. now() is the time in nanoseconds whereas cycles() is a counter
value of the counter in the cpu.

> > One could do this but we want to have a tickless system. The tick is only
> > necessary if the time needs to be adjusted.
>
> I really think a tickless system, for other than UML systems, is a loosing
> thing.  The accounting overhead on context switch (which increases as the number
> of switchs per second) will cause more overhead than a periodic accounting tick
> once a respectable load appears.  The periodic accounting tick has a flat
> overhead that does not depend on load.

I am not following you here. Why does the context switch overhead
increase? Because there are multiple interrupts for different tasks done
in the tick?

