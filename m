Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319357AbSILX7Y>; Thu, 12 Sep 2002 19:59:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319365AbSILX7Y>; Thu, 12 Sep 2002 19:59:24 -0400
Received: from host.greatconnect.com ([209.239.40.135]:2833 "EHLO
	host.greatconnect.com") by vger.kernel.org with ESMTP
	id <S319357AbSILX7W>; Thu, 12 Sep 2002 19:59:22 -0400
Message-ID: <3D812BEB.3040903@rackable.com>
Date: Thu, 12 Sep 2002 17:06:03 -0700
From: Samuel Flory <sflory@rackable.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Stephen Lord <lord@sgi.com>
CC: Andrea Arcangeli <andrea@suse.de>, Austin Gonyou <austin@coremetrics.com>,
       Christian Guggenberger 
	<christian.guggenberger@physik.uni-regensburg.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>, linux-xfs@oss.sgi.com
Subject: Re: 2.4.20pre5aa2
References: <20020911201602.A13655@pc9391.uni-regensburg.de>	<1031768655.24629.23.camel@UberGeek.coremetrics.com>	<20020911184111.GY17868@dualathlon.random>  <3D81235B.6080809@rackable.com> <1031874330.1236.3.camel@snafu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Line 578 is BUG(); below:
mapit:
        pb->pb_flags |= _PBF_MEM_ALLOCATED;
        if (all_mapped) {
                pb->pb_flags |= _PBF_ALL_PAGES_MAPPED;

                /* A single page buffer is always mappable */
                if (page_count == 1) {
                        pb->pb_addr = (caddr_t)
                                page_address(pb->pb_pages[0]) + 
pb->pb_offset;
                        pb->pb_flags |= PBF_MAPPED;
                } else if (flags & PBF_MAPPED) {
                        if (as_list_len > 64)
                                purge_addresses();
                        pb->pb_addr = vmap(pb->pb_pages, page_count);
                        if (!pb->pb_addr)
                                BUG();
                        pb->pb_addr += pb->pb_offset;
                        pb->pb_flags |= PBF_MAPPED | _PBF_ADDR_ALLOCATED;
                }
        }
        /* If some pages were found with data in them
         * we are not in PBF_NONE state.
         */
        if (good_pages != 0) {
                pb->pb_flags &= ~(PBF_NONE);
                if (good_pages != page_count) {
                        pb->pb_flags |= PBF_PARTIAL;
                }
        }

        PB_TRACE(pb, PB_TRACE_REC(look_pg), good_pages);

        return rval;
}


Stephen Lord wrote:

>On Thu, 2002-09-12 at 18:29, Samuel Flory wrote:
>  
>
>>  Your patch seem to solve only some  of the xfs issues for me.  Before 
>>the patch my system hung when booting.  This only occured I  had xfs 
>>compiled into the kernel.   After patching  things seemed fine, but 
>>durning "dbench 32" the system locked.  Upon rebooting and attempting to 
>>mount the filesystem I got this:
>>XFS mounting filesystem md(9,2)
>>Starting XFS recovery on filesystem: md(9,2) (dev: 9/2)
>>kernel BUG at page_buf.c:578!
>><and so on>
>>
>>    
>>
>
>Line numbers in no way line up with the code I have in front of me,
>However, this appears to equate to a failure in the address space
>remapping code. This is not a failure I have ever seen in our code
>base.
>
>Steve
>
>
>  
>


