Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992502AbWJTFjX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992502AbWJTFjX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 01:39:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992503AbWJTFjX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 01:39:23 -0400
Received: from natklopstock.rzone.de ([81.169.145.174]:48261 "EHLO
	natklopstock.rzone.de") by vger.kernel.org with ESMTP
	id S2992502AbWJTFjW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 01:39:22 -0400
Date: Fri, 20 Oct 2006 07:38:56 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Ben Collins <ben.collins@ubuntu.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>, Jeff Garzik <jeff@garzik.org>
Subject: Re: revert mv643xx change from ubuntu tree
Message-ID: <20061020053856.GA3277@aepfle.de>
References: <20061019121836.GA26319@aepfle.de> <1161318901.31915.21.camel@gullible>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1161318901.31915.21.camel@gullible>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, Ben Collins wrote:

> On Thu, 2006-10-19 at 14:18 +0200, Olaf Hering wrote:
> > Somehow the Ubuntu guys managed to sneak this compile error into the
> > tree:
> > 
> > commit ce9e3d9953c8cb67001719b5516da2928e956be4
> > 
> >       [mv643xx] Add pci device table for auto module loading.
> > 
> > drivers/net/mv643xx_eth.c:1560: error: array type has incomplete element type
> > drivers/net/mv643xx_eth.c:1561: warning: implicit declaration of function ‘PCI_DEVICE’
> > drivers/net/mv643xx_eth.c:1561: error: ‘PCI_VENDOR_ID_MARVELL’ undeclared here (not in a function)
> > drivers/net/mv643xx_eth.c:1561: error: ‘PCI_DEVICE_ID_MARVELL_MV64360’ undeclared here (not in a function)
> 
> Correct, I missed the include for linux/pci.h.
> 
> This patch has been trailing our tree since 2.6.12. Could you help me to
> understand what in this driver will cause it to be autoloaded by udev
> when compiled as a module?

See commit ce9e3d9953c8cb67001719b5516da2928e956be4, platform devices
have now a modalias entry in sysfs. The network card is not a PCI
device.
