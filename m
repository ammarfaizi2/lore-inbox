Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932331AbVHJWCX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932331AbVHJWCX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 18:02:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932375AbVHJWCX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 18:02:23 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:40178 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S932331AbVHJWCW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 18:02:22 -0400
Message-ID: <42FA796A.4080205@mvista.com>
Date: Wed, 10 Aug 2005 15:02:18 -0700
From: Todd Poynor <tpoynor@mvista.com>
User-Agent: Mozilla Thunderbird 1.0+ (X11/20050531)
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: linux-kernel@vger.kernel.org, linux-pm@lists.osdl.org,
       cpufreq@lists.linux.org.uk
Subject: Re: PowerOP 0/3: System power operating point management API
References: <20050809024907.GA25064@slurryseal.ddns.mvista.com> <20050810100718.GC1945@elf.ucw.cz>
In-Reply-To: <20050810100718.GC1945@elf.ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
>>Depending on the ability of the hardware to make software-controlled
>>power/performance adjustments, this may be useful to select custom
>>voltages, bus speeds, etc. in desktop/server systems.  Various embedded
>>systems have several parameters that can be set.  For example, an XScale
>>PXA27x could be considered to have six basic power parameters (mainly
>>cpu run mode and memory and bus dividers) that for the most part
>>should
> 
> 
> This scares me a bit. Is table enough to handle this? I'm afraid that
> table will get very large on systems that allow you to do "almost
> anything".

Exhaustive tables for all combinations of possible parameters aren't 
expected (or practical for many systems as you note).  In practice, a 
subset of these possible operating points are created and activated over 
the lifetime of the system, where the subset is chosen by a system 
designer according to the needs of the particular system.  It's a matter 
for the higher-layer power management software to decide whether to have 
in-kernel tables of the possible operating points (as cpufreq does for 
various platforms) or whether to require userspace to create only the 
ones wanted (as does DPM).  There are cpufreq patches for PXA27x 
somewhere, for example, and in that case a subset of the supported 
operating points (and there are still only about 16 of those even for 
such a complicated piece of hardware) are represented in the kernel 
tables, choosing one of the possible combinations of memory/bus/etc. 
parameters for each unique cpu frequency.  Thanks,

-- 
Todd
