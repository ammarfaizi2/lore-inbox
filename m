Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267198AbUGMWyt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267198AbUGMWyt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 18:54:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267215AbUGMWyI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 18:54:08 -0400
Received: from pimout3-ext.prodigy.net ([207.115.63.102]:6274 "EHLO
	pimout3-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S267198AbUGMWjh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 18:39:37 -0400
Date: Tue, 13 Jul 2004 15:39:23 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: Anton Ertl <anton@mips.complang.tuwien.ac.at>,
       linux-kernel@vger.kernel.org, Jan Knutar <jk-lkml@sci.fi>,
       L A Walsh <lkml@tlinx.org>
Subject: Re: XFS: how to NOT null files on fsck?
Message-ID: <20040713223923.GC7980@taniwha.stupidest.org>
References: <200407050247.53743.norberto+linux-kernel@bensa.ath.cx> <200407102143.49838.jk-lkml@sci.fi> <20040710184601.GB5014@taniwha.stupidest.org> <200407101555.27278.norberto+linux-kernel@bensa.ath.cx> <20040710191914.GA5471@taniwha.stupidest.org> <2hgxc-5x9-9@gated-at.bofh.it> <2004Jul13.092529@mips.complang.tuwien.ac.at> <20040713222411.GA1035@hh.idb.hist.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040713222411.GA1035@hh.idb.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 14, 2004 at 12:24:11AM +0200, Helge Hafting wrote:

> There is another solution - zero blocks when freeing them.

slow

> (Or put them on a list for later zeroing when the fs isn't busy, in
> order to kee??????p good performance)

complicated, doesn't buy as anything, it also means the blocks are
tied up whilst they are being zeroed (consider a truncated on a
multi-gb file, fairly common)

> With this approach you don't need to zero a half-written
> block after a crash, which means you destroy less data.

it doesn't zero after a crash, what happens is the blocks never make
it to disk and the metadata (which did make it to disk) reflects this
so read returns nulls

as is, you can truncate a multi-gb file, write over it and the only IO
you see will be the new data being written out,  zeroing in between
would be horribly pianful


  --cw
