Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030282AbVKHSdi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030282AbVKHSdi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 13:33:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965267AbVKHSdi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 13:33:38 -0500
Received: from mail.fh-wedel.de ([213.39.232.198]:43732 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S965246AbVKHSdh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 13:33:37 -0500
Date: Tue, 8 Nov 2005 19:33:39 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: "Eric W. Biederman" <ebiederman@lnxi.com>
Cc: Arnd Bergmann <arnd@arndb.de>, dwmw2@infradead.org,
       linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
       Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 06/25] mtd: move ioctl32 code to mtdchar.c
Message-ID: <20051108183339.GB31446@wohnheim.fh-wedel.de>
References: <20051105162650.620266000@b551138y.boeblingen.de.ibm.com> <20051105162712.921102000@b551138y.boeblingen.de.ibm.com> <20051108105923.GA31446@wohnheim.fh-wedel.de> <m3zmofovsc.fsf@maxwell.lnxi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <m3zmofovsc.fsf@maxwell.lnxi.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 November 2005 11:10:27 -0700, Eric W. Biederman wrote:
> Jörn Engel <joern@wohnheim.fh-wedel.de> writes:
> 
> > Moving crap over to mtdchar.c is a good thing.  Complete removal of
> > mtdchar.c might be even better, but at least the crap is relatively
> > self-contained now.
> 
> Agreed moving the compat_ioctl to mtdchar now that it is possible
> sounds good.
> 
> I can see that argument with respect to mtdblock.  But why would
> removal of mtdchar be a good thing?  It is a simple raw access
> interface.   For those whose flash parts are too small for a filesystem
> or when you are doing things that you can't do with a filesystem
> like making or checking it you need something like mtd char.  For
> embedded folks who don't care you can just compile it out.

mtdchar.c is one of the worst drivers inside the kernel.  The concept
of having a simple char device driver for flash may have its charm,
but the actual implementation is horrible.  And things like the
read-only devices are even unfixable.

mtdblock.c, while being quite a bit more complicated, does not require
a ton of ioctls, will not confuse users with minor number 7 actually
being device number 3 and magically being read-only despite unix
permissions and hardware properties.  Plus, it is just a file.

Can you name a few examples, where mtdchar.c makes sense?  I've found
it to be quite useless.

Jörn

-- 
A quarrel is quickly settled when deserted by one party; there is
no battle unless there be two.
-- Seneca
