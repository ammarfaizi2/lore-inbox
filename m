Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268581AbUJPDLJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268581AbUJPDLJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 23:11:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268582AbUJPDLJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 23:11:09 -0400
Received: from main.gmane.org ([80.91.229.2]:712 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S268581AbUJPDLE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 23:11:04 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Anand Kumria <wildfire@progsoc.org>
Subject: b44 misdetected on Dell Inspiron 1100
Date: Sat, 16 Oct 2004 13:11:05 +1000
Message-ID: <pan.2004.10.16.03.11.01.490609@progsoc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 203.7.227.188
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table (Debian GNU/Linux))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a Dell Inspiron 1100 which has a Broadcom b44 built-in ethernet
card. It appears that the subsystem_vendor and subsystem_device fields are
being returned to userspace in the wrong order. Dell's PCI ID is 0x0128.
The output below is with 2.6.9-rc4.

$ lspci -v
[...]
0000:00:1f.5 Multimedia audio controller: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) AC'97 Audio Controller (rev 02)
        Subsystem: Dell: Unknown device 0149
[...]
0000:02:01.0 Ethernet controller: Broadcom Corporation BCM4401 100Base-T (rev 01)
        Subsystem: Unknown device 4401:1028
[..]

$ # audio controller
$ cat /sys/bus/pci/devices/0000\:00\:1f.5/subsystem_vendor 
0x1028
$ cat /sys/bus/pci/devices/0000\:00\:1f.5/subsystem_device
0x0149

$ # network controller
$ cat /sys/bus/pci/devices/0000\:02\:01.0/subsystem_vendor
0x4401
$ cat /sys/bus/pci/devices/0000\:02\:01.0/subsystem_device
0x1028

I had a quick look at b44.c and b44.h and couldn't see anything obvious
and from emailing a few people it was suggested I email here. 

Thanks,
Anand

