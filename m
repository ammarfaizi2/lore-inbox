Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262443AbUC2VFf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 16:05:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262462AbUC2VFe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 16:05:34 -0500
Received: from mail-ext.curl.com ([66.228.88.132]:49679 "HELO
	mail-ext.curl.com") by vger.kernel.org with SMTP id S262443AbUC2VF1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 16:05:27 -0500
To: Pavel Machek <pavel@ucw.cz>
Cc: =?iso-8859-1?q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cowlinks v2
References: <20040320083411.GA25934@wohnheim.fh-wedel.de>
	<s5gznab4lhm.fsf@patl=users.sf.net>
	<20040320152328.GA8089@wohnheim.fh-wedel.de>
	<20040329171245.GB1478@elf.ucw.cz>
From: "Patrick J. LoPresti" <patl@users.sourceforge.net>
Message-ID: <s5g7jx31int.fsf@patl=users.sf.net>
Date: 29 Mar 2004 16:05:25 -0500
In-Reply-To: <20040329171245.GB1478@elf.ucw.cz>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> writes:

> > > What happens if the disk fills while you are making the copy?  Will
> > > open(2) on an *existing file* then return ENOSPC?
>
> Applications can not be sure that it is existing file. If you
> do stat followed by open, someone may have removed the file in
> between. So it is not so new case.

I should have said, "Will open(2) without O_CREAT then return ENOSPC?"

This is definitely a new case.

For what it's worth, I agree with whoever (Jamie?) said that COW
should be primarily a space optimization, and that semantically the
two files should mostly behave like separate copies.

In fact, I think it is unfortunate, in some ways, that things like
permissions and timestamps are kept in the inode.  This means that two
files may only be COW-linked if they also share ownership,
permissions, and timestamps, which makes COW links less useful for
some applications (e.g., sharing source trees among multiple
developers).

But sharing data blocks without sharing inodes is too horrible even to
contemplate, I suppose.

 - Pat
