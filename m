Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265956AbUFJA1j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265956AbUFJA1j (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 20:27:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266048AbUFJA1j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 20:27:39 -0400
Received: from cantor.suse.de ([195.135.220.2]:14219 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265956AbUFJA1h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 20:27:37 -0400
Subject: Re: ide errors in 7-rc1-mm1 and later
From: Chris Mason <mason@suse.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>, axboe@suse.de,
       edt@aei.ca, linux-kernel@vger.kernel.org
In-Reply-To: <20040609165007.78dd8420.akpm@osdl.org>
References: <1085689455.7831.8.camel@localhost>
	 <200406092352.18470.bzolnier@elka.pw.edu.pl>
	 <20040609150658.5e5e6653.akpm@osdl.org>
	 <200406100138.18028.bzolnier@elka.pw.edu.pl>
	 <20040609165007.78dd8420.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1086827287.10973.305.camel@watt.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 09 Jun 2004 20:28:08 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-06-09 at 19:50, Andrew Morton wrote:
> Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl> wrote:
> >
> > Does journal has checksum or some other protection against failure during
> > writing journal to a disk?  If not than it still can be screwed even with
> > ordered writes if we are unfortunate enough.  ;-)
> 
> A transaction is written to disk as two synchronous operations: write all
> the data, wait on it, write the single commit block, wait on that.
> 
> If the commit block were to hit disk before the data then we have a window
> in which poweroff+recovery would replay garbage into the filesystem.
> 
> So I think we have a bug in the current ext3 barrier implementation - we
> need a blk_issue_flush() before submitting the buffer_ordered commit block.

The IDE barriers are both a pre and post flush.  If the commit block is
ordered, before the commit block hits the disk we know all the blocks
previously submitted are also on disk.

-chris


