Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264505AbUFNU6J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264505AbUFNU6J (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 16:58:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264513AbUFNU6J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 16:58:09 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:57850 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S264505AbUFNU6D
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 16:58:03 -0400
Message-ID: <40CE1128.8030806@mvista.com>
Date: Mon, 14 Jun 2004 13:57:12 -0700
From: George Anzinger <george@mvista.com>
Reply-To: ganzinger@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: karim@opersys.com
CC: Geoff Levand <geoffrey.levand@am.sony.com>,
       high-res-timers-discourse@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] high-res-timers patches for 2.6.6
References: <40C7BE29.9010600@am.sony.com> <40CA4D23.2010006@opersys.com>
In-Reply-To: <40CA4D23.2010006@opersys.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Karim Yaghmour wrote:
> 
> Geoff Levand wrote:
> 
>> For those interested, the set of three patches provide POSIX high-res 
>> timer support for linux-2.6.6.  The core and i386 patches are updates 
>> of George Anzinger's hrtimers-2.6.5-1.0.patch available on SourceForge 
>> <http://sourceforge.net/projects/high-res-timers/>.  The ppc32 port is 
>> not available on SourceForge yet.
> 
> 
> I've got to ask:
> 
> Just reading from the Posix 1003.1b section 14 spec referenced by the HRT
> main project page, I see the following:
> ------------------------------------------------------------------------------ 
> 
> Realtime applications must be able to operate on data within strict timing
> constraints in order to schedule application or system events. Timing
> requirements can be in response to the need for either high system 
> throughput
> or fast response time. Applications requiring high throughput may process
> large amounts of data and use a continuous stream of data points equally
> spaced in time. For example, electrocardiogram research uses a continuous
> stream of data for qualitative and quantitative analysis.
> ------------------------------------------------------------------------------ 
> 
> 
> If this is really the goal here, then why not just integrate Adeos into
> the kernel and make some form of HRT as a loadable module that uses 
> Adeos to
> provide its services?
> 
> Currently Adeos runs on x86, ARM (MMU-full and MMU-less), PPC, so 
> portability
> is not an issue. Plus, the interface provided can either be directly used
> by drivers to get hard-rt interrupts or it can be used by another layer to
> provide more elaborate services (like RTAI or, potentially, HRT.) Using the
> virtual interrupts that can be dynamically allocated at runtime, it's 
> rather
> easy to send signals between domains.
> 
> Sure, you may not have the exact Posix 1003.1b API, but I don't remember 
> there
> being any persistent goal of having the kernel conform to any standard.

I don't see how this delivers any added value to the user.  I suppose code 
running at the kernel level might gain something, but at the user level we still 
have to deal with preemption latencies, which are the biggest problem (and, 
aside from messing up the accuracy of the timers, are NOT timer issues at all).

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

