Return-Path: <linux-kernel-owner+w=401wt.eu-S932359AbXAIStg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932359AbXAIStg (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 13:49:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932368AbXAIStg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 13:49:36 -0500
Received: from mpc-26.sohonet.co.uk ([193.203.82.251]:40331 "EHLO
	moving-picture.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932359AbXAIStf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 13:49:35 -0500
X-Greylist: delayed 3351 seconds by postgrey-1.27 at vger.kernel.org; Tue, 09 Jan 2007 13:49:35 EST
Message-ID: <45A3D6A5.6080302@moving-picture.com>
Date: Tue, 09 Jan 2007 17:53:41 +0000
From: James Pearson <james-p@moving-picture.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040524
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Understanding cpufreq?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Disclaimer: This email and any attachments are confidential, may be legally
X-Disclaimer: privileged and intended solely for the use of addressee. If you
X-Disclaimer: are not the intended recipient of this message, any disclosure,
X-Disclaimer: copying, distribution or any action taken in reliance on it is
X-Disclaimer: strictly prohibited and may be unlawful. If you have received
X-Disclaimer: this message in error, please notify the sender and delete all
X-Disclaimer: copies from your system.
X-Disclaimer: 
X-Disclaimer: Email may be susceptible to data corruption, interception and
X-Disclaimer: unauthorised amendment, and we do not accept liability for any
X-Disclaimer: such corruption, interception or amendment or the consequences
X-Disclaimer: thereof.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a number of dual CPU and dual CPU/dual core Opteron systems that 
are used as compute servers. In an effort to reduce power consumption 
and reduce heat output, I would like to make use of the PowerNow! 
capabilities to clock back the CPUs when the machines are idle.

These machines are running a 2.6.9-42 RHEL4 kernel with the powernow-k8 
module loaded - which I believe have backported cpufreq support from 
more recent mainline kernels.

In trying to achieve what I want, I've become rather confused as to how 
cpufreq in a multi-CPU environment works:

There is a directory under /sys/devices/system/cpu/cpu*/cpufreq for each 
CPU, which seems to imply that each CPU speed can be controlled 
separately - can this really be the case? Can separate CPU cores run at 
different speeds?

e.g. I can echo 4 different governor names to the scaling_governor file 
in each /sys/devices/system/cpu/cpu[0-3]/cpufreq directory on a 4 core 
machine - and the resulting scaling_cur_freq file can contain a 
different value.

However, the "cpu MHz" fields in /proc/cpuinfo are all the same for each 
each CPU - I assume the values in /proc/cpuinfo are the 'correct' values ??

Also, if I set all the governors to userspace, and then set each CPU's 
speed via scaling_setspeed to a different (allowed) value, then it 
appears quite random as to which value is then reflected in 
/proc/cpuinfo i.e. sometimes it will take the value given to CPU 0, 
other times it will be CPU 1 etc.

If I set all the governors to ondemand, the CPUs will from time to time, 
clock back their speed in situations where one or more CPUs are being 
heavily used. i.e it appears that each CPU is treated separately, and if 
one CPU is deemed to be idle enough by its given metrics, then it can 
reduce the speed of all CPUs, regardless of other CPUs being 'busy' ...

I've also tried a couple of userspace daemons (cpuspeed and powernowd) - 
again, these treat each CPU separately and will also reduce the speed of 
an 'idle' CPU - and hence reduce the speed of all the CPUs, again, 
regardless of other CPUs being 'busy'.

Essentially what I want to achieve is something like: if _any_ CPU is 
'busy' (usage over some threshold over some sampling period), then run 
at full speed and if _all_ CPUs are 'idle' (all below some threshold 
over some sampling period) then clock back the CPUs.

Is there something/some setting(s) that can do this in a multi-CPU machine?

Thanks

James Pearson
