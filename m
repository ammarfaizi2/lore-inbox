Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129226AbQK3VHK>; Thu, 30 Nov 2000 16:07:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129345AbQK3VHB>; Thu, 30 Nov 2000 16:07:01 -0500
Received: from zmamail01.zma.compaq.com ([161.114.64.101]:17418 "HELO
	zmamail01.zma.compaq.com") by vger.kernel.org with SMTP
	id <S129226AbQK3VGt>; Thu, 30 Nov 2000 16:06:49 -0500
Message-ID: <3A26BA85.1060805@zk3.dec.com>
Date: Thu, 30 Nov 2000 15:37:25 -0500
From: Peter Rival <frival@zk3.dec.com>
Organization: Tru64 QMG Performance Engineering
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.16-22smp i686; en-US; m18) Gecko/20001107 Netscape6/6.0
X-Accept-Language: en
MIME-Version: 1.0
To: Phillip Ezolt <ezolt@perf.zko.dec.com>
Cc: ink@jurassic.park.msu.ru, rth@twiddle.net, axp-list@redhat.com,
        Jay.Estabrook@COMPAQ.com, linux-kernel@vger.kernel.org,
        clinux@zk3.dec.com, wcarr@perf.zko.dec.com
Subject: Re: Alpha SCSI error on 2.4.0-test11
In-Reply-To: <Pine.OSF.3.96.1001130145721.15171B-100000@perf.zko.dec.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Phil,

Phillip Ezolt wrote:

> Hi All,
> 
> Qlogic SCSI support seems broken on 2.4.0-test11 on a Miata (Digital Personal WorkStation 600au).
> 
> When starting up, we get a machine check after initialing the qlogic SCSI code. 
> 
> Using the Alpha kgdb, we figured out that the code is dying in scsi_wait_request().

Wow, I'm impressed!  I didn't realize that kgdb worked on Alpha...Were 
you using the remote kgdb?  (You can answer me offline to save 
bandwidth.)  This would be a _huge_ help in trying to figure out why my 
Wildfire^WGS160 is crashing with the DISCONTIGMEM code that I stole from 
Jay and have been hacking on.

Speaking of that system, it has two QLogic adapters in it (both 1040Bs, 
like the Miata), and they are working just fine under 2.4.0-test11 
(obviously, without my changes ;).  It looks like it's probably the 
platform code that's busted.  I can't remember...are those Pyxis or 
CIA?  Anyway, could this have something to do with the PCI & PCI bridge 
work that Richard and Ivan just submitted?

- Pete

> 
> Here's the backtrace: 
> 
> scsi_wait_req (SRpnt=0xfffffc0001f9b480, cmnd=0xfffffc890000a078, 
>     buffer=0x100, bufflen=2, timeout=17891584, retries=6144)
>     at /usr/src/linux/include/asm/atomic.h:85
> (gdb) where
> #0  scsi_wait_req (SRpnt=0xfffffc0001f9b480, cmnd=0xfffffc890000a078, 
>     buffer=0x100, bufflen=2, timeout=17891584, retries=6144)
>     at /usr/src/linux/include/asm/atomic.h:85
> #1  0xfffffc00004107f0 in scan_scsis_single (channel=0, dev=41080, lun=0, 
>     max_dev_lun=0xfffffc00001efa30, sparse_lun=0xfffffc00001efa34, 
>     SDpnt2=0xfffffc00001efa38, shpnt=0xfffffc00005ff800, 
>     scsi_result=0xfffffc00001ef930 "\001") at scsi_scan.c:516
> #2  0xfffffc0000410548 in scan_scsis (shpnt=0xfffffc00005ff800, hardcoded=1, 
>     hchannel=0, hid=0, hlun=0) at scsi_scan.c:403
> #3  0xfffffc0000404f58 in scsi_register_host (tpnt=0xfffffc000058fb80)
>     at scsi.c:1904
> #4  0xfffffc00004dac50 in init_this_scsi_driver ()
> #5  0xfffffc00004c2bec in do_initcalls ()
> #6  0xfffffc00004c2c6c in do_basic_setup ()
> #7  0xfffffc0000310078 in init (unused=0x0) at init/main.c:775
>   
> 
> Note: On the working kernels, the two controllers are 0x800 apart, but
> on the broken kernels, they are only 0x400.  Could the overlap
> cause problems? 
> 
> 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
