Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261159AbTFAB6T (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 21:58:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261161AbTFAB6T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 21:58:19 -0400
Received: from smtp-out.comcast.net ([24.153.64.113]:5909 "EHLO
	smtp-out.comcast.net") by vger.kernel.org with ESMTP
	id S261159AbTFAB6S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 21:58:18 -0400
Date: Sat, 31 May 2003 22:05:30 -0400
From: Albert Cahalan <albert@users.sf.net>
Subject: PCI in /proc, /sys, and so on
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <1054433129.22088.764.camel@cube>
Organization: 
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.4
Content-type: text/plain
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In /proc/bus/pci, there is a tree containing
files to access PCI config space (only, no BARs)
and a seemingly out-of-place "devices" file.
There is no support for multiple domains.
Like this:
.
|-- 00
|   |-- 0b.0
|   `-- 10.0
|-- 01
|   |-- 0b.0
|   |-- 17.0
|   |-- 18.0
|   |-- 19.0
|   `-- 1a.0
|-- 02
|   |-- 0b.0
|   `-- 0f.0
`-- devices

Over in /sys/devices, there is a tree with more
info. At first glance I thought "pci0" would be
the first domain, but really it is just the bus
number. So that duplicates part of the name
lower down the tree: /sys/devices/pci2/02:0b.0
has a pair of "2" that are redundant.

So, there's no PCI domain support anywhere except
in some nasty ioctl, and no interface to allow
simple file-based access to PCI MMIO regions.

Future directions? Where would file-based access
be most acceptable? (in /proc, in /sys, or ???)

It sure would be nice to have all the stuff for
any given device end up in the same directory.


