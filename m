Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265602AbTGDBRI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 21:17:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265612AbTGDBRI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 21:17:08 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:2269 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265602AbTGDBRG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 21:17:06 -0400
Date: Fri, 4 Jul 2003 02:31:31 +0100
From: Matthew Wilcox <willy@debian.org>
To: Matthew Wilcox <willy@debian.org>
Cc: linux-pci@atrey.karlin.mff.cuni.cz, Patrick Mochel <mochel@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [7/6] PCI config space in sysfs
Message-ID: <20030704013131.GF23597@parcelfarce.linux.theplanet.co.uk>
References: <20030703204258.GB23597@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030703204258.GB23597@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 03, 2003 at 09:42:58PM +0100, Matthew Wilcox wrote:
>  - Fix a couple of bugs in sysfs's handling of binary files (my fault).

Now I'm having second thoughts.  Sigh ;-)

My intended design was that sysfs would copy to/from buffer + offset
rather than buffer.  Seems that change 1.6 to this file (hm, bkweb seems
broken at the moment?) changed that.  so that broke my pci-sysfs changes
which weren't in the tree at the time.

It probably makes more sense to copy to/from buffer rather than
buffer+offset so we can implement larger sized binary files (we can use
a smaller buffer than the size of the file and do multiple read/write
calls).

So I think I'd like to hold off on this patchset, not change sysfs and
adapt my changes to the new API (which I didn't even know had changed.
grr.)

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
