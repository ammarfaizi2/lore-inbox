Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265265AbUEZAFw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265265AbUEZAFw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 20:05:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265267AbUEZAFw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 20:05:52 -0400
Received: from fw.osdl.org ([65.172.181.6]:15327 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265265AbUEZAFv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 20:05:51 -0400
Date: Tue, 25 May 2004 17:05:46 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: olh@suse.de, linux-kernel@vger.kernel.org
Subject: Re: very low performance on SCSI disks if device node is in tmpfs
In-Reply-To: <20040525154107.053b9ef6.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0405251703000.9951@ppc970.osdl.org>
References: <20040525184732.GB26661@suse.de> <20040525144836.1af59a96.akpm@osdl.org>
 <20040525145923.68af0ad8.akpm@osdl.org> <20040525154107.053b9ef6.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 25 May 2004, Andrew Morton wrote:
>
> We need to set file->f_ra _after_ calling blkdev_open(), when inode->i_mapping
> points at the right thing.  And we need to get it from
> inode->i_mapping->host->i_mapping too, which represents the underlying device.

Hmm.. Is f_mapping is guaranteed to be non-NULL? At least for the O_DIRECT 
case, we explicitly test for f_mapping being non-NULL, although that test 
is quite possibly bogus. Maybe we should fix that too?

		Linus
