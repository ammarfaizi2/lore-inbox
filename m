Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265271AbUEZAM4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265271AbUEZAM4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 20:12:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265273AbUEZAM4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 20:12:56 -0400
Received: from fw.osdl.org ([65.172.181.6]:25826 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265271AbUEZAMH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 20:12:07 -0400
Date: Tue, 25 May 2004 17:14:46 -0700
From: Andrew Morton <akpm@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: olh@suse.de, linux-kernel@vger.kernel.org
Subject: Re: very low performance on SCSI disks if device node is in tmpfs
Message-Id: <20040525171446.7db5bec2.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0405251703000.9951@ppc970.osdl.org>
References: <20040525184732.GB26661@suse.de>
	<20040525144836.1af59a96.akpm@osdl.org>
	<20040525145923.68af0ad8.akpm@osdl.org>
	<20040525154107.053b9ef6.akpm@osdl.org>
	<Pine.LNX.4.58.0405251703000.9951@ppc970.osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> wrote:
>
> On Tue, 25 May 2004, Andrew Morton wrote:
> >
> > We need to set file->f_ra _after_ calling blkdev_open(), when inode->i_mapping
> > points at the right thing.  And we need to get it from
> > inode->i_mapping->host->i_mapping too, which represents the underlying device.
> 
> Hmm.. Is f_mapping is guaranteed to be non-NULL?

Yes, we just did

        f->f_mapping = inode->i_mapping;

> At least for the O_DIRECT 
> case, we explicitly test for f_mapping being non-NULL, although that test 
> is quite possibly bogus. Maybe we should fix that too?

yup.
