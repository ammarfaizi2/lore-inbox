Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264702AbUGMJxs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264702AbUGMJxs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 05:53:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264726AbUGMJxs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 05:53:48 -0400
Received: from pimout1-ext.prodigy.net ([207.115.63.77]:17371 "EHLO
	pimout1-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S264702AbUGMJxp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 05:53:45 -0400
Date: Tue, 13 Jul 2004 02:53:00 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Anton Ertl <anton@mips.complang.tuwien.ac.at>
Cc: linux-kernel@vger.kernel.org, Jan Knutar <jk-lkml@sci.fi>,
       L A Walsh <lkml@tlinx.org>
Subject: Re: XFS: how to NOT null files on fsck?
Message-ID: <20040713095300.GA2986@taniwha.stupidest.org>
References: <20040713080950.GA1810@taniwha.stupidest.org> <E1BkJgc-0002Sb-O5@a4.complang.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1BkJgc-0002Sb-O5@a4.complang.tuwien.ac.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 13, 2004 at 11:34:54AM +0200, Anton Ertl wrote:

> It would be the former owner of the block.

there might not be a former owner (in most cases there probably isn't)

> Stale data yes, but probably not stale data from blocks that were
> formerly free (or the file system is insecure).

some, like reiserfs apparently do (or did, it may be different now, if
not used reiserfs for a long time)

> So, how do you tell?

code inspection and/or testing

> Where is data not critical?

that depends on the person and situation, for me personally lots of my
data isn't critical.  certainly it's annoying to loose data but
probably not life threatening

> I had such a problem even with a widely-used application like GNU
> Emacs (many years ago, may be fixed now), casting doubt on your
> claim that fixing the application is easy.

emacs will usually rename the old file so at the very least you have
that

i've had emacs crash and whilst it's frustrating, it certainly isn't
as bad as loosing an email (which may or may not be important, i'll
decide that after i read it)

> ext3 data=ordered will probably also work better in most cases than an
> FS with eager meta-data updates (like, apparently, XFS), but I don't
> think it guarantees in-order semantics.

i thought that was the point of it?  as best as i can tell the
metadata changes will become visible after the data has updated

however, in the case of something like kde/emacs/whatever you can
*still* loose data

consider something like:

	open with truncate
	crash

or more likely:

	open with truncate
	write some data
	crash

there is also an even more common case than either of these:

        open with truncate
	write data, get -ENOSPC
	spplication terminates/aborts

at which point you've stomped on your file.  it's non uncommong for
KDE to do this (even though the window would apparently be very small)



  --cw
