Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131025AbRBAQca>; Thu, 1 Feb 2001 11:32:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131027AbRBAQcU>; Thu, 1 Feb 2001 11:32:20 -0500
Received: from roc-24-95-203-215.rochester.rr.com ([24.95.203.215]:32013 "EHLO
	d185fcbd7.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S131025AbRBAQcF>; Thu, 1 Feb 2001 11:32:05 -0500
Date: Thu, 01 Feb 2001 11:31:42 -0500
From: Chris Mason <mason@suse.com>
To: Rik van Riel <riel@conectiva.com.br>, David Ford <david@linux.com>
cc: LKML <linux-kernel@vger.kernel.org>, reiserfs-list@namesys.com
Subject: Re: [reiserfs-list] Re: VM brokenness, possibly related to reiserfs
Message-ID: <377430000.981045102@tiny>
In-Reply-To: <Pine.LNX.4.21.0102011411540.1321-100000@duckman.distro.conectiva>
X-Mailer: Mulberry/2.0.6b4 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thursday, February 01, 2001 02:16:43 PM -0200 Rik van Riel <riel@conectiva.com.br> wrote:

> 
> About the system hanging completely, I wonder if it goes
> away by pressing sysrq-S (sync all disks). If it does,
> maybe Reiserfs was blocking all the pages in the inactive
> list from being written because one of the active pages
> (not a replacement candidate) needed to be written out
> first?  Or does the Reiserfs ->writepage() function handle
> this?
> 

In most cases, the reiserfs writepage func is the same as block_write_full_page.  The only difference should come when a packed tail has been mmap'd.

Since JOURNAL_MAX_BATCH was at 100, the log should have only pinned 400k.  More blocks could be pinned, but kreiserfsd should be in the process of flushing those.

I've been trying out a few things to send memory pressure down to reiserfs, but they have mostly been based on the code to make fs/buffer.c use writepage for flushing.  I should have done something simple first, I'll start on that now.

-chris

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
