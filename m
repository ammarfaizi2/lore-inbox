Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267433AbTBXUWo>; Mon, 24 Feb 2003 15:22:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267434AbTBXUWo>; Mon, 24 Feb 2003 15:22:44 -0500
Received: from fmr06.intel.com ([134.134.136.7]:23242 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id <S267433AbTBXUWl>; Mon, 24 Feb 2003 15:22:41 -0500
Subject: CPCI stopped building
From: Rusty Lynch <rusty@linux.co.intel.com>
To: Scott Murray <scottm@somanetworks.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 24 Feb 2003 12:21:44 -0800
Message-Id: <1046118108.2099.2.camel@vmhack>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Attempting to turn on cpci support on the latest kernel breaks the build.
The problem is that pci_is_dev_in_use() has been removed, but 
cpci_hotplug_pci.c still calls the non-existant function in 
unconfigure_visit_pci_dev_phase1().

It looks like pci_dev_driver(dev) can be used in replacement (since that is
what driver/pci/hotplug.c is now doing in pci_remove_device_safe(), but 
I haven't taken the time to really understand what is happening.

    --rustyl

Here is the changeset comment:

ChangeSet 1.1002.8.3 2003/02/21 13:44:13 hch@sgi.com
  [PATCH] try_module_get(THIS_MODULE) is bogus
  
  In most cases the fix is to add an struct module * member to the operations
  vector instead and manipulate the refcounts in the callers context.
  
  For the ALSA cases it was completly superflous (when will people get it that
  using an exported symbol will make it's module unloadable?..)
drivers/pci/hotplug.c 1.11 2003/02/21 11:43:17 hch@sgi.com
  try_module_get(THIS_MODULE) is bogus







