Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261371AbULHWGr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261371AbULHWGr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 17:06:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261387AbULHWGr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 17:06:47 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:11501 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261371AbULHWFL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 17:05:11 -0500
Date: Wed, 8 Dec 2004 14:05:00 -0800
From: Greg KH <greg@kroah.com>
To: Tomasz K?oczko <kloczek@rudy.mif.pg.gda.pl>
Cc: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] udev 048 release
Message-ID: <20041208220500.GA19187@kroah.com>
References: <20041208185856.GA26734@kroah.com> <20041208192810.GA28374@kroah.com> <20041208194618.GA28810@kroah.com> <Pine.LNX.4.61L.0412082238420.18542@rudy.mif.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61L.0412082238420.18542@rudy.mif.pg.gda.pl>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 08, 2004 at 10:56:27PM +0100, Tomasz K?oczko wrote:
> 
> First: is it any real reason for use by udev private copy libsysfs which
> is statically linked with udev ?

Yes, the "system" version of libsysfs is not always the same one that
udev wants.  Over the past year or so, sometimes it has varied a lot.
Hopefully now we are properly synced up, but I still trust our own
version, not any other version (this really matters on boxes that have
older versions of libsysfs, like SLES 9 and friends.)

> I'm using udev with shared libsysfs for a months and all works correcly.

Great.  Notice any code size savings?  Yeah, it's not really all that
much.  You also need static linking when using klibc to get a very tiny
udev for your boot initramfs image.

> If no reasons patches for using system avalaible libsysfs for udev 048 
> can be downloaded from:
> 
> http://cvs.pld.org.pl/SOURCES/udev-uses_system_libsysfs.patch?rev=1.7
> http://cvs.pld.org.pl/SOURCES/udev-extras_scsi_id_sysfs.patch?rev=1.1
> 
> Also after aplying this patches libsysfs/ subdirectory can be removed from 
> udev source tree.

Will it still properly build with klibc?

Also, please realize that libsysfs is really not on many machines, due
to it only being used by 1 other program at this time.  So any memory
size savings is very limited.

> Second: in current udev Makefile is used direct stripping linked binaries.
> Why ?

Smaller size :)

> It makes harder packaging udev if someone will try generate udev in 
> for example rpm form with debug info in separated udev-debug package.

I'm sure those who package up rpms of udev have dealt with this properly
somehow.  For the rest of the world, I'd prefer to keep the current way.

thanks,

greg k-h
