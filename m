Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933297AbWKNCGZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933297AbWKNCGZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 21:06:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933287AbWKNCGZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 21:06:25 -0500
Received: from elvis.mu.org ([192.203.228.196]:62930 "EHLO elvis.mu.org")
	by vger.kernel.org with ESMTP id S933297AbWKNCGY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 21:06:24 -0500
Message-ID: <45592497.1080109@FreeBSD.org>
Date: Mon, 13 Nov 2006 18:06:15 -0800
From: Suleiman Souhlal <ssouhlal@FreeBSD.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051204)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Linux Kernel ML <linux-kernel@vger.kernel.org>, vojtech@suse.cz,
       Jiri Bohac <jbohac@suse.cz>
Subject: Re: [PATCH 0/2] Make the TSC safe to be used by gettimeofday().
References: <455916A5.2030402@FreeBSD.org> <200611140250.57160.ak@suse.de>
In-Reply-To: <200611140250.57160.ak@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> On Tuesday 14 November 2006 02:06, Suleiman Souhlal wrote:
> 
>>I've had a proof-of-concept for this since August, and finally got around to
>>somewhat cleaning it up.
> 
> 
> Thanks. 
> 
> I got a competing implementation for this unfortunately now from Vojtech & Jiri
> 
> Yours is simpler, but I'm not sure as complete. What are your assurances
> against non monoticity for example?

I believe that the results returned will always be monotonic, as long as 
the frequency of the TSC does not change from under us (that is, without 
the kernel knowing). This is because we "synchronize" each CPU's vxtime 
with a global time source (HPET) every time we know the TSC rate changes.

>>It can certainly still be improved, namely by using vgetcpu() instead of CPUID
>>to find the cpu number (but I couldn't get it to work, when I tried).
> 
> 
> What did not work?

I was not able to make vgettimeofday use vgetcpu(). It seemed like vgetcpu()
was not returning the same value as smp_processor_id() would, so the 
values I'd get with vgettimeofday() did not completely agree with the 
ones from gettimeofday(2). I didn't have the chance to investigate more.

>>Another possible improvement would be to use RDTSCP when available.
>>There's also a small race in do_gettimeofday(), vgettimeofday() and
>>vmonotonic_clock() but I've never seen it happen.
> 
> 
> I did a vposix_getclock with monotonic clock support on my own already, was about to 
> be merged with the vDSO. It still used global synchronized TSC though.

-- Suleiman

