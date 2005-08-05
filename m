Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262886AbVHEGly@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262886AbVHEGly (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 02:41:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262884AbVHEGlj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 02:41:39 -0400
Received: from smtp.osdl.org ([65.172.181.4]:53416 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262883AbVHEGki (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 02:40:38 -0400
Date: Thu, 4 Aug 2005 23:39:27 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Martin J. Bligh" <mbligh@mbligh.org>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       James Bottomley <James.Bottomley@steeleye.com>
Subject: Re: Symbios problems in recent -mm trees?
Message-Id: <20050804233927.2d3abb16.akpm@osdl.org>
In-Reply-To: <135040000.1123216397@[10.10.2.4]>
References: <135040000.1123216397@[10.10.2.4]>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <mbligh@mbligh.org> wrote:
>
> If you look on http://test.kernel.org/, you'll see in the rightmost
> column there's a yellow box under elm3b70 for 2.6.13-rc4-mm1, but
> current mainline kernels are all green (ie no problems). That means
> one test failed, in this case making an fs on the spare partition. 
> Odd. I went digging ...

Don't you know that testing stuff just creates more work?

> Looks like this got introduced between 2.6.12-mm1 and 2.6.12-mm2
> Sorry, should've caught it earlier. I'll blame OLS or something.
> This is an 8x power4 box running "bare metal" (ie not on top of
> the hypervisor).

sym2 works OK on my little test box with latest -mm lineup, and I have zero
patches which touch that driver.

James, could some of the scsi core rework have caused this?

> seems /dev/sdc1 doesn't exist.
> 07/31/05-02:44:32 processing command: (5) 'fs --partition=1 --mkext2fs --mount -l /mnt/tmp'
> n format
> PARTITION='/dev/sdc1'
> mke2fs 1.35 (28-Feb-2004)
> mkfs.ext2: No such device or address while trying to determine filesystem size
> 07/31/05-02:44:32 fs: creating filesystem ext2 Failed rc = 1
> 
> Looking back at the bootlog (http://test.kernel.org/9609/debug/console.log),
> I see it really not looking very happy (snapshot below).
> 
> Good bootlog is here for comparsion: 
> (http://test.kernel.org/9445/debug/console.log)
> 
> sym0: <1010-66> rev 0x1 at pci 0001:01:01.0 irq 115
> sym0: No NVRAM, ID 7, Fast-80, LVD, parity checking
> sym0: SCSI BUS has been reset.
> scsi0 : sym-2.2.1
>  target0:0:8: FAST-40 WIDE SCSI 80.0 MB/s ST (25 ns, offset 31)
>   Vendor: IBM       Model: IC35L036UCDY10-0  Rev: S25M
>   Type:   Direct-Access                      ANSI SCSI revision: 03
>  target0:0:8: tagged command queuing enabled, command queue depth 16.
>  target0:0:8: Beginning Domain Validation
>  target0:0:8: asynchronous.
>  target0:0:8: wide asynchronous.
>  target0:0:8: FAST-80 WIDE SCSI 160.0 MB/s DT IU QAS (12.5 ns, offset 31)
> sym0: unexpected disconnect
>  target0:0:8: Write Buffer failure 700ff
>  target0:0:8: Domain Validation Disabing Information Units
>  target0:0:8: FAST-80 WIDE SCSI 160.0 MB/s DT (12.5 ns, offset 31)
> sym0: unexpected disconnect
>  target0:0:8: Write Buffer failure 700ff
>  target0:0:8: Domain Validation detected failure, dropping back
>  target0:0:8: FAST-40 WIDE SCSI 80.0 MB/s DT (25 ns, offset 31)
>  target0:0:8: Ending Domain Validation
>  target0:0:9: FAST-40 WIDE SCSI 80.0 MB/s ST (25 ns, offset 31)
>   Vendor: IBM       Model: IC35L036UCDY10-0  Rev: S25M
>   Type:   Direct-Access                      ANSI SCSI revision: 03
>  target0:0:9: tagged command queuing enabled, command queue depth 16.
>  target0:0:9: Beginning Domain Validation
>  target0:0:9: asynchronous.
>  target0:0:9: wide asynchronous.
>  target0:0:9: FAST-80 WIDE SCSI 160.0 MB/s DT IU QAS (12.5 ns, offset 31)
> sym0: unexpected disconnect
>  target0:0:9: Write Buffer failure 700ff
>  target0:0:9: Domain Validation Disabing Information Units
>  target0:0:9: FAST-80 WIDE SCSI 160.0 MB/s DT (12.5 ns, offset 31)
> sym0: unexpected disconnect
>  target0:0:9: Write Buffer failure 700ff
>  target0:0:9: Domain Validation detected failure, dropping back
>  target0:0:9: FAST-40 WIDE SCSI 80.0 MB/s DT (25 ns, offset 31)
>  target0:0:9: Ending Domain Validation
>  target0:0:10: FAST-40 WIDE SCSI 80.0 MB/s ST (25 ns, offset 31)
>   Vendor: IBM       Model: IC35L036UCDY10-0  Rev: S25M
>   Type:   Direct-Access                      ANSI SCSI revision: 03
>  target0:0:10: tagged command queuing enabled, command queue depth 16.
>  target0:0:10: Beginning Domain Validation
>  target0:0:10: asynchronous.
>  target0:0:10: wide asynchronous.
>  target0:0:10: Domain Validation skipping write tests
>  target0:0:10: FAST-80 WIDE SCSI 160.0 MB/s DT IU QAS (12.5 ns, offset 31)
> sym0: unexpected disconnect
>  target0:0:10: Domain Validation Disabing Information Units
>  target0:0:10: FAST-80 WIDE SCSI 160.0 MB/s DT (12.5 ns, offset 31)
> sym0: unexpected disconnect
>  target0:0:10: Domain Validation detected failure, dropping back
>  target0:0:10: FAST-40 WIDE SCSI 80.0 MB/s DT (25 ns, offset 31)
>  target0:0:10: Ending Domain Validation
>   Vendor: IBM       Model: HSBPM2   PU2SCSI  Rev: 0016
>   Type:   Enclosure                          ANSI SCSI revision: 02
>  target0:0:14: Beginning Domain Validation
>  0:0:14:0: phase change 6-7 9@100503a8 resid=7.
>  0:0:14:0: phase change 6-7 9@100503a8 resid=7.
>  0:0:14:0: phase change 6-7 9@100503a8 resid=7.
>  0:0:14:0: phase change 6-7 9@100503a8 resid=7.
>  target0:0:14: Ending Domain Validation
>   Vendor: IBM       Model: HSBPD4M  PU3SCSI  Rev: 0016
>   Type:   Enclosure                          ANSI SCSI revision: 02
>  target0:0:15: Beginning Domain Validation
>  0:0:15:0: phase change 6-7 9@100503a8 resid=7.
>  0:0:15:0: phase change 6-7 9@100503a8 resid=7.
>  0:0:15:0: phase change 6-7 9@100503a8 resid=7.
>  0:0:15:0: phase change 6-7 9@100503a8 resid=7.
>  target0:0:15: Ending Domain Validation
> sym1: <1010-66> rev 0x1 at pci 0001:01:01.1 irq 116
> sym1: No NVRAM, ID 7, Fast-80, LVD, parity checking
> sym1: SCSI BUS has been reset.
> scsi1 : sym-2.2.1
> sym2: <1010-66> rev 0x1 at pci 0001:41:01.0 irq 119
> sym2: No NVRAM, ID 7, Fast-80, LVD, parity checking
> sym2: SCSI BUS has been reset.
> scsi2 : sym-2.2.1
> sym3: <1010-66> rev 0x1 at pci 0001:41:01.1 irq 120
> sym3: No NVRAM, ID 7, Fast-80, LVD, parity checking
> sym3: SCSI BUS has been reset.
> scsi3 : sym-2.2.1
> st: Version 20050501, fixed bufsize 32768, s/g segs 256
> SCSI device sda: 71096640 512-byte hdwr sectors (36401 MB)
> SCSI device sda: drive cache: write through
> SCSI device sda: 71096640 512-byte hdwr sectors (36401 MB)
> SCSI device sda: drive cache: write through
>  sda: sda1 sda2 sda3 sda4 < sda5 sda6 >
> Attached scsi disk sda at scsi0, channel 0, id 8, lun 0
> SCSI device sdb: 71096640 512-byte hdwr sectors (36401 MB)
> SCSI device sdb: drive cache: write through
> SCSI device sdb: 71096640 512-byte hdwr sectors (36401 MB)
> SCSI device sdb: drive cache: write through
>  sdb: sdb1 sdb2
> Attached scsi disk sdb at scsi0, channel 0, id 9, lun 0
>  target0:0:10: FAST-40 WIDE SCSI 80.0 MB/s DT (25 ns, offset 31)
>  target0:0:10: FAST-40 WIDE SCSI 80.0 MB/s DT (25 ns, offset 31)
>  target0:0:10: FAST-40 WIDE SCSI 80.0 MB/s DT (25 ns, offset 31)
> sdc: Unit Not Ready, sense:
> : Current: sense key=0x0
>     ASC=0x0 ASCQ=0x0
>  target0:0:10: FAST-40 WIDE SCSI 80.0 MB/s DT (25 ns, offset 31)
> Device  not ready.
>  target0:0:10: FAST-40 WIDE SCSI 80.0 MB/s DT (25 ns, offset 31)
> Device  not ready.
>  target0:0:10: FAST-40 WIDE SCSI 80.0 MB/s DT (25 ns, offset 31)
> Device  not ready.
> sdc : READ CAPACITY failed.
> sdc : status=1, message=00, host=0, driver=08 
> sd: Current: sense key=0x0
>     ASC=0x0 ASCQ=0x0
>  target0:0:10: FAST-40 WIDE SCSI 80.0 MB/s DT (25 ns, offset 31)
> Device  not ready.
> sdc: asking for cache data failed
> sdc: assuming drive cache: write through
>  target0:0:10: FAST-40 WIDE SCSI 80.0 MB/s DT (25 ns, offset 31)
>  target0:0:10: FAST-40 WIDE SCSI 80.0 MB/s DT (25 ns, offset 31)
>  target0:0:10: FAST-40 WIDE SCSI 80.0 MB/s DT (25 ns, offset 31)
> sdc: Unit Not Ready, sense:
> : Current: sense key=0x0
>     ASC=0x0 ASCQ=0x0
>  target0:0:10: FAST-40 WIDE SCSI 80.0 MB/s DT (25 ns, offset 31)
> Device  not ready.
>  target0:0:10: FAST-40 WIDE SCSI 80.0 MB/s DT (25 ns, offset 31)
> Device  not ready.
>  target0:0:10: FAST-40 WIDE SCSI 80.0 MB/s DT (25 ns, offset 31)
> Device  not ready.
> sdc : READ CAPACITY failed.
> sdc : status=1, message=00, host=0, driver=08 
> sd: Current: sense key=0x0
>     ASC=0x0 ASCQ=0x0
>  target0:0:10: FAST-40 WIDE SCSI 80.0 MB/s DT (25 ns, offset 31)
> Device  not ready.
> sdc: asking for cache data failed
> sdc: assuming drive cache: write through
>  sdc:<6> target0:0:10: FAST-40 WIDE SCSI 80.0 MB/s DT (25 ns, offset 31)
> Device sdc not ready.
> end_request: I/O error, dev sdc, sector 0
> Buffer I/O error on device sdc, logical block 0
>  target0:0:10: FAST-40 WIDE SCSI 80.0 MB/s DT (25 ns, offset 31)
> Device sdc not ready.
> end_request: I/O error, dev sdc, sector 0
> Buffer I/O error on device sdc, logical block 0
>  unable to read partition table
