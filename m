Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264668AbUGMJfm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264668AbUGMJfm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 05:35:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264726AbUGMJfl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 05:35:41 -0400
Received: from a4.complang.tuwien.ac.at ([128.130.173.65]:19907 "EHLO
	a4.complang.tuwien.ac.at") by vger.kernel.org with ESMTP
	id S264668AbUGMJfB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 05:35:01 -0400
Subject: Re: XFS: how to NOT null files on fsck?
To: cw@f00f.org (Chris Wedgwood)
Date: Tue, 13 Jul 2004 11:34:54 +0200 (CEST)
From: "Anton Ertl" <anton@mips.complang.tuwien.ac.at>
Cc: linux-kernel@vger.kernel.org, jk-lkml@sci.fi (Jan Knutar),
       lkml@tlinx.org (L A Walsh)
In-Reply-To: <20040713080950.GA1810@taniwha.stupidest.org>
Reply-To: anton@mips.complang.tuwien.ac.at
X-Mailer: ELM [version 2.5 PL7]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E1BkJgc-0002Sb-O5@a4.complang.tuwien.ac.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wedgwood wrote:
> 
> On Tue, Jul 13, 2004 at 07:25:29AM +0000, Anton Ertl wrote:
> 
> > A secure FS must ensure that other people's deleted data does not
> > end up in the file.  AFAIK FSs don't record owners for free blocks,
> > so they can only ensure this by zeroing the blocks.
> 
> How can free blocks have an owner?  They wouldn't be free then.

It would be the former owner of the block.

> > So I doubt that you will see any different behaviour from an FS that
> > keeps only meta-data consistent and writes meta-data before data.
> 
> You do, some fs' will return stale data.

Stale data yes, but probably not stale data from blocks that were
formerly free (or the file system is insecure).

> > It's too hard to fix the applications, since there is no easy way to
> > test that they are really fixed.
> 
> No, it's not hard to fix the applications and it's easy to tell if
> they are fixed.

So, how do you tell?

> > Also, the number of applications is much higher than the number of
> > file systems.
> 
> You don't fix all applications, only ones where data is critical and
> their handling of it is poor.  MTAs like postfix don't have a problem
> for example, they are generally written well.

Where is data not critical?  I had such a problem even with a
widely-used application like GNU Emacs (many years ago, may be fixed
now), casting doubt on your claim that fixing the application is easy.

> > The file system should provide something that I call in-order
> > semantics, i.e., that the disk state always represents an existing
> > (possibly old) logical state of the FS, not some state that never
> > existed, or some existing state with missing data.
> 
> ext3 and reiserfs have what amounts to this as an option right now.
> It has some performance implications but I'm told works great.

You mean ext3 data=journal?  The last I heard about it was that it was
broken.

ext3 data=ordered will probably also work better in most cases than an
FS with eager meta-data updates (like, apparently, XFS), but I don't
think it guarantees in-order semantics.

- anton
