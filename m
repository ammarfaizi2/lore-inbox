Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262384AbTAJUee>; Fri, 10 Jan 2003 15:34:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266114AbTAJUee>; Fri, 10 Jan 2003 15:34:34 -0500
Received: from wencor.com ([12.30.196.34]:42179 "EHLO wencor.com")
	by vger.kernel.org with ESMTP id <S262384AbTAJUeb>;
	Fri, 10 Jan 2003 15:34:31 -0500
Message-ID: <3E1F3049.4080502@xmission.com>
Date: Fri, 10 Jan 2003 13:42:49 -0700
From: Chris Wood <cwood@xmission.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
CC: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.20, .text.lock.swap cpu usage? (ibm x440)
References: <3E1A12B5.4020505@xmission.com> <3E1A16C5.87EDE35A@digeo.com> <3E1DAEAC.4060904@xmission.com> <3E1DD913.2571469F@digeo.com>
In-Reply-To: <3E1DD913.2571469F@digeo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Chris Wood wrote:
> 
>>..
>>The server ran fine for 3 days, so it took a bit to get this info.
> 
> 
> Is appreciated, thanks.
>  
> 
>>Is there a list of which patches I can apply if I don't want to apply
>>the entire 2.4.20aa1?  I'm nervous about breaking other things, but may
>>give it a try anyway.
> 
> 
> http://www.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.20aa1/05_vm_16_active_free_zone_bhs-1
> http://www.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.20aa1/10_inode-highmem-2
> 
> The former is the most important and, alas, has dependencies on
> earlier patches.
> 
> hm, OK.  I've pulled all Andrea's VM changes and the inode-highmem fix
> into a standalone diff.  I'll beat on that a bit tonight before unleashing
> it.
> 

I tried to apply 2.4.20aa1 to my /usr/src/linux and then compile it, but 
it failed to compile.  I do have the IBM x440 (NUMA) patches applied to 
this tree, I don't know if that caused any problems but I didn't see any 
when I applied the patch.  I'll attach a snip at the end of this email 
just in case it may point to something (there was more than this).

> 
>>Thanks for the help!
>>
>>Here is a /proc/meminfo when it is running fine:
> 
> 
> These numbers are a little odd.  You seem to have only lost 200M of
> lowmem to buffer_heads.  Bill, what's your take on this?
> 
> Maybe we're looking at the wrong thing.  Are any of your applications
> using mlock(), mlockall(), etc?

I'm not sure, other than our services our main programs are in Cobol 
(iCobol and AcuCobol).  I could ask the vendors if that would help.


------- sorry if this is an ugly paste -------

/usr/src/linux-2.4.20/include/asm/pgalloc.h: In function `get_pgd_slow':
/usr/src/linux-2.4.20/include/asm/pgalloc.h:49: `PAGE_OFFSET_RAW' 
undeclared (fi
rst use in this function)
/usr/src/linux-2.4.20/include/asm/pgalloc.h:54: warning: implicit 
declaration of
  function `set_64bit'
/usr/src/linux-2.4.20/include/asm/pgalloc.h: In function `free_pgd_slow':
/usr/src/linux-2.4.20/include/asm/pgalloc.h:110: `PAGE_OFFSET_RAW' 
undeclared (f
irst use in this function)
In file included from /usr/src/linux-2.4.20/include/linux/blkdev.h:11,
                  from /usr/src/linux-2.4.20/include/linux/blk.h:4,
                  from init/main.c:25:
/usr/src/linux-2.4.20/include/asm/io.h: In function `virt_to_phys':
/usr/src/linux-2.4.20/include/asm/io.h:78: `PAGE_OFFSET_RAW' undeclared 
(first u
se in this function)
/usr/src/linux-2.4.20/include/asm/io.h:79: warning: control reaches end 
of non-v
oid function
/usr/src/linux-2.4.20/include/asm/io.h: In function `phys_to_virt':
/usr/src/linux-2.4.20/include/asm/io.h:96: `PAGE_OFFSET_RAW' undeclared 
(first u
se in this function)
/usr/src/linux-2.4.20/include/asm/io.h:97: warning: control reaches end 
of non-v
oid function
/usr/src/linux-2.4.20/include/asm/io.h: In function `isa_check_signature':
/usr/src/linux-2.4.20/include/asm/io.h:280: `PAGE_OFFSET_RAW' undeclared 
(first
use in this function)
init/main.c: In function `start_kernel':
init/main.c:381: `PAGE_OFFSET_RAW' undeclared (first use in this function)
make: *** [init/main.o] Error 1
In file included from eni.c:9:
/usr/src/linux-2.4.20/include/linux/mm.h: In function `pmd_alloc':
/usr/src/linux-2.4.20/include/linux/mm.h:521: `PAGE_OFFSET_RAW' 
undeclared (firs
t use in this function)
/usr/src/linux-2.4.20/include/linux/mm.h:521: (Each undeclared 
identifier is rep
orted only once
/usr/src/linux-2.4.20/include/linux/mm.h:521: for each function it 
appears in.)
/usr/src/linux-2.4.20/include/linux/mm.h:522: warning: control reaches 
end of no
n-void function
In file included from /usr/src/linux-2.4.20/include/linux/highmem.h:5,
                  from /usr/src/linux-2.4.20/include/linux/vmalloc.h:8,
                  from /usr/src/linux-2.4.20/include/asm/io.h:47,
                  from /usr/src/linux-2.4.20/include/asm/pci.h:35,
                  from /usr/src/linux-2.4.20/include/linux/pci.h:622,
                  from eni.c:10:
/usr/src/linux-2.4.20/include/asm/pgalloc.h: In function `get_pgd_slow':
/usr/src/linux-2.4.20/include/asm/pgalloc.h:49: `PAGE_OFFSET_RAW' 
undeclared (fi
rst use in this function)
/usr/src/linux-2.4.20/include/asm/pgalloc.h:54: warning: implicit 
declaration of
  function `set_64bit'
/usr/src/linux-2.4.20/include/asm/pgalloc.h: In function `free_pgd_slow':
/usr/src/linux-2.4.20/include/asm/pgalloc.h:110: `PAGE_OFFSET_RAW' 
undeclared (f
irst use in this function)
In file included from /usr/src/linux-2.4.20/include/asm/pci.h:35,
                  from /usr/src/linux-2.4.20/include/linux/pci.h:622,
                  from eni.c:10:
/usr/src/linux-2.4.20/include/asm/io.h: In function `virt_to_phys':
/usr/src/linux-2.4.20/include/asm/io.h:78: `PAGE_OFFSET_RAW' undeclared 
(first u
se in this function)
/usr/src/linux-2.4.20/include/asm/io.h:79: warning: control reaches end 
of non-v
oid function
/usr/src/linux-2.4.20/include/asm/io.h: In function `phys_to_virt':
/usr/src/linux-2.4.20/include/asm/io.h:96: `PAGE_OFFSET_RAW' undeclared 
(first u
se in this function)
/usr/src/linux-2.4.20/include/asm/io.h:97: warning: control reaches end 
of non-v
oid function
/usr/src/linux-2.4.20/include/asm/io.h: In function `isa_check_signature':
/usr/src/linux-2.4.20/include/asm/io.h:280: `PAGE_OFFSET_RAW' undeclared 
(first
use in this function)
make[2]: *** [eni.o] Error 1
make[1]: *** [_modsubdir_atm] Error 2
make: *** [_mod_drivers] Error 2



