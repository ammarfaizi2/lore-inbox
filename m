Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265083AbTF2Xuc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jun 2003 19:50:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265518AbTF2Xuc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jun 2003 19:50:32 -0400
Received: from smtp2.pp.htv.fi ([213.243.153.6]:5084 "EHLO smtp2.pp.htv.fi")
	by vger.kernel.org with ESMTP id S265083AbTF2Xu3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jun 2003 19:50:29 -0400
Date: Mon, 30 Jun 2003 03:05:08 +0300
From: Richard Braakman <dark@xs4all.nl>
To: linux-kernel@vger.kernel.org
Subject: Re: File System conversion -- ideas
Message-ID: <20030630000508.GA3657@cs78143044.pp.htv.fi>
References: <200306291011.h5TABQXB000391@81-2-122-30.bradfords.org.uk> <20030629132807.GA25170@mail.jlokier.co.uk> <3EFEEF8F.7050607@post.pl> <20030629192847.GB26258@mail.jlokier.co.uk> <20030629194215.GG27348@parcelfarce.linux.theplanet.co.uk> <200306291545410600.02136814@smtp.comcast.net> <3EFF4677.4050002@sktc.net> <200306291636150850.0241B66C@smtp.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200306291636150850.0241B66C@smtp.comcast.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 29, 2003 at 04:36:15PM -0400, rmoser wrote:
> Told you, I can't code it.  I could work on making an initial design for the
> most important part though, the datasystem that separates the two filesystems
> and holds the meta-data and data in self-contained atoms.  I KNOW I won't
> get it right the first time, but I can give you a place to start.

I don't think that's the most important part.  The most important part
is figuring out a layout for the filesystem while it's in transition,
such that it is at the same time a valid ext3 filesystem (so that the
ext3 export routines can work on it) and a valid reiser4 filesystem
(so that the reiser4 import routines can work on it).  And you need
to do it in such a way that the import routines won't stomp on data
that hasn't been exported yet.

If you don't have that, then there's no point in putting it in the
kernel because you won't be able to re-use the kernel fs code anyway.

Then you need to generalize this to work with any pair of filesystems.

As for the datasystem to hold the metadata: I expect you'll find that
backup/restore systems already implement this.  It's what they have to
do, after all.

Richard Braakman
