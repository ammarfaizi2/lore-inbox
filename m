Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263161AbUC2XQv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 18:16:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263172AbUC2XQv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 18:16:51 -0500
Received: from gprs214-171.eurotel.cz ([160.218.214.171]:29568 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S263161AbUC2XQp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 18:16:45 -0500
Date: Tue, 30 Mar 2004 01:16:35 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Patrick J. LoPresti" <patl@users.sourceforge.net>
Cc: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cowlinks v2
Message-ID: <20040329231635.GA374@elf.ucw.cz>
References: <20040320083411.GA25934@wohnheim.fh-wedel.de> <s5gznab4lhm.fsf@patl=users.sf.net> <20040320152328.GA8089@wohnheim.fh-wedel.de> <20040329171245.GB1478@elf.ucw.cz> <s5g7jx31int.fsf@patl=users.sf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5g7jx31int.fsf@patl=users.sf.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > What happens if the disk fills while you are making the copy?  Will
> > > > open(2) on an *existing file* then return ENOSPC?
> >
> > Applications can not be sure that it is existing file. If you
> > do stat followed by open, someone may have removed the file in
> > between. So it is not so new case.
> 
> I should have said, "Will open(2) without O_CREAT then return ENOSPC?"
> 
> This is definitely a new case.
> 
> For what it's worth, I agree with whoever (Jamie?) said that COW
> should be primarily a space optimization, and that semantically the
> two files should mostly behave like separate copies.
> 
> In fact, I think it is unfortunate, in some ways, that things like
> permissions and timestamps are kept in the inode.  This means that two
> files may only be COW-linked if they also share ownership,
> permissions, and timestamps, which makes COW links less useful for
> some applications (e.g., sharing source trees among multiple
> developers).

I think they *should* have separate permissions.

Also it should be possible to have file with 2 hardlinks cowlinked
somewhere, and possibly make more hardlinks of that one... Having
pointer to another inode in place where direct block pointers normally
are should be enough (thinking ext2 here).

> But sharing data blocks without sharing inodes is too horrible even to
> contemplate, I suppose.

Why, btw?

Lets say we allocate 4 bits instead of one for block bitmap. Count
"15" is special, now it means "15 or higher". That means we have to
"garbage-collect" to free space that used to have more than 15 links,
but that should not happen too often...
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]


