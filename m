Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277390AbRJEOU7>; Fri, 5 Oct 2001 10:20:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277391AbRJEOUt>; Fri, 5 Oct 2001 10:20:49 -0400
Received: from rj.sgi.com ([204.94.215.100]:2739 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S277390AbRJEOUc>;
	Fri, 5 Oct 2001 10:20:32 -0400
Message-Id: <200110051420.f95EKVr12837@jen.americas.sgi.com>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.11-pre2-xfs 
In-Reply-To: Message from Andrey Nekrasov <andy@spylog.ru> 
   of "Fri, 05 Oct 2001 02:22:13 +0400." <20011005022213.A8501@spylog.ru> 
Date: Fri, 05 Oct 2001 09:20:31 -0500
From: Steve Lord <lord@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hello Steve Lord,
> 
> > >  2. kernel 2.4.11-pre2-xfs, with highmem support
> > >  3. create ramdisk 512Mb and run "tiotest -c -f 110"
> > 
> > And what type of filesystems were used? I am presuming XFS.
> 
> ext2 & xfs , but whis test with ext2

OK, in which case I doubt that the changes XFS has in the kernel will
be influencing things - except xfs filesystems elsewhere on the system
will have hold of memory, although it should be reclaimable from ext2
just fine.

> 
> > >  4. 
> > >  __alloc_pages: 0-order allocation failed (gfp=0x3d0/0) from c0127fe9
> > >  __alloc_pages: 0-order allocation failed (gfp=0x2f0/0) from c0127fe9
> > >  __alloc_pages: 0-order allocation failed (gfp=0x70/0) from c0127fe9
> > >  __alloc_pages: 0-order allocation failed (gfp=0x2f0/0) from c0127fe9
> > >  __alloc_pages: 0-order allocation failed (gfp=0x70/0) from c0127fe9
>  
> > Can you map that address onto a symbol by any chance?
> 
> #/ksymoops-2.4.3/ksymoops -A c0127fe9 -m /boot/System.map
> ...
> 
> Adhoc c0127fe8 <_alloc_pages+18/20>

Oh well, thats really useful, maybe __alloc_pages should report on its
caller's caller.

> 
> 6.
> 
> ...
> swap_dup: Bad swap file entry 3f41e02c
> VM: killing process forwarderng
> swap_free: Bad swap offset entry 3ce50000
> swap_free: Bad swap file entry 3f41e02c
> swap_free: Bad swap offset entry 38bb5000
> ...
> 
> What is it? Kernel or may be my hardware problem?


Probably kernel, but I am not really an expert on this part of the system,
is your swap a device or a file on a filesystem?

> 
> 
> 
> 7. Interesting result (xfs speed):
> 
> buran:~ # cat ram_disk_ext2 
> buran:/ramdisk0/tiobench-0.3.1 # while (true) do ./tiotest -c -f 110 ;
> sleep
> 60; done
> Tiotest results for 4 concurrent io threads:
> 
> ,----------------------------------------------------------------------.
> | Item                  | Time     | Rate         | Usr CPU | Sys CPU  |
> +-----------------------+----------+--------------+----------+---------+
> | Write         440 MBs |   17.9 s |  24.646 MB/s |   0.7 %  |  60.8 % |
> | Random Write   16 MBs |    0.5 s |  28.593 MB/s |   1.8 %  |  60.4 % |
> | Read          440 MBs |   14.1 s |  31.167 MB/s |  28.3 %  |  43.6 % |
> | Random Read    16 MBs |    0.5 s |  33.751 MB/s |  30.2 %  |  51.8 % |
> ----------------------------------------------------------------------'
> 
> buran:~ # cat ram_disk_xfs  
> buran:/ramdisk0/tiobench-0.3.1 # while (true) do ./tiotest -c -f 110 ;
> sleep
> 60; done
> Tiotest results for 4 concurrent io threads:
> 
> ,----------------------------------------------------------------------.
> | Item                  | Time     | Rate         | Usr CPU | Sys CPU  |
> +-----------------------+----------+--------------+----------+---------+
> | Write         440 MBs |    7.9 s |  55.974 MB/s |   1.8 %  |  71.4 % |
> | Random Write   16 MBs |    0.3 s |  45.764 MB/s |   0.0 %  |  55.6 % |
> | Read          440 MBs |   11.1 s |  39.529 MB/s |  38.0 %  |  34.3 % |
> | Random Read    16 MBs |    0.5 s |  32.868 MB/s |  27.3 %  |  42.1 % |
> ----------------------------------------------------------------------'
> 
> 

That's good to see,

 Thanks

    Steve

> 
> 
> 
> 
> -- 
> bye.
> Andrey Nekrasov, SpyLOG.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


