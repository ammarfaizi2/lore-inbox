Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751084AbWHPJ7w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751084AbWHPJ7w (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 05:59:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751085AbWHPJ7w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 05:59:52 -0400
Received: from arrakeen.ouaza.com ([212.85.152.62]:25502 "EHLO
	arrakeen.ouaza.com") by vger.kernel.org with ESMTP id S1751084AbWHPJ7v
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 05:59:51 -0400
Date: Wed, 16 Aug 2006 11:59:25 +0200
From: Raphael Hertzog <hertzog@debian.org>
To: Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Kernel with rt-preempt patch 2.6.17-rt8 not booting
Message-ID: <20060816095925.GE4325@ouaza.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Please CC me when responding)

Hello,

I was trying the latest rt-preempt patch (2.6.17-rt8) with linux 2.6.17.7 on a
little 386-based ISA CPU card (40Mhz, 8Mb RAM):
http://www.icop.com.tw/products_detail.asp?ProductID=205
More detailed spec of the CPU are here:
http://www.dmp.com.tw/tech/m6117d/

With all options activated (default config), the kernel wouldn't boot with
the following error displayed in loop:
Unknown interrupt or fault at EIP 00010086 c0120060 c01218b9

It happens very early in the boot and I don't see any other kernel message
before (or if there are any, they are very quickly moved out of the
display by the error message).

I tried to "isolate" the error by trying various combinations of options.
Deactivating CONFIG_PREEMPT_RT and CONFIG_PREEMPT_RCU and (and using
PREEMPT_DESKTOP and CLASSIC_RCU) let the kernel boot (I'm not sure which
of the two options solved the boot problem, I didn't try them individually)
but the "performance" was very bad compared to a stock kernel. I
guessed this was due to the "threaded soft/hard IRQ" and I tried to disable
those, and then the machine became very unresponsive... like it would
answer ping of the last 20 seconds all in once (it looks like the kernel
didn't receive any interrupt when the network trafic came in and did
everything in a batch later).

What more can I do to help fix this bug ? I'm happy to try out patches and
do whatever further research may be needed. The initial .config (which
didn't boot) is here:
http://ouaza.com/~rhertzog/config-2.6-rt

(this output below is generated with a stock 2.6.17.7 kernel)
# cat /proc/interrupts
           CPU0
  0:   88503366          XT-PIC  timer
  2:          0          XT-PIC  cascade
  3:         11          XT-PIC  serial
  4:         12          XT-PIC  serial
  5:       4958          XT-PIC  NE2000
 14:      10771          XT-PIC  ide0
NMI:          0
ERR:          0

Cheers,
-- 
Raphaël Hertzog

Premier livre français sur Debian GNU/Linux :
http://www.ouaza.com/livre/admin-debian/
