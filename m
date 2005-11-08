Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965140AbVKHSp7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965140AbVKHSp7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 13:45:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965252AbVKHSp7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 13:45:59 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:22995 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S965140AbVKHSp5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 13:45:57 -0500
Subject: Re: [PATCH 06/25] mtd: move ioctl32 code to mtdchar.c
From: Josh Boyer <jdub@us.ibm.com>
To: =?ISO-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: "Eric W. Biederman" <ebiederman@lnxi.com>, linux-mtd@lists.infradead.org,
       dwmw2@infradead.org, linux-kernel@vger.kernel.org,
       Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>
In-Reply-To: <20051108183339.GB31446@wohnheim.fh-wedel.de>
References: <20051105162650.620266000@b551138y.boeblingen.de.ibm.com>
	 <20051105162712.921102000@b551138y.boeblingen.de.ibm.com>
	 <20051108105923.GA31446@wohnheim.fh-wedel.de>
	 <m3zmofovsc.fsf@maxwell.lnxi.com>
	 <20051108183339.GB31446@wohnheim.fh-wedel.de>
Content-Type: text/plain; charset=UTF-8
Date: Tue, 08 Nov 2005 12:45:43 -0600
Message-Id: <1131475544.12616.14.camel@windu.rchland.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-11-08 at 19:33 +0100, Jörn Engel wrote:
> On Tue, 8 November 2005 11:10:27 -0700, Eric W. Biederman wrote:
> > I can see that argument with respect to mtdblock.  But why would
> > removal of mtdchar be a good thing?  It is a simple raw access
> > interface.   For those whose flash parts are too small for a filesystem
> > or when you are doing things that you can't do with a filesystem
> > like making or checking it you need something like mtd char.  For
> > embedded folks who don't care you can just compile it out.
> 
> mtdchar.c is one of the worst drivers inside the kernel.  The concept
> of having a simple char device driver for flash may have its charm,
> but the actual implementation is horrible.  And things like the
> read-only devices are even unfixable.

Sucky implementation isn't a reason for removal.  It's a reason to fix
sucky implementation.

> 
> mtdblock.c, while being quite a bit more complicated, does not require
> a ton of ioctls, will not confuse users with minor number 7 actually
> being device number 3 and magically being read-only despite unix
> permissions and hardware properties.  Plus, it is just a file.
> 
> Can you name a few examples, where mtdchar.c makes sense?  I've found
> it to be quite useless.

It allows users to write an image to a NAND device that has bad blocks
and not totally screw it up.  This is possible because of those ioctls.
The mtdblock stuff knows nothing of this.

I do agree that the read-only devices don't make sense.  The code itself
probably needs work too.  But until someone takes the time to make the
mtdblock devices have equivalent functionality, mtdchar needs to stay.

(And mtdblock has it's own set of issues as well.  I'd be happy to
discuss them, but I think it would be offtopic for this thread.)

josh

