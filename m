Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751339AbVLDJ2q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751339AbVLDJ2q (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Dec 2005 04:28:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751340AbVLDJ2q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Dec 2005 04:28:46 -0500
Received: from fsmlabs.com ([168.103.115.128]:44471 "EHLO spamalot.fsmlabs.com")
	by vger.kernel.org with ESMTP id S1751339AbVLDJ2p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Dec 2005 04:28:45 -0500
X-ASG-Debug-ID: 1133688520-11506-68-0
X-Barracuda-URL: http://10.0.1.244:8000/cgi-bin/mark.cgi
Date: Sun, 4 Dec 2005 01:34:18 -0800 (PST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: Helge Hafting <helgehaf@aitel.hist.no>, Jeff Garzik <jgarzik@pobox.com>,
       Helge Hafting <helge.hafting@aitel.hist.no>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Tejun Heo <htejun@gmail.com>
X-ASG-Orig-Subj: Re: Linux 2.6.15-rc3 problem found - scsi order changed
Subject: Re: Linux 2.6.15-rc3 problem found - scsi order changed
In-Reply-To: <Pine.LNX.4.64.0512031702110.3099@g5.osdl.org>
Message-ID: <Pine.LNX.4.64.0512040110280.27389@montezuma.fsmlabs.com>
References: <Pine.LNX.4.64.0511282006370.3177@g5.osdl.org>
 <20051129213656.GA8706@aitel.hist.no> <Pine.LNX.4.64.0511291340340.3029@g5.osdl.org>
 <438D69FF.2090002@aitel.hist.no> <438EB150.2090502@pobox.com>
 <20051204004302.GA2188@aitel.hist.no> <Pine.LNX.4.64.0512031702110.3099@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=5.0 KILL_LEVEL=5.0 tests=
X-Barracuda-Spam-Report: Code version 3.02, rules version 3.0.5907
	Rule breakdown below pts rule name              description
	---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 3 Dec 2005, Linus Torvalds wrote:

> diff --git a/drivers/Makefile b/drivers/Makefile
> index fac1e16..ea410b6 100644
> --- a/drivers/Makefile
> +++ b/drivers/Makefile
> @@ -5,7 +5,7 @@
>  # Rewritten to use lists instead of if-statements.
>  #
>  
> -obj-$(CONFIG_PCI)		+= pci/ usb/
> +obj-$(CONFIG_PCI)		+= pci/
>  obj-$(CONFIG_PARISC)		+= parisc/
>  obj-$(CONFIG_RAPIDIO)		+= rapidio/
>  obj-y				+= video/
> @@ -49,6 +49,7 @@ obj-$(CONFIG_ATA_OVER_ETH)	+= block/aoe/
>  obj-$(CONFIG_PARIDE) 		+= block/paride/
>  obj-$(CONFIG_TC)		+= tc/
>  obj-$(CONFIG_USB)		+= usb/
> +obj-$(CONFIG_PCI)		+= usb/
>  obj-$(CONFIG_USB_GADGET)	+= usb/gadget/
>  obj-$(CONFIG_GAMEPORT)		+= input/gameport/
>  obj-$(CONFIG_INPUT)		+= input/

Yes that fixed it, but why walk into usb/ on CONFIG_PCI?
