Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267641AbUHJSVS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267641AbUHJSVS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 14:21:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267624AbUHJSUg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 14:20:36 -0400
Received: from webmail3.altiris.com ([64.90.198.11]:41341 "EHLO
	ali-ex1.altiris.com") by vger.kernel.org with ESMTP id S267588AbUHJSOI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 14:14:08 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: PROBLEM: 2.6.7 Linux Kernel Crash While Detecting PCI Devices
Date: Tue, 10 Aug 2004 12:14:09 -0600
Message-ID: <9B96255DE3B181429D06C6ADB0B37470232B12@sandman.altiris.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: PROBLEM: 2.6.7 Linux Kernel Crash While Detecting PCI Devices
Thread-Index: AcR74lsKiRjDyn+ISbmnLgLAR+POQADH6utA
From: "John Riggs" <jriggs@altiris.com>
To: <linux-kernel@vger.kernel.org>
Cc: <greg@kroah.com>, "John Riggs" <jriggs@altiris.com>
X-OriginalArrivalTime: 10 Aug 2004 18:14:09.0234 (UTC) FILETIME=[D4A4A320:01C47F05]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The problem appears to be coming from the following series of calls:

returns EEXIST
create_dir
sysfs_create_dir
create_dir
kobject_add
class_device_add
class_device_register  
pci_alloc_child_bus

This causes pci_bus* child->class_dev.kobj.dentry to be NULL, which is
passed into class_device_create_file eventually becoming a NULL POINTER
in the function sysfs_add_file. (The NULL variable in sysfs_add_file is
now called dir.)

I don't have much of an understanding of the kernel, but it appears to
me that a PCI device is getting created twice. Does anybody have any
pointers as to what might be going on, or can point me in the right
direction to look?

Thanks,
John
