Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261638AbUKITau@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261638AbUKITau (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 14:30:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261639AbUKITau
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 14:30:50 -0500
Received: from soundwarez.org ([217.160.171.123]:8917 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S261638AbUKITap (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 14:30:45 -0500
Date: Tue, 9 Nov 2004 20:30:43 +0100
From: Kay Sievers <kay.sievers@vrfy.org>
To: linux-kernel@vger.kernel.org
Cc: Greg KH <greg@kroah.com>
Subject: /sys/devices/system/timer registered twice
Message-ID: <20041109193043.GA8767@vrfy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I got this on a Centrino box with the latest bk:

  [kay@pim linux.kay]$ ls -l /sys/devices/system/
  total 0
  drwxr-xr-x  7 root root 0 Nov  8 15:12 .
  drwxr-xr-x  5 root root 0 Nov  8 15:12 ..
  drwxr-xr-x  3 root root 0 Nov  8 15:12 cpu
  drwxr-xr-x  3 root root 0 Nov  8 15:12 i8259
  drwxr-xr-x  2 root root 0 Nov  8 15:12 ioapic
  drwxr-xr-x  3 root root 0 Nov  8 15:12 irqrouter
  ?---------  ? ?    ?    ?            ? timer


It is caused by registering two devices with the name "timer" from:

  arch/i386/kernel/time.c
  arch/i386/kernel/timers/timer_pit.c

If I change one of the names, I get two correct looking sysfs entries.

Greg, shouldn't the driver core prevent the corruption of the first
device if another one tries to register with the same name?

Thanks,
Kay
