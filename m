Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161854AbWKIV6f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161854AbWKIV6f (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 16:58:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161859AbWKIV6e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 16:58:34 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:4321 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1161854AbWKIV6d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 16:58:33 -0500
Date: Thu, 9 Nov 2006 16:58:31 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Andrew Morton <akpm@osdl.org>, Benoit Boissinot <bboissin@gmail.com>,
       Mattia Dongili <malattia@linux.it>
cc: USB development list <linux-usb-devel@lists.sourceforge.net>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       SCSI development list <linux-scsi@vger.kernel.org>
Subject: Re: [linux-usb-devel] 2.6.19-rc5-mm1
In-Reply-To: <20061109192658.GA2560@inferi.kami.home>
Message-ID: <Pine.LNX.4.44L0.0611091655080.2262-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Nov 2006, Mattia Dongili wrote:

> On Thu, Nov 09, 2006 at 11:04:53AM -0800, Andrew Morton wrote:
> > 
> > (added linux-scsi)
> [...]
> > > [27526.232000] EIP: [<e8074e26>]
> > > scsi_device_dev_release_usercontext+0x36/0x100 [scsi_mod] SS:ESP
> > > 0068:dfdb1e3c
> > > 
> > > full dmesg attached, I can test patches and provide any useful
> > > information if needed (just not now because the dock is at work).
> > 
> > You're the second or third person to report this (to no effect, btw). 
> 
> oh, great. I was going to report the same (had with usb key unplug).
> Linux version 2.6.19-rc5-mm1-1 (mattia@tadamune) (gcc version 4.1.2 20060901 (prerelease) (Debian 4.1.1-13)) #4 SMP Wed Nov 8 22:46:11 CET 2006

I don't know exactly where the problem lies, but I have narrowed it down.

In drivers/scsi/sd.c:sd_probe(), the call to add_disk() increases the 
device's refcount by 1.  However in sd_remove(), the call to del_gendisk() 
decreases the device's refcount by 2.  Consequently the structure is 
deallocated too early, causing the oops.

Somebody who knows more than I do about add_disk() and del_gendisk() will 
have to figure what's going wrong.

Alan Stern

