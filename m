Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161441AbWJ3UGZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161441AbWJ3UGZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 15:06:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030585AbWJ3UFy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 15:05:54 -0500
Received: from mail.kroah.org ([69.55.234.183]:32969 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1161445AbWJ3UFR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 15:05:17 -0500
Date: Mon, 30 Oct 2006 12:04:14 -0800
From: Greg KH <greg@kroah.com>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@osdl.org>, Dave Jones <davej@redhat.com>,
       linux-kernel@vger.kernel.org, Jeff Garzik <jeff@garzik.org>
Subject: Re: 2.6.19-rc3-mm1 - ATI SATA controller not detected
Message-ID: <20061030200414.GA938@kroah.com>
References: <20061029160002.29bb2ea1.akpm@osdl.org> <20061030035430.GA4045@kroah.com> <20061029211604.41114b13.akpm@osdl.org> <200610302055.21305.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200610302055.21305.rjw@sisk.pl>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2006 at 08:55:18PM +0100, Rafael J. Wysocki wrote:
> Hi,
> 
> On Monday, 30 October 2006 06:16, Andrew Morton wrote:
> > On Sun, 29 Oct 2006 19:54:30 -0800
> > Greg KH <greg@kroah.com> wrote:
> > 
> > > On Sun, Oct 29, 2006 at 09:50:00PM -0500, Dave Jones wrote:
> > > > On Sun, Oct 29, 2006 at 04:00:02PM -0800, Andrew Morton wrote:
> > > > 
> > > >  > - For some reason Greg has resurrected the patches which detect whether
> > > >  >   you're using old versions of udev and if so, punish you for it.
> > > >  > 
> > > >  >   If weird stuff happens, try upgrading udev.
> > > > 
> > > > Where "old" is how old exactly ?
> > > 
> > > As per the Kconfig help entry, any version of udev released before 2006
> > > will probably have problems with the new config option.  So follow the
> > > text and enable the option if you are running an old version of udev and
> > > you should be fine.
> > 
> > <hunts>
> > 
> > Greg is referring to CONFIG_SYSFS_DEPRECATED.  I didn't know it existed. 
> > If I had known I'd have saved maybe an hour and I perhaps wouldn't have had
> > to revert gregkh-driver-tty-device.patch
> > 
> > What mailing list was this discussed and reviewed on?
> > 
> > The option should default to "y".
> 
> I have this one set, but the kernel apparently fails to find the ATI SATA
> controller:
> 
> 00:12.0 IDE interface: ATI Technologies Inc ATI 4379 Serial ATA Controller (rev 80) (prog-if 8f [Master SecP SecO PriP PriO])
>         Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 16
>         I/O ports at 9000 [size=8]
>         I/O ports at 9008 [size=4]
>         I/O ports at 9010 [size=8]
>         I/O ports at 7018 [size=4]
>         I/O ports at 7020 [size=16]
>         Memory at d4409000 (32-bit, non-prefetchable) [size=512]
>         [virtual] Expansion ROM at 52000000 [disabled] [size=512K]
>         Capabilities: [60] Power Management version 2
>         Capabilities: [50] Message Signalled Interrupts: 64bit- Queue=0/0 Enable
> 
> (with 2.6.19-rc2-mm2 and before it was handled by the sata_sil driver).

This has nothing to do with the CONFIG_SYSFS_DEPRECATED configuration
option.  Do you have CONFIG_PCI_MULTITHREAD_PROBE also enabled?  If so,
please disable it, some SATA drivers do not like it very much just yet.

thanks,

greg k-h
