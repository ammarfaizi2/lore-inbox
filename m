Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268568AbUIGTbr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268568AbUIGTbr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 15:31:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268333AbUIGT17
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 15:27:59 -0400
Received: from p3EE060A9.dip0.t-ipconnect.de ([62.224.96.169]:42624 "EHLO
	susi.maya.org") by vger.kernel.org with ESMTP id S268576AbUIGTYw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 15:24:52 -0400
From: Andreas Hartmann <andihartmann@01019freenet.de>
X-Newsgroups: fa.linux.kernel
Subject: software-suspend-2.0.0.105-for-2.4.27 broken?
Date: Tue, 07 Sep 2004 21:23:07 +0200
Organization: privat
Message-ID: <chl1qr$1ic$1@p3EE060A9.dip0.t-ipconnect.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Complaints-To: abuse@fu.berlin.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.7) Gecko/20040828
X-Accept-Language: de, en-us, en
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I applied to a vanilla kernel the following patches from
software-suspend-2.0.0.105-for-2.4.27:

10-preempt
10-preempt-log
20-software-suspend-linux-2.4.27-rev2-whole
30-software-suspend-core-2.0.0.104-whole
31-software-suspend-core-2.0.0.105-incremental

First of all:
After booting this kernel, I can't see any /proc/swsusp entries, but
/proc/sys/kernel/swsusp exists.

When trying to hibernate, suspension is canceled, because there wouldn't
be enough space in the swap device - which is obviously wrong. I've got
512 MB RAM and the swap partition has the same size. When trying to
hibernate, RAM is used half and the swap partition isn't used at all.

/var/log/messages says:

Sep  6 21:19:47 athlon kernel: Software Suspend 2.0.0.105: Swap space
signature found.
Sep  6 21:19:47 athlon kernel: Software Suspend 2.0.0.105: Suspending enabled.
Sep  6 21:19:47 athlon kernel: Software Suspend 2.0.0.105: Initiating a
software_suspend cycle.
Sep  6 21:19:50 athlon kernel: Couldn't get enough yet. 10334 pages short.
Sep  6 21:19:50 athlon kernel: Unable to free sufficient memory to
suspend. Still need 69083 pages.
Sep  6 21:19:50 athlon kernel: Please include the following information in
bug reports:
Sep  6 21:19:50 athlon kernel: - SWSUSP core    : 2.0.0.105
Sep  6 21:19:50 athlon kernel: - Kernel Version : 2.4.27
Sep  6 21:19:50 athlon kernel: - Version spec.  : 2.0.1
Sep  6 21:19:50 athlon kernel: - Compiler vers. : 3.3
Sep  6 21:19:50 athlon kernel: - Modules loaded : nfs nfsd lockd sunrpc
eepro100 mii sis900 crc32 serial usb-storage scsi_mod uhci usbcore
parport_pc lp parport loop lvm-mod unix
Sep  6 21:19:50 athlon kernel: - Attempt number : 1
Sep  6 21:19:50 athlon kernel: - Pageset sizes  : 0 and 0 (166 low).
Sep  6 21:19:50 athlon kernel: - Parameters     : 257 0 0 1 512 2048
Sep  6 21:19:50 athlon kernel: - Calculations   : Image size: 70501. Ram
to suspend: 73295.
Sep  6 21:19:50 athlon kernel: - Limits         : 131056 pages RAM.
Initial boot: 128300.
Sep  6 21:19:50 athlon kernel: - Overall expected compression percentage: 0.
Sep  6 21:19:51 athlon kernel: - GZIP compressor enabled.
Sep  6 21:19:51 athlon kernel: - Swapwriter active.
Sep  6 21:19:51 athlon kernel:   Swap available for image: 125293.
Sep  6 21:19:51 athlon kernel: - Debugging compiled in.
Sep  6 21:19:51 athlon kernel: - Max ranges used: 14620 ranges in 43 pages.
Sep  6 21:19:51 athlon kernel: - Suspend cancelled. No I/O speed stats.


My configuration:

.config:
CONFIG_SOFTWARE_SUSPEND2_CORE=y
CONFIG_SOFTWARE_SUSPEND2=y
CONFIG_SOFTWARE_SUSPEND_SWAPWRITER=y
CONFIG_SOFTWARE_SUSPEND_GZIP_COMPRESSION=y
# CONFIG_SOFTWARE_SUSPEND_LZF_COMPRESSION is not set
CONFIG_SOFTWARE_SUSPEND_TEXT_MODE=y
# CONFIG_SOFTWARE_SUSPEND_BOOTSPLASH is not set
CONFIG_SOFTWARE_SUSPEND_DEBUG=y
# CONFIG_SOFTWARE_SUSPEND_KEEP_IMAGE is not set
CONFIG_SOFTWARE_SUSPEND_RELAXED_PROC=y
CONFIG_SOFTWARE_SUSPEND_DEFAULT_RESUME2="swap:/dev/hda9"


lilo.conf:
  image  = /boot/vmlinuz-2.4.27
  label  = 2427
  root   = /dev/hda1
  append="resume2=swap:/dev/hda9"

If there is not more than about 150MB of RAM used, suspension and resume
does work with 2.0.0.105, too.


Does anybody know what to do to get it working?


Thanks for any hint,
kind regards,
Andreas Hartmann


---------------------------------------------------------------------------------

Hibernation works well with kernel 2.4.26 and swsusp 2.0.0.66:

Sep  6 19:25:43 athlon kernel: Should have tried to free page c14a4f94.
Sep  6 19:25:43 athlon kernel: Software Suspend 2.0.0.66: Swap space
signature found.
Sep  6 19:25:43 athlon kernel: Software Suspend 2.0.0.66: Suspending enabled.
Sep  6 19:25:43 athlon kernel: Software Suspend 2.0.0.66: Initiating a
software_suspend cycle.
Sep  6 19:26:04 athlon kernel: syslogd (144) is busy.
Sep  6 19:26:04 athlon kernel: tee (597) is busy.
Sep  6 19:26:04 athlon kernel: serial.c: Suspending 3f8
Sep  6 19:26:04 athlon kernel: serial.c: Suspending 2f8
Sep  6 19:26:04 athlon kernel: serial.c: Resuming 3f8
Sep  6 19:26:04 athlon kernel: serial.c: Resuming 2f8
Sep  6 19:26:04 athlon kernel: Please include the following information in
bug reports:
Sep  6 19:26:04 athlon kernel: - SWSUSP core    : 2.0.0.66
Sep  6 19:26:04 athlon kernel: - Kernel Version : 2.4.26
Sep  6 19:26:04 athlon kernel: - Version spec.  : 2.0.1
Sep  6 19:26:04 athlon kernel: - Compiler vers. : 3.3
Sep  6 19:26:04 athlon kernel: - Modules loaded : snd-pcm-oss
snd-mixer-oss snd-via82xx snd-pcm snd-timer s
Sep  6 19:26:04 athlon kernel: - Attempt number : 1
Sep  6 19:26:04 athlon kernel: - Pageset sizes  : 9626 and 58059 (58059 low).
Sep  6 19:26:04 athlon kernel: - Parameters     : 0 0 0 1 512 32
Sep  6 19:26:04 athlon kernel: - Calculations   : Image size: 67728. Ram
to suspend: 1156.
Sep  6 19:26:04 athlon kernel: - Limits         : 131056 pages RAM.
Initial boot: 128291.
Sep  6 19:26:04 athlon kernel: - Overall expected compression percentage: 0.
Sep  6 19:26:04 athlon kernel: - Swapwriter active.
Sep  6 19:26:04 athlon kernel:   Swap available for image: 128510.
Sep  6 19:26:04 athlon kernel: - GZIP compressor enabled.
Sep  6 19:26:04 athlon kernel:   Compressed 277237760 bytes into 88717381.
Sep  6 19:26:04 athlon kernel:   Image compressed by 68 percent.
Sep  6 19:26:04 athlon kernel: - Debugging compiled in.
Sep  6 19:26:04 athlon kernel: - Max ranges used: 13662 ranges in 41 pages.
Sep  6 19:26:04 athlon kernel: - I/O speed: Write 15 MB/s, Read 45 MB/s.
