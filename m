Return-Path: <linux-kernel-owner+w=401wt.eu-S1755161AbXAAI5Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755161AbXAAI5Q (ORCPT <rfc822;w@1wt.eu>);
	Mon, 1 Jan 2007 03:57:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755188AbXAAI5Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Jan 2007 03:57:16 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:41762
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1755161AbXAAI5P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Jan 2007 03:57:15 -0500
Date: Mon, 01 Jan 2007 00:57:14 -0800 (PST)
Message-Id: <20070101.005714.35017753.davem@davemloft.net>
To: segher@kernel.crashing.org
Cc: hch@infradead.org, linux-kernel@vger.kernel.org, devel@laptop.org,
       dmk@flex.com, wmb@firmworks.com, jg@laptop.org
Subject: Re: [PATCH] Open Firmware device tree virtual filesystem
From: David Miller <davem@davemloft.net>
In-Reply-To: <445cb4c27a664491761ce4e219aa0960@kernel.crashing.org>
References: <20061231.024917.59652177.davem@davemloft.net>
	<20061231154103.GA7409@infradead.org>
	<445cb4c27a664491761ce4e219aa0960@kernel.crashing.org>
X-Mailer: Mew version 5.1.52 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Segher Boessenkool <segher@kernel.crashing.org>
Date: Mon, 1 Jan 2007 04:33:13 +0100

> >>> All we've done is created a trivial implementation for exporting
> >>> the device tree to userland that isn't burdened by the powerpc
> >>> and sparc legacy code that's in there now.
> >>
> >> So now we'll have _3_ different implementations of exporting
> >> the OFW device tree via procfs.  Your's, the proc_devtree
> >> of powerpc, and sparc's /proc/openprom
> >>
> >> That doesn't make any sense to me, having 3 ways of doing the same
> >> exact thing and making no attempt to share code at all.
> 
> Not the same exact thing -- using a text representation for
> the property contents is a very different thing (and completely
> braindead).

The filesystem bit is for groveling around and getting information
from the shell prompt, or shell scripts.  Text processing.

If you want the binary bits, export it with something like
/dev/openprom.  We don't generally export binary representation
files out of /proc or /sys, in fact this rule I believe is layed
our precisely somewhere at least in the sysfs case.

> Every architecture that supports the device tree filesystem,
> initialises a "struct device_tree_ops" with a bunch of
> pointers to functions that allow you to traverse the device
> tree and read its properties (and maybe write properties, or
> even delete and create new nodes.  The devtree filesystem code
> simply calls into these functions to do the actual operations
> on the device tree (access an in-kernel data structure, call
> the OF, or both -- or something entirely different, who knows).

That's the only key point in my opinion, any clean interface that
sits in front of this stuff is fine as long as it encompasses
all of the necessary operations and allows just about any
implementation underneath.
