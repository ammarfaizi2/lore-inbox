Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129069AbQKOGAc>; Wed, 15 Nov 2000 01:00:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129091AbQKOGAO>; Wed, 15 Nov 2000 01:00:14 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:46596 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S129069AbQKOF7z>;
	Wed, 15 Nov 2000 00:59:55 -0500
Message-ID: <3A121F2B.21DB3265@mandrakesoft.com>
Date: Wed, 15 Nov 2000 00:29:15 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Adam J. Richter" <adam@yggdrasil.com>
CC: dake@staszic.waw.pl, linux-kernel@vger.kernel.org
Subject: Re: Patch(?): linux-2.4.0-test11-pre4/drivers/sound/yss225.c 
 compilefailure
In-Reply-To: <200011150102.RAA00924@adam.yggdrasil.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Adam J. Richter" wrote:
>         If a programmer errs in favor of __devinit, the result is
> extra memory consumption under CONFIG_HOTPLUG.  If a programmer
> errs in favor of __init, the result is a crash during hot p
> ug insertion.  Avoiding crashes at the expensive of a pretty small
> amount of memory usage is the more "conservative" way to err.

You suggest avoiding correctness in order to protect against dumb
programmers.  That path leads to Windows.


> >Otherwise, you rob CONFIG_HOTPLUG people of some memory that could
> >otherwise be freed at boot.  And the number of CONFIG_HOTPLUG people is
> >not small, it includes not only the CardBus users but USB users too...
> 
>         We have been discussing this on linux-devel-usb.  The
> latest patches submitted to Linus and in 2.4.0-test10-pre{3,4}
> support USB hot plugging regardless of whether CONFIG_HOTPLUG is
> specified.
> 
> bash% find linux-2.4.0-test11-pre4/drivers/usb -type f | xargs egrep HOTPLUG

Read the code.  test11-pre[34] was broken due to my recent
CONFIG_KMOD/CONFIG_HOTPLUG separation, and should have had
CONFIG_HOTPLUG.  test11-pre5 has CONFIG_HOTPLUG.  As it should.


>         Having USB hot plugging without needing to build in PCI
> hot plugging is useful,

Of course.  But CONFIG_HOTPLUG does not mean PCI hotplugging.  It means
any hotplug support in the kernel.  That is why __devinit exists and is
used in a generic fashion.  


>         After 2.4.0, [...] we may
> want to explore adding __usbdevinit{,data} defines in include/linux/init.h
> that would be controlled by a new CONFIG_USB_HOTPLUG option, as in
> the patches that I posted for this to linux-usb-devel.

This is not just a USB issue.  Please discuss this on linux-kernel, so
we can have a coherent hotplug strategy for the entire kernel.

If we are going to create CONFIG_USB_HOTPLUG, we must -eliminate-
CONFIG_HOTPLUG, and create CONFIG_PCI_HOTPLUG, and
CONFIG_ANOTHERBUS_HOTPLUG and so on, for each hotplug bus.

	Jeff


-- 
Jeff Garzik             |
Building 1024           | The chief enemy of creativity is "good" sense
MandrakeSoft            |          -- Picasso
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
