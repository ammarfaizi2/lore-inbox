Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266073AbUFJBBF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266073AbUFJBBF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 21:01:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266078AbUFJBBF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 21:01:05 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:57286 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S266073AbUFJBBB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 21:01:01 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Chris Mason <mason@suse.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: ide errors in 7-rc1-mm1 and later
Date: Thu, 10 Jun 2004 03:05:01 +0200
User-Agent: KMail/1.5.3
Cc: axboe@suse.de, edt@aei.ca, linux-kernel@vger.kernel.org
References: <1085689455.7831.8.camel@localhost> <20040609165007.78dd8420.akpm@osdl.org> <1086827287.10973.305.camel@watt.suse.com>
In-Reply-To: <1086827287.10973.305.camel@watt.suse.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200406100305.01636.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 10 of June 2004 02:28, Chris Mason wrote:
> On Wed, 2004-06-09 at 19:50, Andrew Morton wrote:
> > Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl> wrote:
> > > Does journal has checksum or some other protection against failure
> > > during writing journal to a disk?  If not than it still can be screwed
> > > even with ordered writes if we are unfortunate enough.  ;-)
> >
> > A transaction is written to disk as two synchronous operations: write all
> > the data, wait on it, write the single commit block, wait on that.
> >
> > If the commit block were to hit disk before the data then we have a
> > window in which poweroff+recovery would replay garbage into the
> > filesystem.
> >
> > So I think we have a bug in the current ext3 barrier implementation - we
> > need a blk_issue_flush() before submitting the buffer_ordered commit
> > block.
>
> The IDE barriers are both a pre and post flush.  If the commit block is
> ordered, before the commit block hits the disk we know all the blocks
> previously submitted are also on disk.

Please re-read my mail.  Journal may be on differrent disk than filesystem.
IDE barries do pre and post flush but for the same device.

> -chris

