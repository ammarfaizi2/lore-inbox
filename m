Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932325AbVLPO6T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932325AbVLPO6T (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 09:58:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932323AbVLPO6T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 09:58:19 -0500
Received: from mtagate1.de.ibm.com ([195.212.29.150]:54451 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S932325AbVLPO6T
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 09:58:19 -0500
Subject: Re: [PATCH 2/2] dasd: remove dynamic ioctl registration
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
To: Christoph Hellwig <hch@lst.de>
Cc: akpm@osdl.org, arnd@arndb.de, linux-kernel@vger.kernel.org
In-Reply-To: <20051216143348.GB19541@lst.de>
References: <20051216143348.GB19541@lst.de>
Content-Type: text/plain
Date: Fri, 16 Dec 2005 15:58:19 +0100
Message-Id: <1134745099.5495.31.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-12-16 at 15:33 +0100, Christoph Hellwig wrote:
> dasd has some really messy code to allow submodule to register ioctl.
> Right now there are two cases:  cmd and eckd.

Wrong, at least four: cmf, eckd, err, and a binary only module from EMC.
Now don't hit me for that binary module. But it has been there for 2.4
and we even reserved some ioctl numbers for them (240-255).

> cmd was merged into the main module in the last patchh, so we don't
> need the mechanism for it anymore.

Seems resonable. The same could be done for the err module. Doesn't have
to be a module, a config option is enough.

> eckd is actually broken right now because we allow calling the eckd
> ioctls on other dasd disciplines aswell, but they assume eckd-specific
> private data.
> 
> Fix this second issue by adding an ioctl method to the dasd_discipline
> structure.

That can easily be fixed by adding a check in the ioctls as well. But
a .ioctl entry in the discipline structure makes sense and would get rid
of all dynamically added ioctls in our code. So I'm all in favor of it.

I would be cautious about ripping out the dynamic ioctls interface
though. I have no idea if there still is an EMC module for 2.6 or other
exploiters. It is an exported interface after all. It is not necessary
to break these exploiters intentionally.

-- 
blue skies,
   Martin

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH


