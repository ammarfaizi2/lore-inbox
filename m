Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261408AbUKIF7B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261408AbUKIF7B (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 00:59:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261421AbUKIF4H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 00:56:07 -0500
Received: from fmr06.intel.com ([134.134.136.7]:12768 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S261408AbUKIFgU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 00:36:20 -0500
Subject: /sys/firmware/acpi (Re: [ACPI] [PATCH/RFC 4/4]An experimental
	implementation for IDE bus)
From: Len Brown <len.brown@intel.com>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Shaohua Li <shaohua.li@intel.com>,
       ACPI Developers <acpi-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>, Greg <greg@kroah.com>,
       Patrick Mochel <mochel@digitalimplant.org>,
       Adam Belay <ambx1@neo.rr.com>, Alex Williamson <alex.williamson@hp.com>
In-Reply-To: <20041108152450.GB32374@parcelfarce.linux.theplanet.co.uk>
References: <1099887081.1750.249.camel@sli10-desk.sh.intel.com>
	 <20041108152450.GB32374@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain
Organization: 
Message-Id: <1099978538.5519.28.camel@d845pe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 09 Nov 2004 00:35:39 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-11-08 at 10:24, Matthew Wilcox wrote:
> ... Are we ever going to do anything
> with /sys/firmware/acpi/namespace/ or will it just stay around
> consuming inodes and dentries for no good reason?

When I suggested deleting /sys/firmware/acpi, Patrick replied that his
intention was that real devices would have symbolic links into that
tree.

I think this is not the best way to go.  Two simple reasons come to
mind:

The ACPI device hierarchy reflects the actual layout of the system
devices better than the current /sys/devices/ tree, linking into it from
/sys/devices doesn't fix /sys/devices.  Instead we need to consult ACPI
during the actual construction of /sys/devices/.

While the layout reflects reality, the device names in
/sys/firmware/acpi are arbitrary internal BIOS names, and so there will
never be any consistency between systems such that a human or a program
could have an easy time navigating the tree structure.

The argument in favor of exposing the tree has been for things like Alex
Williamson's patch to invoke ACPI methods by reading /sysfs.  But this
is a really neat solution looking for a problem.  if and when such a
problem is found, the same technique can always be made available under
the real /sys/devices tree.

-Len


