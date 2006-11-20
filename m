Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933958AbWKTGZ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933958AbWKTGZ4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 01:25:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933960AbWKTGZ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 01:25:56 -0500
Received: from relay.rinet.ru ([195.54.192.35]:60641 "EHLO relay.rinet.ru")
	by vger.kernel.org with ESMTP id S933958AbWKTGZz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 01:25:55 -0500
Message-ID: <45614A95.6090102@mail.ru>
Date: Mon, 20 Nov 2006 09:26:29 +0300
From: Michael Raskin <a1d23ab4@mail.ru>
User-Agent: Thunderbird 2.0a1 (X11/20060809)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.19-rc1-mm1+ memory problem
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0.2 (relay.rinet.ru [195.54.192.35]); Mon, 20 Nov 2006 09:25:54 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Short description: when X is loaded (maybe any heavy application is 
sufficient, but I don't use anything heavy in console), 'free' says used 
memory is growing.

Keywords: memory.

Kernel: built locally, gcc 4.0.3

I have a strange problem with 2.6.19-rc-mm kernels. After I load X, I 
notice that memory is marked used at rate of tens of KB/s. Then it 
starts to swap very heavily, when physical memory is all used. I tried 
to verify it - it is so with all -mm kernels after 2.6.19-rc1-mm1, 
including 2.6.19-rc5-mm2. At the meantime everything works OK with 
kernels 2.6.18-mm3 and 2.6.19-rc1 through 2.6.19-rc6. I do not see any 
options that should be memory eating in my .config . Module list is 
short enough to include inline.

When I just run some things like periodical suck, oops proxy server etc 
with X shut down, I do not notice "leak" from console because of small 
fluctuations of memory use. When I run X and shut it down, used memory 
count goes up a few megs (consistent with speed of eating it by X).

I didn't find exactly this problem in lkml or www, though the problem 
with OOM on 2.6.19-rc-mm seems similar.

What should I check to fix problem or produce a useful bug report?

/etc/sysconfig/modules:

ehci-hcd, usb-storage, usbhid, ipaq, i915

Now loaded in 2.6.19-rc6:

i915, drm, ipaq, usbserial, usbhid, usb_storage, libusual, ehci_hcd, 
usbcore

Main configuration options:

http://bigtip.narod.ru/temp/xorg.conf.txt
http://bigtip.narod.ru/temp/config-2.6.19-rc2-mm5-swsusp-my-1.txt
http://bigtip.narod.ru/temp/lspci.txt

Drivers:

http://bigtip.narod.ru/temp/ioports.txt
http://bigtip.narod.ru/temp/iomem.txt
