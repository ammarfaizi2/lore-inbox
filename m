Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261609AbVDVIAf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261609AbVDVIAf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Apr 2005 04:00:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261857AbVDVIAf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Apr 2005 04:00:35 -0400
Received: from kruuna.helsinki.fi ([128.214.205.14]:30858 "EHLO
	kruuna.helsinki.fi") by vger.kernel.org with ESMTP id S261609AbVDVIAZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Apr 2005 04:00:25 -0400
From: Atro Tossavainen <atossava@cc.helsinki.fi>
Message-Id: <200504220800.j3M80GSL006528@kruuna.helsinki.fi>
Subject: Linux kernel TI TLAN driver
To: torben.mathiasen@compaq.com
Date: Fri, 22 Apr 2005 11:00:16 +0300 (EEST)
CC: linux-kernel@vger.kernel.org
Reply-To: Atro.Tossavainen@helsinki.fi
X-Mailer: ELM [version 2.4ME+ PL121g (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I got my hands on a Texas Instruments ThunderLAN PCI 100 Mbit card (PCI
ID 104c:0500), which is what SGI are supplying if you want a second NIC
in your O2.  It appears that this card is not supported by the tlan
driver in the Linux kernel (at least not in 2.4.29, which is what I am
using on the machine I tried it on).  Patching the driver with the
relevant PCI IDs allowed the detection of the card, as shown in dmesg:

ThunderLAN driver v1.15
TLAN: eth0 irq=15, io=8400, Compaq NetFlex-3/E, Rev. 48
TLAN: 1 device installed, PCI: 1  EISA: 0

and in "ifconfig eth0":

eth0	Link encap: Ethernet   HWaddr 00:00:58:01:55:53

(and the rest of the normal stuff)

but trying to configure the interface with an address and bringing
it up caused a kernel oops.  (This is on Alpha.)

# ifconfig eth0 inet blah... up
Unable to handle kernel paging request at virtual address 00000000093fcb04
Segmentation fault

In dmesg, there is an

ifconfig(4218): Oops 0
followed by a register dump, a trace, and some code.

Any ideas?

-- 
Atro Tossavainen (Mr.)               / The Institute of Biotechnology at
Systems Analyst, Techno-Amish &     / the University of Helsinki, Finland,
+358-9-19158939  UNIX Dinosaur     / employs me, but my opinions are my own.
< URL : http : / / www . helsinki . fi / %7E atossava / > NO FILE ATTACHMENTS
