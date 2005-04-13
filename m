Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261186AbVDMSmr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261186AbVDMSmr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 14:42:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261216AbVDMSjg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 14:39:36 -0400
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:57805 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S261189AbVDMShX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 14:37:23 -0400
Date: Wed, 13 Apr 2005 14:37:22 -0400
To: aeriksson@fastmail.fm
Cc: linux-kernel@vger.kernel.org
Subject: Re: DVD writer and IDE support...
Message-ID: <20050413183722.GQ17865@csclub.uwaterloo.ca>
References: <20050413181421.5C20E240480@latitude.mynet.no-ip.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050413181421.5C20E240480@latitude.mynet.no-ip.org>
User-Agent: Mutt/1.3.28i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2005 at 08:14:21PM +0200, aeriksson@fastmail.fm wrote:
> I've just gotten myself a new DVD burner which triggers some 
> interesting events in the kernel. From the log:
> 
> hdc: ATAPI 48X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(33)
> Uniform CD-ROM driver Revision: 3.20
> hdc: packet command error: status=0x51 { DriveReady SeekComplete Error }
> hdc: packet command error: error=0x40 { LastFailedSense=0x04 }
> ide: failed opcode was: unknown
> ATAPI device hdc:
>   Error: Hardware error -- (Sense key=0x04)
>   Focus servo failure -- (asc=0x09, ascq=0x02)
>   The failed "Read Cd/Dvd Capacity" packet command was: 
>   "25 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 "

Well certainly something appears to go wrong.  So far I have used a dvd
writer (PX708A and PX716A) on kernels up to 2.6.10 (i386) and 2.6.11
(amd64) and had no problems using ide-cd to do the burning (writing
DVDs using growisofs of course, and CDs using cdrecord).

> rmmod'ing the icd-cd module and modprob'ing the ide-scsi (seeing as 
> that used to be the common approach for folks (I'm new to burners...))
> I got this in the log:
> 
> ide-scsi is deprecated for cd burning! Use ide-cd and give dev=/dev/hdX as device
> scsi0 : SCSI host adapter emulation for IDE ATAPI devices
>   Vendor: AOPEN     Model: DUW1608/ARR       Rev: A060
>   Type:   CD-ROM                             ANSI SCSI revision: 02
> sr0: scsi3-mmc drive: 48x/48x writer cd/rw xa/form2 cdda tray
> Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
> 
> How should I interprete this? That the device is not supported under
> the icd-cd module but the scsi support detects and supports it ok?
> I've not tried to burn anything with it yet so I have no hard facts on
> if there is enough support (yet).
> 
> If there is any sort of data which need to be shipped somewhere to 
> make this device supported by ide-cd, I'd be glad to help...

Well it does look odd that it loads with one and not the other.  Which
kernel is this with?

Does writing CDs and DVDs actually work using ide-scsi?  Does it work
using ide-cd?

Len Sorensen
