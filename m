Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932330AbVLPPBX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932330AbVLPPBX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 10:01:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932327AbVLPPBX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 10:01:23 -0500
Received: from verein.lst.de ([213.95.11.210]:54171 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S932329AbVLPPBW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 10:01:22 -0500
Date: Fri, 16 Dec 2005 16:00:58 +0100
From: Christoph Hellwig <hch@lst.de>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Christoph Hellwig <hch@lst.de>, akpm@osdl.org, arnd@arndb.de,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] dasd: remove dynamic ioctl registration
Message-ID: <20051216150058.GA20144@lst.de>
References: <20051216143348.GB19541@lst.de> <1134745099.5495.31.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1134745099.5495.31.camel@localhost.localdomain>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 16, 2005 at 03:58:19PM +0100, Martin Schwidefsky wrote:
> On Fri, 2005-12-16 at 15:33 +0100, Christoph Hellwig wrote:
> > dasd has some really messy code to allow submodule to register ioctl.
> > Right now there are two cases:  cmd and eckd.
> 
> Wrong, at least four: cmf, eckd, err, and a binary only module from EMC.
> Now don't hit me for that binary module. But it has been there for 2.4
> and we even reserved some ioctl numbers for them (240-255).

NACK, binary modules are not a reason to keep broken things, rather one
to fix it better sooner than later.

> > cmd was merged into the main module in the last patchh, so we don't
> > need the mechanism for it anymore.
> 
> Seems resonable. The same could be done for the err module. Doesn't have
> to be a module, a config option is enough.

yes, it would clean up the err code a lot.

> > Fix this second issue by adding an ioctl method to the dasd_discipline
> > structure.
> 
> That can easily be fixed by adding a check in the ioctls as well. But
> a .ioctl entry in the discipline structure makes sense and would get rid
> of all dynamically added ioctls in our code. So I'm all in favor of it.

Yepp.  I generally prefer to not just fix things but rip out surrounding
mess.  Keeps code maintainable in the long run.

> I would be cautious about ripping out the dynamic ioctls interface
> though. I have no idea if there still is an EMC module for 2.6 or other
> exploiters. It is an exported interface after all. It is not necessary
> to break these exploiters intentionally.

Yes, it is.  Unrelated modules adding ioctls is a big no-way.  Even more
for binary modules.  The EMC code deserves to be broken.
