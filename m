Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269279AbUHZSee@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269279AbUHZSee (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 14:34:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269277AbUHZSeG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 14:34:06 -0400
Received: from fw.osdl.org ([65.172.181.6]:54682 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269317AbUHZS1K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 14:27:10 -0400
Date: Thu, 26 Aug 2004 11:27:01 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jamie Lokier <jamie@shareable.org>
cc: Christoph Hellwig <hch@lst.de>, Hans Reiser <reiser@namesys.com>,
       Alex Zarochentsev <zam@namesys.com>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
In-Reply-To: <20040826181620.GT5733@mail.shareable.org>
Message-ID: <Pine.LNX.4.58.0408261119480.2304@ppc970.osdl.org>
References: <20040825205149.GA17654@lst.de> <412DA2CF.2030204@namesys.com>
 <20040826124119.GA431@lst.de> <20040826134812.GB5733@mail.shareable.org>
 <20040826155744.GA4250@lst.de> <20040826160638.GJ5733@mail.shareable.org>
 <20040826161303.GA4716@lst.de> <Pine.LNX.4.58.0408260919380.2304@ppc970.osdl.org>
 <20040826172029.GP5733@mail.shareable.org> <Pine.LNX.4.58.0408261021250.2304@ppc970.osdl.org>
 <20040826181620.GT5733@mail.shareable.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 26 Aug 2004, Jamie Lokier wrote:
>
> > .. but even if it did that, it should use O_DIRECTORY when it did so. If 
> > it doesn't, it's broken.
> 
> Didn't someone just say that O_DIRECTORY will succeed on a device,
> precisely because opendir() is supposed to succeed on the device?

It will succeed on the _name_ of the device, but it won't open the device 
node. It would open the _directory_ node associated with that name.

Think of it this way: a pathname always points to one "container". That 
container is either a directory or a single node - and O_DIRECTORY ends up 
being the thing that chooses between them.

> > I don't think you can do that. The kernel has no idea how to mount the
> > filesystem.
> 
> It is not the kernel which decides.  The filesystem containing
> /dev/hda/part1 opens "the directory branch".

But that filesystem cannot know what the _other_ filesystem configurations 
are. And that's what you'd have to have to mount.

> The obvious implementation has the userspace helper just mounting it,
> end of story.  If the mount command fails, it fails.  Much like autofs.

Yes, that would work, but it's of questionable use. If you want autofs, 
then just _use_ autofs.

		Linus
