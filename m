Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265268AbUEZAKl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265268AbUEZAKl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 20:10:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265269AbUEZAKl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 20:10:41 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:428 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265268AbUEZAKg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 20:10:36 -0400
Date: Wed, 26 May 2004 01:10:33 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, olh@suse.de, linux-kernel@vger.kernel.org
Subject: Re: very low performance on SCSI disks if device node is in tmpfs
Message-ID: <20040526001033.GA12308@parcelfarce.linux.theplanet.co.uk>
References: <20040525184732.GB26661@suse.de> <20040525144836.1af59a96.akpm@osdl.org> <20040525145923.68af0ad8.akpm@osdl.org> <20040525154107.053b9ef6.akpm@osdl.org> <Pine.LNX.4.58.0405251703000.9951@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0405251703000.9951@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 25, 2004 at 05:05:46PM -0700, Linus Torvalds wrote:
> 
> 
> On Tue, 25 May 2004, Andrew Morton wrote:
> >
> > We need to set file->f_ra _after_ calling blkdev_open(), when inode->i_mapping
> > points at the right thing.  And we need to get it from
> > inode->i_mapping->host->i_mapping too, which represents the underlying device.
> 
> Hmm.. Is f_mapping is guaranteed to be non-NULL? At least for the O_DIRECT 
> case, we explicitly test for f_mapping being non-NULL, although that test 
> is quite possibly bogus. Maybe we should fix that too?

->f_mapping should never be NULL after successive open().
