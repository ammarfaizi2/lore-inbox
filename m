Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264256AbUEDHFX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264256AbUEDHFX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 03:05:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264257AbUEDHFX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 03:05:23 -0400
Received: from dwdmx2.dwd.de ([141.38.3.197]:59443 "HELO dwdmx2.dwd.de")
	by vger.kernel.org with SMTP id S264256AbUEDHFO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 03:05:14 -0400
Date: Tue, 4 May 2004 07:05:12 +0000 (GMT)
From: Holger Kiehl <Holger.Kiehl@dwd.de>
X-X-Sender: kiehl@praktifix.dwd.de
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: IPMI hangup in 2.6.6-rc3
Message-Id: <Pine.LNX.4.58.0405040649310.15047@praktifix.dwd.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo

When compiling in IPMI (not as modules) my system hangs just after
it prints out detection of IPMI. 2.6.5 did work fine. Compiling
it as a module and inserting it with modprobe causes modprobe
to hang in D state, there is nothing unusual in /var/log/messages:

May  4 08:46:34 apollo kernel: ipmi message handler version v31
May  4 08:46:34 apollo kernel: IPMI System Interface driver version v31, KCS version v31, SMIC version v31, BT version v31
May  4 08:46:34 apollo kernel: ipmi_si: Found SMBIOS-specified state machine at I/O address 0xca2
May  4 08:54:14 apollo kernel: ipmi device interface version v31

lsmod shows all modules:

[root@apollo log]# lsmod
Module                  Size  Used by
ipmi_devintf            5892  0 
ipmi_si                28490  1 
ipmi_msghandler        49764  2 ipmi_devintf,ipmi_si
sunrpc                126152  1 
button                  5144  0 
battery                 7692  0 
ac                      3852  0

However when calling ipmitool it just hangs forever at the following
place:

open("/dev/ipmi0", O_RDWR)              = 3
ioctl(3, 0x80046910, 0xbfffeb5c)        = 0
time(NULL)                              = 1083653893
brk(0)                                  = 0x806c000
brk(0x808d000)                          = 0x808d000
brk(0)                                  = 0x808d000
ioctl(3, 0x8014690d, 0xbfffea40)        = 0
select(4, [3], NULL, NULL, NULL

The system is a dual Xeon with HT enabled and 2GB memory (highmem 4GB
enabled), board is Intel SE7501HG2. CONFIG_PREEMPT is disabled.

Please CC me since I am not on the list.

Thanks,
Holger
