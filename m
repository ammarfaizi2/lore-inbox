Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264116AbUDBSRS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 13:17:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264143AbUDBSRS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 13:17:18 -0500
Received: from mail.fh-wedel.de ([213.39.232.194]:6078 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S264116AbUDBSRQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 13:17:16 -0500
Date: Fri, 2 Apr 2004 20:17:07 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Pavel Machek <pavel@ucw.cz>
Cc: mj@ucw.cz, jack@ucw.cz, "Patrick J. LoPresti" <patl@users.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cowlinks v2
Message-ID: <20040402181707.GA28112@wohnheim.fh-wedel.de>
References: <20040320083411.GA25934@wohnheim.fh-wedel.de> <s5gznab4lhm.fsf@patl=users.sf.net> <20040320152328.GA8089@wohnheim.fh-wedel.de> <20040329171245.GB1478@elf.ucw.cz> <s5g7jx31int.fsf@patl=users.sf.net> <20040329231635.GA374@elf.ucw.cz> <20040402165440.GB24861@wohnheim.fh-wedel.de> <20040402180128.GA363@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040402180128.GA363@elf.ucw.cz>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 April 2004 20:01:28 +0200, Pavel Machek wrote:
> 
> I do not think I'm proposing hell.

Yet. :)

> > If you really want cowlinks and hardlinks to be intermixed freely, I'd
> > happily agree with you as soon as you can define the behaviour for all
> > possible cases in a simple document and none of them make me scared
> > again.  Show me that it is possible and makes sense.
> 
> Okay:
> 
>             User/kernel API modifications for cowlinks
> 
> open(..., O_RDWR) may return ENOSPACE
> 
> new syscall is introduced, copyfile(int fd_from, int fd_to). fd_to
> must be empty, or it returns -EINVAL. copyfile() copies content of
> file from one file to another. It may return success even through
> there's not enough space on filesystem to actually do the copy. It is
> also pretty fast.
> 
> another syscall is introduced for diff and friends, long long
> get_data_id(int fd). It may only be used on non-zero-length regular
> files. if get_data_id(fd1) == get_data_id(fd2), it means that files
> fd1 and fd2 contain same data and you do not need to read them to
> check it.

Sounds good, but you missed the hell part.

What happens, if you copyfile() a file that has two links?
Then you link() the result.
Then you copyfile() one of those two links.
Then you link()...

Now you write to either one of the six files.  What happens?

Give me a clean proposal how this is simple, defined and not too
dangerous for the unaware.  Then I agree, there is no hell involved.

Jörn

-- 
When in doubt, use brute force.
-- Ken Thompson
