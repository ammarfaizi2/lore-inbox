Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262247AbSI0REq>; Fri, 27 Sep 2002 13:04:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262527AbSI0REq>; Fri, 27 Sep 2002 13:04:46 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:65238 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S262247AbSI0REo>;
	Fri, 27 Sep 2002 13:04:44 -0400
Date: Fri, 27 Sep 2002 22:44:24 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Zwane Mwaikambo <zwane@linuxpower.ca>, Andrew Morton <akpm@digeo.com>,
       lkml <linux-kernel@vger.kernel.org>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: 2.5.38-mm3
Message-ID: <20020927224424.A28529@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20020927152833.D25021@in.ibm.com> <502559422.1033113869@[10.10.2.3]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <502559422.1033113869@[10.10.2.3]>; from mbligh@aracnet.com on Fri, Sep 27, 2002 at 08:04:31AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 27, 2002 at 08:04:31AM -0700, Martin J. Bligh wrote:
> >> > What application were you all running ?
> 
> Kernel compile on NUMA-Q looks like this:
> 
> 125673 total
> 82183 default_idle
> 2288 d_lookup
> 1921 vm_enough_memory
> 1883 __generic_copy_from_user
> 1566 file_read_actor
> 1381 .text.lock.file_table           <-------------

More likely, this is contention for the files_lock. Do you have any 
lockmeter data ?  That should give us more information. If so,
the files_struct_rcu isn't likely to help.

> 1168 find_get_page
> 1116 get_empty_filp
> 
> Presumably that's the same thing? Interestingly, if I look back at 
> previous results, I see it's about twice the cost in -mm as it is 
> in mainline, not sure why ... at least against 2.5.37 virgin it was.

Not sure why it shows up more in -mm, but likely because -mm has
lot less contention on other locks like dcache_lock.

> 
> > Please try running the files_struct_rcu patch where fget() is lockfree
> > and let me know what you see.
> 
> Will do ... if you tell me where it is ;-)

Oh, the usual place -
http://sourceforge.net/project/showfiles.php?group_id=8875&release_id=112473
I wish sourceforge FRS continued to allow direct links to patches.

Thanks
-- 
Dipankar Sarma  <dipankar@in.ibm.com> http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.
