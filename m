Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967584AbWK2T3W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967584AbWK2T3W (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 14:29:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967588AbWK2T3W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 14:29:22 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:63971 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S967584AbWK2T3V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 14:29:21 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QkDSb7K8jPWH9VuHwafiCTdclhVIV65IiRJkSzN1TC6Sco+Q7DJLV+CsGMu4xtlmqMRS+ZYFp9D550Q3bdYCAMMZu9PIz7OXJx6s42LAYyl/cp0jkojYEAj43InqKY+g2Ny6NNG3cKnkN0e4MerV18oIAvMFcHVfyQvCs+PrCw4=
Message-ID: <63a95c50611291129q109abeb2o7e5afb7ca94a3f2c@mail.gmail.com>
Date: Wed, 29 Nov 2006 11:29:18 -0800
From: "Kunal Trivedi" <ktrivedi@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Possible Bug in VM accounting (Committed_AS) on x86_64 architecture ?
In-Reply-To: <63a95c50611291122l27c9af6fha78db3bf32fe6c1c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <63a95c50611291122l27c9af6fha78db3bf32fe6c1c@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I am running into a problem and due to limited understanding unable to
solve it...
Problem:
-------------
On 64 bit machines (running linux 2.6.xx), Committed_AS grows over the
period of time. Within 3-4 weeks system reaches a stage where further
malloc() returns -ENOMEM. Test shows that just running simple program
(which malloc, touch, free memory) cause this increase in Committed_AS
number.  (I am using vm-overcommit... Below detailed information)

System/Kernel Spec:
------------------------------
-----
CentOS kernel, 2.6.9-34.EL-x86_64_SMP
Physical: 8G
Swap: 2G
Machine type: AMD
Nothing un-usual in .config. Pretty much using standard options. (If
needed I will send .config)
Here is /proc/meminfo numbers:

MemTotal:      8169736 kB
MemFree:       1256676 kB
Buffers:        123496 kB
Cached:        5009620 kB
SwapCached:          0 kB
Active:        5297288 kB
Inactive:      1003628 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:      8169736 kB
LowFree:       1256676 kB
SwapTotal:     2096472 kB
SwapFree:      2096472 kB
Dirty:           10036 kB
Writeback:           0 kB
Mapped:        5814464 kB
Slab:           571352 kB
Committed_AS:  7125024 kB
PageTables:      12916 kB
VmallocTotal: 536870911 kB
VmallocUsed:    268300 kB
VmallocChunk: 536601679 kB
HugePages_Total:     0
HugePages_Free:      0
Hugepagesize:     2048 kB

OverCommit Options:
---------------------------------
vm.overcommit_ratio = 100
vm.overcommit_memory = 2

Hence my virtual limit is 10G (8*100/100 + 2)

Detailed Description:
-------------------------------
I have noticed that 64 bit machine with overcommit policy (as above)
starts giving problem within 3-4 weeks. To prove that I've written
small program.
 It allocates memory of different sizes (not that it matters much due
to caching of diffeent malloc. I am using standard ptmalloc). Sizes
are 16B, 32B, 64B, 256B, 1024B, 57B, 127B and so on... . Then it
touches that memory (memset) and then free it. These operations are
being performed in while(1) loop.

Observations:
----------------------
Committed_AS: number gorws 5M per hour. I made sure that nothing else
is running on the system during that time...

Is there any obvious problem reported for vm accounting on 64 bit
architecture ? Or this is expected ? Or vm-overcommit is only meant
for 32 bit architecture ?

Please advice..

Thanks in advance.
-- 

-Kunal
