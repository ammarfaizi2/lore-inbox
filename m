Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265913AbUA1L5E (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 06:57:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265915AbUA1L5E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 06:57:04 -0500
Received: from 213-84-216-119.adsl.xs4all.nl ([213.84.216.119]:51335 "EHLO
	morannon.frodo.local") by vger.kernel.org with ESMTP
	id S265913AbUA1L5B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 06:57:01 -0500
From: Frodo Looijaard <frodol@dds.nl>
Date: Wed, 28 Jan 2004 12:56:55 +0100
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: PATCH to access old-style FAT fs
Message-ID: <20040128115655.GA696@arda.frodo.local>
References: <20040126173949.GA788@frodo.local> <bv3qb3$4lh$1@terminus.zytor.com> <87n0898sah.fsf@devron.myhome.or.jp> <4016B316.4060304@zytor.com> <87ad4987ti.fsf@devron.myhome.or.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ad4987ti.fsf@devron.myhome.or.jp>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 28, 2004 at 05:17:45AM +0900, OGAWA Hirofumi wrote:
> "H. Peter Anvin" <hpa@zytor.com> writes:
> 
> > I guess the original poster has found filesystems which have a 0
> > followed by garbage.  

Exactly. At least on those EPOC filesystems, and I seem to have had a
old diskette around (perhaps out of the DR-DOS age?) which had the same
problem. Regrettably, the diskette got hosed.


> The new cluster for directory entries must be initialized by 0x00.
> This is required by spec.

Might be. In that case the EPOC filesystems do not conform to spec. Now
that would be a first time.
 

> If cluster has garbage, the fat driver needs to do such the following
> part. Stop at DIR_Name[0] == 0 is not enough, and I don't think DOS
> does this.

[Patch fragment to set DIR_Name[0] to 0 when new dir entries are added]

I don't know. I do not have a working MS-DOS partition anymore to test
this on.


As I said, I *think* it is safe to have my patch always applied (that
is, stop when DIR_Name[0] == 0, and be careful to add a new DIR_Name[0] = 0
entry when new entries are added at the back). It would conform to the
standard.  But I would not really be surprised if there was yet another
FAT implementation somewhere out there that breaks the standard in some
other subtle way, which works now but exhibits problems with my patch.
That is why I made it a mount option.

Thanks,
  Frodo

-- 
Frodo Looijaard <frodol@dds.nl>  PGP key and more: http://huizen.dds.nl/~frodol
Defenestration n. (formal or joc.):
  The act of removing Windows from your computer in disgust, usually followed
  by the installation of Linux or some other Unix-like operating system.
