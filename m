Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262684AbVCaAYg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262684AbVCaAYg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 19:24:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262685AbVCaAYg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 19:24:36 -0500
Received: from fmr22.intel.com ([143.183.121.14]:23705 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S262684AbVCaAYa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 19:24:30 -0500
Date: Wed, 30 Mar 2005 16:24:01 -0800
From: Rajesh Shah <rajesh.shah@intel.com>
To: gregkh@suse.de
Cc: pcihpd-discuss@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Reading root bridge resources
Message-ID: <20050330162401.A13356@unix-os.sc.intel.com>
Reply-To: Rajesh Shah <rajesh.shah@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg,
A while back I had volunteered to write a patch that stores the
resource ranges being decoded by root bridges for ACPI based 
i386 and x86_64 systems. The thread at:
http://sourceforge.net/mailarchive/message.php?msg_id=10604487
has some context regarding this. The basic intent was to allow
hot-plugged devices sitting directly under a root bridge (versus
under a p2p bridge) to claim the correct resources. The current
code in pci_scan_bus_parented() simply assigns ioport_resource
and iomem_resource to each root bridge, even if it decodes a
subset of those resources.

I did such a patch recently, and ran into problems while testing
it. I made the changes in arch/i386, just like Matthew had done
for arch/ia64. I found that ACPI firmware on some systems was
not reporting the correct resources in the _CRS method per the 
ACPI specification. On other systems, there were too many resource
ranges to fit in the 4 slots available in the pci_bus structure. 
Getting an inaccurate picture of root bridge resources broke 2 of
my test systems, since some devices failed to claim resources at 
boot time even though they were otherwise properly configured by
BIOS. 

I am therefore inclined to just drop this patch. This may break
hotplug on systems that support hotplug slots directly connected
to the root bridge. If a slot is under a p2p bridge, we already
read bridge bases correctly so this problem does not affect us.
Note however that I was not able to find any such i386 or x86_64
machine anyway. Does somebody have access to such a machine? Any 
other suggestions?

Note that a similar patch went into 2.6.11-mm4'ish for ia64. I
haven't heard of any breakage there, so apparently ia64 system
firmware is better behaved.

Rajesh
