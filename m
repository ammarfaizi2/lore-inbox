Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964847AbWGMIJg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964847AbWGMIJg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 04:09:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964852AbWGMIJg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 04:09:36 -0400
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:39868 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S964847AbWGMIJf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 04:09:35 -0400
Date: Thu, 13 Jul 2006 10:09:34 +0200
From: Andreas Mohr <andim2@users.sourceforge.net>
To: bhuvan.kumarmital@wipro.com
Cc: linux-usb-devel@lists.sourceforge.net, kernelnewbies-request@nl.linux.org,
       kernel-mentors@selenic.com, os_drivers@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: Expertise required on building code for SMP
Message-ID: <20060713080934.GA9109@rhlx01.fht-esslingen.de>
Reply-To: andi@lisas.de
References: <24ED22E506B5A042BF5B05B6B017D86C0A9046@PNE-HJN-MBX01.wipro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24ED22E506B5A042BF5B05B6B017D86C0A9046@PNE-HJN-MBX01.wipro.com>
User-Agent: Mutt/1.4.2.1i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jul 13, 2006 at 01:12:14PM +0530, bhuvan.kumarmital@wipro.com wrote:
> We've written a device driver in linux for a pcmcia card with usb and
> serial functionality. I need to test this driver on a dual core/SMP
> machine. We work on kernel 2.6.15.4. I have recompiled this kernel
> version on my dual core machine with the CONFIG_SMP flag set during
> menuconfig.
> 
> How do i ensure that my driver is making use of the SMP feature? Do
> build my driver code i have a makefile in which i use the EXTRA_CFLAGS=
> -D__SMP__ -DCONFIG_SMP -DLINUX.
> Am i using the right flags? Do these flags really have any significance
> in deciding whether the SMP capability will be exploited? Are there any
> other flags i need to use while building my driver code? What does the
> -jN flag mean? Should i be using it in my case.
> 
> Please guide me. I am a bit confused.

Are you talking about "make -jN"?
If so, that is purely for deciding how many threads to use to *compile*
the code, not run-time execution. Not relevant.

As Arjan said, you should use the normal kbuild infrastructure,
either for external module builds by using something like:
make -C /lib/modules/`uname -r`/build M=`pwd`
make -C /lib/modules/`uname -r`/build M=`pwd` modules_install
or for in-kernel-tree builds.

See linux/Documentation/kbuild/

Simply provide a driver Makefile that contains all tags required for kbuild
infrastructure, that should automatically take care of any and all
compiler flags you need to use, whether you're using an
SMP kernel configuration or not.
For sample users of the external kbuild driver build, see e.g. the
acx WLAN driver (both in-kernel and external build possible there,
see README).


About SMP in general: AFAIK there is nothing to configure here,
the only thing you really have to get right is proper locking inside your
driver to prevent concurrent resource access.

Andreas Mohr

P.S.: oh, and getting this driver submitted for kernel inclusion
      would be nice :)
      (both for you and us, since it'd reduce amount of maintenance work
       due to people improving it automatically)
