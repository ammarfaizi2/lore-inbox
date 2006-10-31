Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422805AbWJaGkn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422805AbWJaGkn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 01:40:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422810AbWJaGkn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 01:40:43 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:21663 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1422805AbWJaGkm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 01:40:42 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: John Richard Moser <nigelenki@comcast.net>
Subject: Re: Suspend to disk:  do we HAVE to use swap?
Date: Tue, 31 Oct 2006 07:39:11 +0100
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <4546C637.5080504@comcast.net> <200610310716.40181.rjw@sisk.pl> <4546EDD4.70904@comcast.net>
In-Reply-To: <4546EDD4.70904@comcast.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610310739.11500.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, 31 October 2006 07:31, John Richard Moser wrote:
> 
> Rafael J. Wysocki wrote:
> > On Tuesday, 31 October 2006 04:42, John Richard Moser wrote:
> >> Something dumb came into my head, and the question is thus brought up
> >> here:  Do we HAVE to use swap for suspend to disk? How about the file
> >> system?
> >
> > In short, we could use regular files for the suspend in the same way in which we
> > use them for swap.  Namely, we could bmap() a file and create a map of it
> > (eg. with extents) that would be used for accessing the corresponding disk
> > sectors at the block device level.  Then, to be able to read the image the
> > resume code would have to be provided with the number of the sector in which
> > the suspend image header is located.
> >
> > However, we already have code that allows us to use swap files for the suspend
> > and turning a regular file into a swap file is as easy as running 'mkswap' and
> > 'swapon' on it.
> 
> And the kernel can survive being loaded, mounting a file system
> readonly, activating swapon on the swap file on the read-only file
> system, and then resuming from it?

The swap file is not activated during the resume before the suspend image
is read from it.  That's why we need the number of the sector in which the
suspend image header is located.

> Also, the file system is consistent after a suspend to disk?

Yes, it is.

> I believe I mentioned something about compressing the image as well...

If you need to compress the image during the suspend, please visit
eg. http://suspend.sf.net (it is recommended to use the latest CVS).

Greetings,
Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
