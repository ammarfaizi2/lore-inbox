Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262817AbUCJUFc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 15:05:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262807AbUCJUFc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 15:05:32 -0500
Received: from adsl-216-103-111-100.dsl.snfc21.pacbell.net ([216.103.111.100]:47241
	"EHLO www.piet.net") by vger.kernel.org with ESMTP id S262754AbUCJUFD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 15:05:03 -0500
Subject: Re: amd64 Fedora Core (With 2.6 Kernel on a MSI MS-9131 Dual
	Processor)
From: Piet Delaney <piet@www.piet.net>
To: fedora-test-list@redhat.com, Rob Myers <rob.myers@gtri.gatech.edu>
Cc: piet <piet@www.piet.net>, linux-kernel@vger.kernel.org
In-Reply-To: <1077645637.25813.505.camel@dungeness.stl.gtri.gatech.edu>
References: <200402241108.18722.czar@czarc.net> 
	<1077645637.25813.505.camel@dungeness.stl.gtri.gatech.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 10 Mar 2004 12:05:05 -0800
Message-Id: <1078949106.1540.805.camel@www.piet.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-02-24 at 10:00, Rob Myers wrote:
> On Tue, 2004-02-24 at 11:08, Gene C. wrote:
.
.
. 
> for my server application availability/stability is number one.  my
> current configuration includes FC1 x86_64 test1 with a hand rolled 2.6
> kernel.

I'm running FC1 x86_64 and having trouble with the USB mouse in 
the 2.6.3 kernel. I read that the problem is that RedHat/FC1 uses
usb_ohci for the usb mouse driver but 2.6 uses ohci_hcd. I found 
ehci_hcd.ko and ohci_hcd module objects and installed that without 
any help. I also tried modifying:

---------------------------------------------------------------------
			/etc/modules.conf:
---------------------------------------------------------------------
alias eth0 tg3
alias eth1 tg3
# alias usb-controller usb-ohci
alias usb-controller ohci-hcd
-----------------------------------------------------------------------

I looked at changing /etc/modprobe.conf.dist to adapt to the changed
name for the driver; fix wasn't obvious.

On Thursday, February 19, 2004, 'pingswept' at

  		http://kerneltrap.org/node/view/2413

said he fixed this problem by setting up his .config file to build
the kernel with:

	{CONFIG_USB_EHCI_HCD, CONFIG_USB_OHCI_HCD, CONFIG_USB_UHCI_HCD} and 
	CONFIG_USB

set to 'y' to compile the modules into the kernel to KISS.

Unfortunately this obvious possibility doesn't seem to be handled
will in user space and during startup the stupid module scripts seem
to get confused and think the modules aren't available and the mouse
fails to work. Insmod reports the problem, looks like mousedev wasn't
found, perhaps linking a few more modules into the kernel will do the
trick. 

Another interesting point is that Fedora on the dual AMD64 MSI MS-9131
(Ver 0.B) hangs if the mouse is in the USB port but runs ok if it's 
installed after the system is running. The 2.6 kernel also seem to 
hang if the USB port has a mouse in it at boot time. It hangs just
after printing "ohci_hcd 0000:03:00.1: OHCI Host Controler". Looks
like a candidate for kgdb.

I was wondering if this might a problem with the Ver 0.B board or the
BIOS. The 2.6.3 kernel is also locking up after running for just a 
few minutes but the 2.4 kernel bundled with Fedora for the AMD-64 
runs fine. 

-piet

> 
> my vote would be to support x86_64 fully with FC2 and thus kernel 2.6. 
> hopefully when FC2 is released it will be just as stable as FC1 is.
> 
> rob.
> 
> 
> -- 
> fedora-test-list mailing list
> fedora-test-list@redhat.com
> To unsubscribe: 
> http://www.redhat.com/mailman/listinfo/fedora-test-list
-- 
piet@www.piet.net

