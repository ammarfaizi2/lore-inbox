Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269298AbUHZRdG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269298AbUHZRdG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 13:33:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269217AbUHZRYz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 13:24:55 -0400
Received: from mail.shareable.org ([81.29.64.88]:40646 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S269258AbUHZRUg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 13:20:36 -0400
Date: Thu, 26 Aug 2004 18:20:29 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Christoph Hellwig <hch@lst.de>, Hans Reiser <reiser@namesys.com>,
       Alex Zarochentsev <zam@namesys.com>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040826172029.GP5733@mail.shareable.org>
References: <20040825200859.GA16345@lst.de> <20040825203516.GB4688@backtop.namesys.com> <20040825205149.GA17654@lst.de> <412DA2CF.2030204@namesys.com> <20040826124119.GA431@lst.de> <20040826134812.GB5733@mail.shareable.org> <20040826155744.GA4250@lst.de> <20040826160638.GJ5733@mail.shareable.org> <20040826161303.GA4716@lst.de> <Pine.LNX.4.58.0408260919380.2304@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0408260919380.2304@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> And it would be perfectly ok for O_DIRECTORY to open such a file, as long
> as it opens the directory branch, not the special device.

What about:

    cd /dev/into_directory_branch/
    run_setuid_program

        -> calls pwd
           pwd opens("."), (".."), ("../..") etc.
 
        -> the setuid program thus ends up opening a device or fifo,
           when it does pwd's path walk.  Yes it could use the getcwd
           syscall, but some programs do their own path walk.

> I advocated (long ago) something like this for /dev handling, just because
> I think it would make sense to have
> 
> 	/dev/hda	<- special file
> 	/dev/hda/part1	<- partition 1 (aka /dev/hda1)
> 
> which just seems like a very obvious and intuitive interface to me. Of 
> course, we have so much legacy in /dev that there's no real point to doing 
> this, but it's still an appealing approach, I think.

It also fits the container idea very well:

        /dev/hda/part1/ <- the filesystem inside partition 1

That's not a contrivance, it's what I'd expect to happen if
/dev/hda is an ordinary file containing a disk image:

 	image.bin	 <- hard disk image (a regular file)
 	image.bin/part1	 <- partition 1
 	image.bin/part1/ <- the filesystem inside partition 1

That's assuming there's a format handler which recognises that image.

-- Jamie
