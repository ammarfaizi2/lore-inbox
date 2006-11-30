Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759186AbWK3JD3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759186AbWK3JD3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 04:03:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759189AbWK3JD2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 04:03:28 -0500
Received: from brick.kernel.dk ([62.242.22.158]:46141 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S1759186AbWK3JD0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 04:03:26 -0500
Date: Thu, 30 Nov 2006 10:03:48 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
Subject: CPU hotplug broken with 2GB VMSPLIT
Message-ID: <20061130090348.GK5400@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Just got a new notebook (Lenovo X60), setup a custom kernel and then I
noticed that suspend to ram doesn't work anymore. The machine suspends
just fine, on resume it brings back the text display but reboots after
it has stalled for a few seconds. On the suggestion of Pavel, I tried
testing CPU hotplug, and indeed he was right: I can offline 1 of the
cores fine, bringing it back online freezes the machine for 3-4 seconds
and then reboots.

carl:/sys/devices/system/cpu/cpu1 # echo 0 > online 
carl:/sys/devices/system/cpu/cpu1 # dmesg
Breaking affinity for irq 219
CPU 1 is now offline
SMP alternatives: switching to UP code
carl:/sys/devices/system/cpu/cpu1 # echo 1 > online 
Read from remote host carl: Connection reset by peer

Booting with maxcpus=1 and resume works fine. Does this ring a bell with
anyone? With highmem enabled and the standard vmsplit, cpu hotplug works
fine for me.

-- 
Jens Axboe

