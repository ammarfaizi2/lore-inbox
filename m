Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751076AbVJOEae@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751076AbVJOEae (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Oct 2005 00:30:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751078AbVJOEae
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Oct 2005 00:30:34 -0400
Received: from rwcrmhc14.comcast.net ([216.148.227.89]:1013 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1751076AbVJOEae (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Oct 2005 00:30:34 -0400
Date: Fri, 14 Oct 2005 21:31:20 -0700
From: Deepak Saxena <dsaxena@plexity.net>
To: jgarzik@pobox.net
Cc: linux-kernel@vger.kernel.org
Subject: [RFC] RNG rewrite...
Message-ID: <20051015043120.GA5946@plexity.net>
Reply-To: dsaxena@plexity.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Plexity Networks
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I want to add support for the RNG on Intel's IXP4xx NPU and 
looking at the existing hw-random.c code, it is written with
the assumption that the RNG is on the PCI bus. I can put a
big #ifdef ARCH_IXP4XX in there but instead I would rather
rewrite the damn thing to use the device model and have a rng
device class with individual drivers for each RNG model, including
IXP4xx. I'll keep the miscdev interface around but will add a
new interface under /sys/class/rng that the userspace tools 
can transition to. Is this OK with folks?

One question I have is about the following comment:

 * This data only exists for exporting the supported
 * PCI ids via MODULE_DEVICE_TABLE.  We do not actually
 * register a pci_driver, because someone else might one day
 * want to register another driver on the same PCI id.

Why? Is there something else on those IDs that another driver might
care about?

Tnx,
~Deepak

-- 
Deepak Saxena - dsaxena@plexity.net - http://www.plexity.net

When law and duty are one, united by religion, you never become fully
conscious, fully aware of yourself. You are always a little less than
an individual. - Frank Herbert
