Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261692AbVC1EXa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261692AbVC1EXa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Mar 2005 23:23:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261708AbVC1EXa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Mar 2005 23:23:30 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:14600 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S261692AbVC1EXU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Mar 2005 23:23:20 -0500
Date: Mon, 28 Mar 2005 06:20:01 +0200
From: Willy Tarreau <willy@w.ods.org>
To: David Dyck <david.dyck@fluke.com>
Cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org
Subject: Re: upgrading modutils may have fixed: unresolved symbols still in 2.4.30-rc2 (usbserial needs symbol tty_ldisc_ref and tty_ldisc_deref which are EXPORT_SYMBOL_GPL)
Message-ID: <20050328042001.GR30052@alpha.home.local>
References: <Pine.LNX.4.62.0503261052050.1495@dd.tc.fluke.com> <20050326191306.GE3237@stusta.de> <Pine.LNX.4.62.0503261158220.206@dd.tc.fluke.com> <Pine.LNX.4.62.0503261512380.228@dd.tc.fluke.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0503261512380.228@dd.tc.fluke.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 26, 2005 at 04:31:59PM -0800, David Dyck wrote:
> >dd:linux# insmod usbserial
> >Using /lib/modules/2.4.30-rc2/kernel/drivers/usb/serial/usbserial.o
> >...: unresolved symbol tty_ldisc_ref
> >...: unresolved symbol tty_ldisc_deref
> 
> I tried again with 2.4.30-rc3, but this time I changed my .config
> file to disable 2 other modules that I didn't need, and wasn't loading.
> 
> < CONFIG_USB_UHCI_ALT=m
> < CONFIG_USB_STV680=m
> 
> and build rc3.  It seems to work, so either my earlier
> rc2 test with make clean wasn't clean-enough, or CONFIG_USB_UHCI_ALT
> interferes - testing with CONFIG_USB_UHCI_ALT as a module (not loaded)
> also works, so since interdiff didn't seem to highlite any difference 
> between rc2 and rc3, I'll suspect that my test make clean didn't
> clean things up good enough, and the entire problem was as
> Adrian Bunk suggest (upgrade modutils, thanks Adrian)

I believe it's because of genksyms during the build process, I had the
exact same problem a few weeks ago on a machine with old modutils. So
you should have cleaned everything and rebuilt from scratch after
installing your new modutils. BTW, the required modutils in
Documentation/Changes is still marked as 2.4.10, I hope it is still
enough.

Regards,
Willy

