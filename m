Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751422AbVK3P5N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751422AbVK3P5N (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 10:57:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751423AbVK3P5N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 10:57:13 -0500
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:53187 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S1751422AbVK3P5M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 10:57:12 -0500
Date: Wed, 30 Nov 2005 10:57:11 -0500
To: art <art@usfltd.com>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: Re: SCSI adaptec 19160 speed - 2.6.14-rt13 - Q for scsi experts
Message-ID: <20051130155711.GD3803@csclub.uwaterloo.ca>
References: <200511291936.AA2621734@usfltd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511291936.AA2621734@usfltd.com>
User-Agent: Mutt/1.5.9i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 29, 2005 at 07:36:44PM -0600, art wrote:
> SCSI adaptec 19160 speed - 2.6.14-rt13 - Q for scsi experts
> 
> Attached scsi disk sda at scsi0, channel 0, id 1, lun 0
>   Vendor: COMPAQ    Model: BF14688286        Rev: HPB3
>   Type:   Direct-Access                      ANSI SCSI revision: 03
> scsi0:A:2:0: Tagged Queuing enabled.  Depth 64
> target0:0:2: Beginning Domain Validation
> target0:0:2: wide asynchronous.
> target0:0:2: FAST-80 WIDE SCSI 160.0 MB/s DT (12.5 ns, offset 63)
> target0:0:2: Ending Domain Validation
> SCSI device sdb: 286749488 512-byte hdwr sectors (146816 MB)
> SCSI device sdb: drive cache: write through
> SCSI device sdb: 286749488 512-byte hdwr sectors (146816 MB)
> SCSI device sdb: drive cache: write through
> sdb: sdb1
> Attached scsi disk sdb at scsi0, channel 0, id 2, lun 0
>   Vendor: COMPAQ    Model: BF14688286        Rev: HPB3
>   Type:   Direct-Access                      ANSI SCSI revision: 03
> scsi0:A:5:0: Tagged Queuing enabled.  Depth 64
> target0:0:5: Beginning Domain Validation
> target0:0:5: wide asynchronous.
> target0:0:5: FAST-80 WIDE SCSI 160.0 MB/s DT (12.5 ns, offset 63)
> target0:0:5: Ending Domain Validation
> SCSI device sdc: 286749488 512-byte hdwr sectors (146816 MB)
> SCSI device sdc: drive cache: write through
> SCSI device sdc: 286749488 512-byte hdwr sectors (146816 MB)
> SCSI device sdc: drive cache: write through
> sdc: sdc1
> Attached scsi disk sdc at scsi0, channel 0, id 5, lun 0
> 
> # hdparm -tT /dev/sdb
> /dev/sdb:
> Timing cached reads:   2316 MB in  2.00 seconds = 1157.90 MB/sec
> Timing buffered disk reads:  268 MB in  3.00 seconds =  89.26 MB/sec
> # hdparm -tT /dev/sdc
> 
> /dev/sdc:
> Timing cached reads:   2512 MB in  2.00 seconds = 1255.49 MB/sec
> Timing buffered disk reads:  268 MB in  3.00 seconds =  89.32 MB/sec
> 
> # hdparm -tT /dev/sdb & hdparm -tT /dev/sdc &
> [1] 3314
> [2] 3315
> 
> /dev/sdb:
> /dev/sdc:
> Timing cached reads:    Timing cached reads:   1228 MB in  2.00 seconds = 613.88 MB/sec
> 1316 MB in  1.99 seconds = 659.73 MB/sec
> Timing buffered disk reads:   Timing buffered disk reads:
> 174 MB in  3.00 seconds =  57.91 MB/sec
> 170 MB in  3.05 seconds =  55.75 MB/sec
> ------------------------------------------------------------------------------------------
> 
> pci is 66Mhz theoretical throuhput ~ 250MB/s

And pci at 33mhz can do 130MB/s or so.  With a bit over overhead those
numbers sure look awful close to what a 33mhz pci bus can handle.

> controller adaptec asc-19160
> discs are 146GB-15krpm-cheetah
> 
> one disc transfer 89MB/s
> 
> adaptec speed with 2 disc on one channel = 57.91+55.75 = 113.66MB/s
> 
> 71% of 160MB/s channel speed i expected ~90%
> 
> any clue?

PCI bus not at 66mhz perhaps?  Is it an add in card on onboard?  I
wonder if a pci bus that supports 66mhz has to drop everything to 33mhz
if any of the cards installed are 33mhz only.  Having never tried I
don't know.

Len Sorensen
