Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261376AbVELI7r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261376AbVELI7r (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 04:59:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261368AbVELI6y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 04:58:54 -0400
Received: from mail.fh-wedel.de ([213.39.232.198]:46764 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S261360AbVELI5o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 04:57:44 -0400
Date: Thu, 12 May 2005 10:57:41 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Carsten Otte <cotte@freenet.de>
Cc: David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, schwidefsky@de.ibm.com, akpm@osdl.org
Subject: Re: [RFC/PATCH 0/5] add execute in place support
Message-ID: <20050512085741.GA16361@wohnheim.fh-wedel.de>
References: <428216DF.8070205@de.ibm.com> <1115828389.16187.544.camel@hades.cambridge.redhat.com> <42823450.8030007@freenet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <42823450.8030007@freenet.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 May 2005 18:35:28 +0200, Carsten Otte wrote:
> >
> Yes and no. For execute in place to work proper, you need an
> allignment of data to page boundaries "on disk" (or on flash)
> just like you have when mmap()ing to userland.
> Before choosing second extended, I also looked at some
> flash/rom filesystems. But I was unable to identify one that
> alligns the data proper (and does not compress things or
> such). The ext family with block size == PAGE_SIZE does
> fullfill that requirement once the "block device" starts on page
> boundary.
> On the other hand I believe that a filesystem specificaly
> designed for flash can provide less metadata overhead then
> second extended. Would also be interresting in our use-case
> on s390.

In principle, both the block device abstraction and the mtd
abstraction fit your bill.  But jffs2 doesn't, so no in-kernel fs
could make use of a xip-aware mtd abstraction.

Patching jffs2 for xip looks like a major effort, at best, and utterly
insane at worst.  I'd prefer not to go down that path.

Jörn

-- 
Optimizations always bust things, because all optimizations are, in
the long haul, a form of cheating, and cheaters eventually get caught.
-- Larry Wall 
