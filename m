Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267186AbUGMW1U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267186AbUGMW1U (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 18:27:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267181AbUGMWYv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 18:24:51 -0400
Received: from hermine.aitel.hist.no ([158.38.50.15]:23051 "HELO
	hermine.aitel.hist.no") by vger.kernel.org with SMTP
	id S267171AbUGMWV1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 18:21:27 -0400
Date: Wed, 14 Jul 2004 00:24:11 +0200
To: Anton Ertl <anton@mips.complang.tuwien.ac.at>
Cc: linux-kernel@vger.kernel.org, Chris Wedgwood <cw@f00f.org>,
       Jan Knutar <jk-lkml@sci.fi>, L A Walsh <lkml@tlinx.org>
Subject: Re: XFS: how to NOT null files on fsck?
Message-ID: <20040713222411.GA1035@hh.idb.hist.no>
References: <200407050247.53743.norberto+linux-kernel@bensa.ath.cx> <200407102143.49838.jk-lkml@sci.fi> <20040710184601.GB5014@taniwha.stupidest.org> <200407101555.27278.norberto+linux-kernel@bensa.ath.cx> <20040710191914.GA5471@taniwha.stupidest.org> <2hgxc-5x9-9@gated-at.bofh.it> <2004Jul13.092529@mips.complang.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2004Jul13.092529@mips.complang.tuwien.ac.at>
User-Agent: Mutt/1.5.6+20040523i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 13, 2004 at 07:25:29AM +0000, Anton Ertl wrote:
> Chris Wedgwood <cw@f00f.org> writes:
> >XFS does *not* zero files, it simply returns zeros for unwritten
> >extents.  If you open an existing file and scribble all over it, you
> >might see the old data during a crash, or the new data if it was
> >flushed.  You shouldn't see zero's though.
> >
> >What does happen though, is that dotfiles are truncated and rewritten,
> >if the data blocks aren't flushed you will get zeros back because the
> >extents were unwritten.  This is really the only sensible thing to do
> >given the circumstances.
> >
> >My guess is that with other fs' (when journaling metadata only) the
> >blocks allocated for the newly written data are *usually* the same as
> >the recently freed blocks from the truncate so things appear to work
> >but in reality it's probably mostly luck.
> 
> A secure FS must ensure that other people's deleted data does not end
> up in the file.  AFAIK FSs don't record owners for free blocks, so
> they can only ensure this by zeroing the blocks.  So I doubt that you
> will see any different behaviour from an FS that keeps only meta-data
> consistent and writes meta-data before data.
> 

There is another solution - zero blocks when freeing them. (Or
put them on a list for later zeroing when the fs isn't busy,
in order to kee��p good performance)

With this approach you don't need to zero a half-written
block after a crash, which means you destroy less data.

Helge Hafting 
