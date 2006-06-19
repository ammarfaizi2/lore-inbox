Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964801AbWFSQzW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964801AbWFSQzW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 12:55:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964802AbWFSQzW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 12:55:22 -0400
Received: from thunk.org ([69.25.196.29]:5054 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S964801AbWFSQzU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 12:55:20 -0400
Date: Mon, 19 Jun 2006 12:55:22 -0400
From: Theodore Tso <tytso@mit.edu>
To: Avi Kivity <avi@argo.co.il>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] [PATCH 5/8] inode-diet: Eliminate i_blksize and use a per-superblock default
Message-ID: <20060619165522.GA15216@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>, Avi Kivity <avi@argo.co.il>,
	linux-kernel@vger.kernel.org
References: <20060619153109.817554000@candygram.thunk.org> <4496C782.8090605@argo.co.il>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4496C782.8090605@argo.co.il>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 19, 2006 at 06:49:22PM +0300, Avi Kivity wrote:
> 
> Isn't this a behavioral change?  If a filesystem chooses to provide 
> i_blksize via a getattr method, it will not show on nfs mounts.

There's actually a philosophical question hiding here over what's the
right thing to do with how st_blksize should be handled over NFS ---
st_blksize is supposed to be the "optimum I/O size"; the question is
what is the right answer that we report in both directions.  For
example, it doesn't matter if we're exporting a Ultra Fast whiz-bang
cluster filesystem with a stripsize of 100 gigabytes.  If wsize is
1024, it might be that we shouldn't be sending back an st_blksize
that's really big.

So I'm not pretending that what we have in the patch is the right
thing, only that I'm not entirely sure we were ever doing the right
thing here.

						- Ted
