Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965199AbWFIORn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965199AbWFIORn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 10:17:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965267AbWFIORn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 10:17:43 -0400
Received: from mx2.rowland.org ([192.131.102.7]:36112 "HELO mx2.rowland.org")
	by vger.kernel.org with SMTP id S965199AbWFIORn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 10:17:43 -0400
Date: Fri, 9 Jun 2006 10:17:42 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: James Bottomley <James.Bottomley@SteelEye.com>
cc: Andrew Morton <akpm@osdl.org>, Jens Axboe <axboe@suse.de>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       SCSI development list <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH 1/3] block layer: early detection of medium not present
In-Reply-To: <1149815229.3276.20.camel@mulgrave.il.steeleye.com>
Message-ID: <Pine.LNX.4.44L0.0606091013470.16847-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Jun 2006, James Bottomley wrote:

> On Tue, 2006-06-06 at 11:26 -0400, Alan Stern wrote:
> > When the block layer checks for new media in a drive, it uses a two-step 
> > procedure: First it checks for media change and then it revalidates the 
> > disk.  When no medium is present the second step fails.
> > 
> > However some drivers (such as the SCSI disk driver) are capable of
> > detecting medium-not-present as part of the media-changed check.  Doing so
> > will reduce by a factor of 2 or more the amount of work done by tasks
> > which, like hald, constantly poll empty drives.
> > 
> > This patch (as694) changes the block layer core to make it recognize a 
> > -ENOMEDIUM error return from the media_changed method.  A follow-on patch 
> > makes the sd driver return this code when no medium is present.
> 
> I'm not sure there's enough buy in to make this change yet ... our media
> change handling is incredibly (and quite possibly far too) complex.
> 
> As documented in Documentation/cdrom/cdrom-standard.tex, the return
> codes for media change are either 0 or 1.

I can change the documentation, if necessary.  On the other hand, I don't 
want to embark on a global alteration of the media-change handling 
throughout the entire kernel!  :-)

> Personally, I can't see a problem with overloading the true return to
> have more information that the error codes provide, but before we do
> this we need the buy in of the cdrom layer, since that's where this
> handling came from, and we need to update the documents to reflect the
> new behaviour ... someone also needs to consider what changes should be
> made in the cdrom layer for this (and whether this is actually the
> correct way to do this from the point of view of CDs).

Agreed.  That's why I cc'ed Jens.  Is there anyone else I should also ask
about this change?

Alan Stern

