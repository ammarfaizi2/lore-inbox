Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318059AbSGLXCT>; Fri, 12 Jul 2002 19:02:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318060AbSGLXCS>; Fri, 12 Jul 2002 19:02:18 -0400
Received: from holomorphy.com ([66.224.33.161]:46751 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S318059AbSGLXCQ>;
	Fri, 12 Jul 2002 19:02:16 -0400
Date: Fri, 12 Jul 2002 16:04:02 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, colpatch@us.ibm.com
Subject: Re: NUMA-Q breakage 2/7 xquad_portio ioremap deadlock
Message-ID: <20020712230402.GB21551@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
	linux-kernel@vger.kernel.org, colpatch@us.ibm.com
References: <20020712223942.GZ25360@holomorphy.com> <1176230000.1026514730@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1176230000.1026514730@flay>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> The cpu_online_map stuff for hotplug cpu created a brand new bootstrap
>> ordering problem for NUMA-Q. The mmapped portio region needs to be
>> ioremapped early but ioremap attempts to do TLB shootdown, and
>> smp_call_function() (called by flush_tlb_all()) deadlocks when
>> cpu_online_map is uninitialized.

On Fri, Jul 12, 2002 at 03:58:50PM -0700, Martin J. Bligh wrote:
> Would it be slightly less of a hack if we just move the ioremap down below
> set_bit(0, &cpu_online_map); later on in smp_boot_cpus ? Untested patch
> below. As long as we set up the xquad_portio remap before any other cpus 
> are online, I can't see it matters exactly when we do it ....
> Either that, or we just define cpu_online_map to be =1 to start with.
> M.

This looks better than fiddling with smp_call_function().


Cheers,
Bill
