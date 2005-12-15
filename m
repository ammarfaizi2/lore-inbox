Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932602AbVLOBdV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932602AbVLOBdV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 20:33:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932539AbVLOBdV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 20:33:21 -0500
Received: from fmr17.intel.com ([134.134.136.16]:11934 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S932602AbVLOBdU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 20:33:20 -0500
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="GB2312"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Subject: RE: [PATCH 1/2] Export cpu info by sysfs
Date: Thu, 15 Dec 2005 09:33:16 +0800
Message-ID: <8126E4F969BA254AB43EA03C59F44E840431C3E2@pdsmsx404>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 1/2] Export cpu info by sysfs
Thread-Index: AcYAluW1U053szAgQRavSo9pofa7lQAfjRkg
From: "Zhang, Yanmin" <yanmin.zhang@intel.com>
To: "Paul Jackson" <pj@sgi.com>
Cc: <linux-kernel@vger.kernel.org>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
X-OriginalArrivalTime: 15 Dec 2005 01:33:17.0934 (UTC) FILETIME=[868470E0:01C60117]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>-----Original Message-----
>>From: Paul Jackson [mailto:pj@sgi.com]
>>Sent: 2005Äê12ÔÂ14ÈÕ 18:12
>>To: Zhang, Yanmin
>>Cc: linux-kernel@vger.kernel.org; Pallipadi, Venkatesh
>>Subject: Re: [PATCH 1/2] Export cpu info by sysfs
>>
>>Some comments on your patch ...
I really appreciate your comments.

>>
>>1) It's easier for others to read patches if they are inline text,
>>   or at least attached as text, not as base64.  See further the
>>   kernel source file: Documentation/SubmittingPatches.  If your
>>   company's email client has difficulty attaching patches without
>>   mangling them, then perhaps you will have better luck with a
>>   dedicated patch sending program, such as one I support:
>>	http://www.speakeasy.org/~pj99/sgi/sendpatchset
Thanks. I use outlook and tried many approaches before, but patches always have unexpected line breaks when I attach them as inline text. Anyway, I found a new approach to avoid that. Next time, I will paste patches as inline.

>>
>>2) > cpumask_scnprintf(buf, NR_CPUS+1, cpu_core_map[cpu]);
>>
>>   The 2nd arg, "NR_CPUS+1", is wrong.  It should be the length
>>   of the buffer (1st arg, "buf").  Unfortunately, you probably
>>   aren't passed that length by sysfs.  Your routine was likely
>>   passed a page, so assuming a size of PAGE_SIZE/2 would work
>>   (big enough to print a cpumask, small enough not to allow
>>   buffer overrun.)
In theory, it's a problem which doesn't exist in fact. The smallest page size on IA64 is 4KB (default is 16KB) and cpumask_scnprintf uses hex format, so one page could store cpumask of (4K-1)*4 cpu. I can't imagine a machine has more than (4K-1)*4 cpu.

>>
>>3) The patch needs to include reasonable documentation (not
>>   just the patch header that goes in the source control log,
>>   but also documentation that will into the source file and/or
>>   into the Documentation directory.)  Unfortunately, it seems
>>   that the rest of /sys/devices/system is not directly documented
>>   under Documentation, except as it pertains to such subjects as
>>   cpufreq, laptop, numastat and hotplug.  So until someone takes
>>   on the challenge of documenting the rest of this /sys hierarchy,
>>   I see no obvious place to add such items as you propose.
I agree with you.

