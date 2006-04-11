Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751094AbWDKV0X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751094AbWDKV0X (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 17:26:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751105AbWDKV0X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 17:26:23 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:45193 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751094AbWDKV0W
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 17:26:22 -0400
Message-ID: <443C1ECA.1040308@us.ibm.com>
Date: Tue, 11 Apr 2006 14:25:30 -0700
From: Ian Romanick <idr@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: Special handling of sysfs device resource files?
X-Enigmail-Version: 0.92.0.0
OpenPGP: id=AC84030F
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I'm in the process of modifying X to be civilized in it's handling of
PCI devices on Linux.  As part of that, I've modified it to map the
/sys/bus/pci/device/*/resource[0-6] files instead of mucking about with
/dev/mem.

This seems to mostly work, but I am having one problem.  I map the
region by opening the file with O_RDWR, then mmap with
(PROT_READ|PROT_WRITE) and MAP_SHARED.  In all cases, the open and mmap
succeed.  However, for I/O BARs, the resulting pointer from mmap is
invalid.  Any access to it results in a segfault and GDB says it's "out
of range".

The base address of the BAR is page aligned, so its not a problem with
the alignment of mmap vs. the alignment of the BAR.  What else could it
be?  I'm pretty stumped.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.1 (GNU/Linux)

iD8DBQFEPB7KX1gOwKyEAw8RAhG/AJ4x+Vjl8V9SNeyMhYe2txeAeKALKACePCwL
6s0kj4YhDY3/thVh6mvO5X4=
=g9eu
-----END PGP SIGNATURE-----
