Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263595AbUA0Mz7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 07:55:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263596AbUA0Mzw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 07:55:52 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:32521 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S263595AbUA0Mzq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 07:55:46 -0500
To: Frodo Looijaard <frodol@dds.nl>
Cc: linux-kernel@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: PATCH to access old-style FAT fs
References: <20040126173949.GA788@frodo.local>
	<bv3qb3$4lh$1@terminus.zytor.com>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Tue, 27 Jan 2004 21:55:34 +0900
In-Reply-To: <bv3qb3$4lh$1@terminus.zytor.com>
Message-ID: <87n0898sah.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H. Peter Anvin" <hpa@zytor.com> writes:

> Followup to:  <20040126173949.GA788@frodo.local>
> By author:    Frodo Looijaard <frodol@dds.nl>
> In newsgroup: linux.dev.kernel
> > 
> > Hi folks,
> > 
> > I have created and attached a new version of my old-style FAT filesystem
> > patch, this time for the 2.6.0 kernel. It can also be found on
> > http://debian.frodo.looijaard.name/. 
> > 
> > Some old implementation of the FAT standard mark the end of the
> > directory file index by inserting a filename beginning with a byte 00.
> > All entries after it should be ignored, even though they are not marked
> > as deleted. At least some EPOC releases (an OS used on Psion PDAs, for
> > example) still use this policy.
> > 
> 
> It's not just "old implementations" -- it's the spec.
> 
> After reaching a filename beginning with 00, no further data should be
> assumed to be in that filesystem.  MS-DOS itself would only do that
> when formatting the filesystem, so *all* the subsequent entries would
> be assumed to start with 00, but that doesn't really seem to be to
> spec.

The new cluster for directory entries must be initialized by 0x00.
And, when the directory entry is deleted, the name[0] is updated by
0xe5 not 0x00.

So, if the name[0] is 0x00, it after, all bytes in cluster is 0x00.

The fat driver can stop at name[0] == 0x00, but this is just optimization.
The behavior shouldn't change by this.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
