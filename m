Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946687AbWKJT3t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946687AbWKJT3t (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 14:29:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161956AbWKJT3s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 14:29:48 -0500
Received: from pilet.ens-lyon.fr ([140.77.167.16]:18330 "EHLO
	pilet.ens-lyon.fr") by vger.kernel.org with ESMTP id S1161954AbWKJT3r
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 14:29:47 -0500
Date: Fri, 10 Nov 2006 20:29:37 +0100
From: Benoit Boissinot <benoit.boissinot@ens-lyon.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, Mattia Dongili <malattia@linux.it>,
       USB development list <linux-usb-devel@lists.sourceforge.net>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       SCSI development list <linux-scsi@vger.kernel.org>
Subject: Re: [linux-usb-devel] 2.6.19-rc5-mm1
Message-ID: <20061110192937.GB9659@ens-lyon.fr>
References: <20061109192658.GA2560@inferi.kami.home> <Pine.LNX.4.44L0.0611091655080.2262-100000@iolanthe.rowland.org> <20061109145100.01d6ec46.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061109145100.01d6ec46.akpm@osdl.org>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 09, 2006 at 02:51:00PM -0800, Andrew Morton wrote:
> On Thu, 9 Nov 2006 16:58:31 -0500 (EST)
> Alan Stern <stern@rowland.harvard.edu> wrote:
> > On Thu, 9 Nov 2006, Mattia Dongili wrote:
> > > On Thu, Nov 09, 2006 at 11:04:53AM -0800, Andrew Morton wrote:
> > > [...]
> > > > > [27526.232000] EIP: [<e8074e26>]
> > > > > scsi_device_dev_release_usercontext+0x36/0x100 [scsi_mod] SS:ESP
> > > > > 0068:dfdb1e3c
> > > > > 
> > > > > full dmesg attached, I can test patches and provide any useful
> > > > > information if needed (just not now because the dock is at work).
> > > > 
> > > > You're the second or third person to report this (to no effect, btw). 
> > > 
> > > oh, great. I was going to report the same (had with usb key unplug).
> > > Linux version 2.6.19-rc5-mm1-1 (mattia@tadamune) (gcc version 4.1.2 20060901 (prerelease) (Debian 4.1.1-13)) #4 SMP Wed Nov 8 22:46:11 CET 2006
> > 
> > I don't know exactly where the problem lies, but I have narrowed it down.
> > 
> > In drivers/scsi/sd.c:sd_probe(), the call to add_disk() increases the 
> > device's refcount by 1.  However in sd_remove(), the call to del_gendisk() 
> > decreases the device's refcount by 2.  Consequently the structure is 
> > deallocated too early, causing the oops.
> > 
> > Somebody who knows more than I do about add_disk() and del_gendisk() will 
> > have to figure what's going wrong.
> > 
> 
> hm.  Maybe it's the disk_sysfs_symlinks() changes.
> 
> Could someone who can reproduce this please try this revert, on
> 2.6.19-rc2-mm2 through 2.6.19-rc5-mm1?
> 

I confirm it fixes it for me too.

regards,

Benoit

-- 
:wq
