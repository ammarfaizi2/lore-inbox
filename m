Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266049AbUFJAlw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266049AbUFJAlw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 20:41:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266063AbUFJAlv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 20:41:51 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:10949 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S266049AbUFJAlu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 20:41:50 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Andrew Morton <akpm@osdl.org>, Chris Mason <mason@suse.com>
Subject: Re: ide errors in 7-rc1-mm1 and later
Date: Thu, 10 Jun 2004 02:45:33 +0200
User-Agent: KMail/1.5.3
Cc: axboe@suse.de, edt@aei.ca, linux-kernel@vger.kernel.org
References: <1085689455.7831.8.camel@localhost> <1086827287.10973.305.camel@watt.suse.com> <20040609173856.4463e36f.akpm@osdl.org>
In-Reply-To: <20040609173856.4463e36f.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200406100245.33513.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 10 of June 2004 02:38, Andrew Morton wrote:
> Chris Mason <mason@suse.com> wrote:
> > On Wed, 2004-06-09 at 19:50, Andrew Morton wrote:
> > > Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl> wrote:
> > > > Does journal has checksum or some other protection against failure
> > > > during writing journal to a disk?  If not than it still can be
> > > > screwed even with ordered writes if we are unfortunate enough.  ;-)
> > >
> > > A transaction is written to disk as two synchronous operations: write
> > > all the data, wait on it, write the single commit block, wait on that.
> > >
> > > If the commit block were to hit disk before the data then we have a
> > > window in which poweroff+recovery would replay garbage into the
> > > filesystem.
> > >
> > > So I think we have a bug in the current ext3 barrier implementation -
> > > we need a blk_issue_flush() before submitting the buffer_ordered commit
> > > block.
> >
> > The IDE barriers are both a pre and post flush.  If the commit block is
> > ordered, before the commit block hits the disk we know all the blocks
> > previously submitted are also on disk.
>
> Oh, OK.  Will the same apply to (for example) scsi?

Not OK.  Chris, pre and post flushes are for the same device.
Journal may be on different device than filesystem!


