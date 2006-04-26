Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932478AbWDZVRS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932478AbWDZVRS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 17:17:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932480AbWDZVRS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 17:17:18 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:20426 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S932478AbWDZVRR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 17:17:17 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [RFC][PATCH] swsusp: support creating bigger images
Date: Wed, 26 Apr 2006 23:16:43 +0200
User-Agent: KMail/1.9.1
Cc: Nigel Cunningham <nigel@suspend2.net>, Pavel Machek <pavel@ucw.cz>,
       Linux PM <linux-pm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
References: <200604242355.08111.rjw@sisk.pl> <200604261341.32500.nigel@suspend2.net> <444F9E2D.2000901@yahoo.com.au>
In-Reply-To: <444F9E2D.2000901@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604262316.44162.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wednesday 26 April 2006 18:22, Nick Piggin wrote:
> Nigel Cunningham wrote:
> > On Wednesday 26 April 2006 12:24, Nick Piggin wrote:
> > 
> >>Rafael J. Wysocki wrote:
> >>
> >>>This means if we freeze bdevs, we'll be able to save all of the LRU pages,
> >>>except for the pages mapped by the current task, without copying.  I think
> >>>we can try to do this, but we'll need a patch to freeze bdevs for this
> >>>purpose. ;-)
> >>
> >>Why not the current task? Does it exit the kernel? Or go through some
> >>get_uesr_pages path?
> > 
> > 
> > I think Rafael is asleep at the mo, so I'll answer for him - he's wanting it 
> > to be compatible with using userspace to control what happens (uswsusp). In 
> > that case, current will be the userspace program that's calling the ioctls to 
> > get processes frozen etc.

Thanks Nigel. :-)

> OK, so what happens if, upon exit from kernel, that userspace task
> subsequently changes some pagecache but doesn't have that mapped? Or
> mmaps something then changes it?

The page cache that is not mapped by anyone is copied before creating the
image and the copy is included in the image.  However there would be a problem
if some page cache mapped by someone else were mapped by the suspending
task after it had exited the kernel.

Fortunately this task is forbidden to open() or mmap() any files at that time
anyway, because it would be likely to corrupt some filesystems if it did.
In fact it must not _touch_ any filesystems after the image has been created.

Greetings,
Rafael
