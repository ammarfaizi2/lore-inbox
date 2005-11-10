Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750830AbVKJNH2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750830AbVKJNH2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 08:07:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750831AbVKJNH2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 08:07:28 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:27032 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750830AbVKJNH2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 08:07:28 -0500
Date: Thu, 10 Nov 2005 07:07:15 -0600
From: Serge Hallyn <serue@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, John Rose <johnrose@austin.ibm.com>,
       Linda Xie <lxie@us.ibm.com>, gregkh@suse.de
Subject: Re: 2.6.14-mm1
Message-ID: <20051110130626.GA7966@sergelap.austin.ibm.com>
References: <20051106182447.5f571a46.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051106182447.5f571a46.akpm@osdl.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Compiling on power5 I get

drivers/built-in.o(.text+0xd448): In function `.rpaphp_config_pci_adapter':
: undefined reference to `.of_scan_bus'
drivers/built-in.o(.text+0xe704): In function `.dlpar_add_slot':
: undefined reference to `.of_create_pci_dev'
drivers/built-in.o(.text+0xe90c): In function `.dlpar_add_slot':
: undefined reference to `.of_scan_pci_bridge'
make: *** [.tmp_vmlinux1] Error 1

Looks like drivers/pci/hotplug/rpadlpar_core.c calls of_create_pci_dev and
of_scan_pci_bridge, and drivers/pci/hotplug/rpaphp_pci.c calls of_scan_bus,
each of which are statically defined in arch/ppc64/kernel/pci.c.

Odd that these are introduced in this patch...  Do they rely on another
patch which was not included in 2.6.14-mm1?

thanks,
-serge
