Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423109AbWJYIOE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423109AbWJYIOE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 04:14:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423104AbWJYIOE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 04:14:04 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:17105 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1423109AbWJYIOB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 04:14:01 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: David Chinner <dgc@sgi.com>
Subject: Re: [PATCH] Freeze bdevs when freezing processes.
Date: Wed, 25 Oct 2006 10:12:58 +0200
User-Agent: KMail/1.9.1
Cc: Pavel Machek <pavel@ucw.cz>, Nigel Cunningham <ncunningham@linuxmail.org>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       xfs@oss.sgi.com
References: <1161576735.3466.7.camel@nigel.suspend2.net> <20061024213737.GD5662@elf.ucw.cz> <20061025001331.GP8394166@melbourne.sgi.com>
In-Reply-To: <20061025001331.GP8394166@melbourne.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610251012.59047.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, 25 October 2006 02:13, David Chinner wrote:
> On Tue, Oct 24, 2006 at 11:37:37PM +0200, Pavel Machek wrote:
> > Hi!
> > 
> > > > Do you mean calling sys_sync() after the userspace has been frozen
> > > > may not be sufficient?
> > > 
> > > In most cases it probably is, but sys_sync() doesn't provide any
> > > guarantees that the filesystem is not being used or written to after
> > > it completes. Given that every so often I hear about an XFS filesystem
> > > that was corrupted by suspend, I don't think this is sufficient...
> > 
> > Userspace is frozen. There's noone that can write to the XFS
> > filesystem.
> 
> Sure, no new userspace processes can write data, but what about the
> internal state of the filesystem?
> 
> All a sync guarantees is that the filesystem is consistent when the
> sync returns and XFS provides this guarantee by writing all data and
> ensuring all metadata changes are logged so if a crash occurs it can
> be recovered (which provides the sync guarantee). hence after a
> sys_sync(), XFS will still have lots of dirty metadata that needs to
> be written to disk at some time in the future so the transactions
> can be removed from the log.
> 
> This dirty metadata can be flushed at any time, and the dirty state
> is kept in XFS structures and not always in page structures (think
> multipage metadata buffers).

Are the dirty metadata flushed by a kernel thread?

Greetings,
Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
