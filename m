Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261321AbTIYPeL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 11:34:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261325AbTIYPeK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 11:34:10 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:33929 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S261321AbTIYPeI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 11:34:08 -0400
Subject: Mapping PCI video memory with remap_page_range
From: JDeas <jdeas@jadsystems.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1064504256.2328.10.camel@HD1>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 25 Sep 2003 08:37:36 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am having problems using the remap_page_range on
a PCI card. I am using a driver that claims to have
worked on RH7.2 but nothing else.

I have setup a RH9.0 (2.4.20-6smp kernel) and made
the changes needed to compile the driver. I have
managed ioctl access and am able to talk and configure
the card with the exception of the mmaped areas
(video buffer and alternate mapped registers).

The only change I made related to this in the old driver
was to change the remap_page_range(). The old version did not supply the
vma struct like needed by the new kernel so I
added it along with a VM_IO flag.(side note: should the VM_IO flag be
used for iomem?)

I inserted printk commands and found the following remap
was being executed.

remap_page_range(421330000,f0000000,4000000,0x27)
I also found the vma->Flag = 840fb


End results were this. Running a program to keep the
driver open, I was able to get the following info
(/proc/[pid]/maps)
42133000-46133000 rw-s 00000000

This seems wrong. The size is right but the mapped address shows 0
Should I not see f0000000? The /proc files (iomem and pci) both show the
card and its resources where requested. 

What else should I check?

Regards,
JD

