Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932391AbWCWWZb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932391AbWCWWZb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 17:25:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932488AbWCWWZb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 17:25:31 -0500
Received: from nommos.sslcatacombnetworking.com ([67.18.224.114]:30336 "EHLO
	nommos.sslcatacombnetworking.com") by vger.kernel.org with ESMTP
	id S932391AbWCWWZa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 17:25:30 -0500
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <25E2BA7D-378B-45B0-995C-201A68432D5C@kernel.crashing.org>
Cc: linux-usb-devel@lists.sourceforge.net,
       LKML mailing list <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
From: Kumar Gala <galak@kernel.crashing.org>
Subject: compile error when building multiple EHCI host controllers as modules
Date: Thu, 23 Mar 2006 16:26:25 -0600
To: Greg KH <gregkh@suse.de>, dbrownell@users.sourceforge.net
X-Mailer: Apple Mail (2.746.3)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - nommos.sslcatacombnetworking.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - kernel.crashing.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was trying to build the USB EHCI host controller support as modules  
for a PowerPC 834x which also has an embedded EHCI (and PCI enabled).

I get the following build error:

In file included from drivers/usb/host/ehci-hcd.c:895:
drivers/usb/host/ehci-fsl.c:365: error: redefinition of '__inittest'
drivers/usb/host/ehci-pci.c:363: error: previous definition of  
'__inittest' was here
drivers/usb/host/ehci-fsl.c:365: error: redefinition of 'init_module'
drivers/usb/host/ehci-pci.c:363: error: previous definition of  
'init_module' was here
drivers/usb/host/ehci-fsl.c:365: error: redefinition of 'init_module'
drivers/usb/host/ehci-pci.c:363: error: previous definition of  
'init_module' was here
drivers/usb/host/ehci-fsl.c:366: error: redefinition of '__exittest'
drivers/usb/host/ehci-pci.c:369: error: previous definition of  
'__exittest' was here
drivers/usb/host/ehci-fsl.c:366: error: redefinition of 'cleanup_module'
drivers/usb/host/ehci-pci.c:369: error: previous definition of  
'cleanup_module' was here
drivers/usb/host/ehci-fsl.c:366: error: redefinition of 'cleanup_module'
drivers/usb/host/ehci-pci.c:369: error: previous definition of  
'cleanup_module' was here

Which makes sense based on how ehci-hcd.c includes "ehci-fsl.c" and  
"ehci-pci.c".  I was wondering if there were an thoughts on how to  
address this so I can build as a module.

- kumar
