Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267254AbUIOSFR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267254AbUIOSFR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 14:05:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267319AbUIOSEA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 14:04:00 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:47861 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S267254AbUIOSDO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 14:03:14 -0400
Message-ID: <41488346.1020101@mvista.com>
Date: Wed, 15 Sep 2004 11:00:38 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Lameter <clameter@sgi.com>
CC: john stultz <johnstul@us.ibm.com>,
       Albert Cahalan <albert@users.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>, tim@physik3.uni-rostock.de,
       Ulrich.Windl@rz.uni-regensburg.de, Len Brown <len.brown@intel.com>,
       linux@dominikbrodowski.de, David Mosberger <davidm@hpl.hp.com>,
       Andi Kleen <ak@suse.de>, paulus@samba.org, schwidefsky@de.ibm.com,
       jimix@us.ibm.com, keith maanthey <kmannth@us.ibm.com>,
       greg kh <greg@kroah.com>, Patricia Gaughen <gone@us.ibm.com>,
       Chris McDermott <lcm@us.ibm.com>
Subject: Re: [RFC][PATCH] new timeofday core subsystem (v.A0)
References: <1094159238.14662.318.camel@cog.beaverton.ibm.com>  <41381C2D.7080207@mvista.com>  <1094239673.14662.510.camel@cog.beaverton.ibm.com>  <4138EBE5.2080205@mvista.com>  <1094254342.29408.64.camel@cog.beaverton.ibm.com>  <41390622.2010602@mvista.com>  <1094666844.29408.67.camel@cog.beaverton.ibm.com>  <413F9F17.5010904@mvista.com>  <1094691118.29408.102.camel@cog.beaverton.ibm.com>  <Pine.LNX.4.58.0409082005370.28366@schroedinger.engr.sgi.com>  <1094700768.29408.124.camel@cog.beaverton.ibm.com>  <413FDC9F.1030409@mvista.com>  <1094756870.29408.157.camel@cog.beaverton.ibm.com>  <4140C1ED.4040505@mvista.com>  <Pine.LNX.4.58.0409131420500.490@schroedinger.engr.sgi.com> <1095114307.29408.285.camel@cog.beaverton.ibm.com> <Pine.LNX.4.58.0409141045370.6963@schroedinger.engr.sgi.com> <41479369.6020506@mvista.com> <Pine.LNX.4.58.0409142024270.10739@schroedinger.engr.sgi.com> <4147F774.6000800@mvista.com> <Pine.LNX.4.58.0409150843270.14721@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.58.0409150843270.14721@schroedinger.engr.sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:
~

>>>One could do this but we want to have a tickless system. The tick is only
>>>necessary if the time needs to be adjusted.
>>
>>I really think a tickless system, for other than UML systems, is a loosing
>>thing.  The accounting overhead on context switch (which increases as the number
>>of switchs per second) will cause more overhead than a periodic accounting tick
>>once a respectable load appears.  The periodic accounting tick has a flat
>>overhead that does not depend on load.
> 
> 
> I am not following you here. Why does the context switch overhead
> increase? Because there are multiple interrupts for different tasks done
> in the tick?
> 
Each task has several timers, i.e. time slice, time limit, and possibly itimer 
profile.  Granted only one of these needs to be sent to the timer code, but that 
takes a bit of time, not much, but enough to increase the context switch 
overhead such that a system with a modest amount of context switching will incur 
more timer management overhead than the periodic tick generates.

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

