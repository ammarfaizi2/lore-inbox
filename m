Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264858AbUGMITK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264858AbUGMITK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 04:19:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264668AbUGMITK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 04:19:10 -0400
Received: from pimout3-ext.prodigy.net ([207.115.63.102]:1791 "EHLO
	pimout3-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S264902AbUGMIKo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 04:10:44 -0400
Date: Tue, 13 Jul 2004 01:09:50 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Anton Ertl <anton@mips.complang.tuwien.ac.at>
Cc: linux-kernel@vger.kernel.org, Jan Knutar <jk-lkml@sci.fi>,
       L A Walsh <lkml@tlinx.org>
Subject: Re: XFS: how to NOT null files on fsck?
Message-ID: <20040713080950.GA1810@taniwha.stupidest.org>
References: <200407050247.53743.norberto+linux-kernel@bensa.ath.cx> <200407102143.49838.jk-lkml@sci.fi> <20040710184601.GB5014@taniwha.stupidest.org> <200407101555.27278.norberto+linux-kernel@bensa.ath.cx> <20040710191914.GA5471@taniwha.stupidest.org> <2hgxc-5x9-9@gated-at.bofh.it> <2004Jul13.092529@mips.complang.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2004Jul13.092529@mips.complang.tuwien.ac.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 13, 2004 at 07:25:29AM +0000, Anton Ertl wrote:

> A secure FS must ensure that other people's deleted data does not
> end up in the file.  AFAIK FSs don't record owners for free blocks,
> so they can only ensure this by zeroing the blocks.

How can free blocks have an owner?  They wouldn't be free then.

> So I doubt that you will see any different behaviour from an FS that
> keeps only meta-data consistent and writes meta-data before data.

You do, some fs' will return stale data.

> It's too hard to fix the applications, since there is no easy way to
> test that they are really fixed.

No, it's not hard to fix the applications and it's easy to tell if
they are fixed.

> Also, the number of applications is much higher than the number of
> file systems.

You don't fix all applications, only ones where data is critical and
their handling of it is poor.  MTAs like postfix don't have a problem
for example, they are generally written well.

> The file system should provide something that I call in-order
> semantics, i.e., that the disk state always represents an existing
> (possibly old) logical state of the FS, not some state that never
> existed, or some existing state with missing data.

ext3 and reiserfs have what amounts to this as an option right now.
It has some performance implications but I'm told works great.

I don't think the current XFS behaviour is undesirable or broken.


   --cw
