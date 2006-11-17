Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933573AbWKQTQk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933573AbWKQTQk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 14:16:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933579AbWKQTQj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 14:16:39 -0500
Received: from wx-out-0506.google.com ([66.249.82.231]:45096 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S933573AbWKQTQe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 14:16:34 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Pt5ehvRQxh2iS5pkVtOlEXLYSVnVprzhzdO1KpbpcFqopU3u1LJ+kkegPsWOK5ZrS/EOMri9oRegvgjyNPHMJ7gvfnVkpIoKNbRsJK8zWA7r7hvAm6tRdF9ArJ3PktUNKCYRpnEQ9OiyuHJr6mN0eIrFEuubeZjsO3kExRczwF8=
Message-ID: <8aa016e10611171116s36501bf7h5d4a92e6d3a07ca7@mail.gmail.com>
Date: Sat, 18 Nov 2006 00:46:32 +0530
From: "Dhaval Giani" <dhaval.giani@gmail.com>
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       davej@codemonkey.org.uk
Subject: cpufreq userspace governor does not reflect changes
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey there,

I finally managed to get cpufreq working. And while using the
userspace governor, I came up with a curious output.

[root@localhost cpufreq]# cat *
0
1862000
1596000
1862000 1596000
ondemand userspace performance
1862000
acpi-cpufreq
userspace
1862000
1596000
1862000
cat: stats: Is a directory
[root@localhost cpufreq]# echo 1596000 > scaling_setspeed
[root@localhost cpufreq]# cat *
0
1862000
1596000
1862000 1596000
ondemand userspace performance
0
acpi-cpufreq
userspace
1862000
1596000
0
cat: stats: Is a directory
[root@localhost cpufreq]#

This is on a Core 2 Duo E6300 processor. The dmesg looks like this,

cpufreq-core: setting new policy for CPU 0: 1596000 - 1862000 kHz
acpi-cpufreq: acpi_cpufreq_verify
freq-table: request for verification of policy (1596000 - 1862000 kHz) for cpu 0
freq-table: verification lead to (1596000 - 1862000 kHz) for cpu 0
acpi-cpufreq: acpi_cpufreq_verify
freq-table: request for verification of policy (1596000 - 1862000 kHz) for cpu 0
freq-table: verification lead to (1596000 - 1862000 kHz) for cpu 0
cpufreq-core: new min and max freqs are 1596000 - 1862000 kHz
cpufreq-core: governor switch
cpufreq-core: __cpufreq_governor for CPU 0, event 2
cpufreq-core: __cpufreq_governor for CPU 0, event 1
userspace: managing cpu 0 started (1596000 - 1862000 kHz, currently 1862000 kHz)
cpufreq-core: governor: change or update limits
cpufreq-core: __cpufreq_governor for CPU 0, event 3
userspace: limit event for cpu 0: 1596000 - 1862000 kHz,currently
1862000 kHz, last set to 1862000 kHz
cpufreq-core: target for CPU 0: 1862000 kHz, relation 0
acpi-cpufreq: acpi_cpufreq_target 1862000 (0)
freq-table: request for target 1862000 kHz (relation: 0) for cpu 0
freq-table: target is 0 (1862000 kHz, 0)
acpi-cpufreq: Already at target state (P0)
printk: 30 messages suppressed.
userspace: cpufreq_set for cpu 0, freq 1596000 kHz
cpufreq-core: target for CPU 0: 1596000 kHz, relation 0
acpi-cpufreq: acpi_cpufreq_target 1596000 (0)
freq-table: request for target 1596000 kHz (relation: 0) for cpu 0
freq-table: target is 1 (1596000 kHz, 9)
cpufreq-core: notification 0 of frequency transition to 0 kHz
userspace: saving cpu_cur_freq of cpu 0 to be 0 kHz
cpufreq-core: notification 1 of frequency transition to 0 kHz
userspace: saving cpu_cur_freq of cpu 0 to be 0 kHz
[root@localhost cpufreq]#

How can I verify what is the processor speed I'm running at? And is
this the result expected? (Also is this how I change the frequency in
a multi-core system? Googling did not really get me anything) As a
side note, I'm also curious to know whether multi core systems support
the processors running at multiple clock speeds? (Somewhere I remember
understanding the code to add all the processors to be added to
affected_cpus map, and if any cpu in that one is affected, all of them
are. Did i understand it right?)

Thanks and regards
Dhaval Giani
