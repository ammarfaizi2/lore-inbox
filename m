Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932133AbVLNKMV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932133AbVLNKMV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 05:12:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932268AbVLNKMV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 05:12:21 -0500
Received: from omx3-ext.sgi.com ([192.48.171.25]:32974 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S932133AbVLNKMU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 05:12:20 -0500
Date: Wed, 14 Dec 2005 02:12:18 -0800
From: Paul Jackson <pj@sgi.com>
To: "Zhang, Yanmin" <yanmin.zhang@intel.com>
Cc: linux-kernel@vger.kernel.org, venkatesh.pallipadi@intel.com
Subject: Re: [PATCH 1/2] Export cpu info by sysfs
Message-Id: <20051214021218.0dad1f70.pj@sgi.com>
In-Reply-To: <8126E4F969BA254AB43EA03C59F44E840431BB3B@pdsmsx404>
References: <8126E4F969BA254AB43EA03C59F44E840431BB3B@pdsmsx404>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some comments on your patch ...

1) It's easier for others to read patches if they are inline text,
   or at least attached as text, not as base64.  See further the
   kernel source file: Documentation/SubmittingPatches.  If your
   company's email client has difficulty attaching patches without
   mangling them, then perhaps you will have better luck with a
   dedicated patch sending program, such as one I support:
	http://www.speakeasy.org/~pj99/sgi/sendpatchset

2) > cpumask_scnprintf(buf, NR_CPUS+1, cpu_core_map[cpu]);

   The 2nd arg, "NR_CPUS+1", is wrong.  It should be the length
   of the buffer (1st arg, "buf").  Unfortunately, you probably
   aren't passed that length by sysfs.  Your routine was likely
   passed a page, so assuming a size of PAGE_SIZE/2 would work
   (big enough to print a cpumask, small enough not to allow
   buffer overrun.)

3) The patch needs to include reasonable documentation (not
   just the patch header that goes in the source control log,
   but also documentation that will into the source file and/or
   into the Documentation directory.)  Unfortunately, it seems
   that the rest of /sys/devices/system is not directly documented
   under Documentation, except as it pertains to such subjects as
   cpufreq, laptop, numastat and hotplug.  So until someone takes
   on the challenge of documenting the rest of this /sys hierarchy,
   I see no obvious place to add such items as you propose.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
