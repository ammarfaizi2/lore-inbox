Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269240AbUISNKs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269240AbUISNKs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Sep 2004 09:10:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269245AbUISNKr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Sep 2004 09:10:47 -0400
Received: from gate.crashing.org ([63.228.1.57]:34233 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S269240AbUISNKf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Sep 2004 09:10:35 -0400
Subject: Re: [PATCH] Fix bound checking in do_mmap_pgoff()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Hugh Dickins <hugh@veritas.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <Pine.LNX.4.44.0409191330420.13231-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0409191330420.13231-100000@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1095599362.18430.4.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 19 Sep 2004 23:09:22 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-09-19 at 22:59, Hugh Dickins wrote:
> On Sun, 19 Sep 2004, Benjamin Herrenschmidt wrote:
> > 
> > A small issue has been forever in do_mmap_pgoff() in the boundary checking
> > in the sense that it won't let you mmap with offset+len enclosing the last
> > page of the "address space". For example, an mmap of /dev/mem won't let you
> > map the last page of the physical address space (which I need for a ROM dump
> > tool on pmac). This fixes it:
> > -	if ((pgoff + (len >> PAGE_SHIFT)) < pgoff)
> > +	if ((pgoff + (len >> PAGE_SHIFT) - 1) < pgoff)
> 
> Your physical address space happens to be 16TB?  Okay...

hrm... nope... my bad, the problem comes from elsewhere, sorry. I need
to look at it again.

> I think you need to add in the patch below, to prevent mismerging of vmas.
> There might be other places which would get confused by an end pgoff of 0.

Ok, that's becoming more tricky then, Andrew, of course drop the bogus
patch for now, I'll look into more details later if I find time. In the
meantime, we'll continue use a special kernel module for doing the
ROM dump.

Ben.
 

