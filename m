Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262180AbUK3Qix@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262180AbUK3Qix (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 11:38:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262173AbUK3Qhj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 11:37:39 -0500
Received: from ylpvm43-ext.prodigy.net ([207.115.57.74]:46550 "EHLO
	ylpvm43.prodigy.net") by vger.kernel.org with ESMTP id S262165AbUK3QgM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 11:36:12 -0500
From: David Brownell <david-b@pacbell.net>
To: linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] Re: [2.6.10-rc2-mm3] Broken usb2 mass-storage?
Date: Tue, 30 Nov 2004 08:34:04 -0800
User-Agent: KMail/1.7.1
Cc: Greg KH <greg@kroah.com>, Christian Axelsson <smiler@lanil.mine.nu>,
       linux-kernel@vger.kernel.org
References: <41ABA453.7070103@lanil.mine.nu> <20041129232014.GB21134@kroah.com>
In-Reply-To: <20041129232014.GB21134@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411300834.04188.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 29 November 2004 3:20 pm, Greg KH wrote:

> > Then I try to access the disk (via fdisk or mount anything) and I get 
> > the following in dmesg:
> > 
> >   usb 1-2: reset high speed USB device using ehci_hcd and address 4
> >   usb 1-2: scsi_eh_0 timed out on ep0in
> 
> Ick, not good.

Has this device always needed a reset?  The interesting
bits of the log are probably the ones immediatelly preceding
the decision to reset it.  Two possibilities come to mind:
something broke the reset logic (the device is clearly not
working right after the reset) ... or something changed to
make the device go bonkers _before_ the reset, which seems
a bit more likely with my current lack-of-facts.  (Especially
if rc2 works and mm3 doesn't.)

- Dave


> ...
> 
> >   usb 1-2: device descriptor read/64, error -110
> >   usb 1-2: scsi_eh_0 timed out on ep0in
> >   usb 1-2: device descriptor read/64, error -110
> >   usb 1-2: reset high speed USB device using ehci_hcd and address 4
> >   usb 1-2: scsi_eh_0 timed out on ep0in
> >   usb 1-2: device descriptor read/64, error -110
> > 
> > Then it stalls a while and this shows up:
> > 
> >   scsi: Device offlined - not ready after error recovery: host 0 
> > channel 0 id 0 lun 0
> >   usb 1-2: USB disconnect, address 4
> >   scsi0 (0:0): rejecting I/O to offline device
> >   scsi0 (0:0): rejecting I/O to offline device
> >   usb-storage: device scan complete
> >   usb 1-2: new high speed USB device using ehci_hcd and address 5
> >   usb 1-2: khubd timed out on ep0in
> >   usb 1-2: device descriptor read/64, error -110
> > 
> > And repeats this.. I think you get the point ;)
> > The process trying to access the disk hangs.
> > Note: the drive works flawless under windows and has worked fine under 
> > linux during various stages of the 2.5 and early 2.6 kernels :)
> > 
