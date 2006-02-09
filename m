Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422911AbWBIRFu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422911AbWBIRFu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 12:05:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422913AbWBIRFu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 12:05:50 -0500
Received: from fmr21.intel.com ([143.183.121.13]:64197 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S1422911AbWBIRFt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 12:05:49 -0500
Date: Thu, 9 Feb 2006 09:03:21 -0800
From: Ashok Raj <ashok.raj@intel.com>
To: Nathan Lynch <ntl@pobox.com>
Cc: Andrew Morton <akpm@osdl.org>, Eric Dumazet <dada1@cosmosbay.com>,
       riel@redhat.com, linux-kernel@vger.kernel.org, torvalds@osdl.org,
       mingo@elte.hu, ak@muc.de, 76306.1226@compuserve.com, wli@holomorphy.com,
       heiko.carstens@de.ibm.com, Paul Jackson <pj@sgi.com>
Subject: Re: [PATCH] percpu data: only iterate over possible CPUs
Message-ID: <20060209090321.A9380@unix-os.sc.intel.com>
References: <20060209160808.GL18730@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20060209160808.GL18730@localhost.localdomain>; from ntl@pobox.com on Thu, Feb 09, 2006 at 08:08:09AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 09, 2006 at 08:08:09AM -0800, Nathan Lynch wrote:
> 
>    powerpc/ppc64, for instance, determines the number of possible cpus
>    from information exported by firmware (and I'm mystified as to why
>    other platforms don't do this).  So it's typical to have a kernel an a
>    pSeries partition with NR_CPUS=128, but cpu_possible_map = 0xff.
> 

Iam assuming in the above ase, cpu_possible_map == cpu_present_map and both
dont change after the OS is booted. v.s in platforms capable of hot-plug
cpus present could grow up to cpu_possible_map (max) when a new cpu is
newly added, that wasnt even present at boot time.

The problem was with ACPI just simply looking at the namespace doesnt
exactly give us an idea of how many processors are possible in this platform.

The reason is we could get more added via SSDT dynamically.

on x86_64, we used the number of disabled cpus reported in MADT at boot time
as an indicator to set cpu_possible_map. So if you had 4 sockets, but just
2 populated, the BIOS would set the missing CPUS with disabled flag. We 
simply count the number of disabled CPUs and add to possible map.

Andi added documentation to cover that as well in 
Documentation/x86_64/cpu-hotplug-spec as a guideline for BIOS folks.


-- 
Cheers,
Ashok Raj
- Open Source Technology Center
