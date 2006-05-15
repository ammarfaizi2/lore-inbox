Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965230AbWEOVLw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965230AbWEOVLw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 17:11:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965232AbWEOVLw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 17:11:52 -0400
Received: from h-66-166-126-70.lsanca54.covad.net ([66.166.126.70]:1707 "EHLO
	myri.com") by vger.kernel.org with ESMTP id S965231AbWEOVLw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 17:11:52 -0400
Message-ID: <4468EE85.4000500@myri.com>
Date: Mon, 15 May 2006 23:11:33 +0200
From: Brice Goglin <brice@myri.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Greg KH <gregkh@suse.de>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: AMD 8131 MSI quirk called too late, bus_flags not inherited ?
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

While looking at the MSI detection, I noticed that the AMD 8131 quirk
(quirk_amd_8131_ioapic) is defined as FINAL and thus executed after the
PCI hierarchy is scanned. So it looks like the bus_flags won't be
inherited at all. If there's a bridge behind the 8131, then the devices
behind this bridge won't see the bus flags and thus might try to enable
MSI anyway.
I tried to change the AMD 8131 quirk to HEADER so that it is executed
during PCI scanning. But, I don't get its message in dmesg anymore. Any
idea?

Thanks,
Brice

