Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261852AbUCQSOm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 13:14:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261900AbUCQSOm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 13:14:42 -0500
Received: from ztxmail04.ztx.compaq.com ([161.114.1.208]:64519 "EHLO
	ztxmail04.ztx.compaq.com") by vger.kernel.org with ESMTP
	id S261852AbUCQSOe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 13:14:34 -0500
Message-ID: <405893FC.4030209@hp.com>
Date: Wed, 17 Mar 2004 13:07:56 -0500
From: Robert Picco <Robert.Picco@hp.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: davidm@hpl.hp.com
Cc: linux-kernel@vger.kernel.org, colpatch@us.ibm.com, mbligh@aracnet.com
Subject: Re: boot time node and memory limit options
References: <40573460.9090605@hp.com> <16471.48076.447058.132559@napali.hpl.hp.com>
In-Reply-To: <16471.48076.447058.132559@napali.hpl.hp.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David:

Well our IA64 "mem=" is used in efi_memmap_walk.  We could change the 
name to "max_address=".  The X86 "mem=" takes effect before the bootmem 
allocator is initialized.  My patch eliminates memory before
mem_init frees all bootmap memory.  My proposed patch doesn't have the 
same functionality as X86 "mem=".

thanks,

Bob

David Mosberger wrote:

>Hi Bob,
>
>  
>
>>>>>>On Tue, 16 Mar 2004 12:07:44 -0500, Robert Picco <Robert.Picco@hp.com> said:
>>>>>>            
>>>>>>
>
>  Bob> This patch supports three boot line options.  mem_limit limits
>  Bob> the amount of physical memory.  node_mem_limit limits the
>  Bob> amount of physical memory per node on a NUMA machine.
>  Bob> nodes_limit reduces the number of NUMA nodes to the value
>  Bob> specified.  On a NUMA machine an eliminated node's CPU(s) are
>  Bob> removed from the cpu_possible_map.
>
>  Bob> The patch has been tested on an IA64 NUMA machine and
>  Bob> uniprocessor X86 machine.
>
>Would it make sense to improve on the consistency of the "mem" option
>at the same time.  IIRC, "mem=N" on x86 means "limit amount of memory
>to N", whereas on ia64 it means "ignore memory above N".  In my
>opinion, it would make sense to change the ia64 "mem" to option to
>match the behavior on x86 and then to use "mem_limit=N" for the
>"ignore memory above N" case (which is very useful for testing
>addressing issues, such as I/O MMU issues).
>
>Thanks,
>
>	--david
>
>  
>

