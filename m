Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268919AbUIHHwu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268919AbUIHHwu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 03:52:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268933AbUIHHwu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 03:52:50 -0400
Received: from mail-gateway-0-1.landonet.net ([196.25.111.196]:40148 "EHLO
	mail-gateway-0-1.landonet.net") by vger.kernel.org with ESMTP
	id S268919AbUIHHwm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 03:52:42 -0400
Message-ID: <413EBA4F.70005@lbsd.net>
Date: Wed, 08 Sep 2004 07:52:47 +0000
From: Nigel Kukard <nkukard@lbsd.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040712
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.8.1 + usb keyboard
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Before upgrading to 2.6.8.1 my USB keyboard was working 100%, I still 
received the below notices in the syslog, but it worked.

I upgraded to 2.6.8.1 and I see in my process list the modprobes that 
hotplug uses are in D-State.

Could anyone let me know if this is an error on my side, or a bug and/or 
how to fix it. I've got sysrq compiled in, but can't find any docs to 
support me debugging the below process and seeing what its getting stuck on.

TIA
Nigel Kukard


syslog snippet....

Sep  8 09:35:25 localhost kernel: usbcore: registered new driver hiddev
Sep  8 09:35:35 localhost kernel: drivers/usb/input/hid-core.c: ctrl urb 
status -2 received
Sep  8 09:35:35 localhost kernel: drivers/usb/input/hid-core.c: timeout 
initializing reports
Sep  8 09:35:35 localhost kernel:
Sep  8 09:35:35 localhost kernel: input: USB HID v1.10 Keyboard [Eleen 
USB Keyboard] on usb-0000:00:1d.0-2
Sep  8 09:35:45 localhost kernel: drivers/usb/input/hid-core.c: ctrl urb 
status -2 received
Sep  8 09:35:45 localhost kernel: drivers/usb/input/hid-core.c: 
usb_submit_urb(ctrl) failed


lsmod snippet.........

Module                  Size  Used by
usbkbd                  6570  1
usbhid                 40906  1


ps afx snippet......

   PID TTY      STAT   TIME COMMAND
     1 ?        S      0:05 init [3]
     2 ?        S      0:00 [migration/0]
     3 ?        SN     0:00 [ksoftirqd/0]
     4 ?        S<     0:00 [events/0]
     5 ?        S<     0:00  \_ [khelper]
  6854 ?        S<     0:00  |   \_ /bin/sh /sbin/hotplug usb
  6857 ?        S<     0:00  |   |   \_ /bin/sh /etc/hotplug/usb.agent
  6920 ?        D<     0:00  |   |       \_ /sbin/modprobe -s -q usbkbd
  6855 ?        S<     0:00  |   \_ /bin/sh /sbin/hotplug usb
  6858 ?        S<     0:00  |       \_ /bin/sh /etc/hotplug/usb.agent
  6909 ?        D<     0:00  |           \_ /sbin/modprobe -s -q usbhid
     6 ?        S<     0:00  \_ [kacpid]
    51 ?        S<     0:00  \_ [kblockd/0]
    64 ?        S<     0:00  \_ [aio/0]
    68 ?        S<     0:00  \_ [xfslogd/0]
    69 ?        S<     0:00  \_ [xfsdatad/0]
   216 ?        S<     0:00  \_ [ata/0]
   222 ?        S<     0:00  \_ [kcryptd/0]
   223 ?        S<     0:00  \_ [kmirrord/0]
  3986 ?        S      0:00  \_ [pdflush]
  3988 ?        S      0:00  \_ [pdflush]
    63 ?        S      0:02 [kswapd0]
    65 ?        S      0:00 [jfsIO]
    66 ?        S      0:00 [jfsCommit]
    67 ?        S      0:00 [jfsSync]
    70 ?        S      0:00 [xfsbufd]
   219 ?        S      0:00 [kseriod]
   253 ?        S      0:02 [kjournald]
   392 ?        S<s    0:00 udevd
  1149 ?        S      0:00 [kjournald]
  1598 ?        S      0:00 [pciehpd_event]
  1631 ?        S      0:00 [khubd]
  2192 ?        S      0:00 [pccardd]
  2195 ?        S      0:00 [pccardd]
  2291 ?        S      0:00 [khpsbpkt]
  2310 ?        S      0:00 [knodemgrd_0]
