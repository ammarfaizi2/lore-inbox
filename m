Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277255AbRJDWWH>; Thu, 4 Oct 2001 18:22:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277256AbRJDWV5>; Thu, 4 Oct 2001 18:21:57 -0400
Received: from mail.spylog.com ([194.67.35.220]:21707 "HELO mail.spylog.com")
	by vger.kernel.org with SMTP id <S277255AbRJDWVu>;
	Thu, 4 Oct 2001 18:21:50 -0400
Date: Fri, 5 Oct 2001 02:22:13 +0400
From: Andrey Nekrasov <andy@spylog.ru>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.11-pre2-xfs
Message-ID: <20011005022213.A8501@spylog.ru>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <andy@spylog.ru> <20011004141513.A5421@spylog.ru> <200110041401.f94E1an22571@jen.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <200110041401.f94E1an22571@jen.americas.sgi.com>
User-Agent: Mutt/1.3.22i
Organization: SpyLOG ltd.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Steve Lord,

> >  2. kernel 2.4.11-pre2-xfs, with highmem support
> >  3. create ramdisk 512Mb and run "tiotest -c -f 110"
> 
> And what type of filesystems were used? I am presuming XFS.

ext2 & xfs , but whis test with ext2

> >  4. 
> >  __alloc_pages: 0-order allocation failed (gfp=0x3d0/0) from c0127fe9
> >  __alloc_pages: 0-order allocation failed (gfp=0x2f0/0) from c0127fe9
> >  __alloc_pages: 0-order allocation failed (gfp=0x70/0) from c0127fe9
> >  __alloc_pages: 0-order allocation failed (gfp=0x2f0/0) from c0127fe9
> >  __alloc_pages: 0-order allocation failed (gfp=0x70/0) from c0127fe9
 
> Can you map that address onto a symbol by any chance?

#/ksymoops-2.4.3/ksymoops -A c0127fe9 -m /boot/System.map
...

Adhoc c0127fe8 <_alloc_pages+18/20>

6.

...
swap_dup: Bad swap file entry 3f41e02c
VM: killing process forwarderng
swap_free: Bad swap offset entry 3ce50000
swap_free: Bad swap file entry 3f41e02c
swap_free: Bad swap offset entry 38bb5000
...

What is it? Kernel or may be my hardware problem?



7. Interesting result (xfs speed):

buran:~ # cat ram_disk_ext2 
buran:/ramdisk0/tiobench-0.3.1 # while (true) do ./tiotest -c -f 110 ;
sleep
60; done
Tiotest results for 4 concurrent io threads:

,----------------------------------------------------------------------.
| Item                  | Time     | Rate         | Usr CPU | Sys CPU  |
+-----------------------+----------+--------------+----------+---------+
| Write         440 MBs |   17.9 s |  24.646 MB/s |   0.7 %  |  60.8 % |
| Random Write   16 MBs |    0.5 s |  28.593 MB/s |   1.8 %  |  60.4 % |
| Read          440 MBs |   14.1 s |  31.167 MB/s |  28.3 %  |  43.6 % |
| Random Read    16 MBs |    0.5 s |  33.751 MB/s |  30.2 %  |  51.8 % |
----------------------------------------------------------------------'

buran:~ # cat ram_disk_xfs  
buran:/ramdisk0/tiobench-0.3.1 # while (true) do ./tiotest -c -f 110 ;
sleep
60; done
Tiotest results for 4 concurrent io threads:

,----------------------------------------------------------------------.
| Item                  | Time     | Rate         | Usr CPU | Sys CPU  |
+-----------------------+----------+--------------+----------+---------+
| Write         440 MBs |    7.9 s |  55.974 MB/s |   1.8 %  |  71.4 % |
| Random Write   16 MBs |    0.3 s |  45.764 MB/s |   0.0 %  |  55.6 % |
| Read          440 MBs |   11.1 s |  39.529 MB/s |  38.0 %  |  34.3 % |
| Random Read    16 MBs |    0.5 s |  32.868 MB/s |  27.3 %  |  42.1 % |
----------------------------------------------------------------------'






-- 
bye.
Andrey Nekrasov, SpyLOG.
