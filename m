Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262123AbULaRhS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262123AbULaRhS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Dec 2004 12:37:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262125AbULaRhS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Dec 2004 12:37:18 -0500
Received: from dialin-163-34.tor.primus.ca ([216.254.163.34]:7040 "EHLO
	node1.opengeometry.net") by vger.kernel.org with ESMTP
	id S262123AbULaRhM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Dec 2004 12:37:12 -0500
Date: Fri, 31 Dec 2004 12:36:43 -0500
From: William Park <opengeometry@yahoo.ca>
To: Andrew Morton <akpm@osdl.org>
Cc: pmarques@grupopie.com, juhl-lkml@dif.dk, marcelo.tosatti@cyclades.com,
       linux-kernel@vger.kernel.org
Subject: Re: waiting 10s before mounting root filesystem?
Message-ID: <20041231173643.GA2741@node1.opengeometry.net>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>, pmarques@grupopie.com,
	juhl-lkml@dif.dk, marcelo.tosatti@cyclades.com,
	linux-kernel@vger.kernel.org
References: <20041227201015.GB18911@sweep.bur.st> <41D07D56.7020702@netshadow.at> <20041229005922.GA2520@node1.opengeometry.net> <20041230152531.GB5058@logos.cnet> <Pine.LNX.4.61.0412310011400.3494@dragon.hygekrogen.localhost> <Pine.LNX.4.61.0412310234040.4725@dragon.hygekrogen.localhost> <20041231035834.GA2421@node1.opengeometry.net> <20041231014905.30b05a11.akpm@osdl.org> <41D5376A.8000705@grupopie.com> <20041231034257.7d2f7d39.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041231034257.7d2f7d39.akpm@osdl.org>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 31, 2004 at 03:42:57AM -0800, Andrew Morton wrote:
> Paulo Marques <pmarques@grupopie.com> wrote:
> >
> > Andrew Morton wrote:
> > > Why is this patch needed?  If it is to offer the user a chance to
> > > insert the correct medium or to connect the correct device, why
> > > not rely upon the user doing that thing and then hitting reset?
> > 
> > No, no. The problem is not user interaction.
> > 
> > The problem is that the USB subsystem takes a lot of time to go
> > through the hostcontrollers -> hubs -> devices. By the time it finds
> > the USB mass storage that is supposed to be used as root filesystem,
> > the kernel had already panic'ed.
> 
> That would be a USB bug, surely.  If /dev/usb/foo is present and
> functioning correctly, and higher-level code tries to access that
> device, USB should _not_ error out - it should block the caller until
> everything is sorted out.

My USB key drive takes 5s to show up as SCSI, from the moment 'uhci_hcd'
and 'usb-storage' spit out message.  I don't know why.  Internally, USB
key drive is solid state flash memory, so it should be faster than any
spinning disks.

The USB key drive works when I load the USB/SCSI modules as modules.
But, when I boot all-compiled-in-kernel and try to mount /dev/sda1 as
root device, the kernel panicks before the USB key drive has chance to
register.  This means that in order to do 'usbboot', one must go through
the contorted process of 'initrd' which is advocated only by special
interest group whose embedded world is one patch way from becoming
obsolete.
