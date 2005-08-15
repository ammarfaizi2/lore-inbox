Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932564AbVHOXYN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932564AbVHOXYN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 19:24:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932569AbVHOXYN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 19:24:13 -0400
Received: from ausc60pc101.us.dell.com ([143.166.85.206]:35682 "EHLO
	ausc60pc101.us.dell.com") by vger.kernel.org with ESMTP
	id S932564AbVHOXYM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 19:24:12 -0400
X-IronPort-AV: i="3.96,109,1122872400"; 
   d="scan'208"; a="299123041:sNHT26400440"
Date: Mon, 15 Aug 2005 18:38:49 -0500
From: Doug Warzecha <Douglas_Warzecha@dell.com>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 2.6.13-rc6] add Dell Systems Management Base Driver (dcdbas) with sysfs support
Message-ID: <20050815233849.GA3758@sysman-doug.us.dell.com>
References: <20050815200522.GA3667@sysman-doug.us.dell.com> <AC1976B5-FAFC-4809-B1B2-579D5F14FDFE@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AC1976B5-FAFC-4809-B1B2-579D5F14FDFE@mac.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2005 at 04:23:37PM -0400, Kyle Moffett wrote:
> On Aug 15, 2005, at 16:05:22, Doug Warzecha wrote:
> >This patch adds the Dell Systems Management Base Driver with sysfs  
> >support.
> 
> >+On some Dell systems, systems management software must access certain
> >+management information via a system management interrupt (SMI).   
> >The SMI data
> >+buffer must reside in 32-bit address space, and the physical  
> >address of the
> >+buffer is required for the SMI.  The driver maintains the memory  
> >required for
> >+the SMI and provides a way for the application to generate the SMI.
> >+The driver creates the following sysfs entries for systems management
> >+software to perform these system management interrupts:
> 
> Why can't you just implement the system management actions in the kernel
> driver?

We want to minimize the amount of code in the kernel and avoid having to update the driver each time a new system management command is added.

> This is tantamount to a binary SMI hook to userspace.  What
> functionality does this provide on a dell system from an administrator's
> point of view?

The libsmbios project is being updated to use this code.  http://linux.dell.com/libsmbios/main/.  Using the libsmbios code, you will be able to set all of the options in BIOS F2 screen from Linux userspace.  Also, libsmbios is looking at implementing a few other things like fan status.  Libsmbios is 100% open-source (OSL/GPL dual license).

> >+Host Control Action
> >+
> >+Dell OpenManage supports a host control feature that allows the  
> >administrator
> >+to perform a power cycle or power off of the system after the OS  
> >has finished
> >+shutting down.  On some Dell systems, this host control feature  
> >requires that
> >+a driver perform a SMI after the OS has finished shutting down.
> >+
> >+The driver creates the following sysfs entries for systems  
> >management software
> >+to schedule the driver to perform a power cycle or power off host  
> >control
> >+action after the system has finished shutting down:
> >+
> >+/sys/devices/platform/dcdbas/host_control_action
> >+/sys/devices/platform/dcdbas/host_control_smi_type
> >+/sys/devices/platform/dcdbas/host_control_on_shutdown
> 
> How is this different from shutdown() or reboot()?

The power cycle feature of the system powers off the system for a few seconds and then powers the system back on without user intervention.  shutdown() and reboot() don't provide that feature.

> What exactly is smi_type used for?  Please provide better documentation
> on how to use this and what it does.

The method of generating a host control SMI is not exactly the same for each PowerEdge system listed in dcdbas.txt.  host_control_smi_type tells the driver how to generate the host control SMI for the system in use.  I'll update dcdbas.txt with the SMI type value associated with the systems listed in that file.

> If this is supposed to be used with the RBU code to trigger a BIOS  
> update, ...

This driver is not needed by the RBU code.

Doug
