Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261436AbUKSPH6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261436AbUKSPH6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 10:07:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261437AbUKSPH6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 10:07:58 -0500
Received: from lilah.hetzel.org ([199.250.128.2]:15546 "EHLO lilah.hetzel.org")
	by vger.kernel.org with ESMTP id S261436AbUKSPHm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 10:07:42 -0500
Date: Fri, 19 Nov 2004 11:29:20 -0500
From: Dorn Hetzel <kernel@dorn.hetzel.org>
To: linux-kernel@vger.kernel.org
Subject: r8169.c
Message-ID: <20041119162920.GA26836@lilah.hetzel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've been working on building a new system using an Abit AA8 Duramax
motherboard, which includes a realtek 8169/8110 gigE controller as 
well as Intel ICH6R AHCI SATA interface.

The r8169.c version 1.2 driver in 2.6.9 had issues hanging the ethernet
on the AA8, so I downloaded version 2.2 from the realtek.com.tw
website, which fixed that issue.

2.6.9, however, was not making happy noises with the ICH6R/AHCI SATA
controller, and after reviewing changelogs and finding encouraging
notes, I gave 2.6.10-rc2 a try and I am happy to report that it
seems to work very well with the AHCI SATA drives.

2.6.10-rc2 still uses the 1.2 8169 driver, same as 2.6.9...

However, the r8169 2.2 driver would not build with 2.6.10-rc2,
due to use of pci_dma_sync_single.

I've made a V2.3 of the 8169 driver which uses 
pci_dma_sync_single_for_cpu instead, and it seems to work fine.

I was hoping to submit a patch to move the new driver into
some appropriate release, but the 2.2/2.3 driver is so far
changed from 1.2 that the diff -u is about the size of the
original and new file combined :(

Which brings me to my question (my apologies for the roundabout path)...

With such a huge diff, should I send a diff, or the whole new file, or
do something else entirely?

Thanks in advance for any advice!

Dorn Hetzel
