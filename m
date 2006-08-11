Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964776AbWHKU3y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964776AbWHKU3y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 16:29:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932393AbWHKU3y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 16:29:54 -0400
Received: from rtr.ca ([64.26.128.89]:30921 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S932421AbWHKU3x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 16:29:53 -0400
Message-ID: <44DCE8BA.2070601@rtr.ca>
Date: Fri, 11 Aug 2006 16:29:46 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>
Cc: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: cpufreq stops working after a while
References: <EB12A50964762B4D8111D55B764A84546F8EC3@scsmsx413.amr.corp.intel.com>
In-Reply-To: <EB12A50964762B4D8111D55B764A84546F8EC3@scsmsx413.amr.corp.intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pallipadi, Venkatesh wrote:
>> Dave Jones wrote:
>>> boot with cpufreq.debug=7, and capture dmesg output after it fails
>>> to transition.  This might be another manifestation of the mysterious
>>> "highest frequency isnt accessable" bug, that seems to come from
>>> some recent change in acpi.
..
> You also need to configure in CONFIG_CPU_FREQ_DEBUG

Thanks, Venki!

Okay, here's the tail end of the trace, in which (search for "max")
one can see the top frequency limit being downgraded.

But, by whom, and why ??
And what's with these requests for oddball frequencies ("685714"),
or is that just normal approximation within the governor?


[  847.588000] speedstep-centrino: no change needed - msr was and needs to be b0c
[  847.988000] cpufreq-core: target for CPU 0: 707142 kHz, relation 0
[  847.988000] freq-table: request for target 707142 kHz (relation: 0) for cpu 0
[  847.988000] freq-table: target is 1 (800000 kHz, 2057)
[  847.988000] speedstep-centrino: target=707142kHz old=1100000 new=800000 msr=0809
[  847.988000] cpufreq-core: notification 0 of frequency transition to 800000 kHz
[  847.988000] userspace: saving cpu_cur_freq of cpu 0 to be 800000 kHz
[  847.988000] cpufreq-core: notification 1 of frequency transition to 800000 kHz
[  847.988000] cpufreq-core: scaling loops_per_jiffy to 3195840 for frequency 800000 kHz
[  847.988000] userspace: saving cpu_cur_freq of cpu 0 to be 800000 kHz
[  848.068000] cpufreq-core: target for CPU 0: 57142 kHz, relation 0
[  848.068000] freq-table: request for target 57142 kHz (relation: 0) for cpu 0
[  848.068000] freq-table: target is 2 (600000 kHz, 1543)
[  848.068000] speedstep-centrino: target=57142kHz old=800000 new=600000 msr=0607
[  848.068000] cpufreq-core: notification 0 of frequency transition to 600000 kHz
[  848.068000] userspace: saving cpu_cur_freq of cpu 0 to be 600000 kHz
[  848.068000] cpufreq-core: notification 1 of frequency transition to 600000 kHz
[  848.068000] cpufreq-core: scaling loops_per_jiffy to 2396880 for frequency 600000 kHz
[  848.068000] userspace: saving cpu_cur_freq of cpu 0 to be 600000 kHz
[  848.148000] cpufreq-core: target for CPU 0: 1100000 kHz, relation 1
[  848.148000] freq-table: request for target 1100000 kHz (relation: 1) for cpu 0
[  848.148000] freq-table: target is 0 (1100000 kHz, 2828)
[  848.148000] speedstep-centrino: target=1100000kHz old=600000 new=1100000 msr=0b0c
[  848.148000] cpufreq-core: notification 0 of frequency transition to 1100000 kHz
[  848.148000] userspace: saving cpu_cur_freq of cpu 0 to be 1100000 kHz
[  848.148000] cpufreq-core: scaling loops_per_jiffy to 4394280 for frequency 1100000 kHz
[  848.148000] cpufreq-core: notification 1 of frequency transition to 1100000 kHz
[  848.148000] userspace: saving cpu_cur_freq of cpu 0 to be 1100000 kHz
[  848.308000] cpufreq-core: target for CPU 0: 785714 kHz, relation 0
[  848.308000] freq-table: request for target 785714 kHz (relation: 0) for cpu 0
[  848.308000] freq-table: target is 1 (800000 kHz, 2057)
[  848.308000] speedstep-centrino: target=785714kHz old=1100000 new=800000 msr=0809
[  848.308000] cpufreq-core: notification 0 of frequency transition to 800000 kHz
[  848.308000] userspace: saving cpu_cur_freq of cpu 0 to be 800000 kHz
[  848.308000] cpufreq-core: notification 1 of frequency transition to 800000 kHz
[  848.308000] cpufreq-core: scaling loops_per_jiffy to 3195840 for frequency 800000 kHz
[  848.308000] userspace: saving cpu_cur_freq of cpu 0 to be 800000 kHz
[  848.388000] cpufreq-core: target for CPU 0: 342857 kHz, relation 0
[  848.388000] freq-table: request for target 342857 kHz (relation: 0) for cpu 0
[  848.388000] freq-table: target is 2 (600000 kHz, 1543)
[  848.388000] speedstep-centrino: target=342857kHz old=800000 new=600000 msr=0607
[  848.388000] cpufreq-core: notification 0 of frequency transition to 600000 kHz
[  848.388000] userspace: saving cpu_cur_freq of cpu 0 to be 600000 kHz
[  848.388000] cpufreq-core: notification 1 of frequency transition to 600000 kHz
[  848.388000] cpufreq-core: scaling loops_per_jiffy to 2396880 for frequency 600000 kHz
[  848.388000] userspace: saving cpu_cur_freq of cpu 0 to be 600000 kHz
[  848.548000] cpufreq-core: target for CPU 0: 1100000 kHz, relation 1
[  848.548000] freq-table: request for target 1100000 kHz (relation: 1) for cpu 0
[  848.548000] freq-table: target is 0 (1100000 kHz, 2828)
[  848.548000] speedstep-centrino: target=1100000kHz old=600000 new=1100000 msr=0b0c
[  848.548000] cpufreq-core: notification 0 of frequency transition to 1100000 kHz
[  848.548000] userspace: saving cpu_cur_freq of cpu 0 to be 1100000 kHz
[  848.548000] cpufreq-core: scaling loops_per_jiffy to 4394280 for frequency 1100000 kHz
[  848.548000] cpufreq-core: notification 1 of frequency transition to 1100000 kHz
[  848.548000] userspace: saving cpu_cur_freq of cpu 0 to be 1100000 kHz
[  848.788000] cpufreq-core: target for CPU 0: 157142 kHz, relation 0
[  848.788000] freq-table: request for target 157142 kHz (relation: 0) for cpu 0
[  848.788000] freq-table: target is 2 (600000 kHz, 1543)
[  848.788000] speedstep-centrino: target=157142kHz old=1100000 new=600000 msr=0607
[  848.788000] cpufreq-core: notification 0 of frequency transition to 600000 kHz
[  848.788000] userspace: saving cpu_cur_freq of cpu 0 to be 600000 kHz
[  848.788000] cpufreq-core: notification 1 of frequency transition to 600000 kHz
[  848.788000] cpufreq-core: scaling loops_per_jiffy to 2396880 for frequency 600000 kHz
[  848.788000] userspace: saving cpu_cur_freq of cpu 0 to be 600000 kHz
[  848.868000] cpufreq-core: target for CPU 0: 1100000 kHz, relation 1
[  848.868000] freq-table: request for target 1100000 kHz (relation: 1) for cpu 0
[  848.868000] freq-table: target is 0 (1100000 kHz, 2828)
[  848.868000] speedstep-centrino: target=1100000kHz old=600000 new=1100000 msr=0b0c
[  848.868000] cpufreq-core: notification 0 of frequency transition to 1100000 kHz
[  848.868000] userspace: saving cpu_cur_freq of cpu 0 to be 1100000 kHz
[  848.868000] cpufreq-core: scaling loops_per_jiffy to 4394280 for frequency 1100000 kHz
[  848.868000] cpufreq-core: notification 1 of frequency transition to 1100000 kHz
[  848.868000] userspace: saving cpu_cur_freq of cpu 0 to be 1100000 kHz
[  849.188000] cpufreq-core: target for CPU 0: 550000 kHz, relation 0
[  849.188000] freq-table: request for target 550000 kHz (relation: 0) for cpu 0
[  849.188000] freq-table: target is 2 (600000 kHz, 1543)
[  849.188000] speedstep-centrino: target=550000kHz old=1100000 new=600000 msr=0607
[  849.188000] cpufreq-core: notification 0 of frequency transition to 600000 kHz
[  849.188000] userspace: saving cpu_cur_freq of cpu 0 to be 600000 kHz
[  849.188000] cpufreq-core: notification 1 of frequency transition to 600000 kHz
[  849.188000] cpufreq-core: scaling loops_per_jiffy to 2396880 for frequency 600000 kHz
[  849.188000] userspace: saving cpu_cur_freq of cpu 0 to be 600000 kHz
[  849.348000] cpufreq-core: target for CPU 0: 1100000 kHz, relation 1
[  849.348000] freq-table: request for target 1100000 kHz (relation: 1) for cpu 0
[  849.348000] freq-table: target is 0 (1100000 kHz, 2828)
[  849.348000] speedstep-centrino: target=1100000kHz old=600000 new=1100000 msr=0b0c
[  849.348000] cpufreq-core: notification 0 of frequency transition to 1100000 kHz
[  849.348000] userspace: saving cpu_cur_freq of cpu 0 to be 1100000 kHz
[  849.348000] cpufreq-core: scaling loops_per_jiffy to 4394280 for frequency 1100000 kHz
[  849.348000] cpufreq-core: notification 1 of frequency transition to 1100000 kHz
[  849.348000] userspace: saving cpu_cur_freq of cpu 0 to be 1100000 kHz
[  852.148000] cpufreq-core: target for CPU 0: 707142 kHz, relation 0
[  852.148000] freq-table: request for target 707142 kHz (relation: 0) for cpu 0
[  852.148000] freq-table: target is 1 (800000 kHz, 2057)
[  852.148000] speedstep-centrino: target=707142kHz old=1100000 new=800000 msr=0809
[  852.148000] cpufreq-core: notification 0 of frequency transition to 800000 kHz
[  852.148000] userspace: saving cpu_cur_freq of cpu 0 to be 800000 kHz
[  852.148000] cpufreq-core: notification 1 of frequency transition to 800000 kHz
[  852.148000] cpufreq-core: scaling loops_per_jiffy to 3195840 for frequency 800000 kHz
[  852.148000] userspace: saving cpu_cur_freq of cpu 0 to be 800000 kHz
[  852.228000] cpufreq-core: target for CPU 0: 57142 kHz, relation 0
[  852.228000] freq-table: request for target 57142 kHz (relation: 0) for cpu 0
[  852.228000] freq-table: target is 2 (600000 kHz, 1543)
[  852.228000] speedstep-centrino: target=57142kHz old=800000 new=600000 msr=0607
[  852.228000] cpufreq-core: notification 0 of frequency transition to 600000 kHz
[  852.228000] userspace: saving cpu_cur_freq of cpu 0 to be 600000 kHz
[  852.228000] cpufreq-core: notification 1 of frequency transition to 600000 kHz
[  852.228000] cpufreq-core: scaling loops_per_jiffy to 2396880 for frequency 600000 kHz
[  852.228000] userspace: saving cpu_cur_freq of cpu 0 to be 600000 kHz
[  852.468000] cpufreq-core: target for CPU 0: 1100000 kHz, relation 1
[  852.468000] freq-table: request for target 1100000 kHz (relation: 1) for cpu 0
[  852.468000] freq-table: target is 0 (1100000 kHz, 2828)
[  852.468000] speedstep-centrino: target=1100000kHz old=600000 new=1100000 msr=0b0c
[  852.468000] cpufreq-core: notification 0 of frequency transition to 1100000 kHz
[  852.468000] userspace: saving cpu_cur_freq of cpu 0 to be 1100000 kHz
[  852.468000] cpufreq-core: scaling loops_per_jiffy to 4394280 for frequency 1100000 kHz
[  852.468000] cpufreq-core: notification 1 of frequency transition to 1100000 kHz
[  852.468000] userspace: saving cpu_cur_freq of cpu 0 to be 1100000 kHz
[  853.228000] cpufreq-core: updating policy for CPU 0
[  853.228000] cpufreq-core: Warning: CPU frequency out of sync: cpufreq and timing core thinks of 1100000, is 800000 kHz.
[  853.228000] cpufreq-core: notification 0 of frequency transition to 800000 kHz
[  853.228000] userspace: saving cpu_cur_freq of cpu 0 to be 800000 kHz
[  853.228000] cpufreq-core: notification 1 of frequency transition to 800000 kHz
[  853.228000] cpufreq-core: scaling loops_per_jiffy to 3195840 for frequency 800000 kHz
[  853.228000] userspace: saving cpu_cur_freq of cpu 0 to be 800000 kHz
[  853.228000] cpufreq-core: setting new policy for CPU 0: 600000 - 1100000 kHz
[  853.228000] freq-table: request for verification of policy (600000 - 1100000 kHz) for cpu 0
[  853.228000] freq-table: verification lead to (600000 - 1100000 kHz) for cpu 0
[  853.228000] freq-table: request for verification of policy (600000 - 800000 kHz) for cpu 0
[  853.228000] freq-table: verification lead to (600000 - 800000 kHz) for cpu 0
[  853.228000] cpufreq-core: new min and max freqs are 600000 - 800000 kHz
[  853.228000] cpufreq-core: governor: change or update limits
[  853.228000] cpufreq-core: __cpufreq_governor for CPU 0, event 3
[  854.308000] cpufreq-core: target for CPU 0: 685714 kHz, relation 0
[  854.308000] freq-table: request for target 685714 kHz (relation: 0) for cpu 0
[  854.308000] freq-table: target is 1 (800000 kHz, 2057)
[  854.308000] speedstep-centrino: no change needed - msr was and needs to be 809
[  854.388000] cpufreq-core: target for CPU 0: 342857 kHz, relation 0
[  854.388000] freq-table: request for target 342857 kHz (relation: 0) for cpu 0
[  854.388000] freq-table: target is 2 (600000 kHz, 1543)
[  854.388000] speedstep-centrino: target=342857kHz old=800000 new=600000 msr=0607
[  854.388000] cpufreq-core: notification 0 of frequency transition to 600000 kHz
[  854.388000] userspace: saving cpu_cur_freq of cpu 0 to be 600000 kHz
[  854.388000] cpufreq-core: notification 1 of frequency transition to 600000 kHz
[  854.388000] cpufreq-core: scaling loops_per_jiffy to 2396880 for frequency 600000 kHz
[  854.388000] userspace: saving cpu_cur_freq of cpu 0 to be 600000 kHz
[  854.548000] cpufreq-core: target for CPU 0: 800000 kHz, relation 1
[  854.548000] freq-table: request for target 800000 kHz (relation: 1) for cpu 0
[  854.548000] freq-table: target is 1 (800000 kHz, 2057)
[  854.548000] speedstep-centrino: target=800000kHz old=600000 new=800000 msr=0809
[  854.548000] cpufreq-core: notification 0 of frequency transition to 800000 kHz
[  854.548000] userspace: saving cpu_cur_freq of cpu 0 to be 800000 kHz
[  854.548000] cpufreq-core: scaling loops_per_jiffy to 3195840 for frequency 800000 kHz
[  854.548000] cpufreq-core: notification 1 of frequency transition to 800000 kHz
[  854.548000] userspace: saving cpu_cur_freq of cpu 0 to be 800000 kHz
[  855.988000] cpufreq-core: target for CPU 0: 57142 kHz, relation 0
[  855.988000] freq-table: request for target 57142 kHz (relation: 0) for cpu 0
[  855.988000] freq-table: target is 2 (600000 kHz, 1543)
[  855.988000] speedstep-centrino: target=57142kHz old=800000 new=600000 msr=0607
[  855.988000] cpufreq-core: notification 0 of frequency transition to 600000 kHz
[  855.988000] userspace: saving cpu_cur_freq of cpu 0 to be 600000 kHz
[  855.988000] cpufreq-core: notification 1 of frequency transition to 600000 kHz
[  855.988000] cpufreq-core: scaling loops_per_jiffy to 2396880 for frequency 600000 kHz
[  855.988000] userspace: saving cpu_cur_freq of cpu 0 to be 600000 kHz
[  856.228000] cpufreq-core: target for CPU 0: 800000 kHz, relation 1
[  856.228000] freq-table: request for target 800000 kHz (relation: 1) for cpu 0
[  856.228000] freq-table: target is 1 (800000 kHz, 2057)
[  856.228000] speedstep-centrino: target=800000kHz old=600000 new=800000 msr=0809
[  856.228000] cpufreq-core: notification 0 of frequency transition to 800000 kHz
[  856.228000] userspace: saving cpu_cur_freq of cpu 0 to be 800000 kHz
[  856.228000] cpufreq-core: scaling loops_per_jiffy to 3195840 for frequency 800000 kHz
[  856.228000] cpufreq-core: notification 1 of frequency transition to 800000 kHz
[  856.228000] userspace: saving cpu_cur_freq of cpu 0 to be 800000 kHz
[  856.628000] cpufreq-core: target for CPU 0: 285714 kHz, relation 0
[  856.628000] freq-table: request for target 285714 kHz (relation: 0) for cpu 0
[  856.628000] freq-table: target is 2 (600000 kHz, 1543)
[  856.628000] speedstep-centrino: target=285714kHz old=800000 new=600000 msr=0607
[  856.628000] cpufreq-core: notification 0 of frequency transition to 600000 kHz
[  856.628000] userspace: saving cpu_cur_freq of cpu 0 to be 600000 kHz
[  856.628000] cpufreq-core: notification 1 of frequency transition to 600000 kHz
[  856.628000] cpufreq-core: scaling loops_per_jiffy to 2396880 for frequency 600000 kHz
[  856.628000] userspace: saving cpu_cur_freq of cpu 0 to be 600000 kHz
[  856.788000] cpufreq-core: target for CPU 0: 800000 kHz, relation 1
[  856.788000] freq-table: request for target 800000 kHz (relation: 1) for cpu 0
[  856.788000] freq-table: target is 1 (800000 kHz, 2057)
[  856.788000] speedstep-centrino: target=800000kHz old=600000 new=800000 msr=0809
[  856.788000] cpufreq-core: notification 0 of frequency transition to 800000 kHz
[  856.788000] userspace: saving cpu_cur_freq of cpu 0 to be 800000 kHz
[  856.788000] cpufreq-core: scaling loops_per_jiffy to 3195840 for frequency 800000 kHz
[  856.788000] cpufreq-core: notification 1 of frequency transition to 800000 kHz
[  856.788000] userspace: saving cpu_cur_freq of cpu 0 to be 800000 kHz
[  857.588000] cpufreq-core: target for CPU 0: 571428 kHz, relation 0
[  857.588000] freq-table: request for target 571428 kHz (relation: 0) for cpu 0
[  857.588000] freq-table: target is 2 (600000 kHz, 1543)
[  857.588000] speedstep-centrino: target=571428kHz old=800000 new=600000 msr=0607
[  857.588000] cpufreq-core: notification 0 of frequency transition to 600000 kHz
[  857.588000] userspace: saving cpu_cur_freq of cpu 0 to be 600000 kHz
[  857.588000] cpufreq-core: notification 1 of frequency transition to 600000 kHz
[  857.588000] cpufreq-core: scaling loops_per_jiffy to 2396880 for frequency 600000 kHz
[  857.588000] userspace: saving cpu_cur_freq of cpu 0 to be 600000 kHz
[  857.668000] cpufreq-core: target for CPU 0: 800000 kHz, relation 1
[  857.668000] freq-table: request for target 800000 kHz (relation: 1) for cpu 0
[  857.668000] freq-table: target is 1 (800000 kHz, 2057)
[  857.668000] speedstep-centrino: target=800000kHz old=600000 new=800000 msr=0809
[  857.668000] cpufreq-core: notification 0 of frequency transition to 800000 kHz
[  857.668000] userspace: saving cpu_cur_freq of cpu 0 to be 800000 kHz
[  857.668000] cpufreq-core: scaling loops_per_jiffy to 3195840 for frequency 800000 kHz
[  857.668000] cpufreq-core: notification 1 of frequency transition to 800000 kHz
[  857.668000] userspace: saving cpu_cur_freq of cpu 0 to be 800000 kHz
[  861.908000] cpufreq-core: target for CPU 0: 457142 kHz, relation 0
[  861.908000] freq-table: request for target 457142 kHz (relation: 0) for cpu 0
[  861.908000] freq-table: target is 2 (600000 kHz, 1543)
[  861.908000] speedstep-centrino: target=457142kHz old=800000 new=600000 msr=0607
[  861.908000] cpufreq-core: notification 0 of frequency transition to 600000 kHz
[  861.908000] userspace: saving cpu_cur_freq of cpu 0 to be 600000 kHz
[  861.908000] cpufreq-core: notification 1 of frequency transition to 600000 kHz
[  861.908000] cpufreq-core: scaling loops_per_jiffy to 2396880 for frequency 600000 kHz
[  861.908000] userspace: saving cpu_cur_freq of cpu 0 to be 600000 kHz
[  861.988000] cpufreq-core: target for CPU 0: 800000 kHz, relation 1
[  861.988000] freq-table: request for target 800000 kHz (relation: 1) for cpu 0
[  861.988000] freq-table: target is 1 (800000 kHz, 2057)
[  861.988000] speedstep-centrino: target=800000kHz old=600000 new=800000 msr=0809
[  861.988000] cpufreq-core: notification 0 of frequency transition to 800000 kHz
[  861.988000] userspace: saving cpu_cur_freq of cpu 0 to be 800000 kHz
[  861.988000] cpufreq-core: scaling loops_per_jiffy to 3195840 for frequency 800000 kHz
[  861.988000] cpufreq-core: notification 1 of frequency transition to 800000 kHz
[  861.988000] userspace: saving cpu_cur_freq of cpu 0 to be 800000 kHz
[  865.588000] cpufreq-core: target for CPU 0: 342857 kHz, relation 0
[  865.588000] freq-table: request for target 342857 kHz (relation: 0) for cpu 0
[  865.588000] freq-table: target is 2 (600000 kHz, 1543)
[  865.588000] speedstep-centrino: target=342857kHz old=800000 new=600000 msr=0607
[  865.588000] cpufreq-core: notification 0 of frequency transition to 600000 kHz
[  865.588000] userspace: saving cpu_cur_freq of cpu 0 to be 600000 kHz
[  865.588000] cpufreq-core: notification 1 of frequency transition to 600000 kHz
[  865.588000] cpufreq-core: scaling loops_per_jiffy to 2396880 for frequency 600000 kHz
[  865.588000] userspace: saving cpu_cur_freq of cpu 0 to be 600000 kHz
[  865.668000] cpufreq-core: target for CPU 0: 800000 kHz, relation 1
[  865.668000] freq-table: request for target 800000 kHz (relation: 1) for cpu 0
[  865.668000] freq-table: target is 1 (800000 kHz, 2057)
[  865.668000] speedstep-centrino: target=800000kHz old=600000 new=800000 msr=0809
[  865.668000] cpufreq-core: notification 0 of frequency transition to 800000 kHz
[  865.668000] userspace: saving cpu_cur_freq of cpu 0 to be 800000 kHz
[  865.668000] cpufreq-core: scaling loops_per_jiffy to 3195840 for frequency 800000 kHz
[  865.668000] cpufreq-core: notification 1 of frequency transition to 800000 kHz
[  865.668000] userspace: saving cpu_cur_freq of cpu 0 to be 800000 kHz
[  865.748000] cpufreq-core: target for CPU 0: 742857 kHz, relation 0
[  865.748000] freq-table: request for target 742857 kHz (relation: 0) for cpu 0
[  865.748000] freq-table: target is 1 (800000 kHz, 2057)
[  865.748000] speedstep-centrino: no change needed - msr was and needs to be 809
[  865.828000] cpufreq-core: target for CPU 0: 285714 kHz, relation 0
[  865.828000] freq-table: request for target 285714 kHz (relation: 0) for cpu 0
[  865.828000] freq-table: target is 2 (600000 kHz, 1543)
[  865.828000] speedstep-centrino: target=285714kHz old=800000 new=600000 msr=0607
[  865.828000] cpufreq-core: notification 0 of frequency transition to 600000 kHz
[  865.828000] userspace: saving cpu_cur_freq of cpu 0 to be 600000 kHz
[  865.828000] cpufreq-core: notification 1 of frequency transition to 600000 kHz
[  865.828000] cpufreq-core: scaling loops_per_jiffy to 2396880 for frequency 600000 kHz
[  865.828000] userspace: saving cpu_cur_freq of cpu 0 to be 600000 kHz
[  865.988000] cpufreq-core: target for CPU 0: 800000 kHz, relation 1
[  865.988000] freq-table: request for target 800000 kHz (relation: 1) for cpu 0
[  865.988000] freq-table: target is 1 (800000 kHz, 2057)
[  865.988000] speedstep-centrino: target=800000kHz old=600000 new=800000 msr=0809
[  865.988000] cpufreq-core: notification 0 of frequency transition to 800000 kHz
[  865.988000] userspace: saving cpu_cur_freq of cpu 0 to be 800000 kHz
[  865.988000] cpufreq-core: scaling loops_per_jiffy to 3195840 for frequency 800000 kHz
[  865.988000] cpufreq-core: notification 1 of frequency transition to 800000 kHz
[  865.988000] userspace: saving cpu_cur_freq of cpu 0 to be 800000 kHz
[  866.948000] cpufreq-core: target for CPU 0: 742857 kHz, relation 0
[  866.948000] freq-table: request for target 742857 kHz (relation: 0) for cpu 0
[  866.948000] freq-table: target is 1 (800000 kHz, 2057)
[  866.948000] speedstep-centrino: no change needed - msr was and needs to be 809
[  871.428000] cpufreq-core: target for CPU 0: 571428 kHz, relation 0
[  871.428000] freq-table: request for target 571428 kHz (relation: 0) for cpu 0
[  871.428000] freq-table: target is 2 (600000 kHz, 1543)
[  871.428000] speedstep-centrino: target=571428kHz old=800000 new=600000 msr=0607
[  871.428000] cpufreq-core: notification 0 of frequency transition to 600000 kHz
[  871.428000] userspace: saving cpu_cur_freq of cpu 0 to be 600000 kHz
[  871.428000] cpufreq-core: notification 1 of frequency transition to 600000 kHz
[  871.428000] cpufreq-core: scaling loops_per_jiffy to 2396880 for frequency 600000 kHz
[  871.428000] userspace: saving cpu_cur_freq of cpu 0 to be 600000 kHz
[  871.668000] cpufreq-core: target for CPU 0: 800000 kHz, relation 1
[  871.668000] freq-table: request for target 800000 kHz (relation: 1) for cpu 0
[  871.668000] freq-table: target is 1 (800000 kHz, 2057)
[  871.668000] speedstep-centrino: target=800000kHz old=600000 new=800000 msr=0809
[  871.668000] cpufreq-core: notification 0 of frequency transition to 800000 kHz
[  871.668000] userspace: saving cpu_cur_freq of cpu 0 to be 800000 kHz
[  871.668000] cpufreq-core: scaling loops_per_jiffy to 3195840 for frequency 800000 kHz
[  871.668000] cpufreq-core: notification 1 of frequency transition to 800000 kHz
[  871.668000] userspace: saving cpu_cur_freq of cpu 0 to be 800000 kHz
[  874.948000] cpufreq-core: target for CPU 0: 628571 kHz, relation 0
[  874.948000] freq-table: request for target 628571 kHz (relation: 0) for cpu 0
[  874.948000] freq-table: target is 1 (800000 kHz, 2057)
[  874.948000] speedstep-centrino: no change needed - msr was and needs to be 809
silvy:~#                                                                                      
