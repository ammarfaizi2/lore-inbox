Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262498AbSJUWaK>; Mon, 21 Oct 2002 18:30:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262523AbSJUWaJ>; Mon, 21 Oct 2002 18:30:09 -0400
Received: from air-2.osdl.org ([65.172.181.6]:56448 "EHLO cherise.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S262498AbSJUWaH>;
	Mon, 21 Oct 2002 18:30:07 -0400
Date: Mon, 21 Oct 2002 15:39:30 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise.pdx.osdl.net
To: Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.44 crash on reboot
In-Reply-To: <Pine.LNX.4.44.0210211530500.983-100000@cherise.pdx.osdl.net>
Message-ID: <Pine.LNX.4.44.0210211534250.983-100000@cherise.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 21 Oct 2002, Patrick Mochel wrote:

> 
> On 21 Oct 2002, Stephen Hemminger wrote:
> 
> > The following happens on 2-way SMP box every time I reboot using
> > serial console. Not sure if it is a socket or inode problem but it looks
> > like a close race.
> > --------------------------------------------------------------------
> > 
> > Unable to handle kernel NULL pointer dereference at virtual address
> > 00000000
> >  printing eip:
> > c01b1a38
> > *pde = 00000000
> > Oops: 0000
> > ide-cd cdrom soundcore mga agpgart autofs nfs lockd sunrpc eepro100 mii
> > mousede
> > CPU:    0
> > EIP:    0060:[<c01b1a38>]    Not tainted
> > EFLAGS: 00010246
> > EIP is at device_shutdown+0x78/0x9e
>             ^^^^^^^^^^^^^^^
> 
> Actually, it appears to be a problem accessing the global device list. 
> Could you please send me your .config (private email is fine).

Actually, if anyone else is experiencing problems shutting down, as there 
have been quite a few reports in the last few days (thanks to myself and 
the SCSI guys), could you please do the following: 

- Apply both the patches mentioned in this email:
http://marc.theaimsgroup.com/?l=linux-kernel&m=103522568629074&w=2

- Enable debugging in drivers/base/power.c at the top of the file by 
applying the patch below.

- Rebuild and try again. 

If you're still experiencing a hang or an Oops, please report it to me 
and/or the list, along with your .config. 

Thanks,

	-pat

===== drivers/base/power.c 1.13 vs edited =====
--- 1.13/drivers/base/power.c	Fri Oct 18 17:57:42 2002
+++ edited/drivers/base/power.c	Mon Oct 21 15:33:34 2002
@@ -8,7 +8,7 @@
  *
  */
 
-#define DEBUG 0
+#define DEBUG 1
 
 #include <linux/device.h>
 #include <linux/module.h>

