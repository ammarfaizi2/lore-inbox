Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261901AbUK2XZh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261901AbUK2XZh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 18:25:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261886AbUK2XWT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 18:22:19 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:56982 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261882AbUK2XUo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 18:20:44 -0500
Date: Mon, 29 Nov 2004 15:20:14 -0800
From: Greg KH <greg@kroah.com>
To: Christian Axelsson <smiler@lanil.mine.nu>,
       linux-usb-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6.10-rc2-mm3] Broken usb2 mass-storage?
Message-ID: <20041129232014.GB21134@kroah.com>
References: <41ABA453.7070103@lanil.mine.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41ABA453.7070103@lanil.mine.nu>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 29, 2004 at 11:36:03PM +0100, Christian Axelsson wrote:
> Hi!
> 
> Im trying to attach a usb2 200gb drive to my laptop that is runnig 
> 2.6.10-rc2-mm3. Upon connect I get this in dmesg:

Hm, so 2.6.10-rc2 works for you?

>   usb 1-2: new high speed USB device using ehci_hcd and address 4
>   scsi0 : SCSI emulation for USB Mass Storage devices
>   usb-storage: device found at 4
>   usb-storage: waiting for device to settle before scanning
>     Vendor: Maxtor 6  Model: Y200P0            Rev: YAR4
>     Type:   Direct-Access                      ANSI SCSI revision: 04
>   SCSI device sda: 398297088 512-byte hdwr sectors (203928 MB)
>   sda: assuming drive cache: write through
>    sda: sda1
>   Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
>   Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0

That looks good.

> Then I try to access the disk (via fdisk or mount anything) and I get 
> the following in dmesg:
> 
>   usb 1-2: reset high speed USB device using ehci_hcd and address 4
>   usb 1-2: scsi_eh_0 timed out on ep0in

Ick, not good.

I'll leave the rest of the logs below, for the linux-usb-devel people to
potentually help out.

Oh, have you tried the ub driver instead?  Does that work for this
device?

>   usb 1-2: device descriptor read/64, error -110
>   usb 1-2: scsi_eh_0 timed out on ep0in
>   usb 1-2: device descriptor read/64, error -110
>   usb 1-2: reset high speed USB device using ehci_hcd and address 4
>   usb 1-2: scsi_eh_0 timed out on ep0in
>   usb 1-2: device descriptor read/64, error -110
> 
> Then it stalls a while and this shows up:
> 
>   scsi: Device offlined - not ready after error recovery: host 0 
> channel 0 id 0 lun 0
>   usb 1-2: USB disconnect, address 4
>   scsi0 (0:0): rejecting I/O to offline device
>   scsi0 (0:0): rejecting I/O to offline device
>   usb-storage: device scan complete
>   usb 1-2: new high speed USB device using ehci_hcd and address 5
>   usb 1-2: khubd timed out on ep0in
>   usb 1-2: device descriptor read/64, error -110
> 
> And repeats this.. I think you get the point ;)
> The process trying to access the disk hangs.
> Note: the drive works flawless under windows and has worked fine under 
> linux during various stages of the 2.5 and early 2.6 kernels :)
> 

thanks,

greg k-h

