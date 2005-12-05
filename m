Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964808AbVLEVlF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964808AbVLEVlF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 16:41:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964810AbVLEVlE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 16:41:04 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:20229 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S964808AbVLEVlB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 16:41:01 -0500
Date: Mon, 5 Dec 2005 22:40:55 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Takahiro Hirofuchi <taka-hir@is.naist.jp>,
       gregkh@suse.de
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: 2.6.15-rc5-mm1: USB_IP problems
Message-ID: <20051205214055.GN9973@stusta.de>
References: <20051204232153.258cd554.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051204232153.258cd554.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 04, 2005 at 11:21:53PM -0800, Andrew Morton wrote:
>...
>  Subsystem trees
>...
> +gregkh-usb-usbip.patch
> 
>  USB tree updates
>...

Problems with this patch:
- USB_IP: no need for a "default N"
- USB_IP must be a tristate, because currently the illegal configurations 
  USB=m, USB_IP=y, USB_IP_{VHCI,STUB}=y are allowed
- compilation fails with USB_IP_VHCI=y, USB_IP_STUB=y:

<--  snip  -->

...
  LD      drivers/usb/ip/built-in.o
drivers/usb/ip/stub.o: In function `usbip_pack_pdu':
: multiple definition of `usbip_pack_pdu'
drivers/usb/ip/vhci-hcd.o:: first defined here
drivers/usb/ip/stub.o: In function `usbip_task_init':
: multiple definition of `usbip_task_init'
drivers/usb/ip/vhci-hcd.o:: first defined here
drivers/usb/ip/stub.o: In function `setreuse':
: multiple definition of `setreuse'
drivers/usb/ip/vhci-hcd.o:: first defined here
drivers/usb/ip/stub.o: In function `usbip_start_eh':
: multiple definition of `usbip_start_eh'
drivers/usb/ip/vhci-hcd.o:: first defined here
drivers/usb/ip/stub.o:(.data+0x0): multiple definition of 
`usbip_debug_flag'
drivers/usb/ip/vhci-hcd.o:(.data+0x0): first defined here
...
make[3]: *** [drivers/usb/ip/built-in.o] Error 1

<--  snip  -->


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

