Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268701AbUJDWA0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268701AbUJDWA0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 18:00:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268699AbUJDV6G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 17:58:06 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:56732 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S268529AbUJDV5T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 17:57:19 -0400
From: Pat Gefre <pfg@sgi.com>
Message-Id: <200410042157.i94Lv7UC104750@fsgi900.americas.sgi.com>
Subject: [PATCH] 2.6 SGI Altix I/O code reorganization
To: tony.luck@intel.com
Date: Mon, 4 Oct 2004 16:57:06 -0500 (CDT)
Cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


We have redone the I/O layer in the Altix code.

We've broken the patch set down to 2 patches. One to remove the files,
the other to add in the new code. Most of the changes from the last
posting are in response to review comments.

Signed-off-by: Patrick Gefre <pfg@sgi.com>

The patches are :
ftp://oss.sgi.com/projects/sn2/sn2-update/001-kill-files
ftp://oss.sgi.com/projects/sn2/sn2-update/002-add-files

They are based off http://lia64.bkbits.net/linux-ia64-release-2.6.9

The general differences between the new code and the old code are:

I/O discovery and initialization was moved to prom to enable us to move
towards EFI 1.10 and ACPI compliance.  EFI 1.10 and ACPI compliance
will be the next 2 phases in our development.  Since prom is now
performing all I/O discovery and initialization, we had to re-architect
the Altix platform specific code in Linux - basically deleting all code
related to discovery and initialization and leaving DMA mapping which
was rewritten.

Until we can implement ACPI in our prom, we will use platform specific
SAL calls to retrieve any PCI configuration that is needed during the
PCI fixup phase.


Note that this new code requires a new Altix prom. If you need one, you
can email me and I can set you up with the proper people to get one.

Also we did not break out the pci_dma.c code (as Christoph has
suggested) - we are in the process of doing that and will submit that
code change in the near future.

-- 

Patrick Gefre
Silicon Graphics, Inc.                     (E-Mail)  pfg@sgi.com
2750 Blue Water Rd                         (Voice)   (651) 683-3127
Eagan, MN 55121-1400                       (FAX)     (651) 683-3054
