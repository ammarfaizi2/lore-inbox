Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262884AbVBBWjA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262884AbVBBWjA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 17:39:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262765AbVBBWhA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 17:37:00 -0500
Received: from fw.osdl.org ([65.172.181.6]:19915 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261366AbVBBWen (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 17:34:43 -0500
Date: Wed, 2 Feb 2005 14:34:22 -0800
From: Andrew Morton <akpm@osdl.org>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: nathans@sgi.com, viro@parcelfarce.linux.theplanet.co.uk,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: RFC: [PATCH-2.6] Add helper function to lock multiple page
 cache pages.
Message-Id: <20050202143422.41c29202.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.60.0502021354540.16084@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.60.0502021354540.16084@hermes-1.csi.cam.ac.uk>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Altaparmakov <aia21@cam.ac.uk> wrote:
>
> Below is a patch which adds a function 
>  mm/filemap.c::find_or_create_pages(), locks a range of pages.  Please see 
>  the function description in the patch for details.

This isn't very nice, is it, really?  Kind of a square peg in a round hole.

If you took the approach of defining a custom file_operations.write() then
I'd imagine that the write() side of things would fall out fairly neatly:
no need for s_umount and i_sem needs to be taken anyway.  No trylocking.

And for the vmscan->writepage() side of things I wonder if it would be
possible to overload the mapping's ->nopage handler.  If the target page
lies in a hole, go off and allocate all the necessary pagecache pages, zero
them, mark them dirty?
